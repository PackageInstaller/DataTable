require("buff_logic_base")
_class("BuffLogicPlayVoice", BuffLogicBase)
BuffLogicPlayVoice = BuffLogicPlayVoice

function BuffLogicPlayVoice:Constructor(buffInstance, logicParam)
  self._audioID = tonumber(logicParam.audioID)
  local audioType = logicParam.audioType
  if audioType == nil then
    self._audioType = SkillAudioType.Cast
  else
    self._audioType = tonumber(audioType)
  end
end

function BuffLogicPlayVoice:DoLogic()
  return {
    audioType = self._audioType,
    audioID = self._audioID
  }
end
