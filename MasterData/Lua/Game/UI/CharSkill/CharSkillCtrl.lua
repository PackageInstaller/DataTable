local PlayerCharData = PlayerData.Char
local PlayerCoinData = PlayerData.Coin
local PlayerItemData = PlayerData.Item
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local ConfigData = require("GameCore.Data.ConfigData")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local CharSkillCtrl = class("CharSkillCtrl", BaseCtrl)
CharSkillCtrl._mapNodeConfig = {
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
  goLv = {},
  txtLvWord_Now = {
    sComponentName = "TMP_Text",
    sLanguageId = "Monster_Rank"
  },
  txtLvNum_Now = {sComponentName = "TMP_Text"},
  txtLvWord_Next = {
    sComponentName = "TMP_Text",
    sLanguageId = "Monster_Rank"
  },
  txtLvNum_Next = {sComponentName = "TMP_Text"},
  goLvMax = {},
  txtLvWord_Max = {
    sComponentName = "TMP_Text",
    sLanguageId = "Monster_Rank"
  },
  txtLvNum_Max = {sComponentName = "TMP_Text"},
  txtLvAdd = {nCount = 3, sComponentName = "TMP_Text"},
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
  goMaterial = {},
  goMat = {nCount = 4},
  ctrlMat = {
    sNodeName = "goMat",
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateMatCtrl"
  },
  btnMat = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtn_Mat"
  },
  btnUpgrade = {
    sComponentName = "UIButton",
    callback = "OnBtn_Upgrade"
  },
  txtBtnUpgrade = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterSkill_Upgrade"
  },
  btnAutoFill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AutoFill"
  },
  txtBtnAutoFill = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDevelopment_Btn_Fill"
  },
  txtRequireCharAdv = {
    sComponentName = "TMP_Text",
    sLanguageId = "Talent_Upgrade_SkillUnable"
  },
  goRequireCharAdv = {
    sNodeName = "txtRequireCharAdv"
  },
  txtReqCount = {sComponentName = "TMP_Text"},
  goReqCoin = {},
  imgReqIcon = {sComponentName = "Image"},
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
CharSkillCtrl._mapEventConfig = {
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel",
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelBack",
  CraftingSuccess = "OnEvent_ItemChanged",
  ConsumableUsed = "OnEvent_ItemChanged",
  AutoFillSuccess = "OnEvent_ItemChanged"
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

function CharSkillCtrl:PlayOpenAnim()
end

function CharSkillCtrl:PlayCloseAnim()
end

function CharSkillCtrl:RefreshContent()
  if self._panel.nPanelId ~= PanelId.CharSkill then
    return
  end
  if self.nCharId ~= self._panel.nCharId then
    self._panel.nUpgradeIndex = 1
  end
  self.nCharId = self._panel.nCharId
  self.EET = ConfigTable.GetData_Character(self.nCharId).EET
  self.tbSKillData = {}
  self.sUpgradeError = nil
  self.tbBranchSkillId = PlayerCharData:GetSkillIds(self.nCharId)
  self:RefreshUpgrade()
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_CharSkill")
end

function CharSkillCtrl:PlaySwitchAnim(nClosePanelId, nOpenPanelId, bBack)
  if nClosePanelId == PanelId.CharSkill then
    self._mapNode.contentRoot.gameObject:SetActive(false)
  end
  if nOpenPanelId == PanelId.CharSkill then
    self._mapNode.contentRoot.gameObject:SetActive(true)
  end
end

function CharSkillCtrl:Awake()
  self.nW = 749
  self.nH_min = 391
  self:SetPngSprite(self._mapNode.imgIcon_CD, "Icon/ZZZOther/icon_common_skillinfo_ct")
  self:SetPngSprite(self._mapNode.imgIcon_Cost, "Icon/ZZZOther/icon_common_skillinfo_eny")
  self:SetSprite_Coin(self._mapNode.imgReqIcon, AllEnum.CoinItemId.Gold)
  self._mapCanNotSetAsEnterSkill = {
    [115] = {
      [1] = false,
      [2] = false
    }
  }
end

function CharSkillCtrl:OnEnable()
  self:RefreshContent()
  if self._panel.nPanelId == PanelId.CharSkill then
    self:PlayOpenAnim()
  else
    self._mapNode.contentRoot.gameObject:SetActive(false)
  end
end

function CharSkillCtrl:OnDisable()
end

function CharSkillCtrl:OnDestroy()
end

function CharSkillCtrl:SetCanvasGroup(cg, bVisible)
  NovaAPI.SetCanvasGroupAlpha(cg, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(cg, bVisible == true)
  NovaAPI.SetCanvasGroupInteractable(cg, bVisible == true)
end

function CharSkillCtrl:RefreshUpgrade()
  self.tbSKillData = PlayerCharData:GetCharSkillUpgradeData(self.nCharId)
  self:SetSkillList()
  self:SetUpgrade()
end

function CharSkillCtrl:SetSkillList()
  for i = 1, 4 do
    local mapSkillData = self.tbSKillData[i]
    self._mapNode.ctrlSkill[i]:SetSkill(mapSkillData.nId, i, mapSkillData.nLv, self.EET, mapSkillData.nAddLv)
  end
  self._mapNode.ctrlSkill[self._panel.nUpgradeIndex]:SetSelect(true)
end

function CharSkillCtrl:SetUpgrade()
  local mapSkillData = self.tbSKillData[self._panel.nUpgradeIndex]
  local nId = mapSkillData.nId
  local nLv = mapSkillData.nLv
  local nAddLv = mapSkillData.nAddLv
  local nNextLv = nLv + 1
  local nMaxLv = mapSkillData.nMaxLv
  local mapReq = mapSkillData.mapReq
  local mapCfgData_Skill = ConfigTable.GetData_Skill(nId)
  if nil == mapCfgData_Skill then
    return
  end
  local nCD = FormatNum(mapCfgData_Skill.SkillCD * ConfigData.IntFloatPrecision)
  local nCost = FormatNum(mapCfgData_Skill.UltraEnergy * ConfigData.IntFloatPrecision)
  local bWithCDCost = 0 < nCD or 0 < nCost
  NovaAPI.SetTMPText(self._mapNode.txtLvNum_Now, tostring(nLv))
  NovaAPI.SetTMPText(self._mapNode.txtLvNum_Next, tostring(nNextLv))
  NovaAPI.SetTMPText(self._mapNode.txtLvNum_Max, tostring(nMaxLv))
  for i = 1, 3 do
    self._mapNode.txtLvAdd[i].gameObject:SetActive(0 < nAddLv)
    if 0 < nAddLv then
      NovaAPI.SetTMPText(self._mapNode.txtLvAdd[i], "(+" .. nAddLv .. ")")
    end
  end
  self._mapNode.goLv:SetActive(nLv ~= nMaxLv)
  self._mapNode.goLvMax:SetActive(nLv == nMaxLv)
  local skillShowCfg = AllEnum.SkillTypeShow[self._panel.nUpgradeIndex]
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
  if nNextLv > nMaxLv then
    nNextLv = nil
  end
  local sDesc = nNextLv and UTILS.ParseDesc(mapCfgData_Skill, GameEnum.levelTypeData.SkillSlot, nNextLv + nAddLv) or UTILS.ParseDesc(mapCfgData_Skill)
  local bIsSimpleDescType = PlayerCharData:GetCharPanelSkillDescType()
  self._mapNode.btnSwitch1_on.gameObject:SetActive(bIsSimpleDescType)
  self._mapNode.btnSwitch1_off.gameObject:SetActive(not bIsSimpleDescType)
  self._mapNode.btnSwitch2_on.gameObject:SetActive(bIsSimpleDescType)
  self._mapNode.btnSwitch2_off.gameObject:SetActive(not bIsSimpleDescType)
  local sShowDesc = bIsSimpleDescType and UTILS.ParseDesc(mapCfgData_Skill, GameEnum.levelTypeData.SkillSlot, nil, true) or sDesc
  if self.mapUpgradeSucTips == nil then
    self.mapUpgradeSucTips = {}
  end
  self.mapUpgradeSucTips.nSkillId = nId
  self.mapUpgradeSucTips.nNextLevel = nNextLv
  self.mapUpgradeSucTips.sSkillName = mapCfgData_Skill.Title
  self.mapUpgradeSucTips.sSkillDesc = sDesc
  self.mapUpgradeSucTips.nAddLevel = nAddLv
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
  self:RefreshHeight(nDescAdaptIdx, mapReq == -1)
  if mapReq == -1 then
    self._mapNode.goMaxLv:SetActive(true)
    self._mapNode.goMaterial:SetActive(false)
  else
    self._mapNode.goMaxLv:SetActive(false)
    self._mapNode.goMaterial:SetActive(true)
    local nCharAdvNum = PlayerCharData:GetCharAdvance(self.nCharId)
    local nHasGoldCount = PlayerCoinData:GetCoinCount(AllEnum.CoinItemId.Gold)
    self.sUpgradeError = nil
    local bCanUpgrade = nHasGoldCount >= mapReq.nReqGold
    if bCanUpgrade == false then
      self.sUpgradeError = ConfigTable.GetUIText("PRESENTS_01")
    end
    NovaAPI.SetTMPText(self._mapNode.txtReqCount, tostring(mapReq.nReqGold))
    NovaAPI.SetTMPColor(self._mapNode.txtReqCount, nHasGoldCount >= mapReq.nReqGold and Blue_Normal or Red_Unable)
    local tbNeedMat = {}
    for i, v in ipairs(mapReq.tbReqItem) do
      self._mapNode.goMat[i]:SetActive(true)
      local nItemId = v[1]
      local nItemReqNum = v[2]
      self._mapNode.btnMat[i].interactable = 0 < nItemId and 0 < nItemReqNum
      if 0 < nItemId and 0 < nItemReqNum then
        local nItemHasNum = PlayerItemData:GetItemCountByID(nItemId)
        if nItemReqNum > nItemHasNum then
          self.sUpgradeError = ConfigTable.GetUIText("CharSkill_NotEnoughMat")
        end
        bCanUpgrade = bCanUpgrade == true and nItemReqNum <= nItemHasNum
        self._mapNode.ctrlMat[i]:SetMat(nItemId, nItemReqNum)
        table.insert(tbNeedMat, {nId = nItemId, nCount = nItemReqNum})
      else
        self._mapNode.ctrlMat[i]:SetMat(0)
      end
    end
    self.tbFillStep, self.tbUseItem, self.tbShowNeedItem = PlayerItemData:AutoFillMat(tbNeedMat)
    local bAbleAutoFill = next(self.tbUseItem) ~= nil and nHasGoldCount >= mapReq.nReqGold
    if nCharAdvNum < mapReq.nReqCharAdvNum then
      self.sUpgradeError = orderedFormat(ConfigTable.GetUIText("CharSKill_NotEnoughCharAdvNum"), mapReq.nReqCharAdvNum)
    end
    bCanUpgrade = bCanUpgrade == true and nCharAdvNum >= mapReq.nReqCharAdvNum
    self._mapNode.btnUpgrade.gameObject:SetActive(nCharAdvNum >= mapReq.nReqCharAdvNum and not bAbleAutoFill)
    self._mapNode.btnAutoFill.gameObject:SetActive(nCharAdvNum >= mapReq.nReqCharAdvNum and bAbleAutoFill)
    self._mapNode.goReqCoin:SetActive(nCharAdvNum >= mapReq.nReqCharAdvNum)
    self._mapNode.goRequireCharAdv:SetActive(nCharAdvNum < mapReq.nReqCharAdvNum)
  end
end

function CharSkillCtrl:RefreshHeight(nType, bMax)
  local nOtherHeight = bMax and desc_adapt_ui_cfg[nType].otherHeightMax or desc_adapt_ui_cfg[nType].otherHeight
  local nMaxHeight = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT - nOtherHeight
  
  local function wait()
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.Content[nType])
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

function CharSkillCtrl:OnBtn_Skill(btn)
  local nIndex = btn.transform:GetSiblingIndex() + 1
  if self._panel.nUpgradeIndex == nIndex then
    return
  end
  self._panel.nUpgradeIndex = nIndex
  for i, v in ipairs(self._mapNode.ctrlSkill) do
    v:SetSelect(i == self._panel.nUpgradeIndex)
  end
  self:SetUpgrade()
end

function CharSkillCtrl:OnBtn_Mat(btn)
  local nIndex = 1
  local sName = btn.name
  if sName == "btnMat1" then
    nIndex = 1
  elseif sName == "btnMat2" then
    nIndex = 2
  elseif sName == "btnMat3" then
    nIndex = 3
  elseif sName == "btnMat4" then
    nIndex = 4
  end
  local mapSkillData = self.tbSKillData[self._panel.nUpgradeIndex]
  local mapReq = mapSkillData.mapReq
  if nil ~= mapReq.tbReqItem[nIndex][1] and mapReq.tbReqItem[nIndex][1] > 0 then
    local mapData = {
      nTid = mapReq.tbReqItem[nIndex][1],
      nNeedCount = mapReq.tbReqItem[nIndex][2],
      bShowDepot = true,
      bShowJumpto = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
  end
end

function CharSkillCtrl:OnBtn_Upgrade(btn)
  if self.sUpgradeError ~= nil then
    EventManager.Hit(EventId.OpenMessageBox, self.sUpgradeError)
    return
  end
  
  local function callBack()
    if self.mapUpgradeSucTips ~= nil then
      EventManager.Hit(EventId.OpenPanel, PanelId.SkillSucBar, self.mapUpgradeSucTips, function()
        self:RefreshUpgrade()
      end)
    end
    PlayerData.Voice:PlayCharVoice("charUp", self.nCharId)
  end
  
  PlayerCharData:CharSkillUpgrade(self.nCharId, self._panel.nUpgradeIndex, callBack)
end

function CharSkillCtrl:OnBtnClick_AutoFill()
  EventManager.Hit(EventId.OpenPanel, PanelId.FillMaterial, self.tbFillStep, self.tbUseItem, self.tbShowNeedItem)
end

function CharSkillCtrl:OnBtnClick_Word(link, _, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function CharSkillCtrl:OnBtnClick_CloseWordTip()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function CharSkillCtrl:OnEvent_RefreshPanel()
  self:RefreshContent()
end

function CharSkillCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, false)
  self:RefreshContent()
end

function CharSkillCtrl:OnEvent_PanelBack(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, true)
  self:RefreshContent()
end

function CharSkillCtrl:OnEvent_ItemChanged()
  if self._panel.nPanelId ~= PanelId.CharSkill then
    return
  end
  self:SetUpgrade()
end

function CharSkillCtrl:OnEvent_SetSimpleDesc()
  PlayerCharData:SetCharPanelSkillDescType(true)
  self:SetUpgrade()
end

function CharSkillCtrl:OnEvent_SetDesc()
  PlayerCharData:SetCharPanelSkillDescType(false)
  self:SetUpgrade()
end

function CharSkillCtrl:OnBtnClick_ShowEnergyEff(btn)
  if self.nCharId ~= nil then
    local mapData = {
      nCharId = self.nCharId,
      bCharSkillEnergyEff = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
  end
end

return CharSkillCtrl
