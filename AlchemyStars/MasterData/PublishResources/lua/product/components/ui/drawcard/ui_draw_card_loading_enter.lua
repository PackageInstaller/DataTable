_class("UIDrawCardLoadingEnter", LoadingHandler)
UIDrawCardLoadingEnter = UIDrawCardLoadingEnter

function UIDrawCardLoadingEnter:PreLoadAfterLoadLevel(TT, ...)
  AudioHelperController.RequestUISoundList({
    CriAudioIDConst.DrawCard_tuijingtou,
    CriAudioIDConst.DrawCard_lagan_new,
    CriAudioIDConst.Drawcard_lagan_eft_3,
    CriAudioIDConst.Drawcard_lagan_eft_4,
    CriAudioIDConst.Drawcard_lagan_eft_5,
    CriAudioIDConst.Drawcard_lagan_eft_6,
    CriAudioIDConst.Drawcard_light_one,
    CriAudioIDConst.Drawcard_light_more,
    CriAudioIDConst.Drawcard_light_one,
    CriAudioIDConst.Drawcard_mul_show,
    CriAudioIDConst.Drawcard_lagan_once
  })
end

function UIDrawCardLoadingEnter:OnLoadingFinish(...)
  local module = GameGlobal.GetModule(GambleModule)
  module:InitContext(self.sceneResReq)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIRecruit, ...)
end

function UIDrawCardLoadingEnter:LoadingType()
  return LoadingType.BOTTOM
end
