local SoldierResultReportCtrl = class("SoldierResultReportCtrl", BaseCtrl)
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
SoldierResultReportCtrl._mapNodeConfig = {
  imgEnding = {},
  txtEnding = {sComponentName = "TMP_Text"},
  imgCharHead = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  goPersonality = {nCount = 3},
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
  txtSkillTitle = {sComponentName = "TMP_Text"},
  btnSkillItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SkillItem"
  },
  imgSkill = {sComponentName = "Image"},
  txtSkillName = {sComponentName = "TMP_Text"},
  imgSkillInitiative = {},
  txtSkillInitiative = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Active"
  },
  imgSkillPassive = {},
  txtSkillPassive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Passive"
  },
  txtKeyGrade = {sComponentName = "TMP_Text"},
  txtGradeChallenge = {sComponentName = "TMP_Text"},
  txtScore = {sComponentName = "TMP_Text"},
  txtRational = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Rational_Text"
  },
  txtHp = {sComponentName = "TMP_Text"},
  txtEconomy = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Economy_Text"
  },
  txtCoin = {sComponentName = "TMP_Text"},
  goCharItem = {},
  goCharList = {nCount = 2, sComponentName = "Transform"},
  txtCharTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Export_Char_List_Title"
  },
  txtPartnerTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Export_Partner_Title"
  },
  goPartnerList = {sComponentName = "Transform"},
  goPartnerItem = {sComponentName = "Transform"},
  txtCardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Export_BuffCard_Title"
  },
  goStrategyCardList = {sComponentName = "Transform"},
  btnStrategyCardItem = {sComponentName = "Transform"},
  NumRoot = {},
  txtDamageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Export_Damage_Title"
  },
  soldierDamageReportItem = {sComponentName = "Transform"},
  goSoldierItemRoot = {sComponentName = "Transform"},
  charDetialRoot = {sComponentName = "Transform"},
  parnterDetialRoot = {sComponentName = "Transform"}
}
SoldierResultReportCtrl._mapEventConfig = {}
SoldierResultReportCtrl._mapRedDotConfig = {}
local iconPath = "Icon/SoldierOtherIcon/"
local iconCardPath = "Icon/SoldierBuffCard/"
local iconPartnerPath = "Icon/SoldierPartner/"

function SoldierResultReportCtrl:Awake()
  self.tbMainCtrl = {}
  self.tbSubCtrl = {}
  self.tbSoldierGridCtrl = {}
  self.tabPartnerBtn = {}
  self.tabStrategyCard = {}
end

function SoldierResultReportCtrl:OnEnable()
end

function SoldierResultReportCtrl:OnDisable()
end

function SoldierResultReportCtrl:OnDestroy()
  for k, ctrl in pairs(self.tbMainCtrl) do
    self:UnbindCtrlByNode(ctrl)
    self.tbMainCtrl[k] = nil
  end
  self.tbMainCtrl = {}
  for k, ctrl in pairs(self.tbSubCtrl) do
    self:UnbindCtrlByNode(ctrl)
    self.tbSubCtrl[k] = nil
  end
  self.tbSubCtrl = {}
  for k, ctrl in pairs(self.tbSoldierGridCtrl) do
    self:UnbindCtrlByNode(ctrl)
    self.tbSoldierGridCtrl[k] = nil
  end
  self.tbSoldierGridCtrl = {}
  if self.tabPartnerBtn then
    for _, v in pairs(self.tabPartnerBtn) do
      v.onClick:RemoveAllListeners()
    end
    self.tabPartnerBtn = nil
  end
  if self.tabStrategyCard then
    for _, v in pairs(self.tabStrategyCard) do
      v.onClick:RemoveAllListeners()
    end
    self.tabStrategyCard = nil
  end
end

function SoldierResultReportCtrl:SetData(mapData)
  mapData = mapData or {}
  self.tbChess = mapData.tbChess or {}
  self.tbDamage = mapData.tbDamage or {}
  self.nBossTemplateId = mapData.nBossTemplateId or 0
  self.nHp = mapData.nHp or 0
  self.tbCard = mapData.tbCard or {}
  self.nGradeChallengeId = mapData.nGradeChallengeId or 0
  self.tbSettle = mapData.tbSettle or {}
  self:RefreshBossTemplate()
  self:RefreshTitle()
  self:RefreshCharList()
  self:RefreshCardList()
  self:RefreshDamage()
  self:RefreshEnding()
