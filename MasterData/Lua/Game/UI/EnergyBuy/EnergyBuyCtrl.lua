local EnergyBuyCtrl = class("EnergyBuyCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
EnergyBuyCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  imgBlurredBg = {},
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  MainRoot = {
    sNodeName = "---Main---",
    sCtrlName = "Game.UI.EnergyBuy.EnergyBuyMainCtrl"
  },
  ConfirmRoot = {
    sNodeName = "---Confirm---",
    sCtrlName = "Game.UI.EnergyBuy.EnergyBuyConfirmCtrl"
  },
  ItemUseRoot = {
    sNodeName = "---ItemUse---",
    sCtrlName = "Game.UI.EnergyBuy.EnergyItemUseCtrl"
  },
  BatteryUseRoot = {
    sNodeName = "---BatteryUse---",
    sCtrlName = "Game.UI.EnergyBuy.EnergyBatteryUseCtrl"
  },
  goEnergy = {},
  animEnergy = {sNodeName = "goEnergy", sComponentName = "Animator"},
  goResBarAnimRoot = {},
  animResBar = {
    sNodeName = "goResBarAnimRoot",
    sComponentName = "Animator"
  },
  goRecoverTime = {},
  txtRecoverTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Recover_Time"
  },
  rtRecoverTime = {
    sNodeName = "txtRecoverTime",
    sComponentName = "RectTransform"
  },
  txtEnergyRecover = {sComponentName = "TMP_Text"},
  btnBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  }
}
EnergyBuyCtrl._mapEventConfig = {
  [EventId.UpdateEnergy] = "RefreshEnergyRecover",
  [EventId.UpdateEnergyBattery] = "RefreshEnergyRecover",
  ChangeEnergyBuyPanel = "OnEvent_ChangeEnergyBuyPanel",
  CloseEnergyBuyPanel = "OnEvent_CloseEnergyBuyPanel",
  ShowEnergyTopRes = "OnEvent_ShowEnergyTopRes",
  [EventId.IsNewDay] = "OnEvent_NewDay"
}

function EnergyBuyCtrl:Awake()
  self.tbWindowStack = {}
  self.nTopBarId = self._mapNode.TopBar.gameObject:GetInstanceID()
  if self._panel.nPanelType ~= AllEnum.EnergyPanelType.Main then
    self.nDirectPanelType = self._panel.nPanelType
  end
end

function EnergyBuyCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  self._mapNode.btnBg.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  self._mapNode.goResBarAnimRoot.gameObject:SetActive(false)
  self._mapNode.goRecoverTime.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self._mapNode.btnBg.gameObject:SetActive(true)
    table.insert(self.tbWindowStack, self._panel.nPanelType)
    self:ChangePanelType()
  end
  
  cs_coroutine.start(wait)
  self:StartRecoverTimer()
end

function EnergyBuyCtrl:StartRecoverTimer()
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  local nCurEnergyBattery = PlayerData.Base:GetCurEnergyBattery().nEnergyBattery
  local nWorldClassMax = ConfigTable.GetConfigNumber("EnergyMaxLimit")
  local nWorldClassBatteryMax = ConfigTable.GetConfigNumber("EnergyBatteryMax")
  local nEnergyBatteryUIEnable = ConfigTable.GetConfigNumber("EnergyBatteryUIEnable")
  local bUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.EnergyBattery)
  local bShowBattery = bUnlock and 0 < nEnergyBatteryUIEnable
  if nCurEnergy < nWorldClassMax then
    self.nNextRestore = PlayerData.Base:GetCurEnergy().nEnergyTime
    self._mapNode.goRecoverTime.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtRecoverTime, ConfigTable.GetUIText("Energy_Recover_Time"))
    self:RefreshRecoverTime()
    if nil == self.recoverTimer then
      self.recoverTimer = self:AddTimer(0, 1, "RefreshRecoverTime", true, true, false)
    end
  elseif nCurEnergy >= nWorldClassMax and nCurEnergyBattery < nWorldClassBatteryMax and bShowBattery then
    self.nNextRestore = PlayerData.Base:GetCurEnergyBattery().nEnergyBatteryTime
    self._mapNode.goRecoverTime.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtRecoverTime, ConfigTable.GetUIText("EnergyBattery_Recover_Time"))
    self:RefreshRecoverTime()
    if nil == self.recoverTimer then
      self.recoverTimer = self:AddTimer(0, 1, "RefreshRecoverTime", true, true, false)
    end
  else
    if nil ~= self.recoverTimer then
      TimerManager.Remove(self.recoverTimer)
      self.recoverTimer = nil
    end
    self._mapNode.goRecoverTime.gameObject:SetActive(false)
  end
end

function EnergyBuyCtrl:RefreshRecoverTime()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = self.nNextRestore - curTime
  local sTimeStr = ""
  if 0 < remainTime then
    if 60 < remainTime then
      local min = math.floor(remainTime / 60)
      local sec = math.floor(remainTime - min * 60)
      sec = string.format("%02d", sec)
      sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_Recover_Time_Min"), min, sec)
    else
      local sec = string.format("%02d", math.floor(remainTime))
      sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_Recover_Time_Sec"), sec)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtEnergyRecover, sTimeStr)
end

