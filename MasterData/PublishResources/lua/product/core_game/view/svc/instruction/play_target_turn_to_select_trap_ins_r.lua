require("base_ins_r")
_class("PlayTargetTurnToSelectTrapInstruction", BaseInstruction)
PlayTargetTurnToSelectTrapInstruction = PlayTargetTurnToSelectTrapInstruction

function PlayTargetTurnToSelectTrapInstruction:Constructor(paramList)
  local trapIDList = paramList.trapIDList
  self._trapIDList = {}
  if trapIDList then
    local arr = string.split(trapIDList, "|")
    for k, idStr in ipairs(arr) do
      local trapID = tonumber(idStr)
      table.insert(self._trapIDList, trapID)
    end
  end
end

function PlayTargetTurnToSelectTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local tarpEntity
  local utilDataSvc = world:GetService("UtilData")
  local posList = utilDataSvc:GetCloneBoardGridPos()
  local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    local trapRenderCmpt = e:TrapRender()
    local trapPos = e:GetRenderGridPosition()
    if trapRenderCmpt and table.icontains(self._trapIDList, trapRenderCmpt:GetTrapID()) and table.icontains(posList, trapPos) then
      tarpEntity = e
      break
    end
  end
  if tarpEntity then
    casterEntity = tarpEntity
  end
  local renderEntityService = world:GetService("RenderEntity")
  renderEntityService:TurnToTarget(targetEntity, casterEntity)
end
