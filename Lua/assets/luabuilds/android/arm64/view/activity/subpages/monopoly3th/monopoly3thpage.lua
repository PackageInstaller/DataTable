local var_0_0 = class("Monopoly3thPage", import("....base.BaseActivityPage"))

var_0_0.ON_START = "MonopolyGame:ON_START"
var_0_0.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_0.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_0.ON_AWARD = "MonopolyGame:ON_AWARD"
var_0_0.MONOPOLY_OP_LAST = "MonopolyGame:MONOPOLY_OP_LAST"

function var_0_0.OnInit(arg_1_0)
	arg_1_0:bind(Monopoly3thPage.MONOPOLY_OP_LAST, function(arg_2_0, arg_2_1, arg_2_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_LAST,
			callback = arg_2_2
		})

		return
	end)
	arg_1_0:bind(Monopoly3thPage.ON_START, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_3_2
		})

		return
	end)
	arg_1_0:bind(Monopoly3thPage.ON_MOVE, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(Monopoly3thPage.ON_TRIGGER, function(arg_5_0, arg_5_1, arg_5_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_5_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_5_2
		})

		return
	end)
	arg_1_0:bind(Monopoly3thPage.ON_AWARD, function(arg_6_0)
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.REDPACKEY)

		return
	end)

	return
end

function var_0_0.getLeftRpCount()
	local var_7_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	return var_7_0.data2_list[1] - var_7_0.data2_list[2]
end

function var_0_0.OnFirstFlush(arg_8_0)
	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	arg_9_0:updateGameUI()

	return
end

function var_0_0.updateGameUI(arg_10_0)
	if not arg_10_0.activity then
		return
	end

	if arg_10_0.gameUI then
		arg_10_0.gameUI:updataActivity(arg_10_0.activity)
	else
		arg_10_0.gameUI = Monopoly3thGame.New(arg_10_0, findTF(arg_10_0._tf, "AD"), arg_10_0.event, 4)

		arg_10_0.gameUI:firstUpdata(arg_10_0.activity)
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	arg_11_0.gameUI:dispose()

	return
end

return var_0_0
