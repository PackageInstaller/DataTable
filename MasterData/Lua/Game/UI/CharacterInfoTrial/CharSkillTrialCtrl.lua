local PlayerCharData = PlayerData.Char
local PlayerCoinData = PlayerData.Coin
local PlayerItemData = PlayerData.Item
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local ConfigData = require("GameCore.Data.ConfigData")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local CharSkillTrialCtrl = class("CharSkillTrialCtrl", BaseCtrl)
CharSkillTrialCtrl._mapNodeConfig = {
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  contentRoot = {
    sNodeName = "----ContentRoot----",
    sComponentName = "RectTransform"
  },
  canvasGroupUpgrade = {
    sNodeName = "--Upgrade--",
    sComponentName = "CanvasGroup"
  },
  ctrlSkill = {
    sNodeName = "goSkill",
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateSkillSelectCtrl"
  },
  btnSkill = {
    sNodeName = "goSkill",
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtn_Skill"
  },
  goLvMax = {},
  txtLvWord_Max = {
    sComponentName = "TMP_Text",
    sLanguageId = "Monster_Rank"
  },
  txtLvNum_Max = {sComponentName = "TMP_Text"},
  goCD = {},
  imgIcon_CD = {sComponentName = "Image"},
  txtProperty_CD = {sComponentName = "TMP_Text", sLanguageId = "Talent_CD"},
  txtValue_CD = {sComponentName = "TMP_Text"},
  goCost = {},
  imgIcon_Cost = {sComponentName = "Image"},
  txtProperty_Cost = {
    sComponentName = "TMP_Text",
    sLanguageId = "Talent_Cost"
  },
  txtValue_Cost = {sComponentName = "TMP_Text"},
  txtIsMaxLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "Talent_MaxLv"
  },
  goMaxLv = {sNodeName = "txtIsMaxLv"},
  goSkillInfoBrief = {},
  imgSkillTypeBg = {sComponentName = "Image"},
  imgSkillType = {sComponentName = "Image"},
  txtSkillType = {sComponentName = "TMP_Text"},
  txtSkillName = {sComponentName = "TMP_Text"},
  goCDCost = {},
  txtSkillDesc = {nCount = 2, sComponentName = "TMP_Text"},
  TMP_Link = {
    nCount = 2,
    sNodeName = "txtSkillDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  goDescNode = {
    nCount = 2,
    sNodeName = "imgSkillBg",
    sComponentName = "RectTransform"
  },
  txtSkillDetailTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Skill_DescTitle"
  },
  ScrollView = {nCount = 2, sComponentName = "ScrollRect"},
  Content = {
    nCount = 2,
    sComponentName = "RectTransform"
  },
  rtSvBg = {
    nCount = 2,
    sComponentName = "RectTransform"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWordTip"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  switch_skillDesc = {nCount = 2},
  switch_name = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "CharSkillDescType"
  },
  btnSwitch1_on = {
    sComponentName = "UIButton",
    callback = "OnEvent_SetDesc"
  },
  btnSwitch1_off = {
    sComponentName = "UIButton",
    callback = "OnEvent_SetSimpleDesc"
  },
  btnSwitch2_on = {
    sComponentName = "UIButton",
    callback = "OnEvent_SetDesc"
  },
  btnSwitch2_off = {
    sComponentName = "UIButton",
    callback = "OnEvent_SetSimpleDesc"
  },
  btEnergyEff = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowEnergyEff"
  }
}
CharSkillTrialCtrl._mapEventConfig = {
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel",
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelBack"
}
local desc_adapt_ui_cfg = {
  [1] = {
    localPosY = -203.6,
    otherHeight = 868.5,
    otherHeightMax = 637.6
  },
  [2] = {
    localPosY = -260.6,
    otherHeight = 925.4,
    otherHeightMax = 694.5
  }
}

function CharSkillTrialCtrl:PlayOpenAnim()
end

function CharSkillTrialCtrl:PlayCloseAnim()
end

function CharSkillTrialCtrl:RefreshContent()
  if self._panel.nPanelId ~= PanelId.CharSkillTrial then
    return
  end
  if self.nCharId ~= self._panel.nCharId then
    self.nUpgradeIndex = 1
  end
  self.nCharId = self._panel.nCharId
  self.EET = ConfigTable.GetData_Character(self.nCharId).EET
  self.tbSKillData = {}
  self.sUpgradeError = nil
  self.tbBranchSkillId = PlayerCharData:GetSkillIds(self.nCharId)
  self:RefreshUpgrade()
end

