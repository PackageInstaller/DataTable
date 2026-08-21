_class("BuffViewPlayVoice", BuffViewBase)
BuffViewPlayVoice = BuffViewPlayVoice

function BuffViewPlayVoice:PlayView(TT)
  local result = self._buffResult
  local entity = self._entity
  if result.audioType == SkillAudioType.Cast then
    if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
      return
    end
    local playingID = AudioHelperController.PlayInnerGameSfx(result.audioID)
    local effectCpmt = entity:EffectHolder()
    if not effectCpmt then
      entity:AddEffectHolder()
      effectCpmt = entity:EffectHolder()
    end
    effectCpmt:AttachAudioID(result.audioID, playingID)
  elseif result.audioType == SkillAudioType.Hit then
    Log.error("BuffViewPlayVoice: Hit类音效与伤害结果相关，PlayVoice不能处理")
  elseif result.audioType == SkillAudioType.Voice then
    if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
      return
    end
    InnerGameHelperRender.InnerGamePlayPetVoid(result.audioID, entity)
  end
end
