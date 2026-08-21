_class("ElementalResDungeonRunData", TestRobotElementalRunData)
ElementalResDungeonRunData = ElementalResDungeonRunData

function ElementalResDungeonRunData:ParseLevelData(rawargs)
  local s = string.split(rawargs, ",")
  local dungeonType = tonumber(s[1])
  self._dungeonType = dungeonType
  if dungeonType == DungeonType.DungeonType_Experience then
    local subtype = tonumber(s[2])
    self._dungeonSubType = subtype
    local missionID = tonumber(s[3])
    self._missionID = missionID
  else
    local missionID = tonumber(s[2])
    self._missionID = missionID
  end
end

function ElementalResDungeonRunData:GetDungeonType()
  return self._resDungeonType
end

function ElementalResDungeonRunData:GetDungeonSubType()
  return self._dungeonSubType
end
