local SoldierRecommendDetailCtrl = class("SoldierRecommendDetailCtrl", BaseCtrl)
local iconPath = "Icon/SoldierBuffCard/"
local iconPath2 = "Icon/SoldierOtherIcon/"
SoldierRecommendDetailCtrl._mapNodeConfig = {
  Topbar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btnHome = {},
  img_Use = {},
  txt_Use = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Use"
  },
  MainChar = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.Template.Character.SoldierCharSupportCardItemCtrl"
  },
  sv_backChar = {
    sComponentName = "LoopScrollView"
  },
  txt_title = {sComponentName = "TMP_Text"},
  txt_buildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_BuildTitle"
  },
  txt_skillTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_RecommendDetail_Tips"
  },
  txt_desc = {sComponentName = "TMP_Text"},
  img_pos = {nCount = 3, sComponentName = "Image"},
  partnerCtrl = {
    sNodeName = "PartnerRoot",
    sCtrlName = "Game.UI.Soldier.Recommend.SpliderRecommendPartnerCtrl"
  },
  strategyCardPrefab = {},
  buffList = {
    sNodeName = "BuffListRoot"
  },
  btn_Apply = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Apply"
  },
  txt_Apply = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Apply"
  },
  btn_Cancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txt_Cancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Cancel"
  },
  charDetialRoot = {sComponentName = "Transform"},
  parnterDetialRoot = {sComponentName = "Transform"},
  txtPersonality1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Instinct"
  },
  txtPersonality2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Analyze"
  },
  txtPersonality3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Chaos"
  },
  imgPersonalityPercent = {nCount = 3, sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  imgCharHead = {sComponentName = "Image"},
  imgSkill = {sComponentName = "Image"},
  txtSkillPassive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Passive"
  },
  txtSkillInitiative = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Active"
  },
  imgSkillInitiative = {},
  imgSkillPassive = {}
}
SoldierRecommendDetailCtrl._mapEventConfig = {}
SoldierRecommendDetailCtrl._mapRedDotConfig = {}

function SoldierRecommendDetailCtrl:Awake()
  self.tbBackCharData = {}
  self.mapBackCharCtrl = {}
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.mapRecommendData = param[1]
    self.bInSoldier = param[2]
  end
  if self.mapRecommendData == nil then
    return
  end
  self.nRecommendId = self.mapRecommendData.nRecommendId
  self:RefreshBossTemplate()
  self:RefreshUI()
  self:SetApplyStatus()
end

function SoldierRecommendDetailCtrl:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    self._mapNode.btnHome.gameObject:SetActive(not self.bInSoldier)
  end
  
  cs_coroutine.start(wait)
end

function SoldierRecommendDetailCtrl:OnDisable()
  for _, objCharCard in pairs(self.mapBackCharCtrl) do
    self:UnbindCtrlByNode(objCharCard)
  end
  self.mapBackCharCtrl = {}
end

function SoldierRecommendDetailCtrl:RefreshUI()
  NovaAPI.SetTMPText(self._mapNode.txt_title, self.mapRecommendData.sTitle)
  NovaAPI.SetTMPText(self._mapNode.txt_desc, self.mapRecommendData.sDesc)
  local tbCharList = self.mapRecommendData.charList or {}
  for nIndex = 1, #self._mapNode.MainChar do
    self:RefreshCharCard(self._mapNode.MainChar[nIndex], tbCharList[nIndex])
  end
  for i = 1, 3 do
    local img_pos = self._mapNode.img_pos[i]
    local nCfgId = PlayerData.SoldierData:GetSoldierPositionEffectDataId(i)
    local cfg = ConfigTable.GetData("SoldierPositionEffect", nCfgId)
    if cfg then
      self:SetPngSprite(img_pos, iconPath2 .. cfg.Icon)
    end
  end
  self:RefreshBackCharList(tbCharList)
  self._mapNode.strategyCardPrefab:SetActive(false)
  local tr = self._mapNode.buffList.transform
  for i = tr.childCount, 1, -1 do
    GameObject.Destroy(tr:GetChild(i - 1).gameObject)
  end
  for _, buffId in ipairs(self.mapRecommendData.tbStrategyCardId or {}) do
    local buffConfig = ConfigTable.GetData("SoldierStrategyCard", buffId)
    if buffConfig then
      local go_buff = instantiate(self._mapNode.strategyCardPrefab, tr)
      go_buff.transform:SetParent(tr)
      go_buff.transform.localScale = Vector3.one
      local img_icon = go_buff.transform:Find("SmallBuff/AnimRoot/imgIcon"):GetComponent("Image")
      local img_bg = go_buff.transform:Find("SmallBuff/AnimRoot/imgBg"):GetComponent("Image")
      local btn_detail = go_buff:GetComponent("UIButton")
      btn_detail.onClick:RemoveAllListeners()
      btn_detail.onClick:AddListener(function()
        EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCardTips, buffId)
      end)
      self:SetPngSprite(img_icon, iconPath .. buffConfig.Icon)
      if buffConfig.Rarity ~= 0 then
        self:SetPngSprite(img_bg, iconPath2 .. AllEnum.SoldierStrategyCardRarityIcon[buffConfig.Rarity] .. AllEnum.SoldierChessIconSurfix.S)
      end
      go_buff:SetActive(true)
    end
  end
  self._mapNode.partnerCtrl:RefreshPartner(tbCharList, self.mapRecommendData.tbExtraPartner or {})
  self._mapNode.partnerCtrl:SetPartnerDetailRoot(self._mapNode.parnterDetialRoot)
