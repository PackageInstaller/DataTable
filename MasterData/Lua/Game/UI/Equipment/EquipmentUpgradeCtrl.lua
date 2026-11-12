local EquipmentUpgradeCtrl = class("EquipmentUpgradeCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
EquipmentUpgradeCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseBg = {
    sNodeName = "snapshot1",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Upgrade_WindowTitle"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtEquipmentName = {sComponentName = "TMP_Text"},
  btnProperty = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Property"
  },
  goProperty = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  imgOff = {nCount = 4},
  imgOn = {nCount = 4},
  imgMax = {nCount = 4},
  txtTitleMat = {sComponentName = "TMP_Text"},
  goTip = {},
  goRevert = {},
  goUpgrade = {},
  goPropertyRevert = {
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  txtUpgradeTip = {nCount = 2, sComponentName = "TMP_Text"},
  goMat = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateMatCtrl"
  },
  btnMat = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_MatTip"
  },
  btnUpgrade = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Upgrade"
  },
  btnRevert = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Revert"
  },
  btnAutoFill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AutoFill"
  },
  txtBtnAutoFill = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDevelopment_Btn_Fill"
  },
  txtBtnUpgrade = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_Upgrade"
  },
  txtBtnRevert = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_Revert"
  },
  imgCostIcon = {sComponentName = "Image"},
  txtCostCount = {sComponentName = "TMP_Text"},
  goCostCoin = {},
  goMaxUpgrade = {},
  animPopUpBlur = {
    sNodeName = "goMaxUpgradeBlur",
    sComponentName = "Animator"
  },
  animPopUpWindow = {
    sNodeName = "goMaxUpgradeWindow",
    sComponentName = "Animator"
  },
  txtPopUpTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Title"
  },
  txtMaxUpgradeTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Upgrade_MaxUpgradeTip"
  },
  goPropertyPopUp = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  btnOK = {sComponentName = "UIButton"},
  txtBtnOK = {sComponentName = "TMP_Text", sLanguageId = "BtnConfirm"},
  btnNG = {sComponentName = "UIButton"},
  txtBtnNG = {sComponentName = "TMP_Text", sLanguageId = "BtnCancel"},
  btnPopUpClose = {sComponentName = "UIButton", callback = "ClosePopUp"},
  btnPopUpCloseBig = {sComponentName = "UIButton", callback = "ClosePopUp"}
}
EquipmentUpgradeCtrl._mapEventConfig = {
  AutoFillSuccess = "OnEvent_ItemChanged"
}

function EquipmentUpgradeCtrl:Open()
  self._mapNode.blur:SetActive(true)
  self:PlayInAni()
  self:Refresh()
end

function EquipmentUpgradeCtrl:Refresh()
  self:RefreshData()
  self:RefreshProperty()
  self:RefreshInfo()
  self:RefreshDesc()
end

function EquipmentUpgradeCtrl:RefreshData()
  local nGemId = PlayerData.Equipment:GetGemIdBySlot(self.nCharId, self.nSlotId)
  self.mapGemCfg = ConfigTable.GetData("CharGem", nGemId)
  self.mapSlotCfg = ConfigTable.GetData("CharGemSlotControl", self.nSlotId)
  local tbEquipment = PlayerData.Equipment:GetEquipmentBySlot(self.nCharId, self.nSlotId)
  self.mapEquipment = tbEquipment[self.nSelectGemIndex]
  local tbNeedMat = {
    {
      nId = self.mapGemCfg.OverlockCostTid,
      nCount = self.mapSlotCfg.OverlockCostQty
    }
  }
  self.tbFillStep, self.tbUseItem, self.tbShowNeedItem = PlayerData.Item:AutoFillMat(tbNeedMat)
  local nHasCoin = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold)
  self.bAbleAutoFill = next(self.tbUseItem) ~= nil and nHasCoin >= self.mapSlotCfg.OverlockDoraCostQty
end

function EquipmentUpgradeCtrl:RefreshInfo()
  local sRoman = ConfigTable.GetUIText("RomanNumeral_" .. self.nSelectGemIndex)
  local sSuf = orderedFormat(ConfigTable.GetUIText("Equipment_NameIndexSuffix"), sRoman)
  NovaAPI.SetTMPText(self._mapNode.txtEquipmentName, self.mapGemCfg.Title .. sSuf)
