class = var_0_10000

local var_0_0 = "WorldDetailMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OnShipInfo = "WorldDetailMediator:OnShipInfo"
var_0_1.OnCmdSkill = "WorldDetailMediator.OnCmdSkill"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnShipInfo, function(arg_2_0, arg_2_1, arg_2_2)
		WorldConst = var_2_10003

		local var_2_0 = var_2_10003.FetchWorldShip(arg_2_1)

		arg_1_0.contextData.fleetId = var_2_0.fleetId

		local var_2_1 = arg_1_0.contextData

		var_2_1.toggle = arg_2_2
		nowWorld = var_2_1

		local var_2_2 = var_2_1()
		local var_2_3 = var_4.GetFleet(var_2_2, var_2_0.fleetId)
		local var_2_4 = var_4.GetShipVOs(var_2_3, true)
		local var_2_5 = arg_1_0
		local var_2_6 = var_6.sendNotification

		GAME = var_2_10008

		local var_2_7 = var_2_10008.GO_SCENE

		SCENE = var_2_10009

		var_2_6(var_2_5, var_2_7, var_2_10009.SHIPINFO, {
			shipId = var_2_0.id,
			shipVOs = var_2_4
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnCmdSkill, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_3_2 = var_2_10004.New
		local var_3_3 = {}

		CommanderSkillMediator = var_2_10006
		var_3_3.mediator = var_2_10006
		CommanderSkillLayer = var_2_10006
		var_3_3.viewComponent = var_2_10006
		var_3_3.data = {
			isWorld = true,
			skill = arg_3_1
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.setPlayerInfo

	getProxy = var_3
	PlayerProxy = var_4

	local var_1_2 = var_3(var_4)

	var_1_1(var_1_0, var_3.getRawData(var_1_2))

	local var_1_3 = arg_1_0.viewComponent
	local var_1_4 = var_1.setFleets

	nowWorld = var_3

	local var_1_5 = var_3()

	var_1_4(var_1_3, var_3.GetFleets(var_1_5))

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	PlayerProxy = var_1_10002
	var_4_0[1] = var_1_10002.UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	PlayerProxy = var_5_1

	if var_5_0 == var_5_1.UPDATED then
		local var_5_3 = arg_5_0.viewComponent
		local var_5_4 = var_4.setPlayerInfo

		getProxy = var_1_10006
		PlayerProxy = var_1_10007

		local var_5_5 = var_1_10006(var_1_10007)

		var_5_4(var_5_3, var_6.getRawData(var_5_5))
	end

	return
end

return var_0_1
