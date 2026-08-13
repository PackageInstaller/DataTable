class = var_0_10000

local var_0_0 = "NewBackYardShipInfoMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.EXTEND = "NewBackYardShipInfoMediator:EXTEND"
var_0_1.OPEN_CHUANWU = "NewBackYardShipInfoMediator:OPEN_CHUANWU"
var_0_1.UPDATE_SHIPS = "NewBackYardShipInfoMediator:UPDATE_SHIPS"
var_0_1.LOOG_PRESS_SHIP = "NewBackYardShipInfoMediator:LOOG_PRESS_SHIP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EXTEND, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SHOPPING, {
			count = 1,
			id = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.LOOG_PRESS_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0.contextData

		var_3_0.type = arg_3_1
		pg = var_3_0

		local var_3_1 = var_3_0.m02
		local var_3_2 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_3 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		var_3_2(var_3_1, var_3_3, var_2_10007.SHIPINFO, {
			shipId = arg_3_2.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0.contextData.type = arg_4_1

		local var_4_0 = arg_1_0

		var_3.OnSelShips(var_4_0, arg_4_1, arg_4_2)

		return
	end)

	return
end

function var_0_1.OnSelShips(arg_5_0, arg_5_1, arg_5_2)
	getProxy = var_1_10003
	DormProxy = var_1_10005

	local var_5_0 = var_1_10003(var_1_10005)
	local var_5_1 = var_3.getRawData(var_5_0)
	local var_5_2, var_5_3, var_5_4 = arg_5_0:GetSelectedShips(var_5_1, arg_5_1, arg_5_2)
	local var_5_5 = {
		callbackQuit = true,
		selectedMax = arg_5_0:GetMaxSel(var_5_1, arg_5_1),
		quitTeam = arg_5_2 ~= nil
	}

	pg = var_8

	local var_5_6 = var_8.ShipFlagMgr.GetInstance()

	var_5_5.ignoredIds = var_8.FilterShips(var_5_6, {
		isActivityNpc = true
	})
	var_5_5.selectedIds = var_5_4
	var_5_5.preView = arg_5_0.viewComponent.__cname
	ShipStatus = var_8
	var_5_5.hideTagFlags = var_8.TAG_HIDE_BACKYARD
	ShipStatus = var_8
	var_5_5.blockTagFlags = var_8.TAG_BLOCK_BACKYARD

	function var_5_5.onShip(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_5_0

		return var_3.OnShip(var_6_0, var_5_3, arg_6_0, arg_6_1, arg_6_2)
	end

	function var_5_5.onSelected(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.OnSelected(var_7_0, arg_5_1, arg_5_2, arg_7_0, function()
			local var_8_0 = arg_5_0

			var_0.sendNotification(var_8_0, var_0_1.UPDATE_SHIPS)
			arg_7_1()

			return
		end)

		return
	end

	var_5_5.priorEquipUpShipIDList = {}
	pairs = var_8

	for iter_5_0, iter_5_1 in var_8(var_5_2) do
		table = var_1_10013

		var_1_10013.insert(var_5_5.priorEquipUpShipIDList, iter_5_1)
	end

	pairs = var_8

	for iter_5_2, iter_5_3 in var_8(var_5_3) do
		table = var_1_10013

		var_1_10013.insert(var_5_5.priorEquipUpShipIDList, iter_5_3)
	end

	i18n = var_8
	var_5_5.leftTopWithFrameInfo = var_8("backyard_longpress_ship_tip")
	var_5_5.isLayer = true
	var_5_5.energyDisplay = true

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.addSubLayers

	Context = iter_5_2

	local var_5_9 = iter_5_2.New
	local var_5_10 = {}

	DockyardScene = var_1_10014
	var_5_10.viewComponent = var_1_10014
	DockyardMediator = var_1_10014
	var_5_10.mediator = var_1_10014
	var_5_10.data = var_5_5

	var_5_8(var_5_7, var_5_9(var_5_10))

	return
end

function var_0_1.GetMaxSel(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	DormShip = var_1_10004

	if arg_9_2 == var_1_10004.FLOOR_1 then
		var_9_0 = arg_9_1.exp_pos
	else
		DormShip = var_4

		if arg_9_2 == var_4.FLOOR_2 then
			var_9_0 = arg_9_1.rest_pos
		end
	end

	return var_9_0
end

function var_0_1.GetSelectedShips(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0

	if not arg_10_3 or not arg_10_3.id then
		var_10_0 = -1
	end

	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = {}

	ipairs = var_1_10008

	for iter_10_0, iter_10_1 in var_1_10008(arg_10_1:GetShips()) do
		getProxy = var_1_10013
		BayProxy = var_1_10015
		var_1_10015 = var_1_10013(var_1_10015)
		var_1_10013 = var_1_10013.RawGetShipById(var_1_10015, iter_10_1.id)

		if iter_10_1:IsSameFloor(arg_10_2) then
			table = var_14

			var_14.insert(var_10_1, var_1_10013.id)

			if var_1_10013.id ~= var_10_0 then
				table = var_14

				var_14.insert(var_10_3, var_1_10013.id)
			end
		else
			table = var_14

			var_14.insert(var_10_2, var_1_10013.id)
		end
	end

	return var_10_1, var_10_2, var_10_3
end

function var_0_1.OnShip(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = #arg_11_4
	local var_11_1

	if arg_11_0.contextData.MaxRsetPos < var_11_0 then
		var_11_0 = false
		i18n = var_11_1
		var_11_1 = var_11_1("backyard_no_pos_for_ship")

		return
	end

	table = var_11_0

	local var_11_2

	if var_11_0.contains(arg_11_1, arg_11_2.id) then
		var_11_2 = false
		i18n = var_11_1

		local var_11_3 = var_11_1("backyard_backyardShipInfoMediator_shipState_rest")

		return
	end

	ShipStatus = var_11_2

	local var_11_4, var_11_5 = var_11_2.ShipStatusCheck("inBackyard", arg_11_2, function(arg_12_0)
		arg_11_3()

		return
	end)

	return var_11_4, var_11_5
end

function var_0_1.OnSelected(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	getProxy = var_1_10005
	DormProxy = var_1_10007

	local var_13_0 = var_1_10005(var_1_10007)
	local var_13_1 = var_5.getRawData(var_13_0)
	local var_13_2 = var_5.GetDicBayShipOnFloor(var_13_1, arg_13_1)

	pg = var_1_10006

	local var_13_3 = var_1_10006.UIMgr.GetInstance()

	var_6.LoadingOn(var_13_3)

	if arg_13_3 == nil or #arg_13_3 == 0 then
		local var_13_5

		if arg_13_2 then
			local var_13_4 = arg_13_0

			var_13_5 = arg_13_0.sendNotification
			GAME = var_1_10009

			var_13_5(var_13_4, var_1_10009.EXIT_SHIP, {
				shipId = arg_13_2.id,
				callback = arg_13_4
			})
		else
			arg_13_4()
		end

		pg = var_13_5

		local var_13_6 = var_13_5.UIMgr.GetInstance()

		var_6.LoadingOff(var_13_6)

		return
	end

	local var_13_7 = {}

	pairs = var_13_1

	for iter_13_0, iter_13_1 in var_13_1(var_13_2) do
		table = var_1_10012

		if not var_1_10012.contains(arg_13_3, iter_13_0) then
			table = var_1_10012

			var_1_10012.insert(var_13_7, function(arg_14_0)
				local var_14_0 = arg_13_0
				local var_14_1 = var_1.sendNotification

				GAME = var_2_10004

				var_14_1(var_14_0, var_2_10004.EXIT_SHIP, {
					shipId = iter_13_0,
					callback = arg_14_0
				})

				return
			end)
		end
	end

	local var_13_8 = arg_13_0.contextData

	var_13_8.shipIdToAdd = {}
	ipairs = var_13_8

	for iter_13_2, iter_13_3 in var_13_8(arg_13_3) do
		if not var_13_2[iter_13_3] then
			var_1_10012 = arg_13_1
			table = var_1_10013

			var_1_10013.insert(arg_13_0.contextData.shipIdToAdd, {
				iter_13_3,
				var_1_10012
			})
		end
	end

	if arg_13_0.contextData.shipIdToAdd and #arg_13_0.contextData.shipIdToAdd > 0 then
		ipairs = var_7

		for iter_13_4, iter_13_5 in var_7(arg_13_0.contextData.shipIdToAdd) do
			table = var_1_10012

			var_1_10012.insert(var_13_7, function(arg_15_0)
				local var_15_0 = arg_13_0
				local var_15_1 = var_1.sendNotification

				GAME = var_2_10004

				var_15_1(var_15_0, var_2_10004.ADD_SHIP, {
					id = iter_13_5[1],
					type = iter_13_5[2],
					callBack = arg_15_0
				})

				return
			end)
		end
	end

	if #var_13_7 > 0 then
		seriesAsync = var_7

		var_7(var_13_7, function()
			local var_16_0 = arg_13_0.contextData

			var_16_0.shipIdToAdd = nil
			pg = var_16_0

			local var_16_1 = var_16_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_16_1)
			arg_13_4()

			return
		end)
	else
		pg = var_7

		local var_13_9 = var_7.UIMgr.GetInstance()

		var_7.LoadingOff(var_13_9)
		arg_13_4()
	end

	return
end

function var_0_1.listNotificationInterests(arg_17_0)
	local var_17_0 = {}

	GAME = var_1_10002
	var_17_0[1] = var_1_10002.EXTEND_BACKYARD_DONE
	var_17_0[2] = var_0_1.UPDATE_SHIPS

	return var_17_0
end

function var_0_1.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1
	local var_18_1 = arg_18_1.getName(var_18_0)
	local var_18_2 = arg_18_1:getBody()

	GAME = var_18_0

	if var_18_1 == var_18_0.EXTEND_BACKYARD_DONE then
		pg = var_4

		local var_18_3 = var_4.TipsMgr.GetInstance()
		local var_18_4 = var_4.ShowTips

		i18n = var_1_10007

		var_18_4(var_18_3, var_1_10007("backyard_backyardShipInfoMediator_ok_unlock"))

		local var_18_5 = arg_18_0.viewComponent

		var_4.UpdateSlots(var_18_5)
	elseif var_18_1 == var_0_1.UPDATE_SHIPS then
		local var_18_6 = arg_18_0.viewComponent

		var_4.UpdateSlots(var_18_6)
	end

	return
end

return var_0_1
