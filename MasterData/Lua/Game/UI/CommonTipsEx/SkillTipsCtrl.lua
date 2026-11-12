local BaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local SkillTipsCtrl = class("SkillTipsCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
SkillTipsCtrl.minTipHeight = 87
SkillTipsCtrl.maxTipHeight = 557
local titleHeight = 175
SkillTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWord"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  imgTipsBg = {
    sComponentName = "RectTransform"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  srDesc = {
    sComponentName = "RectTransform"
  },
  imgBranchSkillBg = {
    sComponentName = "RectTransform"
  },
  BranchTipsContent = {
    sComponentName = "RectTransform"
  },
  TMPBranchTitle = {sComponentName = "TMP_Text"},
  imgBranchBg = {sComponentName = "Image"},
  imgBranchIcon = {sComponentName = "Image"},
  txtTalentRank = {sComponentName = "TMP_Text"},
  TMPBranchDesc = {sComponentName = "TMP_Text"},
  TMP_LinkBranch = {
    sNodeName = "TMPBranchDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  rtDescContent = {
    sComponentName = "RectTransform"
  },
  TMPSkillTitle = {sComponentName = "TMP_Text"},
  TMPSkillLevel = {sComponentName = "TMP_Text"},
  imgSkillBg = {sComponentName = "Image"},
  imgSkillIcon = {sComponentName = "Image"},
  TMPSkillDesc = {sComponentName = "TMP_Text"},
  imgCDInfoBg = {},
  imgEnergyInfoBg = {},
  rtSkillInfo = {},
  TMPEnergy = {sComponentName = "TMP_Text"},
  TMPCD = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "TMPSkillDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  RelatedSkillBg = {
    sComponentName = "RectTransform"
  },
  RelatedTipsContent = {
    sComponentName = "RectTransform"
  },
  RelatedSkillGrid = {},
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  }
}
SkillTipsCtrl._mapEventConfig = {}

function SkillTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.mapData = tbParam[2]
  end
  self._mapNode.RelatedSkillBg.gameObject:SetActive(false)
  self._mapNode.RelatedSkillGrid:SetActive(false)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContent:GetComponent("CanvasGroup"), 0)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.imgBranchSkillBg:GetComponent("CanvasGroup"), 0)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.RelatedSkillBg:GetComponent("CanvasGroup"), 0)
end

function SkillTipsCtrl:FadeIn()
end

function SkillTipsCtrl:FadeOut()
end

