require("cutscene_base_ins_r")
_class("CutscenePlayAudioInstruction", CutsceneBaseInstruction)
CutscenePlayAudioInstruction = CutscenePlayAudioInstruction

function CutscenePlayAudioInstruction:Constructor(paramList)
  self._audioID = tonumber(paramList.audioID)
end

function CutscenePlayAudioInstruction:DoInstruction(TT, phaseContext)
  AudioHelperController.PlayInnerGameSfx(self._audioID)
end
