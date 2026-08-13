class = var_0_10000

local var_0_0 = "MonopolyPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseActivityPage"))

var_0_1.ON_START = "MonopolyGame:ON_START"
var_0_1.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_1.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_1.ON_AWARD = "MonopolyGame:ON_AWARD"

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	arg_1_0:bind(var_0_1.ON_START, function(arg_2_0, arg_2_1, arg_2_2)
		pg = var_2_10003

		local var_2_0 = var_2_10003.m02
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.MONOPOLY_OP
		local var_2_3 = {
			activity_id = arg_2_1
		}

		ActivityConst = var_2_10007
		var_2_3.cmd = var_2_10007.MONOPOLY_OP_THROW
		var_2_3.callback = arg_2_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_MOVE, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.MONOPOLY_OP
		local var_3_3 = {
			activity_id = arg_3_1
		}

		ActivityConst = var_2_10007
		var_3_3.cmd = var_2_10007.MONOPOLY_OP_MOVE
		var_3_3.callback = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TRIGGER, function(arg_4_0, arg_4_1, arg_4_2)
		pg = var_2_10003

		local var_4_0 = var_2_10003.m02
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.MONOPOLY_OP
		local var_4_3 = {
			activity_id = arg_4_1
		}

		ActivityConst = var_2_10007
		var_4_3.cmd = var_2_10007.MONOPOLY_OP_TRIGGER
		var_4_3.callback = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_AWARD, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.OPEN_LAYER

		Context = var_2_10004

		local var_5_3 = var_2_10004.New
		local var_5_4 = {}

		RedPacketMediator = var_2_10006
		var_5_4.mediator = var_2_10006
		RedPacketLayer = var_2_10006
		var_5_4.viewComponent = var_2_10006

		var_5_1(var_5_0, var_5_2, var_5_3(var_5_4))

		return
	end)

	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	if not arg_7_0.game then
		import = var_1
		arg_7_0.game = var_1("view.activity.subPages.Monopoly.game.MomopolyGame").New()

		local var_7_0 = arg_7_0.game

		var_2.SetUp(var_7_0, arg_7_0, arg_7_0.activity)
	else
		local var_7_1 = arg_7_0.game

		var_1.NetActivity(var_7_1, arg_7_0.activity)
	end

	return
end

function var_0_1.OnDestroy(arg_8_0)
	local var_8_0 = arg_8_0.game

	var_1.Destroy(var_8_0)

	return
end

return var_0_1