function EnergyBuyCtrl:RefreshEnergyRecover()
  self:StartRecoverTimer()
end

function EnergyBuyCtrl:ChangePanelType()
  self._mapNode.MainRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.EnergyPanelType.Main)
  self._mapNode.ConfirmRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.EnergyPanelType.BuyConfirm)
  self._mapNode.ItemUseRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.EnergyPanelType.ItemUse)
  self._mapNode.BatteryUseRoot.gameObject:SetActive(self._panel.nPanelType == AllEnum.EnergyPanelType.BatteryUse)
  if self.nDirectPanelType ~= nil then
    local bShowEnergy = self.nDirectPanelType == AllEnum.EnergyPanelType.ItemUse
    self._mapNode.goEnergy.gameObject:SetActive(bShowEnergy)
    self._mapNode.goResBarAnimRoot.gameObject:SetActive(not bShowEnergy)
    local sAnim = bShowEnergy and "tc_top_bar_02_t_in" or "tc_top_bar_01_t_in"
    self._mapNode.animResBar:Play(sAnim)
    self.nDirectPanelType = nil
  else
    local bShowRecover = self._panel.nPanelType == AllEnum.EnergyPanelType.Main or self._panel.nPanelType == AllEnum.EnergyPanelType.ItemUse
    local sRecoverAnim = bShowRecover and "EnergyBuy_Time_in" or "EnergyBuy_Time_out"
    local sEnergyAnim = bShowRecover and "tc_top_bar_02_t_in" or "tc_top_bar_02_t_out"
    local sResBarAnim = not bShowRecover and "tc_top_bar_01_t_in" or "tc_top_bar_01_t_out"
    self._mapNode.goResBarAnimRoot.gameObject:SetActive(not bShowRecover)
    self._mapNode.goEnergy.gameObject:SetActive(bShowRecover)
    self._mapNode.animEnergy:Play(sEnergyAnim)
    self.animRoot:Play(sRecoverAnim)
    self._mapNode.animResBar:Play(sResBarAnim)
  end
  if self._panel.nPanelType == AllEnum.EnergyPanelType.Main then
    self._mapNode.MainRoot:ShowPanel()
  elseif self._panel.nPanelType == AllEnum.EnergyPanelType.BuyConfirm then
    self._mapNode.ConfirmRoot:ShowPanel()
  elseif self._panel.nPanelType == AllEnum.EnergyPanelType.ItemUse then
    self._mapNode.ItemUseRoot:ShowPanel()
  elseif self._panel.nPanelType == AllEnum.EnergyPanelType.BatteryUse then
    self._mapNode.BatteryUseRoot:ShowPanel()
  end
end

function EnergyBuyCtrl:ClosePanel(nPanelType)
  self._mapNode.animEnergy:Play("tc_top_bar_02_t_out")
  self._mapNode.animResBar:Play("tc_top_bar_01_t_out")
  self.animRoot:Play("EnergyBuy_Time_out")
  if nPanelType == AllEnum.EnergyPanelType.Main then
    self._mapNode.MainRoot:Close()
  elseif nPanelType == AllEnum.EnergyPanelType.BuyConfirm then
    self._mapNode.ConfirmRoot:Close()
  elseif nPanelType == AllEnum.EnergyPanelType.ItemUse then
    self._mapNode.ItemUseRoot:Close()
  elseif nPanelType == AllEnum.EnergyPanelType.BatteryUse then
    self._mapNode.BatteryUseRoot:Close()
  end
end

function EnergyBuyCtrl:OnDisable()
end

function EnergyBuyCtrl:OnDestroy()
end

function EnergyBuyCtrl:OnEvent_ChangeEnergyBuyPanel(nPanelType)
  self:ClosePanel(self._panel.nPanelType)
  self._panel.nPanelType = nPanelType
  table.insert(self.tbWindowStack, self._panel.nPanelType)
  self:AddTimer(1, 0.3, function()
    self:ChangePanelType()
  end, true, true, true)
end

function EnergyBuyCtrl:OnEvent_CloseEnergyBuyPanel(bCloseAll)
  local nPanelType = table.remove(self.tbWindowStack, #self.tbWindowStack)
  if nPanelType ~= self._panel.nPanelType or bCloseAll then
    EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
  else
    self:ClosePanel(self._panel.nPanelType)
    self:AddTimer(1, 0.3, function()
      if #self.tbWindowStack > 0 then
        self:RefreshEnergyRecover()
        self._panel.nPanelType = self.tbWindowStack[#self.tbWindowStack]
        self:ChangePanelType()
      else
        EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
      end
    end, true, true, true)
  end
end

function EnergyBuyCtrl:OnEvent_ShowEnergyTopRes(bShow)
  self._mapNode.goResBarAnimRoot.gameObject:SetActive(bShow)
end

function EnergyBuyCtrl:OnBtnClick_Close()
  self:OnEvent_CloseEnergyBuyPanel()
end

function EnergyBuyCtrl:OnEvent_NewDay()
  if PanelManager.GetCurPanelId() == PanelId.MainView then
    EventManager.Hit("NewDay_Clear_Guide")
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Alert_NextDay"),
      callbackConfirm = function()
        PanelManager.Home()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

return EnergyBuyCtrl
