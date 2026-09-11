local VolumeRaceTrialScoreRewardItem = class("VolumeRaceTrialScoreRewardItem", (import("game.views.osiris.raceTrial.RaceTrialScoreRewardItem")))

function VolumeRaceTrialScoreRewardItem:RefreshTitle()
	self.title_.text = self.cfg_.need
end

return VolumeRaceTrialScoreRewardItem
