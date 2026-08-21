local var_0_0 = class("MonopolyCarPage", import("....base.BaseActivityPage"))

var_0_0.ON_START = "MonopolyGame:ON_START"
var_0_0.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_0.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_0.ON_AWARD = "MonopolyGame:ON_AWARD"

function var_0_0.OnInit(arg_1_0)
	arg_1_0:bind(MonopolyCarPage.ON_START, function(arg_2_0, arg_2_1, arg_2_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_2_2
		})

		return
	end)
	arg_1_0:bind(MonopolyCarPage.ON_MOVE, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_3_2
		})

		return
	end)
	arg_1_0:bind(MonopolyCarPage.ON_TRIGGER, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(MonopolyCarPage.ON_AWARD, function(arg_5_0)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_1_0.activity.id,
			cmd = ActivityConst.MONOPOLY_OP_AWARD
		})

		return
	end)

	return
end

function var_0_0.OnFirstFlush(arg_6_0)
	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	if arg_7_0.gameUI then
		arg_7_0.gameUI:updataActivity(arg_7_0.activity)
	else
		arg_7_0.gameUI = MonopolyCarGame.New(arg_7_0, findTF(arg_7_0._tf, "AD"), arg_7_0.event)

		arg_7_0.gameUI:firstUpdata(arg_7_0.activity)
	end

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
