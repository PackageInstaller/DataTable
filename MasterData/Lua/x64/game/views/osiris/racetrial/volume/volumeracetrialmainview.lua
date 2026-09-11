RaceTrialMainView = import("game.views.osiris.raceTrial.RaceTrialMainView")

local VolumeRaceTrialMainView = class("VolumeRaceTrialMainView", RaceTrialMainView)

function VolumeRaceTrialMainView:UIName()
	return RaceTrialTools.GetMainUIName(self.params_.activityID)
end

function VolumeRaceTrialMainView:AddUIListeners()
	self:AddBtnListener(self.firstRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.scoreRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("volumeRaceTrialScoreRewardPop", {
			mainActivityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		RaceTrialAction:ReceiveScoreReward(self.curLv_)
	end)
	self:AddBtnListener(self.DivineBtn_, nil, function()
		JumpTools.OpenPageByJump("volumeHeroRaceTrialDetails")
	end)
end

return VolumeRaceTrialMainView