end

function SoldierResultReportCtrl:RefreshBossTemplate()
  if self.nBossTemplateId == 0 then
    return
  end
  local mapCfg = ConfigTable.GetData("SoldierBossTemplate", self.nBossTemplateId)
  if mapCfg == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtCharName, mapCfg.Name or "")
  self:SetPngSprite(self._mapNode.imgCharHead, mapCfg.SoldierPlayerHead)
  self:SetPngSprite(self._mapNode.imgSkill, mapCfg.SoldierRoleSkillIcon)
  NovaAPI.SetTMPText(self._mapNode.txtSkillTitle, mapCfg.Title or "")
  NovaAPI.SetTMPText(self._mapNode.txtSkillName, mapCfg.Name or "")
  local nSkillType = mapCfg.SoldierRoleSkillType
  self._mapNode.imgSkillPassive.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_1 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_3)
  self._mapNode.imgSkillInitiative.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_2 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_4)
  for i = 1, 3 do
    local nType = 0
    if i == 1 then
      nType = mapCfg.Personality_Intuition
    elseif i == 2 then
      nType = mapCfg.Personality_Analysis
    elseif i == 3 then
      nType = mapCfg.Personality_Chaos
    end
    local mapGradeCfg = ConfigTable.GetData("SoldierBossPersonalityGrade", nType)
    if mapGradeCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgPersonalityPercent[i], mapGradeCfg.Icon)
    end
  end
end

function SoldierResultReportCtrl:RefreshTitle()
  NovaAPI.SetTMPText(self._mapNode.txtHp, tostring(self.nHp))
  local nCoin = 0
  if self.tbSettle ~= nil then
    nCoin = self.tbSettle.nTotalCoinQty
  end
  NovaAPI.SetTMPText(self._mapNode.txtCoin, self:ThousandsNumber(nCoin))
  local mapChallengeCfg = ConfigTable.GetData("SoldierGradeChallenge", self.nGradeChallengeId)
  if mapChallengeCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtGradeChallenge, mapChallengeCfg.Name or "")
    local mapKeyGradeCfg = ConfigTable.GetData("SoldierKeyGrade", mapChallengeCfg.KeyGradeId)
    if mapKeyGradeCfg ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtKeyGrade, mapKeyGradeCfg.Name or "")
    end
  end
  local nPassedNode = self.tbSettle.nPassedNode or 0
  local nRemainingHp = self.tbSettle.nRemainingHp or 0
  local nCheckStageDps = self.tbSettle.nCheckStageDps or 0
  local nCheckStageTime = self.tbSettle.nCheckStageTime or 0
  local nChessTotalCost = self.tbSettle.nChessTotalCost or 0
  local nTotalScore = nPassedNode + nRemainingHp + nCheckStageDps + nCheckStageTime + nChessTotalCost
  NovaAPI.SetTMPText(self._mapNode.txtScore, nTotalScore)
end

function SoldierResultReportCtrl:RefreshCharList()
  self._mapNode.goCharItem:SetActive(false)
  local tabMain, tabSub = {}, {}
  for _, v in ipairs(self.tbChess) do
    if v.nPositionType == GameEnum.SoldierPositionType.FightPosition then
      tabMain[v.nIndex] = v
    elseif v.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
      tabSub[v.nIndex] = v
    end
  end
  local tbActivePartner, tbPartner = SoldierAttrData.CalcActivePartners(self.tbChess)
  self.tbActivePartner = tbActivePartner
  for _, v in pairs(tabMain) do
    local goChar = instantiate(self._mapNode.goCharItem, self._mapNode.goCharList[1])
    goChar:SetActive(true)
    if not self.tbMainCtrl[v.nIndex] then
      local ctrl = self:BindCtrlByNode(goChar, "Game.UI.Soldier.Template.Character.SoldierCharCardItemCtrl")
      self.tbMainCtrl[v.nIndex] = ctrl
      if v.nId > 0 then
        ctrl:SetItemData(v.nId, GameEnum.SoldierPositionType.FightPosition)
        ctrl:SetStar(v.nStar)
        ctrl:SetAttribute(v.nIndex)
        ctrl:SetClickCallback(_, function()
          local chessData = {
            nPositionType = GameEnum.SoldierPositionType.FightPosition,
            nId = v.nId,
            nStar = math.max(v.nStar, 1)
          }
          self:OnClickCharItem(chessData)
        end)
      else
        ctrl:SetItemData(nil)
      end
    end
  end
  for _, v in pairs(tabSub) do
    local goChar = instantiate(self._mapNode.goCharItem, self._mapNode.goCharList[2])
    goChar:SetActive(true)
    if not self.tbSubCtrl[v.nIndex] then
      local ctrl = self:BindCtrlByNode(goChar, "Game.UI.Soldier.Template.Character.SoldierCharCardItemCtrl")
      self.tbSubCtrl[v.nIndex] = ctrl
      if 0 < v.nId then
        ctrl:SetItemData(v.nId, GameEnum.SoldierPositionType.SupportPosition)
        ctrl:SetStar(v.nStar)
        ctrl:SetAttribute(0)
        ctrl:SetClickCallback(_, function()
          local chessData = {
            nPositionType = GameEnum.SoldierPositionType.SupportPosition,
            nId = v.nId,
            nStar = math.max(v.nStar, 1)
          }
          self:OnClickCharItem(chessData)
        end)
      else
        ctrl:SetItemData(nil)
      end
    end
  end
  if tbPartner == nil then
    return
  end
  self._mapNode.goPartnerItem.gameObject:SetActive(false)
  self:RefreshPartnerList(tbPartner)
