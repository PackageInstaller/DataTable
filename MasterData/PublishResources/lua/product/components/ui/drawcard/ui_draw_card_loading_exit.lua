_class("UIDrawCardLoadingExit", LoadingHandler)
UIDrawCardLoadingExit = UIDrawCardLoadingExit

function UIDrawCardLoadingExit:PreLoadAfterLoadLevel(TT, ...)
  AudioHelperController.ReleaseUISoundList({
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

function UIDrawCardLoadingExit:OnLoadingFinish(...)
  local module = GameGlobal.GetModule(GambleModule)
  module:ClearContext()
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
end

function UIDrawCardLoadingExit:LoadingType()
  return LoadingType.BOTTOM
end
