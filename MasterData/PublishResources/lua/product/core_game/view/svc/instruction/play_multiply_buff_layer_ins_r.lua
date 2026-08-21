require("base_ins_r")
_class("PlayMultiplyBuffLayerInstruction", BaseInstruction)
PlayMultiplyBuffLayerInstruction = PlayMultiplyBuffLayerInstruction

function PlayMultiplyBuffLayerInstruction:Constructor(paramList)
end

function PlayMultiplyBuffLayerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local tResults = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.MultiplyBuffLayer)
  if not tResults or table.count(tResults) == 0 then
    return
  end
  for _, result in ipairs(tResults) do
    self:_RefreshBuffLayerByResult(TT, world, result)
  end
end

function PlayMultiplyBuffLayerInstruction:_RefreshBuffLayerByResult(TT, world, result)
  if not result:GetFinalLayerCount() then
    return
  end
  local targetID = result:GetTargetID()
  local eTarget = world:GetEntityByID(targetID)
  local buffSeq = result:GetLayerBuffSeq()
  local finalLayerCount = result:GetFinalLayerCount()
  local buffView = eTarget:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffSeq)
  if not viewInstance then
    return
  end
  viewInstance:SetLayerCount(TT, finalLayerCount)
  world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if eTarget:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, eTarget:PetPstID():GetPstID(), finalLayerCount)
  end
end
