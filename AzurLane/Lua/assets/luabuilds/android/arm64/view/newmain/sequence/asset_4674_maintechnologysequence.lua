class = var_0_10000

local var_0_0 = var_0_10000("MainTechnologySequence")

var_0_0.DontNotifyBluePrintTaskAgain = false

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	TechnologyProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)

	if not var_2.getBuildingBluePrint(var_1_0) then
		arg_1_1()

		return
	end

	local var_1_1 = var_3
	local var_1_2 = var_3.getTaskIds(var_1_1)
	local var_1_3 = false

	ipairs = var_1_1

	for iter_1_0, iter_1_1 in var_1_1(var_1_2) do
		local var_1_4 = var_3

		var_1_10011 = var_3.getTaskOpenTimeStamp(var_1_4, iter_1_1)
		pg = var_1_10012

		local var_1_5 = var_1_10012.TimeMgr.GetInstance()

		if var_1_10011 <= var_1_10012.GetServerTime(var_1_5) then
			getProxy = var_1_10012
			TaskProxy = var_1_5

			local var_1_6 = var_1_10012(var_1_5)

			if not var_1_10012.getTaskById(var_1_6, iter_1_1) then
				getProxy = var_1_10012
				TaskProxy = var_1_6

				local var_1_7 = var_1_10012(var_1_6)

				var_1_10012 = var_1_10012.getFinishTaskById(var_1_7, iter_1_1)
			end

			getProxy = var_1_4
			TaskProxy = var_15

			local var_1_8 = var_1_4(var_15)
			local var_1_9 = var_13.isFinishPrevTasks(var_1_8, iter_1_1)

			if not var_1_10012 and var_1_9 then
				var_1_3 = true

				arg_1_0:TriggerTask(iter_1_1)
			end
		end
	end

	if var_1_3 and not var_0_0.DontNotifyBluePrintTaskAgain then
		local var_1_10 = var_3:getShipVO()

		pg = var_7

		local var_1_11 = var_7.MsgboxMgr.GetInstance()
		local var_1_12 = var_7.ShowMsgBox
		local var_1_13 = {}

		i18n = var_1_10011
		var_1_13.content = var_1_10011("blueprint_task_update_tip", var_1_10:getConfig("name"))

		function var_1_13.onYes()
			pg = var_2_10000

			local var_2_0 = var_2_10000.m02
			local var_2_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_2_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_2_1(var_2_0, var_2_2, var_2_10004.SHIPBLUEPRINT)

			return
		end

		function var_1_13.onNo()
			var_0_0.DontNotifyBluePrintTaskAgain = true

			arg_1_1()

			return
		end

		var_1_12(var_1_11, var_1_13)
	else
		arg_1_1()
	end

	return
end

function var_0_0.TriggerTask(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)

	if not var_2.isFinishPrevTasks(var_4_0, arg_4_1) then
		return
	end

	pg = var_2

	local var_4_1 = var_2.m02
	local var_4_2 = var_2.sendNotification

	GAME = var_5

	var_4_2(var_4_1, var_5.TRIGGER_TASK, arg_4_1)

	return
end

return var_0_0
