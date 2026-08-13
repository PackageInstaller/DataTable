class = var_0_10000

local var_0_0 = var_0_10000("MainTechnologySequence")

var_0_0.DontNotifyBluePrintTaskAgain = false

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	TechnologyProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)

	if not var_2.getBuildingBluePrint(var_1_0) then
		arg_1_1()

		return
	end

	local var_1_1 = var_3:getTaskIds()
	local var_1_2 = false

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_1) do
		local var_1_3 = var_3
		local var_1_4 = var_3.getTaskOpenTimeStamp(var_1_3, iter_1_1)

		pg = var_1_3

		local var_1_5 = var_1_3.TimeMgr.GetInstance()

		if var_1_4 <= var_12.GetServerTime(var_1_5) then
			getProxy = var_12
			TaskProxy = var_1_5

			local var_1_6 = var_12(var_1_5)
			local var_1_7

			if not var_12.getTaskById(var_1_6, iter_1_1) then
				getProxy = var_1_7
				TaskProxy = var_1_6
				var_1_6 = var_1_7(var_1_6)
				var_1_7 = var_1_7.getFinishTaskById(var_1_6, iter_1_1)
			end

			getProxy = var_1_6
			TaskProxy = var_14

			local var_1_8 = var_1_6(var_14)
			local var_1_9 = var_13.isFinishPrevTasks(var_1_8, iter_1_1)

			if not var_1_7 and var_1_9 then
				var_1_2 = true

				arg_1_0:TriggerTask(iter_1_1)
			end
		end
	end

	if var_1_2 and not var_0_0.DontNotifyBluePrintTaskAgain then
		local var_1_10 = var_3
		local var_1_11 = var_3.getShipVO(var_1_10)

		pg = var_1_10

		local var_1_12 = var_1_10.MsgboxMgr.GetInstance()
		local var_1_13 = var_7.ShowMsgBox
		local var_1_14 = {}

		i18n = iter_1_1
		var_1_14.content = iter_1_1("blueprint_task_update_tip", var_1_11:getConfig("name"))

		function var_1_14.onYes()
			pg = var_2_10000

			local var_2_0 = var_2_10000.m02
			local var_2_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_2_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_2_1(var_2_0, var_2_2, var_2_10003.SHIPBLUEPRINT)

			return
		end

		function var_1_14.onNo()
			var_0_0.DontNotifyBluePrintTaskAgain = true

			arg_1_1()

			return
		end

		var_1_13(var_1_12, var_1_14)
	else
		arg_1_1()
	end

	return
end

function var_0_0.TriggerTask(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	if not var_2.isFinishPrevTasks(var_4_0, arg_4_1) then
		return
	end

	pg = var_2

	local var_4_1 = var_2.m02
	local var_4_2 = var_2.sendNotification

	GAME = var_4

	var_4_2(var_4_1, var_4.TRIGGER_TASK, arg_4_1)

	return
end

return var_0_0
