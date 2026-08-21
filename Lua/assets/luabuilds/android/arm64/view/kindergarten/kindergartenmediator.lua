local var_0_0 = class("KindergartenMediator", import("view.base.ContextMediator"))

var_0_0.GO_SCENE = "KindergartenMediator.GO_SCENE"
var_0_0.GO_SUBLAYER = "KindergartenMediator.GO_SUBLAYER"
var_0_0.ON_EXTRA_RANK = "KindergartenMediator.ON_EXTRA_RANK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_0.ON_EXTRA_RANK, function(arg_4_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_BOSSRUSH
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if arg_6_1:getBody().id == ActivityConst.ALVIT_PT_ACT_ID then
			arg_6_0.viewComponent:UpdatePt()
		end
	elseif var_6_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_6_0.viewComponent:UpdateTask()
	end

	return
end

return var_0_0
