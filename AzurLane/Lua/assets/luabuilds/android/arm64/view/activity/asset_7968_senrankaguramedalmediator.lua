class = var_0_10000

local var_0_0 = "SenrankaguraMedalMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.SUBMIT_TASK_ALL = "activity submit task all"
var_0_1.SUBMIT_TASK = "activity submit task "
var_0_1.TASK_GO = "task go "

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SUBMIT_TASK, function(arg_2_0, arg_2_1)
		arg_1_0.displayAwards = {}

		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SUBMIT_TASK, arg_2_1, function(arg_3_0)
			if not arg_3_0 then
				-- block empty
			end

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.SUBMIT_TASK_ALL, function(arg_4_0, arg_4_1)
		getProxy = var_2_10002
		TaskProxy = var_2_10004

		local var_4_0 = var_2_10002(var_2_10004)
		local var_4_1 = false
		local var_4_2 = {}

		for iter_4_0 = 1, #arg_4_1 do
			local var_4_3 = var_4_0:getTaskById(arg_4_1[iter_4_0])

			table = var_2_10010

			var_2_10010.insert(var_4_2, var_4_3)

			if not var_4_3 then
				return
			end

			if not var_4_1 and var_4_3:IsOverflowShipExpItem() then
				var_4_1 = true
				pg = var_2_10010

				local var_4_4 = var_2_10010.MsgboxMgr.GetInstance()

				var_2_10010 = var_2_10010.ShowMsgBox

				local var_4_5 = {}

				i18n = var_2_10014
				var_4_5.content = var_2_10014("player_expResource_mail_fullBag")

				function var_4_5.onYes()
					arg_1_0.displayAwards = {}

					local var_5_0 = arg_1_0
					local var_5_1 = var_0.sendNotification

					GAME = var_3_10003

					var_5_1(var_5_0, var_3_10003.SUBMIT_TASK_ONESTEP, {
						resultList = var_4_2
					})

					return
				end

				function var_4_5.onNo()
					return
				end

				var_2_10010(var_4_4, var_4_5)
			end
		end

		if not var_4_1 then
			arg_1_0.displayAwards = {}

			local var_4_6 = arg_1_0
			local var_4_7 = var_5.sendNotification

			GAME = iter_4_0

			var_4_7(var_4_6, iter_4_0.SUBMIT_TASK_ONESTEP, {
				resultList = var_4_2
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.TASK_GO, {
			taskVO = arg_7_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.SUBMIT_TASK_DONE
	ActivityProxy = var_2
	var_8_0[2] = var_2.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_8_0[3] = var_2.ACTIVITY_SHOW_AWARDS
	GAME = var_2
	var_8_0[4] = var_2.MEMORYBOOK_UNLOCK_DONE
	GAME = var_2
	var_8_0[5] = var_2.MEMORYBOOK_UNLOCK_AWARD_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	GAME = var_9_0

	if var_9_1 == var_9_0.SUBMIT_TASK_DONE then
		if #var_9_2 > 0 then
			for iter_9_0 = 1, #var_9_2 do
				if var_9_2[iter_9_0].configId == arg_9_0.viewComponent.ptId then
					-- block empty
				else
					table = var_8

					var_8.insert(arg_9_0.displayAwards, var_9_2[iter_9_0])
				end
			end
		end

		arg_9_0:checkShowTaskAward()
	else
		GAME = var_4

		if var_9_1 == var_4.ACTIVITY_UPDATED then
			-- block empty
		else
			GAME = var_4

			if var_9_1 == var_4.MEMORYBOOK_UNLOCK_DONE then
				local var_9_3 = arg_9_0.viewComponent

				var_4.updateUI(var_9_3)
			else
				ActivityProxy = var_4

				local var_9_5

				if var_9_1 == var_4.ACTIVITY_SHOW_AWARDS then
					local var_9_4 = arg_9_0.viewComponent

					var_9_5 = var_9_5.emit
					BaseUI = iter_9_0

					var_9_5(var_9_4, iter_9_0.ON_ACHIEVE, var_9_2.awards, var_9_2.callback)

					local var_9_6 = arg_9_0.viewComponent

					var_9_5.updateUI(var_9_6)
				else
					GAME = var_9_5

					if var_9_1 == var_9_5.MEMORYBOOK_UNLOCK_AWARD_DONE then
						-- block empty
					end
				end
			end
		end
	end

	return
end

function var_0_1.checkShowTaskAward(arg_10_0)
	if #arg_10_0.displayAwards > 0 then
		local var_10_0 = arg_10_0.viewComponent
		local var_10_1 = var_1.emit

		BaseUI = var_1_10004

		var_10_1(var_10_0, var_1_10004.ON_ACHIEVE, arg_10_0.displayAwards)
	end

	local var_10_2 = arg_10_0.viewComponent

	var_1.updateUI(var_10_2)

	arg_10_0.displayAwards = {}

	return
end

return var_0_1