end

function SoldierResultReportCtrl:RefreshPartnerList(tbPartner)
  for _, v in ipairs(tbPartner) do
    local mapPartnerGroupCfg = CacheTable.GetData("_SoldierPartnerGroup", v.nType)
    if mapPartnerGroupCfg ~= nil then
      local cfgList = CacheTable.GetData("_SoldierPartner", v.nType)
      if cfgList == nil then
        return
      end
      local partnerCfg = cfgList[v.nActiveLevel] or cfgList[1]
      local goU = instantiate(self._mapNode.goPartnerItem, self._mapNode.goPartnerList)
      goU.gameObject:SetActive(true)
      local imgPartner = goU:Find("imgPartner"):GetComponent("Image")
      local imgPartnerIcon = goU:Find("imgPartnerIcon"):GetComponent("Image")
      local txtPartnerCount = goU:Find("txtPartnerCount"):GetComponent("TMP_Text")
      if v.nActiveLevel == 0 then
        self:SetPngSprite(imgPartner, iconPath .. AllEnum.SoldierPartnerLevelIcon[GameEnum.PartnerLevelQuality.None].bg)
      else
        self:SetPngSprite(imgPartner, iconPath .. AllEnum.SoldierPartnerLevelIcon[partnerCfg.PartnerLevelQuality].bg)
      end
      self:SetPngSprite(imgPartnerIcon, iconPartnerPath .. mapPartnerGroupCfg.Icon .. AllEnum.SoldierChessIconSurfix.M)
      NovaAPI.SetTMPText(txtPartnerCount, tostring(v.nCurNum or 0))
      
      local function clickCb()
        EventManager.Hit(EventId.OpenPanel, PanelId.SoldierPartnerTips, self._mapNode.parnterDetialRoot, v.nType, v.nActiveLevel, false, self.tbChess, true, false)
        EventManager.Hit("OnSetParnterTipsPosition", self._mapNode.parnterDetialRoot:GetChild(0).position, self._mapNode.parnterDetialRoot:GetChild(1).position, self._mapNode.parnterDetialRoot:GetChild(2).position)
        EventManager.Hit("SoldierCharTips_ShowBg")
      end
      
      local btn = imgPartner.gameObject:GetComponent("UIButton")
      btn.onClick:RemoveAllListeners()
      btn.onClick:AddListener(clickCb)
      table.insert(self.tabPartnerBtn, btn)
    end
  end
end

function SoldierResultReportCtrl:OnClickCharItem(chessData)
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self._mapNode.charDetialRoot, chessData, self.tbChess, self.tbActivePartner, {})
  EventManager.Hit("OnSetTipsPosition", self._mapNode.charDetialRoot:GetChild(0).position, self._mapNode.charDetialRoot:GetChild(1).position, self._mapNode.charDetialRoot:GetChild(2).position)
  EventManager.Hit("SoldierCharTips_ShowBg")
end

