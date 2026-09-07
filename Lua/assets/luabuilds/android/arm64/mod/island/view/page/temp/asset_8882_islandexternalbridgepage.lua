local IslandExternalBridgePage = class("IslandExternalBridgePage", import("...base.IslandBasePage"))

function IslandExternalBridgePage:getUIName()
	return "IslandEmptyUI"
end

function IslandExternalBridgePage:NeedCache()
	return false
end

function IslandExternalBridgePage:OnShow()
	self:AddSubLayers(self:GetContext())

	return
end

function IslandExternalBridgePage:OnHide()
	self:RemoveSubLayers(self:GetContext())

	return
end

function IslandExternalBridgePage:AddSubLayers(arg_5_1, arg_5_2)
	arg_5_1.data = {
		container = self._tf,
		onClose = function()
			self:Hide()

			return
		end,
		params = arg_5_2
	}

	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(IslandMediator),
		context = arg_5_1
	})

	return
end

function IslandExternalBridgePage:RemoveSubLayers(arg_7_1)
	local var_7_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_7_1.mediator)

	if var_7_0 then
		pg.m02:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_7_0
		})
	end

	return
end

function IslandExternalBridgePage:GetContext()
	assert(false, "overwrite me")

	return
end

return IslandExternalBridgePage