end

function EquipmentUpgradeCtrl:RefreshProperty()
  for i = 1, 4 do
    if self.nSelectUpgradeIndex == i then
      local bSelectChanged = false
      local nId = self.mapEquipment.tbAffix[self.nSelectUpgradeIndex]
      local mapCfg = ConfigTable.GetData("CharGemAttrValue", nId)
      if mapCfg then
        local nLeft = mapCfg.OverlockCount - self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex]
        if 0 < nLeft then
          bSelectChanged = true
        end
      end
      if bSelectChanged then
        self._mapNode.goProperty[i]:SetProperty(self.mapEquipment.tbAffix[i], self.nCharId, false, self.mapEquipment.tbUpgradeCount[i] + 1)
      else
        self._mapNode.goProperty[i]:SetProperty(self.mapEquipment.tbAffix[i], self.nCharId, false, self.mapEquipment.tbUpgradeCount[i])
      end
    else
      self._mapNode.goProperty[i]:SetProperty(self.mapEquipment.tbAffix[i], self.nCharId, false, self.mapEquipment.tbUpgradeCount[i])
    end
    self._mapNode.imgMax[i]:SetActive(false)
    self._mapNode.imgOff[i]:SetActive(self.nSelectUpgradeIndex ~= i)
    self._mapNode.imgOn[i]:SetActive(self.nSelectUpgradeIndex == i)
  end
end

function EquipmentUpgradeCtrl:RefreshDesc()
  self._mapNode.goRevert:SetActive(false)
  self._mapNode.goUpgrade:SetActive(false)
  self._mapNode.btnUpgrade.gameObject:SetActive(true)
  self._mapNode.btnAutoFill.gameObject:SetActive(false)
  self._mapNode.goTip:SetActive(false)
  self._mapNode.goCostCoin:SetActive(false)
  local nUpgradeCount = self.mapEquipment:GetUpgradeCount()
  local nLimit = ConfigTable.GetConfigNumber("CharGemOverlockCount")
  local bAble = nUpgradeCount < nLimit
  if bAble then
    if self.nSelectUpgradeIndex == 0 then
      self._mapNode.goTip:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtUpgradeTip[1], orderedFormat(ConfigTable.GetUIText("Equipment_Upgrade_NeedSelect"), nLimit - nUpgradeCount))
      NovaAPI.SetTMPText(self._mapNode.txtTitleMat, ConfigTable.GetUIText("Equipment_Upgrade_OptionTitle"))
    elseif self.nSelectUpgradeIndex ~= 0 then
      local nId = self.mapEquipment.tbAffix[self.nSelectUpgradeIndex]
      local mapCfg = ConfigTable.GetData("CharGemAttrValue", nId)
      if mapCfg then
        local nLeft = mapCfg.OverlockCount - self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex]
        if 0 < nLeft then
          self._mapNode.goUpgrade:SetActive(true)
          self._mapNode.btnUpgrade.gameObject:SetActive(not self.bAbleAutoFill)
          self._mapNode.btnAutoFill.gameObject:SetActive(self.bAbleAutoFill)
          self._mapNode.goMat[1]:SetMat(self.mapGemCfg.OverlockCostTid, self.mapSlotCfg.OverlockCostQty)
          self._mapNode.goMat[2]:SetMat(AllEnum.CoinItemId.Gold, self.mapSlotCfg.OverlockDoraCostQty)
          self:RefreshCoin()
          NovaAPI.SetTMPText(self._mapNode.txtTitleMat, ConfigTable.GetUIText("Equipment_Upgrade_CostTitle"))
        else
          self._mapNode.goTip:SetActive(true)
          NovaAPI.SetTMPText(self._mapNode.txtUpgradeTip[1], ConfigTable.GetUIText("Equipment_Upgrade_MaxLevel"))
          NovaAPI.SetTMPText(self._mapNode.txtTitleMat, ConfigTable.GetUIText("Equipment_Upgrade_OptionTitle"))
        end
      end
    end
  elseif self.nSelectUpgradeIndex == 0 then
    self._mapNode.goTip:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtUpgradeTip[1], orderedFormat(ConfigTable.GetUIText("Equipment_Upgrade_NeedSelect"), nLimit - nUpgradeCount))
    NovaAPI.SetTMPText(self._mapNode.txtTitleMat, ConfigTable.GetUIText("Equipment_Upgrade_OptionTitle"))
  elseif self.nSelectUpgradeIndex ~= 0 then
    if 0 < self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex] then
      self._mapNode.goRevert:SetActive(true)
      self._mapNode.goPropertyRevert:SetProperty(self.mapEquipment.tbAffix[self.nSelectUpgradeIndex], self.nCharId, false, self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex] - 1)
      NovaAPI.SetTMPText(self._mapNode.txtUpgradeTip[2], orderedFormat(ConfigTable.GetUIText("Equipment_Upgrade_RevertDesc"), nLimit - nUpgradeCount + 1))
      NovaAPI.SetTMPText(self._mapNode.txtTitleMat, ConfigTable.GetUIText("Equipment_Upgrade_RevertTitle"))
    else
      self._mapNode.goTip:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtUpgradeTip[1], ConfigTable.GetUIText("Equipment_Upgrade_MaxLimit"))
      NovaAPI.SetTMPText(self._mapNode.txtTitleMat, ConfigTable.GetUIText("Equipment_Upgrade_OptionTitle"))
    end
  end
