class = var_0_10000

local var_0_0 = "WorldPortMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.OnOpenBay = "WorldPortMediator.OnOpenBay"
var_0_1.OnTaskGoto = "WorldPortMediator.OnTaskGoto"
var_0_1.OnAccepetTask = "WorldPortMediator.OnAccepetTask"
var_0_1.OnSubmitTask = "WorldPortMediator.OnSubmitTask"
var_0_1.OnReqPort = "WorldPortMediator.OnReqPort"
var_0_1.OnBuyGoods = "WorldPortMediator.OnBuyGoods"
var_0_1.OnBuyNShopGoods = "WorldPortMediator.OnBuyNShopGoods"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnOpenBay, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_2_3 = var_2_10004.DOCKYARD
		local var_2_4 = {
			selectedMax = 1,
			selectedMin = 0
		}

		DockyardScene = var_2_10006
		var_2_4.mode = var_2_10006.MODE_WORLD
		ShipStatus = var_6
		var_2_4.hideTagFlags = var_6.TAG_HIDE_WORLD

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end)
	arg_1_0:bind(var_0_1.OnTaskGoto, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0.viewComponent

		var_2.closeView(var_3_0)

		local var_3_1 = arg_1_0
		local var_3_2 = var_2.sendNotification

		WorldMediator = var_2_10005

		var_3_2(var_3_1, var_2_10005.OnTriggerTaskGo, {
			taskId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnAccepetTask, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.WORLD_TRIGGER_TASK, {
			taskId = arg_4_1.id,
			portId = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnSubmitTask, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.WORLD_SUMBMIT_TASK, {
			taskId = arg_5_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnReqPort, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.WORLD_PORT_REQ, {
			mapId = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnBuyGoods, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.WORLD_PORT_SHOPPING, {
			goods = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnBuyNShopGoods, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_1_0
		local var_8_1 = var_3.sendNotification

		GAME = var_2_10006

		var_8_1(var_8_0, var_2_10006.WORLD_PORT_NEW_SHOPPING, {
			goods = arg_8_1,
			count = arg_8_2
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.SetPlayer

	getProxy = var_4
	PlayerProxy = var_1_10006

	local var_1_2 = var_4(var_1_10006)

	var_1_1(var_1_0, var_4.getRawData(var_1_2))

	nowWorld = var_1_1

	local var_1_3 = var_1_1()
	local var_1_4 = arg_1_0.viewComponent

	var_2.SetAtlas(var_1_4, var_1_3:GetAtlas())

	local var_1_5 = arg_1_0.viewComponent
	local var_1_6 = var_2.SetPort
	local var_1_7 = var_1_3:GetActiveMap()

	var_1_6(var_1_5, var_5.GetPort(var_1_7))
	arg_1_0:CheckTaskNotify(var_1_3:GetTaskProxy())

	return
end

function var_0_1.initNotificationHandleDic(arg_9_0)
	local var_9_0 = {}

	PlayerProxy = var_1_10002
	var_9_0[var_1_10002.UPDATED] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.viewComponent
		local var_10_1 = var_2.SetPlayer

		getProxy = var_2_10005
		PlayerProxy = var_2_10007

		local var_10_2 = var_2_10005(var_2_10007)

		var_10_1(var_10_0, var_5.getRawData(var_10_2))

		return
	end
	GAME = var_2
	var_9_0[var_2.WORLD_PORT_SHOPPING_DONE] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_1:getBody()
		local var_11_1 = arg_11_0.viewComponent
		local var_11_2 = var_3.emit

		BaseUI = var_2_10006

		var_11_2(var_11_1, var_2_10006.ON_ACHIEVE, var_11_0.drops)

		local var_11_3 = arg_11_0.viewComponent

		var_3.UpdateCDTip(var_11_3)

		return
	end
	GAME = var_2
	var_9_0[var_2.WORLD_PORT_NEW_SHOPPING_DONE] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_1:getBody()
		local var_12_1 = arg_12_0.viewComponent
		local var_12_2 = var_3.emit

		BaseUI = var_2_10006

		var_12_2(var_12_1, var_2_10006.ON_ACHIEVE, var_12_0.drops)

		return
	end
	arg_9_0.handleDic = var_9_0

	return
end

function var_0_1.CheckTaskNotify(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getTasks()

	pairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(var_13_0) do
		local var_13_1 = iter_13_1:getState()

		WorldTask = var_1_10009

		if var_13_1 == var_1_10009.STATE_ONGOING then
			local var_13_2 = iter_13_1.config.complete_condition

			WorldConst = var_1_10009

			if var_13_2 == var_1_10009.TaskTypeArrivePort then
				WBank = var_13_2

				local var_13_3 = var_13_2
				local var_13_4 = var_13_2.Fetch

				WorldMapOp = var_1_10011

				local var_13_5 = var_13_4(var_13_3, var_1_10011)

				WorldConst = var_1_10009
				var_13_5.op = var_1_10009.OpReqTask
				var_1_10011 = arg_13_0
				var_1_10009 = arg_13_0.sendNotification
				GAME = var_1_10012

				var_1_10009(var_1_10011, var_1_10012.WORLD_MAP_OP, var_13_5)
			end
		end
	end

	return
end

return var_0_1
