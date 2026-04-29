_class("PlayCoffinMusumeCandleSetSelfLightInstruction", BaseInstruction)
PlayCoffinMusumeCandleSetSelfLightInstruction = PlayCoffinMusumeCandleSetSelfLightInstruction

function PlayCoffinMusumeCandleSetSelfLightInstruction:Constructor(paramList)
  self._candleEffectID = tonumber(paramList.candleEffectID)
end

function PlayCoffinMusumeCandleSetSelfLightInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.CoffinMusumeSetCandleLight)
  if not result then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local e = world:GetEntityByID(result:GetEntityID())
  if e then
    local hasEffect = e:HasEffectHolder()
    local effectIDEntityDic = hasEffect and e:EffectHolder():GetEffectIDEntityDic()
    hasEffect = hasEffect and effectIDEntityDic[self._candleEffectID] and #effectIDEntityDic[self._candleEffectID] > 0
    if not hasEffect then
      local fxsvc = world:GetService("Effect")
      fxsvc:CreateEffect(self._candleEffectID, e)
    end
  end
  world:GetService("PlayBuff"):PlayBuffView(TT, NTCoffinMusumeSkillChangeLight:New({
    result:GetEntityID()
  }))
end