function CharSkillTrialCtrl:PlaySwitchAnim(nClosePanelId, nOpenPanelId, bBack)
  if nClosePanelId == PanelId.CharSkillTrial then
    self._mapNode.contentRoot.gameObject:SetActive(false)
  end
  if nOpenPanelId == PanelId.CharSkillTrial then
    self._mapNode.contentRoot.gameObject:SetActive(true)
  end
end

function CharSkillTrialCtrl:Awake()
  self.nW = 749
  self.nH_min = 391
  self:SetPngSprite(self._mapNode.imgIcon_CD, "Icon/ZZZOther/icon_common_skillinfo_ct")
  self:SetPngSprite(self._mapNode.imgIcon_Cost, "Icon/ZZZOther/icon_common_skillinfo_eny")
  self._mapCanNotSetAsEnterSkill = {
    [115] = {
      [1] = false,
      [2] = false
    }
  }
  self.nUpgradeIndex = 1
end

function CharSkillTrialCtrl:OnEnable()
  self:RefreshContent()
  if self._panel.nPanelId == PanelId.CharSkillTrial then
    self:PlayOpenAnim()
  else
    self._mapNode.contentRoot.gameObject:SetActive(false)
  end
end

function CharSkillTrialCtrl:OnDisable()
end

function CharSkillTrialCtrl:OnDestroy()
end

function CharSkillTrialCtrl:SetCanvasGroup(cg, bVisible)
  NovaAPI.SetCanvasGroupAlpha(cg, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(cg, bVisible == true)
  NovaAPI.SetCanvasGroupInteractable(cg, bVisible == true)
end

function CharSkillTrialCtrl:RefreshUpgrade()
  self.tbSKillData = PlayerCharData:GetSkillIds(self.nCharId)
  self.tbSkillLevels = self._panel.mapCharTrialInfo.tbSkillLvs
  self:SetSkillList()
  self:SetUpgrade()
end

function CharSkillTrialCtrl:SetSkillList()
  for i = 1, 4 do
    self._mapNode.ctrlSkill[i]:SetSkill(self.tbSKillData[i], i, self.tbSkillLevels[i], self.EET, 0)
  end
  self._mapNode.ctrlSkill[self.nUpgradeIndex]:SetSelect(true)
end

function CharSkillTrialCtrl:SetUpgrade()
  local mapSkillData = self.tbSKillData[self.nUpgradeIndex]
  local nId = mapSkillData
  local mapCfgData_Skill = ConfigTable.GetData_Skill(nId)
  if nil == mapCfgData_Skill then
    return
  end
  local nCD = FormatNum(mapCfgData_Skill.SkillCD * ConfigData.IntFloatPrecision)
  local nCost = FormatNum(mapCfgData_Skill.UltraEnergy * ConfigData.IntFloatPrecision)
  NovaAPI.SetTMPText(self._mapNode.txtLvNum_Max, tostring(self.tbSkillLevels[self.nUpgradeIndex]))
  self._mapNode.goLvMax:SetActive(true)
  local skillShowCfg = AllEnum.SkillTypeShow[self.nUpgradeIndex]
  NovaAPI.SetTMPText(self._mapNode.txtSkillType, ConfigTable.GetUIText(skillShowCfg.sLanguageId))
  local skillTypeIconIdx = skillShowCfg.iconIndex
  self:SetAtlasSprite(self._mapNode.imgSkillType, "05_language", "zs_character_skill_text_" .. skillTypeIconIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgSkillType)
  local _, _color = ColorUtility.TryParseHtmlString(skillShowCfg.bgColor)
  NovaAPI.SetImageColor(self._mapNode.imgSkillTypeBg, _color)
  NovaAPI.SetTMPText(self._mapNode.txtSkillName, mapCfgData_Skill.Title)
  local sCD = tostring(nCD) .. ConfigTable.GetUIText("Talent_Sec")
  local sCost = tostring(nCost)
  if nCD <= 0 then
    sCD = ConfigTable.GetUIText("Skill_NoCD")
  end
  if nCost <= 0 then
    sCost = ConfigTable.GetUIText("Skill_NoCost")
  end
  NovaAPI.SetTMPText(self._mapNode.txtValue_CD, sCD)
  NovaAPI.SetTMPText(self._mapNode.txtValue_Cost, sCost)
  local bVisibleCD, bVisibleCost = false, false
  if mapCfgData_Skill.Type == GameEnum.skillType.NORMAL then
    bVisibleCD, bVisibleCost = false, false
  elseif mapCfgData_Skill.Type == GameEnum.skillType.SKILL or mapCfgData_Skill.Type == GameEnum.skillType.SUPPORT or mapCfgData_Skill.Type == GameEnum.skillType.OTHER_SKILL then
    bVisibleCD, bVisibleCost = true, false
  elseif mapCfgData_Skill.Type == GameEnum.skillType.ULTIMATE then
    bVisibleCD, bVisibleCost = true, true
  end
  self._mapNode.goCDCost:SetActive(bVisibleCD or bVisibleCost)
  self._mapNode.goCD:SetActive(bVisibleCD)
  self._mapNode.goCost:SetActive(bVisibleCost)
  local bWithCDCost = bVisibleCD == true or bVisibleCost == true
  local sDesc = UTILS.ParseDesc(mapCfgData_Skill)
  local bIsSimpleDescType = PlayerCharData:GetCharPanelSkillDescType()
  self._mapNode.btnSwitch1_on.gameObject:SetActive(bIsSimpleDescType)
  self._mapNode.btnSwitch1_off.gameObject:SetActive(not bIsSimpleDescType)
  self._mapNode.btnSwitch2_on.gameObject:SetActive(bIsSimpleDescType)
  self._mapNode.btnSwitch2_off.gameObject:SetActive(not bIsSimpleDescType)
  local sShowDesc = bIsSimpleDescType and UTILS.ParseDesc(mapCfgData_Skill, GameEnum.levelTypeData.SkillSlot, nil, true, 10) or sDesc
  local nDescAdaptIdx = (bVisibleCD or bVisibleCost) and 2 or 1
  self._mapNode.goDescNode[1].gameObject:SetActive(nDescAdaptIdx == 1)
  self._mapNode.goDescNode[2].gameObject:SetActive(nDescAdaptIdx == 2)
  self._mapNode.switch_skillDesc[1].gameObject:SetActive(nDescAdaptIdx == 1)
  self._mapNode.switch_skillDesc[2].gameObject:SetActive(nDescAdaptIdx == 2)
  if nDescAdaptIdx == 1 then
    NovaAPI.SetTMPText(self._mapNode.txtSkillDesc[1], sShowDesc)
    NovaAPI.SetTMPText(self._mapNode.txtSkillDesc[2], "")
  else
    NovaAPI.SetTMPText(self._mapNode.txtSkillDesc[1], "")
    NovaAPI.SetTMPText(self._mapNode.txtSkillDesc[2], sShowDesc)
  end
end

function CharSkillTrialCtrl:RefreshHeight(nType, bMax)
  local nOtherHeight = bMax and desc_adapt_ui_cfg[nType].otherHeightMax or desc_adapt_ui_cfg[nType].otherHeight
  local nMaxHeight = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT - nOtherHeight
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nContentH = self._mapNode.Content[nType].rect.height
    local bOver = nContentH > nMaxHeight
    local nHeight = bOver and nMaxHeight or nContentH
    NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView[nType], bOver)
    self._mapNode.rtSvBg[nType].sizeDelta = Vector2(self._mapNode.rtSvBg[nType].rect.width, nHeight)
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView[nType], 1)
  end
  
  cs_coroutine.start(wait)
