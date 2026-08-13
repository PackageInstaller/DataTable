class = var_0_10000

local var_0_0 = "FullPreviewMediatorTemplate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GO_SCENE = "FullPreviewMediator.TemplateGO_SCENE"
var_0_1.CHANGE_SCENE = "FullPreviewMediatorTemplate.CHANGE_SCENE"
var_0_1.GO_SUBLAYER = "FullPreviewMediatorTemplate.GO_SUBLAYER"
var_0_1.GO_MINIGAME = "FullPreviewMediatorTemplate.GO_MINIGAME"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_2_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_2_0:bind(var_0_1.CHANGE_SCENE, function(arg_4_0, arg_4_1, ...)
		local var_4_0 = arg_2_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.CHANGE_SCENE, arg_4_1, ...)

		return
	end)
	arg_2_0:bind(var_0_1.GO_SUBLAYER, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_2_0

		var_3.addSubLayers(var_5_0, arg_5_1, nil, arg_5_2)

		return
	end)
	arg_2_0:bind(var_0_1.GO_MINIGAME, function(arg_6_0, arg_6_1, ...)
		local var_6_0 = arg_2_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.GO_MINI_GAME, arg_6_1, ...)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	ActivityProxy = var_1_10002
	var_7_0[1] = var_1_10002.ACTIVITY_UPDATED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	ActivityProxy = var_8_1

	if var_8_0 == var_8_1.ACTIVITY_UPDATED then
		local var_8_3 = arg_8_0.viewComponent

		var_4.UpdateView(var_8_3, var_8_2)
	end

	return
end

return var_0_1
