class = var_0_10000

local var_0_0 = "DOAYearHotSpringMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.UNLOCK_SLOT = "UNLOCK_SLOT"
var_0_1.OPEN_INFO = "OPEN_INFO"
var_0_1.OPEN_CHUANWU = "DOAYearHotSpringMediator:Open chuanwu"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.UNLOCK_SLOT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0.activity
		local var_2_1, var_2_2 = var_2.GetUpgradeCost(var_2_0)

		MsgboxMediator = var_2_10004

		local var_2_3 = var_2_10004.ShowMsgBox
		local var_2_4 = {}

		MSGBOX_TYPE_NORMAL = var_2_10006
		var_2_4.type = var_2_10006
		i18n = var_2_10006
		var_2_4.content = var_2_10006("hotspring_expand", var_2_2)
		var_2_4.contextSprites = {
			{
				path = "props/wenquanshoupai",
				name = "wenquanshoupai"
			}
		}

		function var_2_4.onYes()
			local var_3_0 = arg_1_0.activity

			if var_0.GetCoins(var_3_0) < var_2_2 then
				pg = var_1

				local var_3_1 = var_1.TipsMgr.GetInstance()
				local var_3_2 = var_1.ShowTips

				i18n = var_3_10003

				var_3_2(var_3_1, var_3_10003("hotspring_tip2"))

				return
			end

			local var_3_3 = arg_1_0
			local var_3_4 = var_1.sendNotification

			GAME = var_3_10003

			local var_3_5 = var_3_10003.ACTIVITY_OPERATION
			local var_3_6 = {
				activity_id = arg_2_1
			}

			SpringActivity = var_5
			var_3_6.cmd = var_5.OPERATION_UNLOCK

			var_3_4(var_3_3, var_3_5, var_3_6)

			return
		end

		var_2_3(var_2_4)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0

		var_3.OnSelShips(var_4_0, arg_4_1, arg_4_2)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_3
	arg_1_0.activity = var_1_2(var_1_1, var_3.ACTIVITY_TYPE_HOTSPRING)

	local var_1_3 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_3, var_1)
	arg_1_0:bind(var_0_1.OPEN_INFO, function()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.addSubLayers

		Context = var_2_10002

		local var_5_2 = var_2_10002.New
		local var_5_3 = {}

		DOAYearHotSpringShipSelectMediator = var_2_10004
		var_5_3.mediator = var_2_10004
		DOAYearHotSpringShipSelectLayer = var_2_10004
		var_5_3.viewComponent = var_2_10004
		var_5_3.data = {
			actId = var_0.id
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	return
end

function var_0_1.GetGetSlotCount(arg_6_0)
	local var_6_0 = arg_6_0.activity

	return var_1.GetSlotCount(var_6_0)
end

function var_0_1.OnSelShips(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetSelectedShipIds(arg_7_2)
	local var_7_1 = {
		callbackQuit = true,
		selectedMax = arg_7_0:GetGetSlotCount(),
		quitTeam = arg_7_2 ~= nil
	}

	pg = var_5

	local var_7_2 = var_5.ShipFlagMgr.GetInstance()

	var_7_1.ignoredIds = var_5.FilterShips(var_7_2, {
		isActivityNpc = true
	})
	Clone = var_5
	var_7_1.selectedIds = var_5(var_7_0)
	var_7_1.preView = arg_7_0.viewComponent.__cname
	ShipStatus = var_5
	var_7_1.hideTagFlags = var_5.TAG_HIDE_BACKYARD
	ShipStatus = var_5
	var_7_1.blockTagFlags = var_5.TAG_BLOCK_BACKYARD

	function var_7_1.onShip(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_7_0

		return var_3.OnShip(var_8_0, arg_8_0, arg_8_1, arg_8_2)
	end

	function var_7_1.onSelected(arg_9_0, arg_9_1)
		local var_9_0 = arg_7_0

		var_2.OnSelected(var_9_0, arg_7_1, arg_9_0, arg_9_1)

		return
	end

	_ = var_5

	local var_7_3 = var_5.filter
	local var_7_4 = arg_7_0.activity

	var_7_1.priorEquipUpShipIDList = var_7_3(var_6.GetShipIds(var_7_4), function(arg_10_0)
		return arg_10_0 > 0
	end)
	i18n = var_5
	var_7_1.leftTopWithFrameInfo = var_5("backyard_longpress_ship_tip")
	var_7_1.isLayer = true
	var_7_1.energyDisplay = true

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.addSubLayers

	Context = var_7

	local var_7_7 = var_7.New
	local var_7_8 = {}

	DockyardScene = var_1_10009
	var_7_8.viewComponent = var_1_10009
	DockyardMediator = var_1_10009
	var_7_8.mediator = var_1_10009
	var_7_8.data = var_7_1

	var_7_6(var_7_5, var_7_7(var_7_8))

	return
end

function var_0_1.GetSelectedShipIds(arg_11_0, arg_11_1)
	local var_11_0

	if not arg_11_1 or not arg_11_1.id then
		var_11_0 = -1
	end

	local var_11_1 = {}

	ipairs = var_1_10004

	local var_11_2 = arg_11_0.activity

	for iter_11_0, iter_11_1 in var_1_10004(var_5.GetShipIds(var_11_2)) do
		local var_11_3

		if 0 < iter_11_1 then
			getProxy = var_9
			BayProxy = var_1_10010
			var_1_10010 = var_9(var_1_10010)
			var_11_3 = var_9.RawGetShipById(var_1_10010, iter_11_1)
		else
			var_11_3 = false
		end

		if false then
			var_11_3 = true
		end

		if var_11_3 and var_11_3.id ~= var_11_0 then
			table = var_1_10010

			var_1_10010.insert(var_11_1, var_11_3.id)
		end
	end

	return var_11_1
end

function var_0_1.OnShip(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	ShipStatus = var_1_10004

	local var_12_0, var_12_1 = var_1_10004.ShipStatusCheck("inBackyard", arg_12_1, function(arg_13_0)
		arg_12_2()

		return
	end)

	return var_12_0, var_12_1
end

function var_0_1.OnSelected(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	Clone = var_1_10004

	local var_14_0 = arg_14_0.activity
	local var_14_1 = var_1_10004(var_5.GetShipIds(var_14_0))

	_ = var_5

	local var_14_2 = var_5.each

	_ = var_14_0

	local var_14_3 = var_14_0.range
	local var_14_4 = arg_14_0.activity

	var_14_2(var_14_3(var_7.GetSlotCount(var_14_4)), function(arg_15_0)
		local var_15_0 = var_14_1
		local var_15_1

		if not var_14_1[arg_15_0] then
			var_15_1 = 0
		end

		var_15_0[arg_15_0] = var_15_1

		return
	end)

	if arg_14_2 == nil or #arg_14_2 == 0 then
		var_14_2 = var_14_1[arg_14_1]

		local var_14_6

		if 0 < var_14_2 then
			local var_14_5 = arg_14_0

			var_14_6 = arg_14_0.sendNotification
			GAME = var_14_4

			local var_14_7 = var_14_4.ACTIVITY_OPERATION
			local var_14_8 = {
				activity_id = arg_14_0.activity.id
			}

			SpringActivity = var_10
			var_14_8.cmd = var_10.OPERATION_SETSHIP
			var_14_8.kvargs1 = {
				{
					value = 0,
					key = arg_14_1
				}
			}

			var_14_6(var_14_5, var_14_7, var_14_8)
		end

		existCall = var_14_6

		var_14_6(arg_14_3)

		return
	end

	_ = var_14_2

	local var_14_9 = var_14_2.filter(arg_14_2, function(arg_16_0)
		table = var_2_10001

		return not var_2_10001.contains(var_14_1, arg_16_0)
	end)

	table = var_6

	var_6.Foreach(var_14_1, function(arg_17_0, arg_17_1)
		if arg_17_1 ~= 0 then
			table = var_2_10002

			if var_2_10002.contains(arg_14_2, arg_17_1) then
				return
			end

			var_14_1[arg_17_0] = 0

			return
		end
	end)

	if #var_14_9 == 1 and var_14_1[arg_14_1] == 0 then
		var_14_1[arg_14_1] = var_14_9[1]
	else
		local var_14_10 = 0

		_ = var_7

		var_7.each(var_14_9, function(arg_18_0)
			while var_14_10 <= #var_14_1 do
				var_14_10 = var_14_10 + 1

				if var_14_1[var_14_10] == 0 then
					break
				end
			end

			var_14_1[var_14_10] = arg_18_0

			return
		end)
	end

	local var_14_11 = {}
	local var_14_12 = arg_14_0.activity
	local var_14_13 = var_7.GetShipIds(var_14_12)

	table = var_14_12

	var_14_12.Foreach(var_14_1, function(arg_19_0, arg_19_1)
		local var_19_0

		if not var_14_13[arg_19_0] then
			var_19_0 = 0
		end

		if var_19_0 ~= arg_19_1 then
			table = var_2_10003

			var_2_10003.insert(var_14_11, {
				key = arg_19_0,
				value = arg_19_1
			})
		end

		return
	end)

	if #var_14_11 > 0 then
		local var_14_14 = arg_14_0
		local var_14_15 = arg_14_0.sendNotification

		GAME = var_10

		local var_14_16 = var_10.ACTIVITY_OPERATION
		local var_14_17 = {
			activity_id = arg_14_0.activity.id
		}

		SpringActivity = var_12
		var_14_17.cmd = var_12.OPERATION_SETSHIP
		var_14_17.kvargs1 = var_14_11

		var_14_15(var_14_14, var_14_16, var_14_17)
	end

	arg_14_3()

	return
end

function var_0_1.listNotificationInterests(arg_20_0)
	local var_20_0 = {}

	PlayerProxy = var_1_10002
	var_20_0[1] = var_1_10002.UPDATED
	ActivityProxy = var_2
	var_20_0[2] = var_2.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_20_0[3] = var_2.ACTIVITY_SHOW_AWARDS
	var_20_0[4] = var_0_1.OPEN_CHUANWU
	var_20_0[5] = var_0_1.UNLOCK_SLOT

	return var_20_0
end

function var_0_1.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1
	local var_21_2 = arg_21_1.getBody(var_21_1)

	if var_21_0 == nil then
		-- block empty
	else
		ActivityProxy = var_21_1

		local var_21_4

		if var_21_0 == var_21_1.ACTIVITY_SHOW_AWARDS then
			local var_21_3 = arg_21_0.viewComponent

			var_21_4 = var_21_4.emit
			BaseUI = var_1_10006

			var_21_4(var_21_3, var_1_10006.ON_ACHIEVE, var_21_2.awards, var_21_2.callback)
		else
			ActivityProxy = var_21_4

			if var_21_0 == var_21_4.ACTIVITY_UPDATED then
				local var_21_5 = var_21_2
				local var_21_6 = var_21_2.getConfig(var_21_5, "type")

				ActivityConst = var_21_5

				if var_21_6 == var_21_5.ACTIVITY_TYPE_HOTSPRING then
					arg_21_0.activity = var_21_2

					local var_21_7 = arg_21_0.viewComponent

					var_4.SetActivity(var_21_7, var_21_2)

					local var_21_8 = arg_21_0.viewComponent

					var_4.UpdateView(var_21_8)
				end
			elseif var_21_0 == var_0_1.OPEN_CHUANWU then
				local var_21_9 = arg_21_0.viewComponent
				local var_21_10 = var_4.emit
				local var_21_11 = var_0_1.OPEN_CHUANWU

				unpack = var_1_10007

				var_21_10(var_21_9, var_21_11, var_1_10007(var_21_2))
			elseif var_21_0 == var_0_1.UNLOCK_SLOT then
				local var_21_12 = arg_21_0.viewComponent

				var_4.emit(var_21_12, var_0_1.UNLOCK_SLOT, var_21_2)
			end
		end
	end

	return
end

function var_0_1.remove(arg_22_0)
	return
end

return var_0_1
