local var_0_0 = class("MonopolyWorldScene", import("..base.BaseUI"))

var_0_0.ON_START = "MonopolyGame:ON_START"
var_0_0.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_0.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_0.ON_AWARD = "MonopolyGame:ON_AWARD"
var_0_0.ON_CLOSE = "MonopolyGame:ON_CLOSE"

function var_0_0.getUIName(arg_1_0)
	return "MonopolyWorldUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	arg_2_0:bind(MonopolyWorldScene.ON_START, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_3_2
		})

		return
	end)
	arg_2_0:bind(MonopolyWorldScene.ON_MOVE, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_4_2
		})

		return
	end)
	arg_2_0:bind(MonopolyWorldScene.ON_TRIGGER, function(arg_5_0, arg_5_1, arg_5_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_5_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_5_2
		})

		return
	end)
	arg_2_0:bind(MonopolyWorldScene.ON_AWARD, function(arg_6_0)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_2_0.activity.id,
			cmd = ActivityConst.MONOPOLY_OP_AWARD
		})

		return
	end)

	arg_2_0.gameUI = MonopolyWorldGame.New(arg_2_0, findTF(arg_2_0._tf, "AD"), arg_2_0.event)

	arg_2_0.gameUI:firstUpdata(arg_2_0.activity)

	return
end

function var_0_0.willExit(arg_7_0)
	if arg_7_0.gameUI then
		arg_7_0.gameUI:dispose()
	end

	return
end

function var_0_0.onBackPressed(arg_8_0)
	if arg_8_0.gameUI.inAnimatedFlag then
		return
	end

	arg_8_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

return var_0_0
