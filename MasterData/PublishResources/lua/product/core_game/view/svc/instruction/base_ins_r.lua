_class("BaseInstruction", Object)
BaseInstruction = BaseInstruction

function BaseInstruction:Constructor(params)
  self._label = params.label
end

function BaseInstruction:GetInstructionType()
end

function BaseInstruction:GetInstructionLabel()
  return self._label
end

function BaseInstruction:DoInstruction(TT, casterEntity, phaseContext)
end

function BaseInstruction:GetCacheResource(skillConfig, skinId)
end

function BaseInstruction:GetCacheAudio()
end

function BaseInstruction:GetCacheVoice()
end

function BaseInstruction:GetSkillID(casterEntity)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  return skillID
end

function BaseInstruction:PlaySkillInstruction(casterEntity)
  local world = casterEntity:GetOwnerWorld()
  local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
  return sPlaySkillInstruction
end

function BaseInstruction:GetEffectResCacheInfo(effectID, count)
  count = count or 1
  if not effectID then
    return nil
  end
  if not Cfg.cfg_effect[effectID] then
    Log.exception(self._className, "effectID not found: ", tostring(effectID))
    return nil
  end
  local resPath = Cfg.cfg_effect[effectID].ResPath
  if not ResourceManager:GetInstance():HasResource(resPath) then
    Log.exception(self._className, "res not found: ", tostring(resPath))
    return nil
  end
  return {resPath, count}
end

function BaseInstruction:CreateInstructionEnv(anyEntity)
  if not anyEntity then
    return {}
  end
  local world = anyEntity:GetOwnerWorld()
  local utilData = world:GetService("UtilData")
  local utilCalc = world:GetService("UtilCalc")
  local rsvcEffect = world:GetService("Effect")
  local rsvcBuff = world:GetService("PlayBuff")
  local rsvcDamage = world:GetService("PlayDamage")
  return {
    world = world,
    utilData = utilData,
    utilCalc = utilCalc,
    effectService = rsvcEffect,
    playBuffService = rsvcBuff,
    playDamageService = rsvcDamage
  }
end
