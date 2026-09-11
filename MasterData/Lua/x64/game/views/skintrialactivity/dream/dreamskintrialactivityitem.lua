FactorySkinTrialActivityItem = import("game.views.skinTrialActivity.Factory.FactorySkinTrialActivityItem")

local DreamSkinTrialActivityItem = class("DreamSkinTrialActivityItem", FactorySkinTrialActivityItem)

function DreamSkinTrialActivityItem:RefreshTime()
	if manager.time:GetServerTime() < self.startTime_ then
		SetActive(self.gameObject_, false)

		return
	end

	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
end

return DreamSkinTrialActivityItem
