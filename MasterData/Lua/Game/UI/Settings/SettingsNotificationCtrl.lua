local SettingsNotificationCtrl = class("SettingsNotificationCtrl", BaseCtrl)
local UIGameSystemSetup = CS.UIGameSystemSetup
SettingsNotificationCtrl._mapNodeConfig = {
  txtPageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Notification"
  },
  txtForwardNews = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Notification_ForwardNews"
  },
  Energy = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  Dispatch = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  }
}
SettingsNotificationCtrl._mapEventConfig = {}

function SettingsNotificationCtrl:RefreshText()
  self._mapNode.Energy:SetText(ConfigTable.GetUIText("Settings_Notification_Energy"))
  self._mapNode.Dispatch:SetText(ConfigTable.GetUIText("Settings_Notification_Dispatch"))
end

function SettingsNotificationCtrl:Init()
  if self.bInit then
    return
  end
  self.bInit = true
  self:LoadSetting()
  if not self.bFirstIn then
    return
  end
  local sState = NovaAPI.GetNotificationSettings()
  if sState == "Denied" and (self.energy or self.dispatch) then
    local data = {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Settings_Notification_Tip"),
      callbackConfirm = function()
        self.energy = false
        self.dispatch = false
        self._mapNode.Energy:SetOn(false)
        self._mapNode.Dispatch:SetOn(false)
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, data)
  end
end

function SettingsNotificationCtrl:Quit()
  if not self.bInit then
    return
  end
end

function SettingsNotificationCtrl:LoadSetting()
  self.bFirstIn = self._panel:LoadLocalData("Notification")
  self.energy = self._panel:LoadLocalData("Energy")
  self._mapNode.Energy:Init(function()
    self.energy = not self.energy
    local sState = NovaAPI.GetNotificationSettings()
    if sState == "Denied" and self.energy then
      local data = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Settings_Notification_Confirm"),
        callbackConfirm = function()
          self.energy = false
          self._mapNode.Energy:SetOn(false)
        end,
        callbackCancel = function()
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, data)
    end
  end, self.energy)
  self.dispatch = self._panel:LoadLocalData("Dispatch")
  self._mapNode.Dispatch:Init(function()
    self.dispatch = not self.dispatch
    local sState = NovaAPI.GetNotificationSettings()
    if sState == "Denied" and self.dispatch then
      local data = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Settings_Notification_Confirm"),
        callbackConfirm = function()
          self.dispatch = false
          self._mapNode.Dispatch:SetOn(false)
        end,
        callbackCancel = function()
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, data)
    end
  end, self.dispatch)
end

function SettingsNotificationCtrl:SaveSetting()
  self._panel:SaveLocalData("Energy", self.energy)
  self._panel:SaveLocalData("Dispatch", self.dispatch)
  self._panel:SaveLocalData("Notification", false)
end

function SettingsNotificationCtrl:Awake()
  self.bInit = false
  self:RefreshText()
end

function SettingsNotificationCtrl:OnEnable()
end

function SettingsNotificationCtrl:OnDisable()
  if not self.bInit then
    return
  end
  self:SaveSetting()
  EventManager.Hit(EventId.SettingsNotificationClose)
end

function SettingsNotificationCtrl:OnDestroy()
end

return SettingsNotificationCtrl
