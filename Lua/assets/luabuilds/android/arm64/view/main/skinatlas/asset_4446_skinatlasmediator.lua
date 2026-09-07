local SkinAtlasMediator = class("SkinAtlasMediator", import("...base.ContextMediator"))

SkinAtlasMediator.OPEN_INDEX = "SkinAtlasMediator:OPEN_INDEX"

function SkinAtlasMediator:register()
	self:bind(SkinAtlasMediator.OPEN_INDEX, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			viewComponent = SkinAtlasIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_2_1
		}))

		return
	end)

	return
end

function SkinAtlasMediator:listNotificationInterests()
	return {
		SetShipSkinCommand.SKIN_UPDATED
	}
end

function SkinAtlasMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == SetShipSkinCommand.SKIN_UPDATED then
		self.viewComponent:UpdateSkinCards()
	end

	return
end

return SkinAtlasMediator