end

function SoldierRecommendDetailCtrl:RefreshBackCharList(tbCharList)
  self.tbBackCharData = {}
  for nIndex = #self._mapNode.MainChar + 1, math.min(#tbCharList, 13) do
    local mapCharData = tbCharList[nIndex]
    if mapCharData.nId ~= nil and mapCharData.nId ~= 0 then
      table.insert(self.tbBackCharData, mapCharData)
    end
  end
  local bHasBackChar = #self.tbBackCharData > 0
  self._mapNode.sv_backChar.gameObject:SetActive(bHasBackChar)
  if bHasBackChar then
    self._mapNode.sv_backChar:Init(#self.tbBackCharData, self, self.OnBackCharRefreshGrid)
  end
  for _, objCharCard in pairs(self.mapBackCharCtrl) do
    if not bHasBackChar or not objCharCard.gameObject.activeSelf then
      self:RefreshCharCard(objCharCard, nil)
    end
  end
end

function SoldierRecommendDetailCtrl:OnBackCharRefreshGrid(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local objCharCard = self.mapBackCharCtrl[nInstanceId]
  if objCharCard == nil then
    objCharCard = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.Template.Character.SoldierCharSupportCardItemCtrl")
    self.mapBackCharCtrl[nInstanceId] = objCharCard
  end
  self:RefreshCharCard(objCharCard, self.tbBackCharData[nIndex])
end

function SoldierRecommendDetailCtrl:RefreshCharCard(objCharCard, mapCharData)
  objCharCard:_RemoveAllTimer()
  objCharCard.nStar = nil
  if mapCharData == nil or mapCharData.nId == nil or mapCharData.nId == 0 then
    objCharCard:SetItemData(nil)
    objCharCard:SetStar(0)
    objCharCard:SetChessPosition(nil)
    objCharCard._mapNode.Fx_warrior.gameObject:SetActive(false)
    objCharCard:SetClickCallback(nil, nil)
    return
  end
  objCharCard:SetItemData(mapCharData.nId)
  objCharCard:SetStar(mapCharData.nStar)
  objCharCard.nStar = mapCharData.nStar or 0
  objCharCard:SetClickCallback(self, function()
    local mapChessData = {
      nId = mapCharData.nId,
      nStar = mapCharData.nStar,
      nPositionType = mapCharData.nPositionType
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self._mapNode.charDetialRoot, mapChessData)
    EventManager.Hit("OnSetTipsPosition", self._mapNode.charDetialRoot:GetChild(0).position, self._mapNode.charDetialRoot:GetChild(1).position, self._mapNode.charDetialRoot:GetChild(2).position)
    EventManager.Hit("SoldierCharTips_ShowBg")
  end)
end

function SoldierRecommendDetailCtrl:RefreshBossTemplate()
  local mapCfg = ConfigTable.GetData("SoldierBossTemplate", self.mapRecommendData.nBossTemplateId or 0)
  if mapCfg ~= nil then
    local sIntGrade = AllEnum.SoldierPersonalityLevelIconByEnum[mapCfg.Personality_Intuition]
    self:SetPngSprite(self._mapNode.imgPersonalityPercent[1], sIntGrade)
    local sAnalyzeGrade = AllEnum.SoldierPersonalityLevelIconByEnum[mapCfg.Personality_Analysis]
    self:SetPngSprite(self._mapNode.imgPersonalityPercent[2], sAnalyzeGrade)
    local sChaosGrade = AllEnum.SoldierPersonalityLevelIconByEnum[mapCfg.Personality_Chaos]
    self:SetPngSprite(self._mapNode.imgPersonalityPercent[3], sChaosGrade)
    self:SetPngSprite(self._mapNode.imgCharHead, mapCfg.SoldierPlayerHead)
    NovaAPI.SetTMPText(self._mapNode.txtCharName, mapCfg.Name or "")
    self:SetPngSprite(self._mapNode.imgSkill, mapCfg.SoldierRoleSkillIcon)
    local nSkillType = mapCfg.SoldierRoleSkillType
    self._mapNode.imgSkillPassive.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_1 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_3)
    self._mapNode.imgSkillInitiative.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_2 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_4)
  end
end

function SoldierRecommendDetailCtrl:SetApplyStatus()
  local bApply = false
  local recommendData = PlayerData.SoldierData:GetRecommendData(self.bInSoldier)
  if recommendData ~= nil and recommendData.nRecommendId == self.mapRecommendData.nRecommendId then
    bApply = true
  end
  self._mapNode.btn_Apply.gameObject:SetActive(not bApply)
  self._mapNode.btn_Cancel.gameObject:SetActive(bApply)
  self._mapNode.img_Use.gameObject:SetActive(bApply)
end

function SoldierRecommendDetailCtrl:OnBtnClick_Apply()
  PlayerData.SoldierData:SetRecommendData(self.mapRecommendData.nRecommendId, self.bInSoldier)
  self:SetApplyStatus()
end

function SoldierRecommendDetailCtrl:OnBtnClick_Cancel()
  PlayerData.SoldierData:SetRecommendData(0, self.bInSoldier)
  self:SetApplyStatus()
end

function SoldierRecommendDetailCtrl:OnBtnClick_RcmdSquare()
end

return SoldierRecommendDetailCtrl
