class = var_0_10000

local var_0_0 = "NewSkinTBMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_EXIT = "NewSkinTBMediator:ON_EXIT"
var_0_1.GO_SET_TB_SKIN = "NewSkinTBMediator:GO_SET_TB_SKIN"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.GO_SET_TB_SKIN, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.EDUCATE_DOCK, {
			OnSelected = function(arg_3_0)
				local var_3_0 = arg_1_0
				local var_3_1 = var_1.sendNotification

				GAME = var_3_10003

				var_3_1(var_3_0, var_3_10003.CHANGE_EDUCATE, {
					id = arg_3_0
				})

				return
			end,
			tbSkinId = arg_1_0.contextData.skinId
		})

		return
	end)

	local var_1_1 = arg_1_0.contextData

	NewEducateHelper = var_1_0
	var_1_1.secId = var_1_0.GetSecIdBySkinId(arg_1_0.contextData.skinId)

	local var_1_2 = arg_1_0.contextData

	getProxy = var_2
	PlayerProxy = var_3

	local var_1_3 = var_2(var_3)
	local var_1_4 = var_2.getRawData(var_1_3)

	var_1_2.isClose = var_2.GetEducateCharacter(var_1_4) == arg_1_0.contextData.secId

	local var_1_5 = arg_1_0.viewComponent

	var_1.setSkin(var_1_5, arg_1_0.contextData.skinId)

	return
end

function var_0_1.onUIAvalible(arg_4_0)
	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return var_0_1
