require("elemental_run_data")
_class("ElementalSummerIIEventRunData", TestRobotElementalRunData)
ElementalSummerIIEventRunData = ElementalSummerIIEventRunData

function ElementalSummerIIEventRunData:ParseLevelData(rawargs)
  local args = string.split(rawargs, ",")
  self._missionID = tonumber(args[1])
  self._componentConfigID = tonumber(args[2])
  self:ParseConfigID()
  if 2 < table.count(args) then
    self._hardID = tonumber(args[3])
  end
  self._affixList = {}
  if table.count(args) > 3 then
    for i = 4, #args do
      table.insert(self._affixList, tonumber(args[i]))
    end
  end
end

function ElementalSummerIIEventRunData:GetEnterMatchParam()
  local param = {
    self:GetMissionID(),
    ECampaignMissionComponentId.ECampaignMissionComponentId_SummerII,
    {
      [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = self:GetComponentConfigID()
    }
  }
  return param
end

function ElementalSummerIIEventRunData:ParseConfigID()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaignID, self._componentID, self.componentType = campaignModule:ParseCfgComponentID(self._componentConfigID)
end

function ElementalSummerIIEventRunData:GetCampaignID()
  return self._campaignID
end

function ElementalSummerIIEventRunData:GetMissionID()
  return self._missionID
end

function ElementalSummerIIEventRunData:GetComponentID()
  return self._componentID
end

function ElementalSummerIIEventRunData:GetComponentConfigID()
  return self._componentConfigID
end

function ElementalSummerIIEventRunData:HaseAffix()
  if not self._hardID then
    return false
  end
  return true
end

function ElementalSummerIIEventRunData:GetHardID()
  return self._hardID
end

function ElementalSummerIIEventRunData:GetAffixList()
  return self._affixList
end
