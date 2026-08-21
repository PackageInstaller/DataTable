require("wave_result_award_system")
_class("ClientWaveResultAwardSystem_Render", WaveResultAwardSystem)
ClientWaveResultAwardSystem_Render = ClientWaveResultAwardSystem_Render

function ClientWaveResultAwardSystem_Render:_DoRenderShowChoosePartner(TT, choosePartners, choosenRelicID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowChoosePartnerUI, true, choosePartners, choosenRelicID)
end

function ClientWaveResultAwardSystem_Render:_DoRenderShowChooseRelic(TT, chooseRelics, closeCallBack, openingChoose)
  GameGlobal.UIStateManager():ShowDialog("UIMiniMazeChooseRelicController", chooseRelics, closeCallBack, openingChoose)
end
