local NewSkinAtlasMediator = class("NewSkinAtlasMediator", import("...base.ContextMediator"))

NewSkinAtlasMediator.OPEN_SHOW_LAYER = "NewSkinAtlasMediator.OPEN_SHOW_LAYER"

function NewSkinAtlasMediator:register()
	self:bind(NewSkinAtlasMediator.OPEN_SHOW_LAYER, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			viewComponent = NewSkinShowLayer,
			mediator = NewSkinShowMediator,
			data = {
				skin = arg_2_1
			}
		}))

		return
	end)

	return
end

function NewSkinAtlasMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED
	}
end

function NewSkinAtlasMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == PlayerProxy.UPDATED then
		self.viewComponent:SetResource()
	end

	return
end

return NewSkinAtlasMediator
