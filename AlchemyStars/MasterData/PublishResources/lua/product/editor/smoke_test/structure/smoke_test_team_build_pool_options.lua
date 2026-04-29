_class("SmokeTestTeamBuildPoolOptions", Object)
SmokeTestTeamBuildPoolOptions = SmokeTestTeamBuildPoolOptions

function SmokeTestTeamBuildPoolOptions:Constructor()
  self.seatStarWeight = {}
  for k, v in pairs(TestConst.MissionRandomWeightByStar) do
    self.seatStarWeight[k] = v
  end
  self.sameElementWeight = TestConst.MissionSameElementWeight
  self.leaderElementWeightEnabled = true
  self.forcePetMainElement = nil
end

function SmokeTestTeamBuildPoolOptions:SetSameElementWeight(v)
  self.sameElementWeight = v
  return self
end

function SmokeTestTeamBuildPoolOptions:SetSeatStarWeight(seatIndex, weightMap)
  self.seatStarWeight[seatIndex] = weightMap
  return self
end

function SmokeTestTeamBuildPoolOptions:SetSkipLeaderElementWeight(v)
  self.leaderElementWeightEnabled = v
end

function SmokeTestTeamBuildPoolOptions:SetForcePetMainElement(v)
  self.forcePetMainElement = v
end
