local var_0_0 = class("AterialYumiaCoreBuffMediator", import("view.base.ContextMediator"))

var_0_0.SUBMIT_TASK = "AterialYumiaCoreBuffMediator.SUBMIT_TASK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SUBMIT_TASK, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_2_1)

		return
	end)
	arg_1_0.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityById(ActivityConst.YUMIA_EXPEDITION_BUFF_ACT_ID)))

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
		[GAME.SUBMIT_TASK_AWARD_DOWN] = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_4_1:getBody()

			arg_4_0.viewComponent:UpdateView()
			arg_4_0.viewComponent:ShowUpgrade(nil, true)

			return
		end
	}

	return
end

return var_0_0
