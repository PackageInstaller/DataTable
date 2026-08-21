require("base_ins_r")
_class("PlayRemoveAudioInstruction", BaseInstruction)
PlayRemoveAudioInstruction = PlayRemoveAudioInstruction

function PlayRemoveAudioInstruction:Constructor(paramList)
  self._audioID = tonumber(paramList.audioID)
end

function PlayRemoveAudioInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local effectCpmt = casterEntity:EffectHolder()
  local playingIDList = effectCpmt:GetAudioPlayingID(self._audioID)
  for i, playingID in ipairs(playingIDList) do
    AudioHelperController.StopInnerGameSfx(playingID, self._audioID)
  end
end
