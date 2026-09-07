local AterialYumiaCoreBuffMediator = class("AterialYumiaCoreBuffMediator", import("view.base.ContextMediator"))

AterialYumiaCoreBuffMediator.SUBMIT_TASK = "AterialYumiaCoreBuffMediator.SUBMIT_TASK"

function AterialYumiaCoreBuffMediator:register()
	self:bind(AterialYumiaCoreBuffMediator.SUBMIT_TASK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_2_1)

		return
	end)
	self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityById(ActivityConst.YUMIA_EXPEDITION_BUFF_ACT_ID)))

	return
end

function AterialYumiaCoreBuffMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.SUBMIT_TASK_AWARD_DOWN] = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_4_1:getBody()

			arg_4_0.viewComponent:UpdateView()
			arg_4_0.viewComponent:ShowUpgrade(nil, true)

			return
		end
	}

	return
end

return AterialYumiaCoreBuffMediator
