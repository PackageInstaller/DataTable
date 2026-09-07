local TechnologyTreeMediator = class("TechnologyTreeMediator", import("..base.ContextMediator"))

function TechnologyTreeMediator:register()
	self:bind(TechnologyConst.OPEN_SHIP_BUFF_DETAIL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:addSubLayers(Context.New({
			mediator = SingleBuffDetailMediator,
			viewComponent = SingleBuffDetailLayer,
			data = {
				groupID = arg_2_1,
				maxLV = arg_2_2,
				star = arg_2_3
			}
		}))

		return
	end)
	self:bind(TechnologyConst.CLOSE_TECHNOLOGY_NATION_LAYER, function(arg_3_0)
		self:sendNotification(TechnologyConst.CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION)

		return
	end)
	self:bind(TechnologyConst.OPEN_TECHNOLOGY_NATION_LAYER, function(arg_4_0)
		self:addSubLayers(Context.New({
			mediator = TechnologyTreeNationMediator,
			viewComponent = TechnologyTreeNationScene,
			data = {}
		}))

		return
	end)
	self:bind(TechnologyConst.OPEN_ALL_BUFF_DETAIL, function(arg_5_0)
		self:addSubLayers(Context.New({
			mediator = AllBuffDetailMediator,
			viewComponent = AllBuffDetailLayer,
			data = {}
		}))

		return
	end)

	return
end

function TechnologyTreeMediator:listNotificationInterests()
	return {
		TechnologyConst.UPDATE_REDPOINT_ON_TOP
	}
end

function TechnologyTreeMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getBody()

	if arg_7_1:getName() == TechnologyConst.UPDATE_REDPOINT_ON_TOP then
		self.viewComponent:updateRedPoint(getProxy(TechnologyNationProxy):getShowRedPointTag())
	end

	return
end

return TechnologyTreeMediator
