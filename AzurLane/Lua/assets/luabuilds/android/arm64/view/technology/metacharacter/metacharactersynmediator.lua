local var_0_0 = class("MetaCharacterSynMediator", import("...base.ContextMediator"))

var_0_0.OPEN_PT_GET_WAY_LAYER = "MetaCharacterSynMediator:OPEN_PT_GET_WAY_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_PT_GET_WAY_LAYER, function(arg_2_0)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = MetaPTGetPreviewLayer,
			mediator = MetaPTGetPreviewMediator,
			data = {}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.ACT_NEW_PT_DONE,
		GAME.GET_META_PT_AWARD_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.GET_META_PT_AWARD_DONE then
		arg_4_0.viewComponent:updateData()
		arg_4_0.viewComponent:updateTaskList()
		arg_4_0.viewComponent:updateGetAwardBtn()
	end

	return
end

return var_0_0
