require("elemental_run_data")
_class("TestRobotElementalCartridgeRunData", TestRobotElementalRunData)
TestRobotElementalCartridgeRunData = TestRobotElementalCartridgeRunData

function TestRobotElementalCartridgeRunData:Constructor()
  self._cartridgeStageIndex = 1
  self._cartridgeID = 0
  self._expv = 1
  self._n8componentID = 0
end

function TestRobotElementalCartridgeRunData:SetCartridgeID(id)
  self._cartridgeID = id
end

function TestRobotElementalCartridgeRunData:GetCartridgeID()
  return self._cartridgeID
end

function TestRobotElementalCartridgeRunData:TickCartridgeStageIndex()
  self._cartridgeStageIndex = self._cartridgeStageIndex + 1
end

function TestRobotElementalCartridgeRunData:SetCartridgeStageIndex(idx)
  self._cartridgeStageIndex = idx
end

function TestRobotElementalCartridgeRunData:GetCartridgeStageIndex()
  return self._cartridgeStageIndex
end

function TestRobotElementalCartridgeRunData:SetN8ComponentID(id)
  self._n8componentID = id
end

function TestRobotElementalCartridgeRunData:GetN8ComponentID()
  return self._n8componentID
end

function TestRobotElementalCartridgeRunData:SetExperienceVersion(v)
  self._expv = v
end

function TestRobotElementalCartridgeRunData:GetExperienceVersion()
  return self._expv
end

function TestRobotElementalCartridgeRunData:GetMissionID()
  local config = Cfg.cfg_item_cartridge[self._cartridgeID]
  if not config then
    Log.exception(self._className, "Invalid cartridge id: ", tostring(self._cartridgeID))
  end
  if #config.MissionID < self._cartridgeStageIndex then
    return
  end
  return config.MissionID[self._cartridgeStageIndex]
end

function TestRobotElementalCartridgeRunData:ParseLevelData(rawarg)
  local sargs = string.split(rawarg, ",")
  local args = {}
  for _, s in ipairs(sargs) do
    table.insert(args, tonumber(s))
  end
  self:SetCartridgeID(args[1])
  self:SetCartridgeStageIndex(args[2] or 1)
  self:SetExperienceVersion(args[3] or 1)
  self:SetN8ComponentID(args[4] or 0)
end
