local IslandTaskType = class("IslandTaskType")

IslandTaskType.MAIN = 1
IslandTaskType.BRANCH = 2
IslandTaskType.DAILY = 3
IslandTaskType.WEEKLY = 4
IslandTaskType.ACTIVITY_BRANCH = 5
IslandTaskType.ACTIVITY_DAILY = 6
IslandTaskType.ACTIVITY_WEEKLY = 7
IslandTaskType.SEASON = 8
IslandTaskType.HIDE = 9

function IslandTaskType.GetPermanentTypes()
	return {
		IslandTaskType.MAIN,
		IslandTaskType.BRANCH,
		IslandTaskType.ACTIVITY_BRANCH,
		IslandTaskType.SEASON,
		IslandTaskType.HIDE
	}
end

IslandTaskType.SHOW_ALL = 0
IslandTaskType.SHOW_MAIN = 1
IslandTaskType.SHOW_BRANCH = 2
IslandTaskType.SHOW_DAILY = 3
IslandTaskType.SHOW_WEEKLY = 4
IslandTaskType.SHOW_ACTIVITY = 5
IslandTaskType.Type2ShowType = {
	[IslandTaskType.MAIN] = IslandTaskType.SHOW_MAIN,
	[IslandTaskType.BRANCH] = IslandTaskType.SHOW_BRANCH,
	[IslandTaskType.DAILY] = IslandTaskType.SHOW_DAILY,
	[IslandTaskType.WEEKLY] = IslandTaskType.SHOW_WEEKLY,
	[IslandTaskType.ACTIVITY_BRANCH] = IslandTaskType.SHOW_ACTIVITY,
	[IslandTaskType.ACTIVITY_DAILY] = IslandTaskType.SHOW_ACTIVITY,
	[IslandTaskType.ACTIVITY_WEEKLY] = IslandTaskType.SHOW_ACTIVITY,
	[IslandTaskType.SEASON] = nil,
	[IslandTaskType.HIDE] = IslandTaskType.SHOW_MAIN
}
IslandTaskType.ShowTypeFields = {
	[IslandTaskType.SHOW_MAIN] = "main",
	[IslandTaskType.SHOW_BRANCH] = "branch",
	[IslandTaskType.SHOW_DAILY] = "daily",
	[IslandTaskType.SHOW_WEEKLY] = "weekly",
	[IslandTaskType.SHOW_ACTIVITY] = "activity"
}
IslandTaskType.ShowTypeUnlockId = {
	[IslandTaskType.SHOW_MAIN] = 0,
	[IslandTaskType.SHOW_BRANCH] = 42,
	[IslandTaskType.SHOW_DAILY] = 43,
	[IslandTaskType.SHOW_WEEKLY] = 44,
	[IslandTaskType.SHOW_ACTIVITY] = 45
}
IslandTaskType.ShowTypeNames = {
	[IslandTaskType.SHOW_ALL] = i18n("island_task_type_1"),
	[IslandTaskType.SHOW_MAIN] = i18n("island_task_type_2"),
	[IslandTaskType.SHOW_BRANCH] = i18n("island_task_type_3"),
	[IslandTaskType.SHOW_DAILY] = i18n("island_task_type_4"),
	[IslandTaskType.SHOW_WEEKLY] = i18n("island_task_type_5"),
	[IslandTaskType.SHOW_ACTIVITY] = i18n("island_task_type_6")
}
IslandTaskType.ShowTypeColors = {
	[IslandTaskType.SHOW_MAIN] = "#36bdff",
	[IslandTaskType.SHOW_BRANCH] = "#f775ff",
	[IslandTaskType.SHOW_DAILY] = "#a891ff",
	[IslandTaskType.SHOW_WEEKLY] = "#46cd92",
	[IslandTaskType.SHOW_ACTIVITY] = "#ffc561"
}
IslandTaskType.ShowTypeTrackColors = {
	[IslandTaskType.SHOW_MAIN] = "#39bfff",
	[IslandTaskType.SHOW_BRANCH] = "#cb72d1",
	[IslandTaskType.SHOW_DAILY] = "#b29dff",
	[IslandTaskType.SHOW_WEEKLY] = "#8dffc0",
	[IslandTaskType.SHOW_ACTIVITY] = "#ffe18e"
}
IslandTaskType.EXCLUED_TRACK_TYPES = {
	IslandTaskType.MAIN,
	IslandTaskType.SEASON,
	IslandTaskType.HIDE
}

function IslandTaskType:GetTrackPriority()
	return switch(self, {
		[IslandTaskType.MAIN] = function()
			return 1
		end,
		[IslandTaskType.ACTIVITY_BRANCH] = function()
			return 2
		end,
		[IslandTaskType.BRANCH] = function()
			return 3
		end,
		[IslandTaskType.ACTIVITY_DAILY] = function()
			return 4
		end,
		[IslandTaskType.DAILY] = function()
			return 5
		end,
		[IslandTaskType.ACTIVITY_WEEKLY] = function()
			return 6
		end,
		[IslandTaskType.WEEKLY] = function()
			return 7
		end
	}, function()
		return 999
	end)
end

function IslandTaskType:GetHudPriority()
	return switch(self, {
		[IslandTaskType.SHOW_MAIN] = function()
			return 1
		end,
		[IslandTaskType.SHOW_BRANCH] = function()
			return 2
		end,
		[IslandTaskType.SHOW_ACTIVITY] = function()
			return 3
		end,
		[IslandTaskType.SHOW_DAILY] = function()
			return 4
		end,
		[IslandTaskType.SHOW_WEEKLY] = function()
			return 5
		end
	}, function()
		return 999
	end)
end

function IslandTaskType:GetTrackingIconName()
	if self == IslandTaskType.MAIN then
		return "task_type_1"
	elseif self == IslandTaskType.BRANCH then
		return "task_type_2"
	elseif self == IslandTaskType.DAILY then
		return "task_type_3"
	elseif self == IslandTaskType.WEEKLY then
		return "task_type_4"
	elseif self == IslandTaskType.ACTIVITY_BRANCH or self == IslandTaskType.ACTIVITY_DAILY or self == IslandTaskType.ACTIVITY_WEEKLY or self == IslandTaskType.SEASON or self == IslandTaskType.HIDE then
		return "task_type_5"
	end

	assert(false, "Unknown type >>>" .. self)

	return
end

return IslandTaskType
