class = var_0_10000

local var_0_0 = "GuildOfficeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_ACCEPT_TASK = "GuildOfficeMediator:ON_ACCEPT_TASK"
var_0_1.ON_COMMIT = "GuildOfficeMediator:ON_COMMIT"
var_0_1.ON_FETCH_CAPITAL_LOG = "GuildOfficeMediator:ON_FETCH_CAPITAL_LOG"
var_0_1.ON_SELECT_TASK = "GuildOfficeMediator:ON_SELECT_TASK"
var_0_1.ON_SUBMIT_TASK = "GuildOfficeMediator:ON_SUBMIT_TASK"
var_0_1.UPDATE_WEEKLY_TASK = "GuildOfficeMediator:UPDATE_WEEKLY_TASK"
var_0_1.ON_PURCHASE_SUPPLY = "GuildOfficeMediator:ON_PURCHASE_SUPPLY"
var_0_1.GET_SUPPLY_AWARD = "GuildOfficeMediator:GET_SUPPLY_AWARD"
var_0_1.REFRES_DONATE_LIST = "GuildOfficeMediator:REFRES_DONATE_LIST"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0:bind(var_0_1.REFRES_DONATE_LIST, function(arg_2_0, arg_2_1)
		return
	end)
	arg_1_0:bind(var_0_1.UPDATE_WEEKLY_TASK, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GUILD_WEEKLY_TASK_PROGREE_UPDATE)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT_TASK, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SUBMIT_TASK, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_TASK, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.GUILD_SELECT_TASK, {
			taskId = arg_5_1,
			num = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACCEPT_TASK, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.TRIGGER_TASK, arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMIT, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.GUILD_COMMIT_DONATE, {
			taskId = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_PURCHASE_SUPPLY, function(arg_8_0)
		local var_8_0 = arg_1_0
		local var_8_1 = var_1.sendNotification

		GAME = var_2_10004

		var_8_1(var_8_0, var_2_10004.GUILD_BUY_SUPPLY)

		return
	end)
	arg_1_0:bind(var_0_1.GET_SUPPLY_AWARD, function(arg_9_0)
		local var_9_0 = arg_1_0
		local var_9_1 = var_1.sendNotification

		GAME = var_2_10004

		var_9_1(var_9_0, var_2_10004.GUILD_GET_SUPPLY_AWARD)

		return
	end)

	local var_1_1 = var_1_0:getData()
	local var_1_2 = arg_1_0.viewComponent

	var_3.SetGuild(var_1_2, var_1_1)

	getProxy = var_3
	PlayerProxy = var_1_2

	local var_1_3 = var_3(var_1_2)
	local var_1_4 = var_3.getRawData(var_1_3)
	local var_1_5 = arg_1_0.viewComponent

	var_4.setPlayer(var_1_5, var_1_4)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	GAME = var_1_10002
	var_10_0[1] = var_1_10002.TRIGGER_TASK_DONE
	GAME = var_2
	var_10_0[2] = var_2.GUILD_COMMIT_DONATE_DONE
	GAME = var_2
	var_10_0[3] = var_2.SUBMIT_TASK_DONE
	GuildProxy = var_2
	var_10_0[4] = var_2.GUILD_UPDATED
	GuildProxy = var_2
	var_10_0[5] = var_2.WEEKLYTASK_ADDED
	GuildProxy = var_2
	var_10_0[6] = var_2.WEEKLYTASK_UPDATED
	GuildProxy = var_2
	var_10_0[7] = var_2.CAPITAL_UPDATED
	PlayerProxy = var_2
	var_10_0[8] = var_2.UPDATED
	GAME = var_2
	var_10_0[9] = var_2.GUILD_WEEKLY_TASK_PROGREE_UPDATE_DONE
	GAME = var_2
	var_10_0[10] = var_2.GUILD_GET_SUPPLY_AWARD_DONE
	GuildProxy = var_2
	var_10_0[11] = var_2.SUPPLY_STARTED
	GAME = var_2
	var_10_0[12] = var_2.ZERO_HOUR_OP_DONE
	TaskProxy = var_2
	var_10_0[13] = var_2.TASK_UPDATED
	GuildProxy = var_2
	var_10_0[14] = var_2.ON_DONATE_LIST_UPDATED

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.getName(var_11_0)
	local var_11_2 = arg_11_1:getBody()

	GuildProxy = var_11_0

	if var_11_1 == var_11_0.GUILD_UPDATED then
		var_1_10006 = arg_11_0.viewComponent

		var_4.SetGuild(var_1_10006, var_11_2)

		goto label_11_0
	end

	PlayerProxy = var_4

	local var_11_3

	if var_11_1 == var_4.UPDATED then
		var_1_10006 = arg_11_0.viewComponent
		var_11_3 = var_11_3.setPlayer
		getProxy = var_1_10007
		PlayerProxy = var_1_10009

		local var_11_4 = var_1_10007(var_1_10009)

		var_11_3(var_1_10006, var_1_10007.getRawData(var_11_4))

		goto label_11_0
	end

	GAME = var_11_3

	local var_11_5

	if var_11_1 == var_11_3.GUILD_COMMIT_DONATE_DONE then
		var_1_10006 = arg_11_0.viewComponent

		var_11_5.UpdateContribution(var_1_10006)

		function var_11_5()
			return
		end

		if var_11_2.awards then
			local var_11_6 = #var_11_2.awards

			if 0 < var_11_6 then
				var_1_10007 = arg_11_0.viewComponent

				local var_11_7 = var_5.emit

				BaseUI = var_1_10008

				var_11_7(var_1_10007, var_1_10008.ON_ACHIEVE, var_11_2.awards, var_11_5)

				goto label_11_0
			end
		end

		var_11_5()

		goto label_11_0
	end

	GuildProxy = var_11_5

	if var_11_1 == var_11_5.ON_DONATE_LIST_UPDATED then
		var_1_10006 = arg_11_0.viewComponent

		var_4.UpdateContribution(var_1_10006)

		goto label_11_0
	end

	GAME = var_4

	local var_11_8

	if var_11_1 == var_4.TRIGGER_TASK_DONE then
		pg = var_11_8
		var_1_10006 = var_11_8.TipsMgr.GetInstance()
		var_11_8 = var_11_8.ShowTips
		i18n = var_1_10007

		var_11_8(var_1_10006, var_1_10007("guild_get_week_done"))

		var_1_10006 = arg_11_0.viewComponent

		var_11_8.UpdateTask(var_1_10006)

		goto label_11_0
	end

	GAME = var_11_8

	local var_11_9

	if var_11_1 == var_11_8.SUBMIT_TASK_DONE then
		var_1_10006 = arg_11_0.viewComponent
		var_11_9 = var_11_9.emit
		BaseUI = var_1_10007

		var_11_9(var_1_10006, var_1_10007.ON_ACHIEVE, var_11_2)

		var_1_10006 = arg_11_0.viewComponent

		var_11_9.UpdateTask(var_1_10006, true)

		goto label_11_0
	end

	GuildProxy = var_11_9

	if var_11_1 ~= var_11_9.WEEKLYTASK_ADDED then
		GuildProxy = var_4

		if var_11_1 ~= var_4.WEEKLYTASK_UPDATED then
			GAME = var_4

			if var_11_1 == var_4.GUILD_WEEKLY_TASK_PROGREE_UPDATE_DONE then
				var_1_10006 = arg_11_0.viewComponent

				var_4.UpdateTask(var_1_10006)
			else
				GAME = var_4

				local var_11_10

				if var_11_1 == var_4.GUILD_GET_SUPPLY_AWARD_DONE then
					var_1_10006 = arg_11_0.viewComponent
					var_11_10 = var_11_10.emit
					BaseUI = var_1_10007

					var_11_10(var_1_10006, var_1_10007.ON_ACHIEVE, var_11_2.list)

					var_1_10006 = arg_11_0.viewComponent

					var_11_10.UpdateSupplyPanel(var_1_10006)
				else
					GuildProxy = var_11_10

					if var_11_1 == var_11_10.SUPPLY_STARTED then
						var_1_10006 = arg_11_0.viewComponent

						var_4.UpdateSupplyPanel(var_1_10006)
					else
						GAME = var_4

						if var_11_1 == var_4.ZERO_HOUR_OP_DONE then
							-- block empty
						else
							TaskProxy = var_4

							if var_11_1 == var_4.TASK_UPDATED then
								getProxy = var_4
								GuildProxy = var_1_10006

								local var_11_11 = var_4(var_1_10006)

								if var_4.getRawData(var_11_11) and var_4:getWeeklyTask() and var_5.id > 0 and var_5:IsSamePrivateTask(var_11_2) then
									local var_11_12 = arg_11_0.viewComponent

									var_6.UpdateTask(var_11_12)
								end
							end
						end
					end
				end
			end

			::label_11_0::

			return
		end
	end
end

return var_0_1
