local MetaCharacterSynMediator = class("MetaCharacterSynMediator", import("...base.ContextMediator"))

MetaCharacterSynMediator.OPEN_PT_GET_WAY_LAYER = "MetaCharacterSynMediator:OPEN_PT_GET_WAY_LAYER"

function MetaCharacterSynMediator:register()
	self:bind(MetaCharacterSynMediator.OPEN_PT_GET_WAY_LAYER, function(arg_2_0)
		self:addSubLayers(Context.New({
			viewComponent = MetaPTGetPreviewLayer,
			mediator = MetaPTGetPreviewMediator,
			data = {}
		}))

		return
	end)

	return
end

function MetaCharacterSynMediator:listNotificationInterests()
	return {
		GAME.ACT_NEW_PT_DONE,
		GAME.GET_META_PT_AWARD_DONE
	}
end

function MetaCharacterSynMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.GET_META_PT_AWARD_DONE then
		self.viewComponent:updateData()
		self.viewComponent:updateTaskList()
		self.viewComponent:updateGetAwardBtn()
	end

	return
end

return MetaCharacterSynMediator
