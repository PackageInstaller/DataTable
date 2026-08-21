local var_0_0 = class("SculptureMediator", import("view.base.ContextMediator"))

var_0_0.ON_UNLOCK_SCULPTURE = "SculptureMediator:ON_UNLOCK_SCULPTURE"
var_0_0.ON_DRAW_SCULPTURE = "SculptureMediator:ON_DRAW_SCULPTURE"
var_0_0.ON_JOINT_SCULPTURE = "SculptureMediator:ON_JOINT_SCULPTURE"
var_0_0.ON_FINSIH_SCULPTURE = "SculptureMediator:ON_FINSIH_SCULPTURE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_FINSIH_SCULPTURE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SCULPTURE_ACT_OP, {
			id = arg_2_1,
			state = SculptureActivity.STATE_FINSIH
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_JOINT_SCULPTURE, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SCULPTURE_ACT_OP, {
			id = arg_3_1,
			state = SculptureActivity.STATE_JOINT
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UNLOCK_SCULPTURE, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.SCULPTURE_ACT_OP, {
			id = arg_4_1,
			state = SculptureActivity.STATE_UNLOCK
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_DRAW_SCULPTURE, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.SCULPTURE_ACT_OP, {
			id = arg_5_1,
			state = SculptureActivity.STATE_DRAW
		})

		return
	end)
	arg_1_0.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SCULPTURE)))

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		GAME.SCULPTURE_ACT_OP_DONE
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getBody()

	if arg_7_1:getName() == GAME.SCULPTURE_ACT_OP_DONE then
		arg_7_0.viewComponent:OnUpdateActivity(var_7_0.state, var_7_0.id, var_7_0.activity)

		if #var_7_0.awards > 0 then
			arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_0.awards)
		end
	end

	return
end

return var_0_0
