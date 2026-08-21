local var_0_0 = class("FullPreviewMediatorTemplate", import("view.base.ContextMediator"))

var_0_0.GO_SCENE = "FullPreviewMediator.TemplateGO_SCENE"
var_0_0.CHANGE_SCENE = "FullPreviewMediatorTemplate.CHANGE_SCENE"
var_0_0.GO_SUBLAYER = "FullPreviewMediatorTemplate.GO_SUBLAYER"
var_0_0.GO_MINIGAME = "FullPreviewMediatorTemplate.GO_MINIGAME"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_2_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_2_0:bind(var_0_0.CHANGE_SCENE, function(arg_4_0, arg_4_1, ...)
		arg_2_0:sendNotification(GAME.CHANGE_SCENE, arg_4_1, ...)

		return
	end)
	arg_2_0:bind(var_0_0.GO_SUBLAYER, function(arg_5_0, arg_5_1, arg_5_2)
		arg_2_0:addSubLayers(arg_5_1, nil, arg_5_2)

		return
	end)
	arg_2_0:bind(var_0_0.GO_MINIGAME, function(arg_6_0, arg_6_1, ...)
		arg_2_0:sendNotification(GAME.GO_MINI_GAME, arg_6_1, ...)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	if arg_8_1:getName() == ActivityProxy.ACTIVITY_UPDATED then
		arg_8_0.viewComponent:UpdateView((arg_8_1:getBody()))
	end

	return
end

return var_0_0
