require("base_ins_r")
_class("PlayVoiceInstruction", BaseInstruction)
PlayVoiceInstruction = PlayVoiceInstruction

function PlayVoiceInstruction:Constructor(paramList)
  self._voiceID = tonumber(paramList.voiceID)
end

function PlayVoiceInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return
  end
  InnerGameHelperRender.InnerGamePlayPetVoid(self._voiceID, casterEntity)
end

function PlayVoiceInstruction:GetCacheVoice()
  if self._voiceID and self._voiceID > 0 then
    return {
      self._voiceID
    }
  end
end