function SkillTipsCtrl:OnEnable()
  self:EnableGamepadUI(self._mapNode.btnShortcutClose)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local btnComp = self.rtTarget:GetComponent("Button")
  if btnComp ~= nil then
    btnComp.interactable = false
  end
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", true)
  NovaAPI.SetTopGridCanvasSorting(self.rtTarget.gameObject, self.sortingOrder)
  if self.mapData.bTravelerDuel then
    self:ShowTravelerDuelSkill()
  elseif self.mapData.bMonster then
    self:ShowMonsterSkill()
  elseif self.mapData.bJointDrill then
    self:ShowJointDrillBossSkill()
  elseif self.mapData.bSoldier then
    self:ShowSoldierBossTemplateSkill()
  elseif self.mapData.bCharSkillEnergyEff then
    if self.rtTarget ~= nil then
      local vX = NovaAPI.GetViewPointX(self.rtTarget.gameObject)
      if 0.5 < vX then
        self._mapNode.imgWordTipBg.transform.localPosition = Vector3(-self._mapNode.imgWordTipBg.transform.localPosition.x, self._mapNode.imgWordTipBg.transform.localPosition.y, self._mapNode.imgWordTipBg.transform.localPosition.z)
      end
    end
    self:ShowCharSkillEnergyEff()
    self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
    self._mapNode.rtContent.gameObject:SetActive(false)
    return
  else
    self:ShowCharacterSkill()
  end
  if self.mapData.bBranch then
    local nBranchId = self.mapData.nBranchId
    local nBranchLevel = self.mapData.nBranchLevel
    local mapBranch = ConfigTable.GetData("RoguelikeTalentSkill", nBranchId)
    if mapBranch ~= nil then
      local sDesc = UTILS.ParseDesc(mapBranch)
      NovaAPI.SetTMPText(self._mapNode.TMPBranchDesc, sDesc)
      NovaAPI.SetTMPText(self._mapNode.txtTalentRank, ConfigTable.GetUIText("RomanNumeral_" .. nBranchLevel == 0 and 1 or nBranchLevel))
      NovaAPI.SetTMPText(self._mapNode.TMPBranchTitle, mapBranch.Title)
      self:SetPngSprite(self._mapNode.imgBranchIcon, mapBranch.Icon)
      local nRare = nBranchId % 100 > 10 and GameEnum.itemRarity.SSR or GameEnum.itemRarity.SR
      self:SetPngSprite(self._mapNode.imgBranchBg, "UI/big_sprites/rare_talent_" .. AllEnum.FrameColor_New[nRare])
      self.bShowBranch = true
    end
  end
  
  local function wait()
    if self.bShowBranch then
      self._mapNode.imgBranchSkillBg.gameObject:SetActive(true)
      local sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
      NovaAPI.SetComponentEnableByName(self._mapNode.imgBranchSkillBg.gameObject, "TopGridCanvas", true)
      NovaAPI.SetTopGridCanvasSorting(self._mapNode.imgBranchSkillBg.gameObject, sortingOrder)
    else
      self._mapNode.imgBranchSkillBg.gameObject:SetActive(false)
    end
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nContentHeight = self._mapNode.rtDescContent.sizeDelta.y
    print(nContentHeight)
    if nContentHeight > self.maxTipHeight then
      nContentHeight = self.maxTipHeight
    end
    if nContentHeight < self.minTipHeight then
      nContentHeight = self.minTipHeight
    end
    self._mapNode.srDesc.sizeDelta = Vector2(self._mapNode.srDesc.sizeDelta.x, nContentHeight + 4)
    self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight + titleHeight)
    if self.bShowBranch then
      local nBrenchHeight = self._mapNode.BranchTipsContent.sizeDelta.y + 40
      if nBrenchHeight > self.maxTipHeight then
        nBrenchHeight = self.maxTipHeight
      end
      if nBrenchHeight < self.minTipHeight then
        nBrenchHeight = self.minTipHeight
      end
      self._mapNode.imgBranchSkillBg.sizeDelta = Vector2(self._mapNode.imgBranchSkillBg.sizeDelta.x, nBrenchHeight)
    end
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self.bShowBranch then
      local screenWidth = self._mapNode.safeAreaRoot.rect.size.x
      if self._mapNode.rtContent.anchoredPosition.x - 2 * self._mapNode.imgBranchSkillBg.sizeDelta.x > -0.5 * screenWidth then
        local anchors = Vector2(0, 1)
        local Pivot = Vector2(1, 1)
        self._mapNode.imgBranchSkillBg.anchorMax = anchors
        self._mapNode.imgBranchSkillBg.anchorMin = anchors
        self._mapNode.imgBranchSkillBg.pivot = Pivot
        self._mapNode.imgBranchSkillBg.anchoredPosition = Vector2(24, 0)
      else
        local anchors = Vector2(1, 1)
        local Pivot = Vector2(0, 1)
        self._mapNode.imgBranchSkillBg.anchorMax = anchors
        self._mapNode.imgBranchSkillBg.anchorMin = anchors
        self._mapNode.imgBranchSkillBg.pivot = Pivot
        self._mapNode.imgBranchSkillBg.anchoredPosition = Vector2(-24, 0)
      end
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.imgBranchSkillBg:GetComponent("CanvasGroup"), 1)
    end
  end
  
  cs_coroutine.start(wait)
end

function SkillTipsCtrl:OnDisable()
  self:DisableGamepadUI()
end

function SkillTipsCtrl:OnDestroy()
end

function SkillTipsCtrl:OnRelease()
end

