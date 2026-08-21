require("base_ins_r")
_class("PlayPet1502051ChainTrajectoryInstruction", BaseInstruction)
PlayPet1502051ChainTrajectoryInstruction = PlayPet1502051ChainTrajectoryInstruction

function PlayPet1502051ChainTrajectoryInstruction:Constructor(paramList)
  self._trajectoryEffectID = tonumber(paramList.trajectoryEffectID)
  if not self._trajectoryEffectID or not Cfg.cfg_effect[self._trajectoryEffectID] then
    Log.exception(self._className, "trajectoryEffectID无效: ", tostring(self._trajectoryEffectID))
  end
  self._hitEffectID = tonumber(paramList.hitEffectID)
  if self._hitEffectID and self._hitEffectID ~= 0 and not Cfg.cfg_effect[self._hitEffectID] then
    Log.exception(self._className, "hitEffectID无效：", tostring(self._hitEffectID))
  end
  self._singleGridTime = tonumber(paramList.singleGridTime)
  self._flyLength = tonumber(paramList.flyLength)
  self._hitAnimName = paramList.hitAnimName
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
end

function PlayPet1502051ChainTrajectoryInstruction:GetCacheResource()
  local t = {}
  if self._trajectoryEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._trajectoryEffectID].ResPath,
      1
    })
  end
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayPet1502051ChainTrajectoryInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local casterPos = casterEntity:GetRenderGridPosition()
  local trajectories = self:_CreateAllTrajectories(casterPos)
  self:_LaunchTrajectories(trajectories)
  GameGlobal.TaskManager():CoreGameStartTask(self._TaskRunTrajectories, self, casterEntity, trajectories, phaseContext)
end

local trajectoryDirections = {
  Vector2.New(0, 1),
  Vector2.New(0, -1),
  Vector2.New(1, 0),
  Vector2.New(-1, 0),
  Vector2.New(1, 1),
  Vector2.New(-1, -1),
  Vector2.New(-1, 1),
  Vector2.New(1, -1)
}

function PlayPet1502051ChainTrajectoryInstruction:_CreateAllTrajectories(casterPos)
  local fxsvc = self._world:GetService("Effect")
  local trajectories = {}
  for _, dir in ipairs(trajectoryDirections) do
    local isCornerDir = math.abs(dir.x) + math.abs(dir.y) > 1
    local beginPos = casterPos + dir
    local efx = fxsvc:CreateWorldPositionDirectionEffect(self._trajectoryEffectID, beginPos, dir)
    table.insert(trajectories, {
      direction = dir,
      entity = efx,
      currentGridPos = beginPos,
      endPos = beginPos + dir * self._flyLength
    })
  end
  return trajectories
end

function PlayPet1502051ChainTrajectoryInstruction:_LaunchTrajectories(trajectories)
  local boardServiceRender = self._world:GetService("BoardRender")
  local time = self._flyLength * self._singleGridTime
  for _, info in ipairs(trajectories) do
    local endWorldPos = boardServiceRender:GridPos2RenderPos(info.endPos)
    local csTransform = info.entity:View():GetGameObject().transform
    info.ease = csTransform:DOMove(endWorldPos, time * 0.001, false)
  end
end

function PlayPet1502051ChainTrajectoryInstruction:_TaskRunTrajectories(TT, casterEntity, trajectories, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  for i = 1, self._flyLength do
    for _, info in ipairs(trajectories) do
      info.currentGridPos = info.currentGridPos + info.direction
    end
    YIELD(TT, self._singleGridTime)
  end
end
