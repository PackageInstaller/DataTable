local AudioControlComponent = require("UI.Public.Item.AudioControlComponent")
local AudioSettingPanel, Super = System.NewClass("AudioSettingPanel", UIBasePanel)
AudioSettingPanel.uiResCls = Panel_Audio_SettingResource

function AudioSettingPanel:ctor()
  Super.ctor(self)
end

function AudioSettingPanel:OnBind(binder)
  Logger.Info("AudioSettingPanel:OnBind(),创建 UI")
  self.binder = binder
  self.binder:BindButtonClick(self.ui.Btn_Close, function()
    self:Close()
  end)
  self.mainComp = self.binder:BindComponent(AudioControlComponent(self.ui.Item_Audio_Control_Main, CommonDefine.rtpcWwiseName.Main))
  self.effectComp = self.binder:BindComponent(AudioControlComponent(self.ui.Item_Audio_Control_Effect, CommonDefine.rtpcWwiseName.Sfx))
  self.voiceComp = self.binder:BindComponent(AudioControlComponent(self.ui.Item_Audio_Control_Voice, CommonDefine.rtpcWwiseName.Voc))
  self.musicComp = self.binder:BindComponent(AudioControlComponent(self.ui.Item_Audio_Control_Music, CommonDefine.rtpcWwiseName.Mus))
end

return AudioSettingPanel
