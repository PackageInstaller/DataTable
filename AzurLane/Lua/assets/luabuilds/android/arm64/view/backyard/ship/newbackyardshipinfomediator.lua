local var_0_0 = class("NewBackYardShipInfoMediator", import("...base.ContextMediator"))

var_0_0.EXTEND = "NewBackYardShipInfoMediator:EXTEND"
var_0_0.OPEN_CHUANWU = "NewBackYardShipInfoMediator:OPEN_CHUANWU"
var_0_0.UPDATE_SHIPS = "NewBackYardShipInfoMediator:UPDATE_SHIPS"
var_0_0.LOOG_PRESS_SHIP = "NewBackYardShipInfoMediator:LOOG_PRESS_SHIP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EXTEND, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			count = 1,
			id = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.LOOG_PRESS_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0.contextData.type = arg_3_1

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_3_2.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0.contextData.type = arg_4_1

		arg_1_0:OnSelShips(arg_4_1, arg_4_2)

		return
	end)

	return
end

function var_0_0.OnSelShips(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = getProxy(DormProxy):getRawData()
	local var_5_1, var_5_2, var_5_3 = arg_5_0:GetSelectedShips(var_5_0, arg_5_1, arg_5_2)
	local var_5_4 = {
		callbackQuit = true,
		selectedMax = arg_5_0:GetMaxSel(var_5_0, arg_5_1),
		quitTeam = arg_5_2 ~= nil
	}

	var_5_4.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
		isActivityNpc = true
	})
	var_5_4.selectedIds = var_5_3
	var_5_4.preView = arg_5_0.viewComponent.__cname
	var_5_4.hideTagFlags = ShipStatus.TAG_HIDE_BACKYARD
	var_5_4.blockTagFlags = ShipStatus.TAG_BLOCK_BACKYARD

	function var_5_4.onShip(arg_6_0, arg_6_1, arg_6_2)
		return arg_5_0:OnShip(var_5_2, arg_6_0, arg_6_1, arg_6_2)
	end

	function var_5_4.onSelected(arg_7_0, arg_7_1)
		arg_5_0:OnSelected(arg_5_1, arg_5_2, arg_7_0, function()
			arg_5_0:sendNotification(var_0_0.UPDATE_SHIPS)
			arg_7_1()

			return
		end)

		return
	end

	var_5_4.priorEquipUpShipIDList = {}

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		table.insert(var_5_4.priorEquipUpShipIDList, iter_5_1)
	end

	for iter_5_2, iter_5_3 in pairs(var_5_2) do
		table.insert(var_5_4.priorEquipUpShipIDList, iter_5_3)
	end

	var_5_4.leftTopWithFrameInfo = i18n("backyard_longpress_ship_tip")
	var_5_4.isLayer = true
	var_5_4.energyDisplay = true

	arg_5_0:addSubLayers(Context.New({
		viewComponent = DockyardScene,
		mediator = DockyardMediator,
		data = var_5_4
	}))

	return
end

function var_0_0.GetMaxSel(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	if arg_9_2 == DormShip.FLOOR_1 then
		var_9_0 = arg_9_1.exp_pos
	elseif arg_9_2 == DormShip.FLOOR_2 then
		var_9_0 = arg_9_1.rest_pos
	end

	return var_9_0
end

function var_0_0.GetSelectedShips(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3 then
		local var_10_0 = arg_10_3.id or -1
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_1:GetShips()) do
			local var_10_2 = getProxy(BayProxy):RawGetShipById(iter_10_1.id)

			if iter_10_1:IsSameFloor(arg_10_2) then
				table.insert(var_10_1, var_10_2.id)

				if var_10_2.id ~= var_10_0 then
					table.insert({}, var_10_2.id)
				end
			else
				table.insert({}, var_10_2.id)
			end
		end

		return var_10_1, {}, {}
	end
end

function var_0_0.OnShip(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if #arg_11_4 > arg_11_0.contextData.MaxRsetPos then
		local var_11_1 = i18n("backyard_no_pos_for_ship")

		return
	end

	if table.contains(arg_11_1, arg_11_2.id) then
		local var_11_3 = i18n("backyard_backyardShipInfoMediator_shipState_rest")

		return
	end

	local var_11_4, var_11_5 = ShipStatus.ShipStatusCheck("inBackyard", arg_11_2, function(arg_12_0)
		arg_11_3()

		return
	end)

	return var_11_4, var_11_5
end

function var_0_0.OnSelected(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = getProxy(DormProxy):getRawData():GetDicBayShipOnFloor(arg_13_1)

	pg.UIMgr.GetInstance():LoadingOn()

	if arg_13_3 == nil or #arg_13_3 == 0 then
		if arg_13_2 then
			arg_13_0:sendNotification(GAME.EXIT_SHIP, {
				shipId = arg_13_2.id,
				callback = arg_13_4
			})
		else
			arg_13_4()
		end

		pg.UIMgr.GetInstance():LoadingOff()

		return
	end

	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if not table.contains(arg_13_3, iter_13_0) then
			table.insert(var_13_1, function(arg_14_0)
				arg_13_0:sendNotification(GAME.EXIT_SHIP, {
					shipId = iter_13_0,
					callback = arg_14_0
				})

				return
			end)
		end
	end

	arg_13_0.contextData.shipIdToAdd = {}

	for iter_13_2, iter_13_3 in ipairs(arg_13_3) do
		if not var_13_0[iter_13_3] then
			table.insert(arg_13_0.contextData.shipIdToAdd, {
				iter_13_3,
				arg_13_1
			})
		end
	end

	if arg_13_0.contextData.shipIdToAdd and #arg_13_0.contextData.shipIdToAdd > 0 then
		for iter_13_4, iter_13_5 in ipairs(arg_13_0.contextData.shipIdToAdd) do
			table.insert(var_13_1, function(arg_15_0)
				arg_13_0:sendNotification(GAME.ADD_SHIP, {
					id = iter_13_5[1],
					type = iter_13_5[2],
					callBack = arg_15_0
				})

				return
			end)
		end
	end

	if #var_13_1 > 0 then
		seriesAsync(var_13_1, function()
			arg_13_0.contextData.shipIdToAdd = nil

			pg.UIMgr.GetInstance():LoadingOff()
			arg_13_4()

			return
		end)
	else
		pg.UIMgr.GetInstance():LoadingOff()
		arg_13_4()
	end

	return
end

function var_0_0.listNotificationInterests(arg_17_0)
	return {
		GAME.EXTEND_BACKYARD_DONE,
		var_0_0.UPDATE_SHIPS
	}
end

function var_0_0.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	if var_18_0 == GAME.EXTEND_BACKYARD_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardShipInfoMediator_ok_unlock"))
		arg_18_0.viewComponent:UpdateSlots()
	elseif var_18_0 == var_0_0.UPDATE_SHIPS then
		arg_18_0.viewComponent:UpdateSlots()
	end

	return
end

return var_0_0
