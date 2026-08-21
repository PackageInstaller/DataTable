require("base_ins_r")
_class("PlayAudioInstruction", BaseInstruction)
PlayAudioInstruction = PlayAudioInstruction

function PlayAudioInstruction:Constructor(paramList)
  self._audioID = tonumber(paramList.audioID)
  local audioType = paramList.audioType
  if audioType == nil then
    self._audioType = SkillAudioType.Cast
  else
    self._audioType = tonumber(audioType)
  end
end

function PlayAudioInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return
  end
  if self._audioType == SkillAudioType.Cast then
    local playingID = AudioHelperController.PlayInnerGameSfx(self._audioID)
    local effectCpmt = casterEntity:EffectHolder()
    if not effectCpmt then
      casterEntity:AddEffectHolder()
      effectCpmt = casterEntity:EffectHolder()
    end
    effectCpmt:AttachAudioID(self._audioID, playingID)
  elseif self._audioType == SkillAudioType.Hit then
    self:_PlayHitAudio(casterEntity, phaseContext)
  elseif self._audioType == SkillAudioType.Voice then
    InnerGameHelperRender.InnerGamePlayPetVoid(self._audioID, casterEntity)
  end
end

function PlayAudioInstruction:_PlayHitAudio(casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Damage)
  if not damageResult then
    return
  end
  local damageInfo = damageResult:GetDamageInfo(1)
  if damageInfo and damageInfo:GetDamageType() == DamageType.Guard then
    local beAttackEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(beAttackEntityID)
    local hitSoundID = 2002
    AudioHelperController.PlayInnerGameSfx(hitSoundID)
  elseif damageInfo and damageInfo:GetDamageType() == DamageType.Miss then
  else
    AudioHelperController.PlayInnerGameSfx(self._audioID)
  end
end

function PlayAudioInstruction:GetCacheAudio()
  if self._audioID and self._audioID > 0 then
    return {
      self._audioID
    }
  end
end
