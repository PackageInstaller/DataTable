class = var_0_10000

local var_0_0 = "MetaQuickTacticsMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.USE_TACTICS_BOOK = "MetaQuickTacticsMediator.USE_TACTICS_BOOK"
var_0_1.OPEN_OVERFLOW_LAYER = "MetaQuickTacticsMediator.OPEN_OVERFLOW_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.META_QUICK_TACTICS_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getName(var_3_0)
	local var_3_2 = arg_3_1:getBody()

	GAME = var_3_0

	if var_3_1 == var_3_0.META_QUICK_TACTICS_DONE then
		local var_3_3 = arg_3_0.viewComponent

		var_4.updateAfterUse(var_3_3)

		local var_3_4 = arg_3_0.viewComponent

		var_4.resetUseData(var_3_4)

		local var_3_5 = arg_3_0.viewComponent

		var_4.updateAfterModifyUseCount(var_3_5)
	end

	return
end

function var_0_1.bindEvent(arg_4_0)
	arg_4_0:bind(var_0_1.USE_TACTICS_BOOK, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_4_0
		local var_5_1 = var_4.sendNotification

		GAME = var_2_10007

		var_5_1(var_5_0, var_2_10007.META_QUICK_TACTICS, {
			shipID = arg_5_1,
			skillID = arg_5_2,
			useCountDict = arg_5_3
		})

		return
	end)
	arg_4_0:bind(var_0_1.OPEN_OVERFLOW_LAYER, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		local var_6_0 = arg_4_0
		local var_6_1 = var_5.addSubLayers

		Context = var_2_10008

		local var_6_2 = var_2_10008.New
		local var_6_3 = {}

		MetaQuickTacticsOverflowMediator = var_2_10011
		var_6_3.mediator = var_2_10011
		MetaQuickTacticsOverflowLayer = var_2_10011
		var_6_3.viewComponent = var_2_10011
		var_6_3.data = {
			shipID = arg_6_1,
			skillID = arg_6_2,
			useCountDict = arg_6_3,
			overExp = arg_6_4
		}

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	return
end

return var_0_1
