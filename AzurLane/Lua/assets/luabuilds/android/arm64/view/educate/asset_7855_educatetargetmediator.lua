class = var_0_10000

local var_0_0 = "EducateTargetMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateContextMediator"))

var_0_1.ON_TASK_SUBMIT = "EducateTargetMediator:ON_TASK_SUBMIT"
var_0_1.ON_GET_TARGET_AWARD = "EducateTargetMediator:ON_GET_TARGET_AWARD"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.EDUCATE_SUBMIT_TASK, {
			id = arg_2_1.id,
			system = arg_2_1:GetSystemType()
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_TARGET_AWARD, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.EDUCATE_GET_TARGET_AWARD)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.EDUCATE_SUBMIT_TASK_DONE
	GAME = var_2
	var_4_0[2] = var_2.EDUCATE_GET_TARGET_AWARD_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	if var_5_1 ~= var_5_0.EDUCATE_SUBMIT_TASK_DONE then
		GAME = var_4

		if var_5_1 == var_4.EDUCATE_GET_TARGET_AWARD_DONE then
			local var_5_3 = arg_5_0.viewComponent
			local var_5_4 = var_4.emit

			EducateBaseUI = var_1_10007

			var_5_4(var_5_3, var_1_10007.EDUCATE_ON_AWARD, {
				items = var_5_2.awards
			})

			local var_5_5 = arg_5_0.viewComponent

			var_4.updateView(var_5_5)
		end

		return
	end
end

return var_0_1
