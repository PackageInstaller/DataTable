class = var_0_10000

local var_0_0 = "TechnologyTreeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	TechnologyConst = var_1_10004

	var_1_1(var_1_0, var_1_10004.OPEN_SHIP_BUFF_DETAIL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.addSubLayers

		Context = var_2_10007

		local var_2_2 = var_2_10007.New
		local var_2_3 = {}

		SingleBuffDetailMediator = var_2_10010
		var_2_3.mediator = var_2_10010
		SingleBuffDetailLayer = var_2_10010
		var_2_3.viewComponent = var_2_10010
		var_2_3.data = {
			groupID = arg_2_1,
			maxLV = arg_2_2,
			star = arg_2_3
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	TechnologyConst = var_4

	var_1_3(var_1_2, var_4.CLOSE_TECHNOLOGY_NATION_LAYER, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		TechnologyConst = var_2_10004

		var_3_1(var_3_0, var_2_10004.CLOSE_TECHNOLOGY_NATION_LAYER_NOTIFICATION)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	TechnologyConst = var_4

	var_1_5(var_1_4, var_4.OPEN_TECHNOLOGY_NATION_LAYER, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		TechnologyTreeNationMediator = var_2_10007
		var_4_3.mediator = var_2_10007
		TechnologyTreeNationScene = var_2_10007
		var_4_3.viewComponent = var_2_10007
		var_4_3.data = {}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	TechnologyConst = var_4

	var_1_7(var_1_6, var_4.OPEN_ALL_BUFF_DETAIL, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		AllBuffDetailMediator = var_2_10007
		var_5_3.mediator = var_2_10007
		AllBuffDetailLayer = var_2_10007
		var_5_3.viewComponent = var_2_10007
		var_5_3.data = {}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	TechnologyConst = var_1_10002
	var_6_0[1] = var_1_10002.UPDATE_REDPOINT_ON_TOP

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1:getBody()

	TechnologyConst = var_7_0

	if var_7_1 == var_7_0.UPDATE_REDPOINT_ON_TOP then
		local var_7_3 = arg_7_0.viewComponent
		local var_7_4 = var_4.updateRedPoint

		getProxy = var_1_10007
		TechnologyNationProxy = var_1_10009

		local var_7_5 = var_1_10007(var_1_10009)

		var_7_4(var_7_3, var_7.getShowRedPointTag(var_7_5))
	end

	return
end

return var_0_1
