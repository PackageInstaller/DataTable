class = var_0_10000

local var_0_0 = "MetaCharacterSynMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.OPEN_PT_GET_WAY_LAYER = "MetaCharacterSynMediator:OPEN_PT_GET_WAY_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_PT_GET_WAY_LAYER, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		MetaPTGetPreviewLayer = var_2_10005
		var_2_3.viewComponent = var_2_10005
		MetaPTGetPreviewMediator = var_2_10005
		var_2_3.mediator = var_2_10005
		var_2_3.data = {}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.ACT_NEW_PT_DONE
	GAME = var_2
	var_3_0[2] = var_2.GET_META_PT_AWARD_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 == var_4_1.GET_META_PT_AWARD_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.updateData(var_4_3)

		local var_4_4 = arg_4_0.viewComponent

		var_4.updateTaskList(var_4_4)

		local var_4_5 = arg_4_0.viewComponent

		var_4.updateGetAwardBtn(var_4_5)
	end

	return
end

return var_0_1