function SoldierResultReportCtrl:RefreshCardList()
  self._mapNode.btnStrategyCardItem.gameObject:SetActive(false)
  if self.tbCard == nil then
    return
  end
  for _, v in ipairs(self.tbCard) do
    local goStrategy = instantiate(self._mapNode.btnStrategyCardItem, self._mapNode.goStrategyCardList)
    goStrategy.gameObject:SetActive(true)
    local cardBg = goStrategy:Find("AnimRoot/imgCardStrategy"):GetComponent("Image")
    local cardIcon = goStrategy:Find("AnimRoot/imgCardIconStrategy"):GetComponent("Image")
    local SoldierStrategyCardCfg = ConfigTable.GetData("SoldierStrategyCard", v.nId)
    if SoldierStrategyCardCfg ~= nil then
      local cardBgPath = iconPath .. AllEnum.SoldierStrategyCardRarityIcon[SoldierStrategyCardCfg.Rarity] .. AllEnum.SoldierChessIconSurfix.S
      self:SetPngSprite(cardBg, cardBgPath)
      self:SetPngSprite(cardIcon, iconCardPath .. SoldierStrategyCardCfg.Icon)
    end
    
    local function clickCb()
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCardTips, v.nId)
    end
    
    local btn = goStrategy:GetComponent("UIButton")
    btn.onClick:RemoveAllListeners()
    btn.onClick:AddListener(clickCb)
    table.insert(self.tabStrategyCard, btn)
  end
end

function SoldierResultReportCtrl:RefreshDamage()
  self._mapNode.NumRoot.gameObject:SetActive(self.tbDamage ~= nil and next(self.tbDamage) ~= nil)
  self._mapNode.soldierDamageReportItem.gameObject:SetActive(false)
  if self.tbDamage == nil then
    return
  end
  local maxDamage = 0
  local tbSortedDamage = {}
  for i, v in pairs(self.tbDamage) do
    if maxDamage < v.nDamage then
      maxDamage = v.nDamage
    end
    table.insert(tbSortedDamage, {id = i, data = v})
  end
  table.sort(tbSortedDamage, function(a, b)
    return a.data.nDamage > b.data.nDamage
  end)
  for _, item in ipairs(tbSortedDamage) do
    self:SetSoldierDamageItem(item.id, item.data, maxDamage)
  end
end

function SoldierResultReportCtrl:RefreshEnding()
  local nEndingId = self.tbSettle.nEndingId
  if nEndingId == nil or nEndingId == 0 then
    self._mapNode.imgEnding.gameObject:SetActive(false)
    return
  end
  local mapCfg = ConfigTable.GetData("SoldierEndingPlan", nEndingId)
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtEnding, orderedFormat(ConfigTable.GetUIText("Soldier_Battle_Ending_Title"), mapCfg.EndingTitle))
  end
end

function SoldierResultReportCtrl:SetSoldierDamageItem(id, damageData, maxDamage)
  local goR = instantiate(self._mapNode.soldierDamageReportItem, self._mapNode.goSoldierItemRoot)
  goR.gameObject:SetActive(true)
  local imgNumLine = goR:Find("imgNumLine"):GetComponent("RectTransform")
  local txDamageCount = goR:Find("imgNumLine/goNumLayout/txDamageCount"):GetComponent("TMP_Text")
  local objSoldier = goR:Find("tc_char_small").gameObject
  local cData = ConfigTable.GetData("SoldierCharacter", id)
  local cSkin = ConfigTable.GetData("SoldierSkin", id)
  local ctrl = self:BindCtrlByNode(objSoldier, "Game.UI.Soldier.Template.SoldierCharGridCtrl")
  ctrl:SetItem(cData.Rarity, 0, cSkin.Icon .. AllEnum.SoldierChessIconSurfix.S, damageData.nStar)
  self.tbSoldierGridCtrl[id] = ctrl
  local ratio = 0
  if maxDamage and 0 < maxDamage then
    ratio = damageData.nDamage / maxDamage
  end
  imgNumLine.sizeDelta = Vector2(20, 76 * ratio)
  NovaAPI.SetTMPText(txDamageCount, damageData.nDamage)
end

function SoldierResultReportCtrl:OnBtnClick_SkillItem(btn)
  if self.nBossTemplateId ~= 0 then
    local mapData = {
      nSkillId = self.nBossTemplateId,
      bSoldier = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
  end
end

function SoldierResultReportCtrl:OnBtnClick_Confirm()
end

return SoldierResultReportCtrl
