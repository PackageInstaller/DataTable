local var_0_0 = class("IslandTaskType")

var_0_0.MAIN = 1
var_0_0.BRANCH = 2
var_0_0.DAILY = 3
var_0_0.WEEKLY = 4
var_0_0.ACTIVITY_BRANCH = 5
var_0_0.ACTIVITY_DAILY = 6
var_0_0.ACTIVITY_WEEKLY = 7
var_0_0.SEASON = 8
var_0_0.HIDE = 9

function var_0_0.GetPermanentTypes()
	return {
		var_0_0.MAIN,
		var_0_0.BRANCH,
		var_0_0.ACTIVITY_BRANCH,
		var_0_0.SEASON,
		var_0_0.HIDE
	}
end

var_0_0.SHOW_ALL = 0
var_0_0.SHOW_MAIN = 1
var_0_0.SHOW_BRANCH = 2
var_0_0.SHOW_DAILY = 3
var_0_0.SHOW_WEEKLY = 4
var_0_0.SHOW_ACTIVITY = 5
var_0_0.Type2ShowType = {
	[var_0_0.MAIN] = var_0_0.SHOW_MAIN,
	[var_0_0.BRANCH] = var_0_0.SHOW_BRANCH,
	[var_0_0.DAILY] = var_0_0.SHOW_DAILY,
	[var_0_0.WEEKLY] = var_0_0.SHOW_WEEKLY,
	[var_0_0.ACTIVITY_BRANCH] = var_0_0.SHOW_ACTIVITY,
	[var_0_0.ACTIVITY_DAILY] = var_0_0.SHOW_ACTIVITY,
	[var_0_0.ACTIVITY_WEEKLY] = var_0_0.SHOW_ACTIVITY,
	[var_0_0.SEASON] = nil,
	[var_0_0.HIDE] = var_0_0.SHOW_MAIN
}
var_0_0.ShowTypeFields = {
	[var_0_0.SHOW_MAIN] = "main",
	[var_0_0.SHOW_BRANCH] = "branch",
	[var_0_0.SHOW_DAILY] = "daily",
	[var_0_0.SHOW_WEEKLY] = "weekly",
	[var_0_0.SHOW_ACTIVITY] = "activity"
}
var_0_0.ShowTypeUnlockId = {
	[var_0_0.SHOW_MAIN] = 0,
	[var_0_0.SHOW_BRANCH] = 42,
	[var_0_0.SHOW_DAILY] = 43,
	[var_0_0.SHOW_WEEKLY] = 44,
	[var_0_0.SHOW_ACTIVITY] = 45
}
var_0_0.ShowTypeNames = {
	[var_0_0.SHOW_ALL] = i18n("island_task_type_1"),
	[var_0_0.SHOW_MAIN] = i18n("island_task_type_2"),
	[var_0_0.SHOW_BRANCH] = i18n("island_task_type_3"),
	[var_0_0.SHOW_DAILY] = i18n("island_task_type_4"),
	[var_0_0.SHOW_WEEKLY] = i18n("island_task_type_5"),
	[var_0_0.SHOW_ACTIVITY] = i18n("island_task_type_6")
}
var_0_0.ShowTypeColors = {
	[var_0_0.SHOW_MAIN] = "#36bdff",
	[var_0_0.SHOW_BRANCH] = "#f775ff",
	[var_0_0.SHOW_DAILY] = "#a891ff",
	[var_0_0.SHOW_WEEKLY] = "#46cd92",
	[var_0_0.SHOW_ACTIVITY] = "#ffc561"
}
var_0_0.ShowTypeTrackColors = {
	[var_0_0.SHOW_MAIN] = "#39bfff",
	[var_0_0.SHOW_BRANCH] = "#cb72d1",
	[var_0_0.SHOW_DAILY] = "#b29dff",
	[var_0_0.SHOW_WEEKLY] = "#8dffc0",
	[var_0_0.SHOW_ACTIVITY] = "#ffe18e"
}
var_0_0.EXCLUED_TRACK_TYPES = {
	var_0_0.MAIN,
	var_0_0.SEASON,
	var_0_0.HIDE
}

function var_0_0.GetTrackPriority(arg_2_0)
	return switch(arg_2_0, {
		[var_0_0.MAIN] = function()
			return 1
		end,
		[var_0_0.ACTIVITY_BRANCH] = function()
			return 2
		end,
		[var_0_0.BRANCH] = function()
			return 3
		end,
		[var_0_0.ACTIVITY_DAILY] = function()
			return 4
		end,
		[var_0_0.DAILY] = function()
			return 5
		end,
		[var_0_0.ACTIVITY_WEEKLY] = function()
			return 6
		end,
		[var_0_0.WEEKLY] = function()
			return 7
		end
	}, function()
		return 999
	end)
end

function var_0_0.GetHudPriority(arg_11_0)
	return switch(arg_11_0, {
		[var_0_0.SHOW_MAIN] = function()
			return 1
		end,
		[var_0_0.SHOW_BRANCH] = function()
			return 2
		end,
		[var_0_0.SHOW_ACTIVITY] = function()
			return 3
		end,
		[var_0_0.SHOW_DAILY] = function()
			return 4
		end,
		[var_0_0.SHOW_WEEKLY] = function()
			return 5
		end
	}, function()
		return 999
	end)
end

function var_0_0.GetTrackingIconName(arg_18_0)
	if arg_18_0 == var_0_0.MAIN then
		return "task_type_1"
	elseif arg_18_0 == var_0_0.BRANCH then
		return "task_type_2"
	elseif arg_18_0 == var_0_0.DAILY then
		return "task_type_3"
	elseif arg_18_0 == var_0_0.WEEKLY then
		return "task_type_4"
	elseif arg_18_0 == var_0_0.ACTIVITY_BRANCH or arg_18_0 == var_0_0.ACTIVITY_DAILY or arg_18_0 == var_0_0.ACTIVITY_WEEKLY or arg_18_0 == var_0_0.SEASON or arg_18_0 == var_0_0.HIDE then
		return "task_type_5"
	end

	assert(false, "Unknown type >>>" .. arg_18_0)

	return
end

return var_0_0
