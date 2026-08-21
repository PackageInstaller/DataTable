local var_0_0 = class("WorldTask")

var_0_0.STATE_INACTIVE = 0
var_0_0.STATE_ONGOING = 1
var_0_0.STATE_FINISHED = 2
var_0_0.STATE_RECEIVED = 3

local var_0_1 = pg.world_task_data

function var_0_0.type2BgColor(arg_1_0)
	var_0_0.Colors = var_0_0.Colors or {
		"yellow",
		"red",
		"blue",
		"orange",
		"green",
		"yellow"
	}

	return var_0_0.Colors[arg_1_0 + 1]
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_1.id
	arg_2_0.progress = arg_2_1.progress or 0
	arg_2_0.submiteTime = arg_2_1.submite_time or 0
	arg_2_0.acceptTime = arg_2_1.accept_time or 0
	arg_2_0.followingEntrance = arg_2_1.event_map_id or 0

	assert(var_0_1[arg_2_0.configId], "unfound config......" .. arg_2_0.configId)

	arg_2_0.config = var_0_1[arg_2_0.configId]
	arg_2_0.new = arg_2_1.new or 0

	local var_2_0 = nowWorld()

	if arg_2_0.config.complete_condition == WorldConst.TaskTypeSubmitItem then
		arg_2_0:updateProgress(var_2_0:GetInventoryProxy():GetItemCount(arg_2_0.config.complete_parameter[1]))
	elseif arg_2_0.config.complete_condition == WorldConst.TaskTypePressingMap then
		arg_2_0:updateProgress(var_2_0:GetTargetMapPressingCount(arg_2_0.config.complete_parameter))
	end

	return
end

function var_0_0.DebugPrint(arg_3_0)
	return string.format("任务 [%s] [id: %s] [状态: %s] [进度: %s/%s] [接受时间: %s] [完成时间: %s]", arg_3_0.config.name, arg_3_0.id, ({
		"未激活",
		"进行中",
		"已完成未提交",
		"已提交",
		"已过期"
	})[arg_3_0:getState() + 1], arg_3_0:getProgress(), arg_3_0:getMaxProgress(), arg_3_0.acceptTime, arg_3_0.submiteTime)
end

function var_0_0.isNew(arg_4_0)
	return arg_4_0.new == 1
end

function var_0_0.getState(arg_5_0)
	if arg_5_0.acceptTime == 0 then
		return var_0_0.STATE_INACTIVE
	elseif arg_5_0.submiteTime > 0 then
		return var_0_0.STATE_RECEIVED
	elseif arg_5_0:getProgress() >= arg_5_0:getMaxProgress() then
		return var_0_0.STATE_FINISHED
	else
		return var_0_0.STATE_ONGOING
	end

	return
end

function var_0_0.getMaxProgress(arg_6_0)
	return arg_6_0.config.complete_parameter_num
end

function var_0_0.updateProgress(arg_7_0, arg_7_1)
	arg_7_0.progress = arg_7_1

	return
end

function var_0_0.getProgress(arg_8_0)
	return arg_8_0.progress
end

function var_0_0.isAlive(arg_9_0)
	local var_9_0 = arg_9_0:getState()

	return var_9_0 == var_0_0.STATE_ONGOING or var_9_0 == var_0_0.STATE_FINISHED
end

function var_0_0.isFinished(arg_10_0)
	return arg_10_0:getState() == var_0_0.STATE_FINISHED
end

function var_0_0.isReceived(arg_11_0)
	return arg_11_0:getState() == var_0_0.STATE_RECEIVED
end

function var_0_0.canSubmit(arg_12_0)
	if arg_12_0:getState() ~= var_0_0.STATE_FINISHED then
		local var_12_1 = i18n("this task is not finish or is finished")

		return
	end

	return true
end

function var_0_0.commited(arg_13_0)
	arg_13_0.submiteTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.GetBgColor(arg_14_0)
	return var_0_0.type2BgColor(arg_14_0.config.type)
end

function var_0_0.GetDisplayDrops(arg_15_0)
	local var_15_0 = {}

	_.each(arg_15_0.config.show, function(arg_16_0)
		table.insert(var_15_0, {
			type = arg_16_0[1],
			id = arg_16_0[2],
			count = arg_16_0[3]
		})

		return
	end)

	return {}
end

function var_0_0.GetFollowingAreaId(arg_17_0)
	local var_17_0 = arg_17_0.config.following_region[1]

	return arg_17_0.config.following_region[1] and var_17_0 > 0 and var_17_0 or nil
end

local var_0_2 = {
	[0] = true,
	[true] = 6,
	[true] = 7
}

function var_0_0.GetFollowingEntrance(arg_18_0)
	if var_0_2[arg_18_0.config.type] then
		do return arg_18_0.config.following_map[1] end

		goto label_18_0
	end

	::label_18_0::

	if arg_18_0.followingEntrance > 0 then
		do
			return arg_18_0.followingEntrance or nil
		end

		return
	end
end

function var_0_0.IsSpecialType(arg_19_0)
	return arg_19_0.config.type == 5
end

function var_0_0.IsTypeCollection(arg_20_0)
	return arg_20_0.config.type == 6
end

function var_0_0.IsLockMap(arg_21_0)
	return arg_21_0.config.target_map_lock == 1
end

function var_0_0.IsAutoSubmit(arg_22_0)
	return arg_22_0.config.auto_complete == 1
end

function var_0_0.canTrigger(arg_23_0)
	local var_23_0 = nowWorld()
	local var_23_1 = WorldTask.New({
		id = arg_23_0
	})
	local var_23_2 = var_23_0:GetTaskProxy()

	if var_23_2:getTaskById(arg_23_0) then
		local var_23_4 = i18n("world_sametask_tip")

		return
	elseif var_23_0:GetLevel() < var_23_1.config.need_level then
		local var_23_6 = i18n1("舰队总等级需达到（缺gametip）" .. var_23_1.config.need_level)

		return
	elseif var_23_2.taskFinishCount < var_23_1.config.need_task_complete then
		local var_23_8 = i18n1("任务完成数需达到（缺gametip）" .. var_23_1.config.need_task_complete)

		return
	end

	return true
end

var_0_0.taskSortOrder = {
	[var_0_0.STATE_INACTIVE] = 2,
	[var_0_0.STATE_ONGOING] = 1,
	[var_0_0.STATE_FINISHED] = 0,
	[var_0_0.STATE_RECEIVED] = 3
}
var_0_0.sortDic = {
	function(arg_24_0)
		return var_0_0.taskSortOrder[arg_24_0:getState()]
	end,
	function(arg_25_0)
		return arg_25_0.config.type
	end,
	function(arg_26_0)
		return -arg_26_0.config.priority
	end,
	function(arg_27_0)
		return arg_27_0.id
	end
}

return var_0_0
