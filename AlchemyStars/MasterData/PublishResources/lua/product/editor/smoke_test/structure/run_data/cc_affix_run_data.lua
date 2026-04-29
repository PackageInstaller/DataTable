require("elemental_run_data")
_class("CCAffixRunData", TestRobotElementalRunData)
CCAffixRunData = CCAffixRunData

function CCAffixRunData:ParseLevelData(rawargs)
  local args = string.split(rawargs, ",")
  self._missionID = tonumber(args[1])
  self._componentEnumID = tonumber(args[2])
  self._componentConfigID = tonumber(args[3])
  self._affixList = {}
  if 3 < table.count(args) then
    for i = 4, #args do
      table.insert(self._affixList, tonumber(args[i]))
    end
  end
end

function CCAffixRunData:GetMissionID()
  return self._missionID
end

function CCAffixRunData:GetComponentEnumID()
  return self._componentEnumID
end

function CCAffixRunData:GetComponentConfigID()
  return self._componentConfigID
end

function CCAffixRunData:GetAffixList()
  return self._affixList
end
