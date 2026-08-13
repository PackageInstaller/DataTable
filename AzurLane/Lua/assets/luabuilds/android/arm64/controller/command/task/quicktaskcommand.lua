class = var_0_10000

local var_0_0 = "QuickTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = arg_1_1:getType()
	local var_1_2
	local var_1_3 = var_1_0

	getProxy = var_1_10006
	TaskProxy = var_1_10008

	local var_1_4 = var_1_10006(var_1_10008)

	if not var_6.getTaskById(var_1_4, var_1_3) then
		pg = var_1_10008

		local var_1_5 = var_1_10008.TipsMgr.GetInstance()
		local var_1_6 = var_8.ShowTips

		i18n = var_1_10011

		var_1_6(var_1_5, var_1_10011("task_is_not_existence", var_1_3))

		if var_1_1 then
			var_1_1(false)
		end

		return
	end

	local var_1_7 = var_7:getConfig("quick_finish")

	getProxy = var_1_4
	BagProxy = var_11

	local var_1_8 = var_1_4(var_11)
	local var_1_9 = var_9.getItemCountById

	Item = var_1_10012

	if var_1_7 > var_1_9(var_1_8, var_1_10012.QUICK_TASK_PASS_TICKET_ID) then
		pg = var_1_7

		local var_1_10 = var_1_7.TipsMgr.GetInstance()
		local var_1_11 = var_8.ShowTips

		i18n = var_1_8

		var_1_11(var_1_10, var_1_8("common_no_item_1"))

		if var_1_1 then
			var_1_1(false)
		end

		return
	end

	if var_6:isSubmitting(var_1_3) then
		return
	else
		var_6:addSubmittingTask(var_1_3)
	end

	local var_1_12 = {}

	if var_7:IsOverflowShipExpItem() then
		table = var_9

		var_9.insert(var_1_12, function(arg_2_0)
			pg = var_2_10001

			local var_2_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_2_1 = var_1.ShowMsgBox
			local var_2_2 = {}

			i18n = var_2_10005
			var_2_2.content = var_2_10005("player_expResource_mail_fullBag")
			var_2_2.onYes = arg_2_0

			function var_2_2.onNo()
				local var_3_0 = var_0

				var_0.removeSubmittingTask(var_3_0, var_1_3)

				if var_1_1 then
					var_1_1(false)
				end

				return
			end

			var_2_1(var_2_0, var_2_2)

			return
		end)
	end

	seriesAsync = var_9

	var_9(var_1_12, function()
		local var_4_0 = false
		local var_4_1
		local var_4_2 = var_0
		local var_4_4

		if var_2.isActivityTask(var_4_2) then
			local var_4_3 = var_0

			var_4_1 = var_4_4.getActId(var_4_3)
			pg = var_4_4
			var_4_4 = var_4_4.activity_template[var_4_1].type
			table = var_2_10003

			local var_4_5 = var_2_10003.contains

			TotalTaskProxy = var_2_10005

			if var_4_5(var_2_10005.normal_task_type, var_4_4) then
				var_4_0 = true
			end
		end

		if var_4_0 then
			pg = var_4_4

			local var_4_6 = var_4_4.ConnectionMgr.GetInstance()

			var_4_4 = var_4_4.Send

			local var_4_7 = 20207
			local var_4_8 = {
				act_id = var_4_1,
				task_id = var_0.id
			}
			local var_4_9 = var_0

			var_4_8.item_cost = var_7.getConfig(var_4_9, "quick_finish")

			var_4_4(var_4_6, var_4_7, var_4_8, 20208, function(arg_5_0)
				QuickTaskCommand = var_3_10001

				var_3_10001.OnQuickTaskComplete(arg_5_0, var_0, var_1_1)

				return
			end)
		else
			pg = var_4_4

			local var_4_10 = var_4_4.ConnectionMgr.GetInstance()
			local var_4_11 = var_2.Send
			local var_4_12 = 20013
			local var_4_13 = {
				id = var_0.id
			}
			local var_4_14 = var_0

			var_4_13.item_cost = var_7.getConfig(var_4_14, "quick_finish")

			var_4_11(var_4_10, var_4_12, var_4_13, 20014, function(arg_6_0)
				QuickTaskCommand = var_3_10001

				var_3_10001.OnQuickTaskComplete(arg_6_0, var_0, var_1_1)

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.OnQuickTaskComplete(arg_7_0, arg_7_1, arg_7_2)
	getProxy = var_1_10003
	TaskProxy = var_1_10005

	local var_7_0 = var_1_10003(var_1_10005)

	var_3.removeSubmittingTask(var_7_0, arg_7_1.id)

	local var_7_1, var_7_2

	if arg_7_0.result == 0 then
		Item = var_7_1
		var_7_1 = var_7_1.QUICK_TASK_PASS_TICKET_ID
		var_7_2 = arg_7_1

		local var_7_3 = arg_7_1.getConfig(var_7_2, "quick_finish")

		getProxy = var_7_0
		BagProxy = var_8

		local var_7_4 = var_7_0(var_8)

		var_7_2 = var_6.removeItemById
		tonumber = var_1_10010

		local var_7_5 = var_1_10010(var_7_1)

		tonumber = var_1_10011

		var_7_2(var_7_4, var_7_5, var_1_10011(var_7_3))

		QuickTaskCommand = var_7_2

		var_7_2.AddGuildLivness(arg_7_1)

		PlayerConst = var_7_2
		var_7_2 = var_7_2.addTranDrop(arg_7_0.award_list, {
			taskId = arg_7_1.id
		})
		SubmitTaskCommand = var_8

		var_8.OnSubmitSuccess(arg_7_1)

		pg = var_8

		local var_7_6 = var_8.TipsMgr.GetInstance()
		local var_7_7 = var_8.ShowTips

		i18n = var_11

		var_7_7(var_7_6, var_11("battlepass_task_quickfinish3"))

		pg = var_7_7

		local var_7_8 = var_7_7.m02
		local var_7_9 = var_8.sendNotification

		GAME = var_11

		var_7_9(var_7_8, var_11.SUBMIT_TASK_DONE, var_7_2, {
			arg_7_1.id
		})

		getProxy = var_7_9
		ActivityProxy = var_7_8

		local var_7_10 = var_7_9(var_7_8)
		local var_7_11 = var_8.getActivityByType

		ActivityConst = var_12

		if var_7_11(var_7_10, var_12.ACTIVITY_TYPE_TASK_LIST_MONITOR) and not var_9:isEnd() then
			local var_7_12

			if not var_9:getConfig("config_data")[1] then
				var_7_12 = {}
			end

			table = var_7_10

			if var_7_10.contains(var_7_12, arg_7_1.id) then
				var_8:monitorTaskList(var_9)
			end
		end

		if arg_7_2 then
			arg_7_2(true)
		end
	else
		pg = var_7_1

		local var_7_13 = var_7_1.TipsMgr.GetInstance()
		local var_7_14 = var_4.ShowTips

		errorTip = var_7_2

		var_7_14(var_7_13, var_7_2("task_submitTask", arg_7_0.result))

		if arg_7_2 then
			arg_7_2(false)
		end
	end

	return
end

function var_0_1.AddGuildLivness(arg_8_0)
	local var_8_0 = arg_8_0

	if arg_8_0.IsGuildAddLivnessType(var_8_0) then
		getProxy = var_1
		GuildProxy = var_8_0

		local var_8_1 = var_1(var_8_0)
		local var_8_2 = var_1.getData(var_8_1)
		local var_8_3 = 0
		local var_8_4 = false

		if var_8_2 and arg_8_0:isGuildTask() then
			var_8_2:setWeeklyTaskFlag(1)

			if var_8_2:getWeeklyTask() then
				var_1_10008 = var_5
				var_8_3 = var_5.GetLivenessAddition(var_1_10008)
			end

			var_8_4 = true
		elseif arg_8_0:IsRoutineType() then
			pg = var_5
			var_8_3 = var_5.guildset.new_daily_task_guild_active.key_value
		elseif arg_8_0:IsWeeklyType() then
			pg = var_5
			var_8_3 = var_5.guildset.new_weekly_task_guild_active.key_value
		end

		if var_8_2 and var_8_3 and var_8_3 > 0 then
			local var_8_5 = var_8_2
			local var_8_6 = var_8_2.getMemberById

			getProxy = var_1_10008
			PlayerProxy = var_1_10010

			local var_8_7 = var_1_10008(var_1_10010)
			local var_8_8 = var_8_6(var_8_5, var_8.getRawData(var_8_7).id)

			var_5.AddLiveness(var_8_8, var_8_3)

			var_8_4 = true
		end

		if var_8_4 then
			var_1:updateGuild(var_8_2)
		end
	end

	return
end

return var_0_1
