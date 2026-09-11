local VolumeRaceTrialScoreRewardPopView = class("VolumeRaceTrialScoreRewardPopView", (import("game.views.osiris.raceTrial.RaceTrialScoreRewardPopView")))

function VolumeRaceTrialScoreRewardPopView:UIName()
	return RaceTrialTools.GetScoreRewardUIName(self.params_.mainActivityID)
end

function VolumeRaceTrialScoreRewardPopView:GetRewardItemClass()
	return VolumeRaceTrialScoreRewardItem
end

return VolumeRaceTrialScoreRewardPopView
