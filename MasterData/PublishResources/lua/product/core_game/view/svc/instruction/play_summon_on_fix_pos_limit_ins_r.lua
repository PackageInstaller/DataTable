require("base_ins_r")
_class("PlaySummonOnFixPosLimitInstruction", BaseInstruction)
PlaySummonOnFixPosLimitInstruction = PlaySummonOnFixPosLimitInstruction

function PlaySummonOnFixPosLimitInstruction:Constructor(paramList)
  self._isDestroy = tonumber(paramList.isDestroy) or 1
end

function PlaySummonOnFixPosLimitInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local trapServiceRender = world:GetService("TrapRender")
  if self._isDestroy ~= 1 then
    local targetEntityID = phaseContext:GetCurTargetEntityID()
    local trapEntity = world:GetEntityByID(targetEntityID)
    trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
    return
  end
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = routineCmpt:GetEffectResultsAsArray(SkillEffectType.SummonOnFixPosLimit)
  if not resultArray then
    return
  end
  for _, result in ipairs(resultArray) do
    local destroyEntityIDList = result:GetDestroyEntityIDList()
    for i, entityID in ipairs(destroyEntityIDList) do
      local entity = world:GetEntityByID(entityID)
      if entity then
        trapServiceRender:PlayTrapDieSkill(TT, {entity})
      end
    end
  end
end
