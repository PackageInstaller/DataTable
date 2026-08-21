require("elemental_run_data")
_class("ElementalGoldbergEventRunData", TestRobotElementalRunData)
ElementalGoldbergEventRunData = ElementalGoldbergEventRunData

function ElementalGoldbergEventRunData:ParseLevelData(rawargs)
  local args = string.split(rawargs, ",")
  self._missionID = tonumber(args[1])
  self._componentEnumID = tonumber(args[2])
  self._componentConfigID = tonumber(args[3])
  self._componentConfigIDKey = tonumber(args[4]) or self._componentEnumID
end

function ElementalGoldbergEventRunData:GetMissionID()
  return self._missionID
end

function ElementalGoldbergEventRunData:GetComponentEnumID()
  return self._componentEnumID
end

function ElementalGoldbergEventRunData:GetComponentConfigID()
  return self._componentConfigID
end

function ElementalGoldbergEventRunData:GetComponentConfigIDKey()
  return self._componentConfigIDKey
end

function ElementalGoldbergEventRunData:ParseExpensionData(rawargs)
  if not rawargs then
    Log.info(self._className, "No expension data. ")
    return
  end
  local args = string.split(rawargs, ",")
  self._expensionType = tonumber(args[1])
  if self._expensionType == STGoldbergRunDataExpension.N12HardAffix or self._expensionType == STGoldbergRunDataExpension.N21HardAffix then
    Log.info(self._className, "ExpensionType == ", self._expensionType, ", proceed affix for hard mission. ")
    local search = Cfg.cfg_component_challenge_mission({
      CampaignMissionId = self:GetMissionID(),
      ComponentID = self:GetComponentConfigID()
    })
    if not search or #search == 0 then
      Log.error(self._className, "MissionID <=> cfg_component_challenge_mission mismatch. MissionID=", self:GetMissionID())
      return
    end
    local cfgComponentChallengeMission = search[1]
    if #args - 1 ~= #cfgComponentChallengeMission.Affix then
      Log.warn(self._className, "unequal affix group count, result can be unexcepted. ")
    end
    local tAffixID = {}
    for i = 2, #args do
      local arg = tonumber(args[i])
      if arg and arg ~= 0 and arg == 1 then
        local group = cfgComponentChallengeMission.Affix[i - 1]
        local rand = math.random(1, #group)
        table.insert(tAffixID, group[rand])
      end
    end
    self._tN12HardAffix = tAffixID
  end
end

function ElementalGoldbergEventRunData:GetExpensionType()
  return self._expensionType
end

function ElementalGoldbergEventRunData:GetN12HardAffix()
  return self._tN12HardAffix
end