end

function EquipmentUpgradeCtrl:RefreshCoin()
  self._mapNode.goCostCoin:SetActive(true)
  self:SetSprite_Coin(self._mapNode.imgCostIcon, AllEnum.CoinItemId.Gold)
  local nHasCoin = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.Gold)
  NovaAPI.SetTMPText(self._mapNode.txtCostCount, self.mapSlotCfg.OverlockDoraCostQty)
  NovaAPI.SetTMPColor(self._mapNode.txtCostCount, nHasCoin < self.mapSlotCfg.OverlockDoraCostQty and Red_Unable or Blue_Normal)
end

function EquipmentUpgradeCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function EquipmentUpgradeCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function EquipmentUpgradeCtrl:Close()
  self._mapNode.window:SetActive(false)
  self.bManualClose = true
  EventManager.Hit(EventId.ClosePanel, PanelId.EquipmentUpgrade)
end

function EquipmentUpgradeCtrl:CheckMaxUpgrade(nId, nIdx)
  local nIndex = 0
  if nIdx ~= nil then
    nIndex = nIdx
  else
    nIndex = self.nSelectUpgradeIndex
  end
  local nCurId = nId + self.mapEquipment.tbUpgradeCount[nIndex]
  local nNextId = nCurId + 1
  local mapNextLevel = ConfigTable.GetData("CharGemAttrValue", nNextId)
  return mapNextLevel ~= nil and mapNextLevel.OverlockCount == 0
end

function EquipmentUpgradeCtrl:Awake()
  self._mapNode.window:SetActive(false)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
    self.nSlotId = tbParam[2]
    self.nSelectGemIndex = tbParam[3]
    self.nSelectUpgradeIndex = tbParam[4] or 0
  end
end

function EquipmentUpgradeCtrl:OnEnable()
  self:Open()
end

function EquipmentUpgradeCtrl:OnDisable()
  if not self.bManualClose then
    PlayerData.Equipment:CacheEquipmentUpgrade(self.nSlotId, self.nSelectGemIndex, self.nCharId, self.nSelectUpgradeIndex)
  end
end

function EquipmentUpgradeCtrl:OnDestroy()
end

function EquipmentUpgradeCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function EquipmentUpgradeCtrl:OnBtnClick_Property(_, nIndex)
  local nBefore = self.nSelectUpgradeIndex
  if self.nSelectUpgradeIndex == nIndex then
    self.nSelectUpgradeIndex = 0
  else
    self.nSelectUpgradeIndex = nIndex
  end
  self:RefreshDesc()
  for i = 1, 4 do
    self._mapNode.imgMax[i]:SetActive(false)
    self._mapNode.imgOff[i]:SetActive(self.nSelectUpgradeIndex ~= i)
    self._mapNode.imgOn[i]:SetActive(self.nSelectUpgradeIndex == i)
  end
  if nBefore ~= 0 then
    self._mapNode.goProperty[nBefore]:SetProperty(self.mapEquipment.tbAffix[nBefore], self.nCharId, false, self.mapEquipment.tbUpgradeCount[nBefore])
  end
  if self.nSelectUpgradeIndex ~= 0 then
    local nUpgradeCount = self.mapEquipment:GetUpgradeCount()
    local nLimit = ConfigTable.GetConfigNumber("CharGemOverlockCount")
    local bAble = nUpgradeCount < nLimit
    local bSelectChanged = false
    local nId = self.mapEquipment.tbAffix[self.nSelectUpgradeIndex]
    local mapCfg = ConfigTable.GetData("CharGemAttrValue", nId)
    if mapCfg then
      local nLeft = mapCfg.OverlockCount - self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex]
      if 0 < nLeft then
        bSelectChanged = true
      end
    end
    if bSelectChanged and bAble then
      local nCurId = self.mapEquipment.tbAffix[nIndex]
      local bMaxUpgrade = self:CheckMaxUpgrade(nCurId, nIndex)
      self._mapNode.imgMax[nIndex]:SetActive(bMaxUpgrade)
      self._mapNode.goProperty[self.nSelectUpgradeIndex]:PlayUpgradeAni(self.mapEquipment.tbAffix[self.nSelectUpgradeIndex], self.nCharId, false, self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex] + 1)
    end
  end
end

function EquipmentUpgradeCtrl:OnBtnClick_Upgrade()
  if self.nSelectUpgradeIndex == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_NeedToSelectAffix"))
    return
  end
  local bAble = self.mapEquipment:CheckUpgradeAble()
  if not bAble then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_UpgradeCountEmpty"))
    return
  end
  local nId = self.mapEquipment.tbAffix[self.nSelectUpgradeIndex]
  local mapCfg = ConfigTable.GetData("CharGemAttrValue", nId)
  if not mapCfg then
    return
  end
  local nLeft = mapCfg.OverlockCount - self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex]
  if nLeft <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_SelectAffixMax"))
    return
  end
  local nHas = PlayerData.Item:GetItemCountByID(self.mapGemCfg.OverlockCostTid)
  local nHasCoin = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.Gold)
  local bEnough = nHas >= self.mapSlotCfg.OverlockCostQty and nHasCoin >= self.mapSlotCfg.OverlockDoraCostQty
  if not bEnough then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_MatNotEnough_Upgrade"))
    if nHas < self.mapSlotCfg.OverlockCostQty then
      self:OnBtnClick_MatTip(self._mapNode.btnMat[1], 1)
    end
    return
  end
  
  local function upgrade()
    local sCost = ""
    local mapItemCfg = ConfigTable.GetData_Item(self.mapGemCfg.OverlockCostTid)
    if mapItemCfg then
      sCost = mapItemCfg.Title
    end
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("Equipment_Upgrade_MainTips"), self.mapSlotCfg.OverlockCostQty, sCost),
      sContentSub = ConfigTable.GetUIText("Equipment_Upgrade_SubTips"),
      callbackConfirmAfterClose = function()
        local function callback()
          local mapData = {
            nAffixId = nId,
            
            nCharId = self.nCharId,
            nUpgradeCount = self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex]
          }
          self._mapNode.aniWindow:Play("t_window_04_t_out")
          self._mapNode.aniBlur:SetTrigger("tOut")
          self:AddTimer(1, 0.2, function()
            self._mapNode.blur:SetActive(false)
            EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentSucBar, mapData, function()
              self._mapNode.blur:SetActive(true)
              self._mapNode.aniWindow:Play("t_window_04_t_in")
              WwiseAudioMgr:PostEvent("ui_common_menu2")
              EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
              self.nSelectUpgradeIndex = 0
              self:Refresh()
            end)
          end, true, true, true)
          EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
        end
        
        PlayerData.Equipment:SendCharGemOverlockReq(self.nCharId, self.nSlotId, self.nSelectGemIndex, self.nSelectUpgradeIndex, callback)
      end,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local function confirm()
    self:ClosePopUp()
    local bSame = self.mapEquipment:CheckUpgradeAlterSame(self.nSelectUpgradeIndex)
    if not bSame then
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Equipment_Upgrade_AlterHasNotSameAffix"),
        callbackConfirmAfterClose = upgrade,
        bBlur = false
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    else
      upgrade()
    end
  end
  
  local nCurId = nId + self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex]
  local nNextId = nCurId + 1
  local mapNextLevel = ConfigTable.GetData("CharGemAttrValue", nNextId)
  local bMaxUpgrade = mapNextLevel ~= nil and mapNextLevel.OverlockCount == 0
  if bMaxUpgrade then
    self:OpenPopUp()
    self._mapNode.goPropertyPopUp[1]:SetProperty(nCurId, self.nCharId)
    self._mapNode.goPropertyPopUp[2]:SetProperty(nNextId, self.nCharId)
    self._mapNode.btnOK.onClick:RemoveAllListeners()
    self._mapNode.btnOK.onClick:AddListener(confirm)
    self._mapNode.btnNG.onClick:RemoveAllListeners()
    self._mapNode.btnNG.onClick:AddListener(function()
      self:ClosePopUp()
    end)
  else
    confirm()
  end
