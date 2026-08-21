require("elemental_run_data")
_class("TestRobotBlackFistRunData", TestRobotElementalRunData)
TestRobotBlackFistRunData = TestRobotBlackFistRunData

function TestRobotBlackFistRunData:Constructor()
  self._missionID = 5041004
  self._campainParams = {504001705, 61}
end

function TestRobotBlackFistRunData:ParseLevelData(arg)
  local s = string.split(arg, ",")
  self._missionID = tonumber(s[1])
end

function TestRobotBlackFistRunData:GetEnterMatchParam()
  return {
    self._missionID,
    ECampaignMissionComponentId.ECampaignMissionComponentId_Blackfist,
    self._campainParams
  }
end

function TestRobotBlackFistRunData:GetComponentConfigID()
  return self._campainParams[1]
end
