ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local ActivitySubmoduleWithAnimationItem = class("ActivitySubmoduleWithAnimationItem", ActivitySubmoduleItem)

function ActivitySubmoduleWithAnimationItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if manager.time:GetServerTime() < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		manager.notify:Invoke(ACTIVITY_MAIN_CLICK_BTN)
		LeanTween.delayedCall(0.6, System.Action(function()
			ActivityTools.JumpToSubmodulePage(self.activityId_)
		end))
	end)
end

function ActivitySubmoduleWithAnimationItem:Dispose()
	ActivitySubmoduleWithAnimationItem.super.Dispose(self)
end

return ActivitySubmoduleWithAnimationItem