function SkillTipsCtrl:ShowCharacterSkill()
  local mapSkill = ConfigTable.GetData_Skill(self.mapData.nSkillId)
  if mapSkill == nil then
    printError("SkillId未找到：" .. self.mapData.nSkillId)
    return
  end
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapSkill.Icon)
  print(self.mapData.nSkillId)
  print(self.mapData.nElementType)
  self:SetAtlasSprite(self._mapNode.imgSkillBg, "12_rare", AllEnum.ElementIconType.Skill .. self.mapData.nElementType, true)
  NovaAPI.SetTMPText(self._mapNode.TMPSkillTitle, mapSkill.Title)
  NovaAPI.SetTMPText(self._mapNode.TMPSkillLevel, orderedFormat(ConfigTable.GetUIText("CommonTips_LevelFormat"), self.mapData.nLevel))
  if mapSkill.Type == GameEnum.skillType.SKILL or mapSkill.Type == GameEnum.skillType.SUPPORT then
    self._mapNode.imgCDInfoBg:SetActive(true)
    self._mapNode.imgEnergyInfoBg:SetActive(false)
  elseif mapSkill.Type == GameEnum.skillType.ULTIMATE then
    self._mapNode.imgCDInfoBg:SetActive(true)
    self._mapNode.imgEnergyInfoBg:SetActive(true)
  else
    self._mapNode.imgCDInfoBg:SetActive(false)
    self._mapNode.imgEnergyInfoBg:SetActive(false)
    self._mapNode.rtSkillInfo:SetActive(false)
  end
  local bHasSectionResumeTime = mapSkill.SectionResumeTime and mapSkill.SectionResumeTime ~= "" and mapSkill.SectionResumeTime ~= 0
  local nCd = bHasSectionResumeTime and mapSkill.SectionResumeTime or mapSkill.SkillCD
  local sCd = tostring(FormatNum(nCd * ConfigData.IntFloatPrecision)) .. ConfigTable.GetUIText("Talent_Sec")
  if nCd <= 0 then
    sCd = ConfigTable.GetUIText("Skill_NoCD")
  end
  NovaAPI.SetTMPText(self._mapNode.TMPCD, sCd)
  NovaAPI.SetTMPText(self._mapNode.TMPEnergy, FormatNum(mapSkill.UltraEnergy * ConfigData.IntFloatPrecision))
  local sDesc = UTILS.ParseDesc(mapSkill)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPSkillDesc, sDesc)
  if not self.mapData.bBranch then
    local rapidjson = require("rapidjson")
    local tbRelatedSkill = rapidjson.decode(mapSkill.RelatedSkill)
    if tbRelatedSkill ~= nil and 0 < #tbRelatedSkill then
      self._mapNode.RelatedSkillBg.gameObject:SetActive(true)
      self:SetRelatedSkill(tbRelatedSkill)
      return
    end
  end
  self._mapNode.RelatedSkillBg.gameObject:SetActive(false)
end

function SkillTipsCtrl:SetRelatedSkill(tbRelatedSkill)
  self:ClearRelatedSkill()
  local nCount = #tbRelatedSkill
  for idx, tbParam in ipairs(tbRelatedSkill) do
    local goGrid = instantiate(self._mapNode.RelatedSkillGrid, self._mapNode.RelatedTipsContent)
    goGrid:SetActive(true)
    local goCtrl = self:BindCtrlByNode(goGrid, "Game.UI.CommonTipsEx.SkillTipsRelatedGridCtrl")
    goCtrl:SetParent(self)
    table.insert(goCtrl, self.tbRelatedSkillCtrl)
    local nLevel = self.mapData.nLevel
    if tbParam[2] ~= nil and tbParam[2] ~= 0 then
      nLevel = tbParam[2]
    end
    goCtrl:Refresh(tbParam[1], nLevel, self.mapData.nElementType, idx == nCount)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nContentHeight = self._mapNode.RelatedTipsContent.sizeDelta.y + 50
    if 932 < nContentHeight then
      nContentHeight = 932
    end
    self._mapNode.RelatedSkillBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight)
    local screenWidth = self._mapNode.safeAreaRoot.rect.size.x
    local screenHeight = self._mapNode.safeAreaRoot.rect.size.y
    local tipsPosition = self._mapNode.rtContent.anchoredPosition.y + self._mapNode.imgTipsBg.anchoredPosition.y + self._mapNode.imgTipsBg.sizeDelta.y
    local offsetY = 0
    if tipsPosition - nContentHeight < -screenHeight * 0.5 + 60 then
      offsetY = -screenHeight * 0.5 + 60 - (tipsPosition - nContentHeight)
    end
    if self._mapNode.rtContent.anchoredPosition.x - 2 * self._mapNode.RelatedSkillBg.sizeDelta.x > -0.5 * screenWidth then
      local anchors = Vector2(0, 1)
      local Pivot = Vector2(1, 1)
      self._mapNode.RelatedSkillBg.anchorMax = anchors
      self._mapNode.RelatedSkillBg.anchorMin = anchors
      self._mapNode.RelatedSkillBg.pivot = Pivot
      self._mapNode.RelatedSkillBg.anchoredPosition = Vector2(24, offsetY)
    else
      local anchors = Vector2(1, 1)
      local Pivot = Vector2(0, 1)
      self._mapNode.RelatedSkillBg.anchorMax = anchors
      self._mapNode.RelatedSkillBg.anchorMin = anchors
      self._mapNode.RelatedSkillBg.pivot = Pivot
      self._mapNode.RelatedSkillBg.anchoredPosition = Vector2(-24, offsetY)
    end
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.RelatedSkillBg:GetComponent("CanvasGroup"), 1)
  end
  
  cs_coroutine.start(wait)
