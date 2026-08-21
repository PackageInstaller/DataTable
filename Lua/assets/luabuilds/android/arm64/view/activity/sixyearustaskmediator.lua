local var_0_0 = class("SixYearUsTaskMediator", import("view.base.ContextMediator"))

var_0_0.ON_TASK_GO = "event on task go"
var_0_0.ON_TASK_SUBMIT = "event on task submit"
var_0_0.ON_TASK_SUBMIT_ONESTEP = "event on task submit one step"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1, arg_3_2)
		seriesAsync({
			function(arg_4_0)
				arg_1_0:settleTownGold({
					arg_3_1.id
				}, arg_4_0)

				return
			end,
			function(arg_5_0)
				arg_1_0.awardIndex = 0
				arg_1_0.showAwards = {}

				arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
					act_id = arg_3_1:getActId(),
					task_ids = {
						arg_3_1.id
					}
				}, arg_3_2)

				return
			end
		}, function()
			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT_ONESTEP, function(arg_7_0, arg_7_1)
		seriesAsync({
			function(arg_8_0)
				arg_1_0:settleTownGold(arg_7_1, arg_8_0)

				return
			end,
			function(arg_9_0)
				arg_1_0.awardIndex = 0
				arg_1_0.showAwards = {}

				for iter_9_0, iter_9_1 in pairs((arg_1_0:getSubmitDatas(arg_7_1))) do
					arg_1_0.awardIndex = arg_1_0.awardIndex + 1

					arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
						act_id = iter_9_0,
						task_ids = iter_9_1
					})
				end

				return
			end
		}, function()
			return
		end)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	if not var_1_0 or var_1_0:isEnd() then
		assert(nil, "not exist act")

		return
	end

	arg_1_0.townActId = var_1_0.id

	return
end

function var_0_0.isSubmitTownGoldTask(arg_11_0, arg_11_1)
	local var_11_0 = pg.task_data_template[arg_11_1]

	return pg.task_data_template[arg_11_1].sub_type == 1006 and var_11_0.target_id == "1004"
end

function var_0_0.settleTownGold(arg_12_0, arg_12_1, arg_12_2)
	if underscore.any(arg_12_1, function(arg_13_0)
		return arg_12_0:isSubmitTownGoldTask(arg_13_0)
	end) then
		arg_12_0:sendNotification(GAME.ACTIVITY_TOWN_OP, {
			activity_id = arg_12_0.townActId,
			cmd = TownActivity.OPERATION.SETTLE_GOLD,
			callback = arg_12_2
		})
	else
		arg_12_2()
	end

	return
end

function var_0_0.listNotificationInterests(arg_14_0)
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:getName()

	if var_15_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if arg_15_0.awardIndex > 0 then
			arg_15_0.awardIndex = arg_15_0.awardIndex - 1
		end

		for iter_15_0, iter_15_1 in ipairs(arg_15_1:getBody().awards) do
			table.insert(arg_15_0.showAwards, iter_15_1)
		end

		if arg_15_0.awardIndex == 0 then
			arg_15_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_15_0.showAwards, function()
				arg_15_0.viewComponent:Show()

				return
			end)

			arg_15_0.showAwards = {}
		end
	elseif var_15_0 == GAME.ACTIVITY_UPDATED then
		arg_15_0.viewComponent:Show()
	end

	return
end

function var_0_0.getSubmitDatas(arg_17_0, arg_17_1)
	local var_17_0 = getProxy(TaskProxy)

	for iter_17_0 = 1, #arg_17_1 do
		local var_17_1 = var_17_0:getTaskById(arg_17_1[iter_17_0])

		if var_17_1 and var_17_1:getActId() then
			local var_17_2 = var_17_1:getActId()

			if not ({})[var_17_2] then
				({})[var_17_2] = {}
			end

			table.insert(({})[var_17_2], arg_17_1[iter_17_0])
		end
	end

	return {}
end

function var_0_0.GetTaskRedTip()
	local var_18_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SIX_YEAR_US_TASK_ACT_ID)
	local var_18_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SIX_YEAR_US_TASK_2_ACT_ID)

	if var_18_0 and not var_18_0:isEnd() then
		for iter_18_0, iter_18_1 in pairs((var_18_0:getConfig("config_data"))) do
			local var_18_2 = getProxy(TaskProxy):getTaskVO(iter_18_1)

			if var_18_2 and var_18_2:getTaskStatus() == 1 then
				return true
			end
		end
	end

	if var_18_1 and not var_18_1:isEnd() then
		for iter_18_2, iter_18_3 in pairs((var_18_1:getConfig("config_data"))) do
			local var_18_3 = getProxy(TaskProxy):getTaskVO(iter_18_3)

			if var_18_3 and var_18_3:getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

return var_0_0
