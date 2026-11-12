local EnergyBatteryUseCtrl = class("EnergyBatteryUseCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
EnergyBatteryUseCtrl._mapNodeConfig = {
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Battery_Use_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtItemName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Battery_Title"
  },
  txtItemDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Battery_Desc"
  },
  txtHaveCount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Count_Text"
  },
  txtHaveCountValue = {sComponentName = "TMP_Text"},
  txtBatteryUseTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Battery_Use_Amount"
  },
  txtBatteryUseValue = {sComponentName = "TMP_Text"},
  goQuantitySlider = {
    sNodeName = "tc_quantity_slider",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySliderCtrl"
  },
  txtHave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Buy_Confirm_Text"
  },
  imgArrow = {},
  txtBeforeValue = {sComponentName = "TMP_Text"},
  txtAfterValue = {sComponentName = "TMP_Text"},
  goMaxValue = {},
  txtMaxValue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Count_Max"
  },
  rtCountBg = {
    sNodeName = "imgCountBg",
    sComponentName = "RectTransform"
  },
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtConfirmBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Btn_Text"
  }
}
EnergyBatteryUseCtrl._mapEventConfig = {
  [EventId.UpdateEnergyBattery] = "OnEvent_UpdateEnergyBattery"
}

function EnergyBatteryUseCtrl:Awake()
  self.bEnable = false
end

function EnergyBatteryUseCtrl:OnEnable()
  self.bEnable = true
end

function EnergyBatteryUseCtrl:ShowPanel()
  self.bBlur = self._panel.bBlur
  self.nUseCount = 1
  self.nMaxCount = 0
  self.nMinCount = 0
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:RefreshUseLimit()
  
  local function callback(nCount)
    self.nUseCount = nCount
    self:RefreshAddCount()
  end
  
  self._mapNode.goQuantitySlider:Init(callback, self.nUseCount, self.nMaxCount)
  self:RefreshAddCount()
end

function EnergyBatteryUseCtrl:OnDisable()
  self.bEnable = false
end

function EnergyBatteryUseCtrl:OnDestroy()
end

function EnergyBatteryUseCtrl:RefreshUseLimit()
  local nCurEnergyBattery = PlayerData.Base:GetCurEnergyBattery().nEnergyBattery
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyObtainLimit")
  local nMaxCount = nMaxEnergy - nCurEnergy
  NovaAPI.SetTMPText(self._mapNode.txtHaveCountValue, nCurEnergyBattery)
  self.nMaxCount = nCurEnergyBattery < nMaxCount and nCurEnergyBattery or nMaxCount
end

function EnergyBatteryUseCtrl:RefreshAddCount()
  NovaAPI.SetTMPText(self._mapNode.txtBatteryUseValue, self.nUseCount)
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.txtBeforeValue, nCurEnergy)
  if self.nUseCount > self.nMaxCount then
    self.nUseCount = self.nMaxCount
  elseif self.nUseCount < 1 then
    self.nUseCount = 1
  end
  local nAfterValue = nCurEnergy + self.nUseCount
  NovaAPI.SetTMPText(self._mapNode.txtAfterValue, nAfterValue)
  self._mapNode.imgArrow.gameObject:SetActive(self.nUseCount > 0)
  self._mapNode.txtAfterValue.gameObject:SetActive(self.nUseCount > 0)
  self._mapNode.goMaxValue.gameObject:SetActive(nAfterValue >= self._panel.nMaxEnergy)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCountBg)
end

function EnergyBatteryUseCtrl:Close()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit("ConsumableUsed")
end

function EnergyBatteryUseCtrl:OnBtnClick_Close()
  EventManager.Hit("CloseEnergyBuyPanel")
end

function EnergyBatteryUseCtrl:OnBtnClick_Confirm()
  if self.nUseCount <= 0 then
    return
  end
  if self.nUseCount > self.nMaxCount then
    local sTip = ConfigTable.GetUIText("Energy_Use_Tip_2")
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = sTip,
      bBlur = false
    })
    return
  end
  
  local function msgCallback()
    EventManager.Hit(EventId.OpenPanel, PanelId.ReceivePropsTips, {
      {
        id = AllEnum.CoinItemId.Energy,
        count = self.nUseCount
      }
    })
    EventManager.Hit("CloseEnergyBuyPanel")
  end
  
  PlayerData.Base:SendEnergyBatteryExtract(self.nUseCount, msgCallback)
end

function EnergyBatteryUseCtrl:OnEvent_UpdateEnergyBattery()
end

return EnergyBatteryUseCtrl
