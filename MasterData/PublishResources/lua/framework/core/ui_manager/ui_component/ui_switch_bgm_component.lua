_class("UISwitchBGMComponent", UIComponent)

function UISwitchBGMComponent:AfterShow(TT)
  AudioHelperController.PlayBGMById(self.registerInfo, AudioConstValue.BGMCrossFadeTime)
end