end

function EquipmentUpgradeCtrl:OpenPopUp()
  self._mapNode.goMaxUpgrade:SetActive(true)
  self._mapNode.animPopUpWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function EquipmentUpgradeCtrl:ClosePopUp()
  if self._mapNode.goMaxUpgrade.activeSelf == false then
    return
  end
  self._mapNode.animPopUpWindow:Play("t_window_04_t_out")
  self._mapNode.animPopUpBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, function()
    self._mapNode.goMaxUpgrade:SetActive(false)
  end, true, true, true)
end

function EquipmentUpgradeCtrl:OnBtnClick_Revert()
  if self.nSelectUpgradeIndex == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_NeedToSelectAffix"))
    return
  end
  if self.mapEquipment.tbUpgradeCount[self.nSelectUpgradeIndex] == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_CanNotRevert"))
    return
  end
  local sCost = ""
  local mapItemCfg = ConfigTable.GetData_Item(self.mapGemCfg.OverlockCostTid)
  if mapItemCfg then
    sCost = mapItemCfg.Title
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Equipment_Revert_MainTips"),
    sContentSub = orderedFormat(ConfigTable.GetUIText("Equipment_Revert_SubTips"), sCost),
    callbackConfirmAfterClose = function()
      local function callback()
        self._mapNode.aniWindow:Play("t_window_04_t_out")
        
        self:AddTimer(1, 0.2, function()
          self._mapNode.aniWindow:Play("t_window_04_t_in")
          WwiseAudioMgr:PostEvent("ui_common_menu2")
          EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
          self.nSelectUpgradeIndex = 0
          self:Refresh()
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_RevertSuccess"))
        end, true, true, true)
        EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
      end
      
      PlayerData.Equipment:SendCharGemOverlockRevertReq(self.nCharId, self.nSlotId, self.nSelectGemIndex, self.nSelectUpgradeIndex, callback)
    end,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function EquipmentUpgradeCtrl:OnBtnClick_AutoFill()
  EventManager.Hit(EventId.OpenPanel, PanelId.FillMaterial, self.tbFillStep, self.tbUseItem, self.tbShowNeedItem)
end

function EquipmentUpgradeCtrl:OnBtnClick_MatTip(btn, index)
  if index == 1 then
    if self.mapGemCfg.OverlockCostTid > 0 then
      local mapData = {
        nTid = self.mapGemCfg.OverlockCostTid,
        nNeedCount = self.mapSlotCfg.OverlockCostQty,
        bShowDepot = true,
        bShowJumpto = true
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
    end
  else
    local mapData = {
      nTid = AllEnum.CoinItemId.Gold,
      nNeedCount = self.mapSlotCfg.OverlockDoraCostQty,
      bShowDepot = true,
      bShowJumpto = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
  end
end

function EquipmentUpgradeCtrl:OnEvent_ItemChanged()
  self:RefreshData()
  self:RefreshDesc()
end

return EquipmentUpgradeCtrl
