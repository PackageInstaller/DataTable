local AllBuffDetailMediator = class("AllBuffDetailMediator", import("..base.ContextMediator"))

AllBuffDetailMediator.OPEN_SET_VALUE_LAYER = "AllBuffDetailMediator:OPEN_SET_VALUE_LAYER"

function AllBuffDetailMediator:register()
	self:bind(AllBuffDetailMediator.OPEN_SET_VALUE_LAYER, function()
		self:addSubLayers(Context.New({
			mediator = TechnologyTreeSetAttrMediator,
			viewComponent = TechnologyTreeSetAttrLayer,
			data = {},
			onRemoved = function()
				self.viewComponent:updateDetail()

				return
			end
		}))

		return
	end)

	return
end

function AllBuffDetailMediator:listNotificationInterests()
	return {}
end

function AllBuffDetailMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return AllBuffDetailMediator
