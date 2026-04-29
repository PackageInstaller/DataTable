require("play_skill_phase_base_r")
_class("PlaySkillPlayAudioPhase", PlaySkillPhaseBase)
PlaySkillPlayAudioPhase = PlaySkillPlayAudioPhase

function PlaySkillPlayAudioPhase:PlayFlight(TT, casterEntity, phaseParam)
  local audioType = phaseParam:GetAudioType()
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return
  end
  if audioType == SkillAudioType.Cast then
    local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
    local isSlantAttack
    if phaseParam:GetSlantAudioID() then
      local attackPos = casterEntity:GetRenderGridPosition()
      local damageResult = skillEffectResultContainer:GetEffectResultsByType(SkillEffectType.Damage)
      if damageResult and #damageResult.array > 0 then
        local damage = damageResult.array[1]
        local damagePos = damage:GetGridPos()
        if attackPos.x ~= damagePos.x and attackPos.y ~= damagePos.y then
          isSlantAttack = true
        end
      end
    end
    local delayTime = phaseParam:GetSoundDelay(skillEffectResultContainer:IsLastNormalAttackAtOnGrid(), isSlantAttack)
    if 0 < delayTime then
      YIELD(TT, delayTime)
    end
    AudioHelperController.PlayInnerGameSfx(phaseParam:GetAudioID(isSlantAttack))
  elseif audioType == SkillAudioType.Hit then
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
      AudioHelperController.PlayInnerGameSfx(phaseParam:GetAudioID())
    end
  elseif audioType == SkillAudioType.Voice then
    InnerGameHelperRender.InnerGamePlayPetVoid(phaseParam:GetAudioID(), casterEntity)
  end
end
