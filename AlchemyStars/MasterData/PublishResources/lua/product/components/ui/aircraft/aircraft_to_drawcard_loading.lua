_class("AircraftToDrawcardLoading", LoadingHandler)
AircraftToDrawcardLoading = AircraftToDrawcardLoading

function AircraftToDrawcardLoading:PreLoadBeforeLoadLevel(TT)
  local module = GameGlobal.GetModule(AircraftModule)
  local main = module:GetClientMain()
  main:Dispose()
  module:SetClientMain(nil)
  module:PushLeaveAircraft()
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

function AircraftToDrawcardLoading:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function AircraftToDrawcardLoading:OnLoadingFinish(...)
  local module = GameGlobal.GetModule(GambleModule)
  module:InitContext(self.sceneResReq)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIDrawCard, ...)
end

function AircraftToDrawcardLoading:LoadingType()
  return LoadingType.STATICPIC
end
