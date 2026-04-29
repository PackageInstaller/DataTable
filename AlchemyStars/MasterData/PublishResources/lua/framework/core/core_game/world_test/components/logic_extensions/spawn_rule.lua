_class("SpawnRuleFixedLocation", ISpawnRule)

function SpawnRuleFixedLocation:Constructor(pos, dir)
  self.Position = pos
  self.Direction = dir
end

function SpawnRuleFixedLocation:MakeSpawn(entity, world)
  entity:SetLocation(self.Position, self.Direction)
end

_class("SpawnRuleFixedScenePoint", ISpawnRule)

function SpawnRuleFixedScenePoint:Constructor(pointIndex)
  self.PointIndex = pointIndex
end

function SpawnRuleFixedScenePoint:MakeSpawn(entity, world)
  local spawnMng = world:SpawnMng().Manager
  local points = spawnMng.AllPoints
  local pos = points[self.PointIndex]
  if pos == nil then
    Log.fatal("SpawnRuleFixedScenePoint Cant Find Point on index: " .. self.PointIndex)
    pos = Vector3(0, 0, 0)
  end
  entity:SetPosition(pos)
end

_class("SpawnRuleRandomScenePoint", ISpawnRule)

function SpawnRuleRandomScenePoint:Constructor()
end

function SpawnRuleRandomScenePoint:MakeSpawn(entity, world)
end
