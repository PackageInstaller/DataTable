require("base_ins_r")
_class("TankTurnToTargetInstruction", BaseInstruction)
TankTurnToTargetInstruction = TankTurnToTargetInstruction

function TankTurnToTargetInstruction:Constructor(paramList)
  self._time = tonumber(paramList.time)
  self._animatorTrigger = paramList.animatorTrigger
end

function TankTurnToTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:Player():GetLocalTeamEntity()
  local gridDir = self:GetDir(targetEntity:GetGridPosition(), casterEntity)
  local BoardServiceRender = world:GetService("BoardRender")
  local renderDir = BoardServiceRender:GridDir2LocationDir(gridDir)
  local go = casterEntity:View():GetGameObject()
  local tween = go.transform:DORotate(renderDir, self._time * 0.001)
  YIELD(TT, self._time)
  if not tween:IsComplete() then
    tween:Complete()
  end
end

function TankTurnToTargetInstruction:GetDir(targetPos, entity)
  local gridLoc = entity:GridLocation()
  local center = gridLoc:Center()
  local vectors = {
    Vector2(-1, 0),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(0, 1)
  }
  local minIdx, minAngle = 1, 180
  local vec = targetPos - center
  for i, v in ipairs(vectors) do
    local angle = Vector2.Angle(vec, v)
    if minAngle > angle then
      minAngle = angle
      minIdx = i
    end
  end
  return vectors[minIdx]
end