end

function SkillTipsCtrl:ClearRelatedSkill()
  if self.tbRelatedSkillCtrl ~= nil then
    for _, relatedSkillCtrl in ipairs(self.tbRelatedSkillCtrl) do
      local go = relatedSkillCtrl.gameObject
      self:UnbindCtrlByNode(relatedSkillCtrl)
      destroy(go)
    end
  end
  delChildren(self._mapNode.RelatedTipsContent)
  self.tbRelatedSkillCtrl = {}
end

function SkillTipsCtrl:ShowMonsterSkill()
  local isWeeklyCopies = PlayerData.RogueBoss:GetIsWeeklyCopies()
  local mapSkill = {}
  if isWeeklyCopies then
    mapSkill = ConfigTable.GetData("WeekBossAffix", self.mapData.nSkillId)
  else
    mapSkill = ConfigTable.GetData("RegionBossAffix", self.mapData.nSkillId)
  end
  if mapSkill == nil then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPSkillLevel, orderedFormat(ConfigTable.GetUIText("CommonTips_LevelFormat"), mapSkill.Level))
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapSkill.Icon)
  self:SetAtlasSprite(self._mapNode.imgSkillBg, "12_rare", AllEnum.ElementIconType.Skill .. mapSkill.Element, true)
  NovaAPI.SetTMPText(self._mapNode.TMPSkillTitle, mapSkill.Name)
  local sDesc = UTILS.SubDesc(mapSkill.Desc)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPSkillDesc, sDesc)
  self._mapNode.TMPSkillLevel.gameObject:SetActive(self.mapData.bBoss ~= true)
  self._mapNode.imgCDInfoBg:SetActive(false)
  self._mapNode.imgEnergyInfoBg:SetActive(false)
  self._mapNode.rtSkillInfo:SetActive(false)
end

function SkillTipsCtrl:ShowTravelerDuelSkill()
  local mapSkill = ConfigTable.GetData("TravelerDuelChallengeAffix", self.mapData.nSkillId)
  if mapSkill == nil then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapSkill.Icon)
  self:SetAtlasSprite(self._mapNode.imgSkillBg, "12_rare", AllEnum.ElementIconType.Skill .. mapSkill.Element, true)
  NovaAPI.SetTMPText(self._mapNode.TMPSkillTitle, mapSkill.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPSkillLevel, "")
  self._mapNode.imgCDInfoBg:SetActive(false)
  self._mapNode.imgEnergyInfoBg:SetActive(false)
  self._mapNode.rtSkillInfo:SetActive(false)
  local sDesc = UTILS.SubDesc(mapSkill.Desc)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPSkillDesc, sDesc)
end

function SkillTipsCtrl:ShowJointDrillBossSkill()
  local mapSkill = ConfigTable.GetData("JointDrillAffix", self.mapData.nSkillId)
  if mapSkill == nil then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  self._mapNode.TMPSkillLevel.gameObject:SetActive(false)
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapSkill.Icon)
  NovaAPI.SetTMPText(self._mapNode.TMPSkillTitle, mapSkill.Name)
  local sDesc = UTILS.SubDesc(mapSkill.Desc)
  sDesc = UTILS.ParseNoBrokenDesc(sDesc)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPSkillDesc, sDesc)
  self._mapNode.imgCDInfoBg:SetActive(false)
  self._mapNode.imgEnergyInfoBg:SetActive(false)
  self._mapNode.rtSkillInfo:SetActive(false)
end

function SkillTipsCtrl:ShowSoldierBossTemplateSkill()
  local mapSkill = ConfigTable.GetData("SoldierBossTemplate", self.mapData.nSkillId)
  if mapSkill == nil then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  self._mapNode.TMPSkillLevel.gameObject:SetActive(false)
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapSkill.SoldierRoleSkillIcon)
  NovaAPI.SetTMPText(self._mapNode.TMPSkillTitle, mapSkill.Title)
  local sDesc = UTILS.SubDesc(mapSkill.Desc)
  sDesc = UTILS.ParseNoBrokenDesc(sDesc)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPSkillDesc, sDesc)
  self._mapNode.imgCDInfoBg:SetActive(false)
  self._mapNode.imgEnergyInfoBg:SetActive(false)
  self._mapNode.rtSkillInfo:SetActive(false)
end

