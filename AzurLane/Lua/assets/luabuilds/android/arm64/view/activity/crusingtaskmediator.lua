local var_0_0 = class("CrusingTaskMediator", import("view.base.ContextMediator"))

var_0_0.ON_TASK_GO = "CrusingTaskMediator.ON_TASK_GO"
var_0_0.ON_TASK_SUBMIT = "CrusingTaskMediator.ON_TASK_SUBMIT"
var_0_0.ON_TASK_QUICK_SUBMIT = "CrusingTaskMediator.ON_TASK_QUICK_SUBMIT"
var_0_0.ON_BUY_QUICK_TASK_ITEM = "CrusingTaskMediator.ON_BUY_QUICK_TASK_ITEM"
var_0_0.ON_EXIT = "CrusingTaskMediator.ON_EXIT"
var_0_0.quickTaskGoodId = 61017

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_QUICK_SUBMIT, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.QUICK_TASK, arg_4_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.ON_BUY_QUICK_TASK_ITEM, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = var_0_0.quickTaskGoodId,
			count = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_EXIT, function(arg_6_0)
		arg_1_0:sendNotification(CrusingMediator.UNFROZEN_MAP_UPDATE)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	arg_1_0.viewComponent:setActivity(var_1_0)
	updateCrusingActivityTask(var_1_0)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		BagProxy.ITEM_UPDATED,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_8_1.id == arg_8_0.viewComponent.activity.id then
			arg_8_0.viewComponent:setActivity(var_8_1)

			if arg_8_0.viewComponent.phase == #arg_8_0.viewComponent.awardList then
				pg.TipsMgr.GetInstance():ShowTips(i18n("battlepass_complete"))
				arg_8_0.viewComponent:closeView()
			else
				arg_8_0.viewComponent:updatePhaseInfo()
			end
		end
	elseif var_8_0 == BagProxy.ITEM_UPDATED then
		if var_8_1.id == Item.QUICK_TASK_PASS_TICKET_ID then
			arg_8_0.viewComponent:updateItemInfo()
		end
	elseif var_8_0 == GAME.SUBMIT_TASK_DONE or var_8_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		local var_8_2 = {}

		for iter_8_0, iter_8_1 in ipairs((arg_8_1:getType())) do
			var_8_2[iter_8_1] = true
		end

		if underscore.any(arg_8_0.viewComponent.tempTaskGroup, function(arg_9_0)
			return underscore.any(arg_9_0, function(arg_10_0)
				return var_8_2[arg_10_0.id]
			end)
		end) then
			arg_8_0.viewComponent:updateCurrentTaskGroup()
		end
	end

	return
end

return var_0_0