end

function CharSkillTrialCtrl:OnBtn_Skill(btn)
  local nIndex = btn.transform:GetSiblingIndex() + 1
  if self.nUpgradeIndex == nIndex then
    return
  end
  self.nUpgradeIndex = nIndex
  for i, v in ipairs(self._mapNode.ctrlSkill) do
    v:SetSelect(i == self.nUpgradeIndex)
  end
  self:SetUpgrade()
end

function CharSkillTrialCtrl:OnBtnClick_Word(link, _, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function CharSkillTrialCtrl:OnBtnClick_CloseWordTip()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function CharSkillTrialCtrl:OnEvent_RefreshPanel()
  self:RefreshContent()
end

function CharSkillTrialCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, false)
  self:RefreshContent()
end

function CharSkillTrialCtrl:OnEvent_PanelBack(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, true)
  self:RefreshContent()
end

function CharSkillTrialCtrl:OnEvent_SetSimpleDesc()
  PlayerCharData:SetCharPanelSkillDescType(true)
  self:SetUpgrade()
end

function CharSkillTrialCtrl:OnEvent_SetDesc()
  PlayerCharData:SetCharPanelSkillDescType(false)
  self:SetUpgrade()
end

function CharSkillTrialCtrl:OnBtnClick_ShowEnergyEff(btn)
  if self.nCharId ~= nil then
    local mapData = {
      nCharId = self.nCharId,
      bCharSkillEnergyEff = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
  end
end

return CharSkillTrialCtrl
