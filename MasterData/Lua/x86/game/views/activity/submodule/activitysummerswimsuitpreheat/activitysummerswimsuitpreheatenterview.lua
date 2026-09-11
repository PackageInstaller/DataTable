local ActivitySummerSwimsuitPreheatEnterView = class("ActivitySummerSwimsuitPreheatEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivitySummerSwimsuitPreheatEnterView:GetUIName()
	return "Widget/Version/Alone_SummerUI_PreheatUI/Alone_SummerUI_PreheatMainUI"
end

function ActivitySummerSwimsuitPreheatEnterView:Init()
	ActivitySummerSwimsuitPreheatEnterView.super.Init(self)

	self.playBtnText_.text = GetTips("SUMMER_PREHEAT_ENTER")
end

function ActivitySummerSwimsuitPreheatEnterView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/activitySummerSwimsuitPreheatMain", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		local var_5_0 = {
			content = GetTips("ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_DESC")
		}

		var_5_0.key = "ACTIVITY_SUMMER_SWIMSUIT_PREHEAT_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_5_0)
	end)
end

function ActivitySummerSwimsuitPreheatEnterView:OnEnter()
	ActivitySummerSwimsuitPreheatEnterView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT, ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_)))
	self:RefreshUI()
end

function ActivitySummerSwimsuitPreheatEnterView:OnExit()
	ActivitySummerSwimsuitPreheatEnterView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_SUMMER_SWIMSUIT_PREHEAT, ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_)))
end

function ActivitySummerSwimsuitPreheatEnterView:RefreshUI()
	return
end

function ActivitySummerSwimsuitPreheatEnterView:Dispose()
	ActivitySummerSwimsuitPreheatEnterView.super.Dispose(self)
end

return ActivitySummerSwimsuitPreheatEnterView
