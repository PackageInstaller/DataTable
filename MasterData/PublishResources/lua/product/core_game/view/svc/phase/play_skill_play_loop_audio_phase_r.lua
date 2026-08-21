require("play_skill_phase_base_r")
_class("PlaySkillPlayLoopAudioPhase", PlaySkillPhaseBase)
PlaySkillPlayLoopAudioPhase = PlaySkillPlayLoopAudioPhase

function PlaySkillPlayLoopAudioPhase:PlayFlight(TT, casterEntity, phaseParam)
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return
  end
  local audioID = phaseParam:GetAudioID()
  local isPlay = phaseParam:IsPlayLoopAudio()
  if isPlay == true then
    local playingID = AudioHelperController.PlayInnerGameSfx(audioID, true)
    self:SkillService():SetLoopAudioPlayingID(playingID)
  else
    local loopAudioPlayingID = self:SkillService():GetLoopAudioPlayingID()
    if loopAudioPlayingID ~= nil then
      AudioHelperController.StopInnerGameSfx(loopAudioPlayingID, audioID)
    end
  end
end
