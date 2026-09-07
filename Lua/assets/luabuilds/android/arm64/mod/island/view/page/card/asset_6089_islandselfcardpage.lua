local IslandSelfCardPage = class("IslandSelfCardPage", import("...base.IslandBasePage"))

function IslandSelfCardPage:getUIName()
	return "IslandEmptyUI"
end

function IslandSelfCardPage:NeedCache()
	return false
end

function IslandSelfCardPage:OnShow()
	self:AddSubLayers(self:GetContext())

	return
end

function IslandSelfCardPage:OnHide()
	self:RemoveSubLayers(self:GetContext())

	return
end

function IslandSelfCardPage:AddSubLayers(arg_5_1)
	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext():getContextByMediator(IslandMediator),
		context = arg_5_1
	})

	return
end

function IslandSelfCardPage:RemoveSubLayers(arg_6_1)
	local var_6_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(arg_6_1.mediator)

	if var_6_0 then
		pg.m02:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_6_0
		})
	end

	return
end

function IslandSelfCardPage:GetContext()
	return Context.New({
		mediator = IslandSelfCardMediator,
		viewComponent = IslandSelfCardAttach,
		data = {
			isIslandPage = true,
			container = self._tf,
			onClose = function()
				self:Hide()

				return
			end
		}
	})
end

return IslandSelfCardPage
