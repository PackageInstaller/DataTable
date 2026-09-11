local ActivitySevenSignToggle = class("ActivitySevenSignToggle", ActivityBaseToggle)

function ActivitySevenSignToggle:Ctor(arg_1_1)
	self.activityId = arg_1_1
end

function ActivitySevenSignToggle:GetName()
	return "ActivitySevenSignToggle" .. self.activityId
end

function ActivitySevenSignToggle:IsActivity()
	return ActivityData:GetActivityIsOpen(self.activityId) and SignData:GetSevenDaySignInfo(self.activityId) ~= nil
end

function ActivitySevenSignToggle:UIClass()
	return SevenDaySignPage
end

function ActivitySevenSignToggle:RedPointKey()
	return string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, self.activityId)
end

function ActivitySevenSignToggle:Check()
	return SignTools.GetSevenDaySignIndex(self.activityId) ~= 0
end

function ActivitySevenSignToggle:Title()
	if ActivityCumulativeSignCfg[self.activityId] then
		return ActivityCumulativeSignCfg[self.activityId].title
	end

	return ""
end

function ActivitySevenSignToggle:Image()
	return "sevendays"
end

function ActivitySevenSignToggle:Order()
	return 11
end

function ActivitySevenSignToggle:GetParams()
	return self.activityId
end

function ActivitySevenSignToggle:GetLimitLevel()
	if ActivityCumulativeSignCfg[self.activityId] then
		return ActivityCumulativeSignCfg[self.activityId].limit_level
	end

	return 0
end

return ActivitySevenSignToggle