function SkillTipsCtrl:ShowCharSkillEnergyEff()
  local mapCharacter = ConfigTable.GetData("Character", self.mapData.nCharId)
  if mapCharacter == nil then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  self._mapNode.btnCloseWordTip.gameObject:SetActive(true)
  self._mapNode.imgWordTipBg:SetActive(true)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPWordTipsTitle, ConfigTable.GetUIText("CharRechargeSpeed_EnergyEff"))
  local tbLines = {}
  table.insert(tbLines, ConfigTable.GetUIText("CharRechargeSpeed_EnergyEffDesc"))
  if mapCharacter.ChargingRate ~= 0 then
    local rateText = self:GetCharRechargeTypeText(mapCharacter.ChargingRate)
    if rateText and rateText ~= "" then
      local prefix = ConfigTable.GetUIText("CharRechargeSpeed_ChargingRate")
      table.insert(tbLines, string.format("%s%s", prefix, rateText))
    end
  end
  if mapCharacter.EnergyConsume then
    local consumeText = self:GetEnergyCostTypeText(mapCharacter.EnergyConsume)
    if consumeText and consumeText ~= "" then
      local prefix = ConfigTable.GetUIText("CharRechargeSpeed_EnergyConsume")
      table.insert(tbLines, string.format("%s%s", prefix, consumeText))
    end
  end
  if self._mapNode.TMPWordDesc then
    if 0 < #tbLines then
      local finalDesc = table.concat(tbLines, "\n")
      NovaAPI.SetTMPText(self._mapNode.TMPWordDesc, finalDesc)
      self._mapNode.TMPWordDesc.gameObject:SetActive(true)
    else
      self._mapNode.TMPWordDesc.gameObject:SetActive(false)
    end
  end
end

function SkillTipsCtrl:GetCharRechargeTypeText(EnumType)
  local tbEnumMap = {
    [GameEnum.CharRechargeSpeed.SupHigh] = ConfigTable.GetUIText("CharRechargeSpeed_SupHigh"),
    [GameEnum.CharRechargeSpeed.High] = ConfigTable.GetUIText("CharRechargeSpeed_High"),
    [GameEnum.CharRechargeSpeed.Mid] = ConfigTable.GetUIText("CharRechargeSpeed_Mid"),
    [GameEnum.CharRechargeSpeed.Low] = ConfigTable.GetUIText("CharRechargeSpeed_Low")
  }
  return tbEnumMap[EnumType] or ""
end

function SkillTipsCtrl:GetEnergyCostTypeText(EnumType)
  local tbEnumMap = {
    [GameEnum.CharEnergyCostSpeed.SupHigh] = ConfigTable.GetUIText("CharEnergyCostSpeed_SupHigh"),
    [GameEnum.CharEnergyCostSpeed.High] = ConfigTable.GetUIText("CharEnergyCostSpeed_High"),
    [GameEnum.CharEnergyCostSpeed.Mid] = ConfigTable.GetUIText("CharEnergyCostSpeed_Mid"),
    [GameEnum.CharEnergyCostSpeed.Low] = ConfigTable.GetUIText("CharEnergyCostSpeed_Low")
  }
  return tbEnumMap[EnumType] or ""
end

function SkillTipsCtrl:OnBtnClick_Word(link, _, sWordId)
  local nWordId = tonumber(sWordId)
  local mapWordData = ConfigTable.GetData_World(nWordId)
  if mapWordData == nil then
    return
  end
  if link ~= nil then
    local vX = NovaAPI.GetViewPointX(link.gameObject)
    if 0.5 < vX then
      self._mapNode.imgWordTipBg.transform.localPosition = Vector3(-self._mapNode.imgWordTipBg.transform.localPosition.x, self._mapNode.imgWordTipBg.transform.localPosition.y, self._mapNode.imgWordTipBg.transform.localPosition.z)
    end
  end
  self._mapNode.btnCloseWordTip.gameObject:SetActive(true)
  self._mapNode.imgWordTipBg:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPWordDesc, mapWordData.Desc)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPWordTipsTitle, mapWordData.Title)
end

function SkillTipsCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function SkillTipsCtrl:OnBtnClick_ClosePanel(btn)
  if self.rtTarget and not self.rtTarget:IsNull() then
    local btnComp = self.rtTarget:GetComponent("Button")
    if btnComp ~= nil then
      btnComp.interactable = true
    end
    NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", false)
  end
  NovaAPI.SetComponentEnableByName(self._mapNode.imgBranchSkillBg.gameObject, "TopGridCanvas", false)
  EventManager.Hit(EventId.ClosePanel, PanelId.SkillTips)
end

return SkillTipsCtrl
