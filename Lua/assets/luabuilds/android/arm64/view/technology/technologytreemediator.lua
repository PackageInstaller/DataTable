local var_0_0 = class("TechnologyTreeMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(TechnologyConst.OPEN_SHIP_BUFF_DETAIL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:addSubLayers(Context.New({
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
	arg_1_0:bind(TechnologyConst.CLOSE_TECHNOLOGY_NATION_LAYER, function(arg_3_0)
		arg_1_0:sendNotification(TechnologyConst.CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION)

		return
	end)
	arg_1_0:bind(TechnologyConst.OPEN_TECHNOLOGY_NATION_LAYER, function(arg_4_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = TechnologyTreeNationMediator,
			viewComponent = TechnologyTreeNationScene,
			data = {}
		}))

		return
	end)
	arg_1_0:bind(TechnologyConst.OPEN_ALL_BUFF_DETAIL, function(arg_5_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = AllBuffDetailMediator,
			viewComponent = AllBuffDetailLayer,
			data = {}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		TechnologyConst.UPDATE_REDPOINT_ON_TOP
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getBody()

	if arg_7_1:getName() == TechnologyConst.UPDATE_REDPOINT_ON_TOP then
		arg_7_0.viewComponent:updateRedPoint(getProxy(TechnologyNationProxy):getShowRedPointTag())
	end

	return
end

return var_0_0
