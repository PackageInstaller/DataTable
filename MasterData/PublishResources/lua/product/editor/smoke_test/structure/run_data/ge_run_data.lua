require("_base_run_data")
_class("GoldbergEventRunData", TestRobotRunData)
GoldbergEventRunData = GoldbergEventRunData

function GoldbergEventRunData:Constructor()
  self._index = 1
  self._missionIDs = {}
  self._mission2Cmpt = {}
end

function GoldbergEventRunData:SetMissionList(t)
  self._missionIDs = t
end

function GoldbergEventRunData:GetMissionID()
  return self._missionIDs[self._index]
end

function GoldbergEventRunData:TickMissionID()
  self._index = self._index + 1
  return self:GetMissionID()
end

function GoldbergEventRunData:SetMission2CmptDic(d)
  self._mission2Cmpt = d
end

function GoldbergEventRunData:GetCampaignComponent()
  local missionID = self:GetMissionID()
  return self._mission2Cmpt[missionID]
end
