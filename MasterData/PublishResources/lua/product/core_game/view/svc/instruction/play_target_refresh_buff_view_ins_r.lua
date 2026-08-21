require("base_ins_r")
_class("PlayTargetRefreshBuffViewInstruction", BaseInstruction)
PlayTargetRefreshBuffViewInstruction = PlayTargetRefreshBuffViewInstruction

function PlayTargetRefreshBuffViewInstruction:Constructor(paramList)
end

function PlayTargetRefreshBuffViewInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  if not targetEntityID then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local buffViewComponent = targetEntity:BuffView()
  if not buffViewComponent then
    return
  end
  local curIndex = phaseContext:GetCurBuffResultIndex()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ModifyBuffValue)
  if buffResultArray == nil or curIndex > table.count(buffResultArray) then
    Log.fatal("add buff instruction ,buff result is nil")
    return
  end
  local buffResult = buffResultArray[curIndex]
  local viewInstance = buffViewComponent:GetBuffViewInstance(buffResult:GetBuffSeq())
  if viewInstance then
    viewInstance:SetLayerCount(TT, buffResult:GetBuffLayer())
  end
  local entity = viewInstance:Entity()
  world:GetService("PlayBuff"):PlayUIChangeBuff(entity)
end
