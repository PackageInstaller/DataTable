require("pop_star_wave_result_system")
_class("PopStarWaveResultSystem_Render", PopStarWaveResultSystem)
PopStarWaveResultSystem_Render = PopStarWaveResultSystem_Render

function PopStarWaveResultSystem_Render:_DoRenderNotifyWaveEnd(TT, waveNum)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTWaveTurnEnd:New(waveNum))
end

function PopStarWaveResultSystem_Render:_DoRenderHandleTurnBattleResult(TT, victory)
  GameGlobal.UAReportForceGuideEvent("BattleResult", {
    victory and 1 or 0
  }, false, true)
end
