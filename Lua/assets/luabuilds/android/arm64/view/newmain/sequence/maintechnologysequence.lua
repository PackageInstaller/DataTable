local var_0_0 = class("MainTechnologySequence")

var_0_0.DontNotifyBluePrintTaskAgain = false

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(TechnologyProxy):getBuildingBluePrint()
	local var_1_1

	if not var_1_0 then
		arg_1_1()

		do return end

		var_1_1 = false
	end

	for iter_1_0, iter_1_1 in ipairs((var_1_0:getTaskIds())) do
		local var_1_2 = pg.TimeMgr.GetInstance()

		if var_1_0:getTaskOpenTimeStamp(iter_1_1) <= var_1_2:GetServerTime() then
			local var_1_3 = getProxy(TaskProxy):getTaskById(iter_1_1)

			var_1_3 = var_1_3 or getProxy(TaskProxy):getFinishTaskById(iter_1_1)

			local var_1_4 = getProxy(TaskProxy):isFinishPrevTasks(iter_1_1)

			if not var_1_3 and var_1_4 then
				var_1_1 = true

				arg_1_0:TriggerTask(iter_1_1)
			end
		end
	end

	if var_1_1 and not var_0_0.DontNotifyBluePrintTaskAgain then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("blueprint_task_update_tip", var_1_0:getShipVO():getConfig("name")),
			onYes = function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPBLUEPRINT)

				return
			end,
			onNo = function()
				var_0_0.DontNotifyBluePrintTaskAgain = true

				arg_1_1()

				return
			end
		})
	else
		arg_1_1()
	end

	return
end

function var_0_0.TriggerTask(arg_4_0, arg_4_1)
	if not getProxy(TaskProxy):isFinishPrevTasks(arg_4_1) then
		return
	end

	pg.m02:sendNotification(GAME.TRIGGER_TASK, arg_4_1)

	return
end

return var_0_0
