class = var_0_10000

local var_0_0 = "TongXinSpringMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.UNLOCK_SLOT = "TongXinSpringMediator:UNLOCK_SLOT"
var_0_1.OPEN_CHUANWU = "TongXinSpringMediator:Open chuanwu"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.UNLOCK_SLOT, function(arg_2_0, arg_2_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10004

		local var_2_0 = var_2_10002(var_2_10004)
		local var_2_1 = var_2.getActivityByType

		ActivityConst = var_2_10005

		local var_2_2 = var_2_1(var_2_0, var_2_10005.ACTIVITY_TYPE_HOTSPRING)
		local var_2_3, var_2_4 = var_2.GetUpgradeCost(var_2_2)

		MsgboxMediator = var_2_2

		local var_2_5 = var_2_2.ShowMsgBox
		local var_2_6 = {}

		MSGBOX_TYPE_NORMAL = var_2_10008
		var_2_6.type = var_2_10008
		i18n = var_2_10008
		var_2_6.content = var_2_10008("202406_wenquan_unlock", var_2_4)
		var_2_6.contextSprites = {
			{
				path = "props/wenquanbi",
				name = "wenquanbi"
			}
		}

		function var_2_6.onYes()
			local var_3_0 = var_0

			if var_0.GetCoins(var_3_0) < var_2_4 then
				pg = var_1

				local var_3_1 = var_1.TipsMgr.GetInstance()
				local var_3_2 = var_1.ShowTips

				i18n = var_3_10004

				var_3_2(var_3_1, var_3_10004("202406_wenquan_unlock_tip2"))

				return
			end

			local var_3_3 = arg_1_0
			local var_3_4 = var_1.sendNotification

			GAME = var_3_10004

			local var_3_5 = var_3_10004.ACTIVITY_OPERATION
			local var_3_6 = {
				activity_id = arg_2_1
			}

			SpringActivity = var_6
			var_3_6.cmd = var_6.OPERATION_UNLOCK

			var_3_4(var_3_3, var_3_5, var_3_6)

			return
		end

		var_2_5(var_2_6)

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

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_HOTSPRING)
	local var_1_4 = arg_1_0.viewComponent

	var_2.InitActivity(var_1_4, var_1_3)

	return
end

function var_0_1.OnSelShips(arg_5_0, arg_5_1, arg_5_2)
	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_5_0 = var_1_10003(var_1_10005)
	local var_5_1 = var_3.getActivityByType

	ActivityConst = var_1_10006

	local var_5_2 = var_5_1(var_5_0, var_1_10006.ACTIVITY_TYPE_HOTSPRING)
	local var_5_3 = arg_5_0:GetSelectedShipIds(arg_5_2)
	local var_5_4 = {
		callbackQuit = true,
		selectedMax = var_5_2:GetSlotCount(),
		quitTeam = arg_5_2 ~= nil
	}

	pg = var_6

	local var_5_5 = var_6.ShipFlagMgr.GetInstance()

	var_5_4.ignoredIds = var_6.FilterShips(var_5_5, {
		isActivityNpc = true
	})
	Clone = var_6
	var_5_4.selectedIds = var_6(var_5_3)
	var_5_4.preView = arg_5_0.viewComponent.__cname
	ShipStatus = var_6
	var_5_4.hideTagFlags = var_6.TAG_HIDE_BACKYARD
	ShipStatus = var_6
	var_5_4.blockTagFlags = var_6.TAG_BLOCK_BACKYARD

	function var_5_4.onShip(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_5_0

		return var_3.OnShip(var_6_0, arg_6_0, arg_6_1, arg_6_2)
	end

	function var_5_4.onSelected(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.OnSelected(var_7_0, arg_5_1, arg_7_0, arg_7_1)

		return
	end

	_ = var_6
	var_5_4.priorEquipUpShipIDList = var_6.filter(var_5_2:GetShipIds(), function(arg_8_0)
		return arg_8_0 > 0
	end)
	i18n = var_6
	var_5_4.leftTopWithFrameInfo = var_6("backyard_longpress_ship_tip")
	var_5_4.isLayer = true
	var_5_4.energyDisplay = true

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.addSubLayers

	Context = var_9

	local var_5_8 = var_9.New
	local var_5_9 = {}

	DockyardScene = var_1_10012
	var_5_9.viewComponent = var_1_10012
	DockyardMediator = var_1_10012
	var_5_9.mediator = var_1_10012
	var_5_9.data = var_5_4

	var_5_7(var_5_6, var_5_8(var_5_9))

	return
end

function var_0_1.OnSelected(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	getProxy = var_1_10004
	ActivityProxy = var_1_10006

	local var_9_0 = var_1_10004(var_1_10006)
	local var_9_1 = var_4.getActivityByType

	ActivityConst = var_1_10007

	local var_9_2 = var_9_1(var_9_0, var_1_10007.ACTIVITY_TYPE_HOTSPRING)

	Clone = var_1_10005

	local var_9_3 = var_1_10005(var_9_2:GetShipIds())

	_ = var_9_0

	local var_9_4 = var_9_0.each

	_ = var_1_10008

	var_9_4(var_1_10008.range(var_9_2:GetSlotCount()), function(arg_10_0)
		local var_10_0 = var_9_3
		local var_10_1

		if not var_9_3[arg_10_0] then
			var_10_1 = 0
		end

		var_10_0[arg_10_0] = var_10_1

		return
	end)

	local var_9_6

	if arg_9_2 == nil or #arg_9_2 == 0 then
		var_9_4 = var_9_3[arg_9_1]

		if 0 < var_9_4 then
			local var_9_5 = arg_9_0

			var_9_6 = arg_9_0.sendNotification
			GAME = var_10

			local var_9_7 = var_10.ACTIVITY_OPERATION
			local var_9_8 = {
				activity_id = var_9_2.id
			}

			SpringActivity = var_12
			var_9_8.cmd = var_12.OPERATION_SETSHIP
			var_9_8.kvargs1 = {
				{
					value = 0,
					key = arg_9_1
				}
			}

			var_9_6(var_9_5, var_9_7, var_9_8)
		end

		existCall = var_9_6

		var_9_6(arg_9_3)

		return
	end

	_ = var_9_4

	local var_9_9 = var_9_4.filter(arg_9_2, function(arg_11_0)
		table = var_2_10001

		return not var_2_10001.contains(var_9_3, arg_11_0)
	end)

	table = var_9_6

	var_9_6.Foreach(var_9_3, function(arg_12_0, arg_12_1)
		if arg_12_1 ~= 0 then
			table = var_2_10002

			if var_2_10002.contains(arg_9_2, arg_12_1) then
				return
			end

			var_9_3[arg_12_0] = 0

			return
		end
	end)

	if #var_9_9 == 1 and var_9_3[arg_9_1] == 0 then
		var_9_3[arg_9_1] = var_9_9[1]
	else
		local var_9_10 = 0

		_ = var_8

		var_8.each(var_9_9, function(arg_13_0)
			while var_9_10 <= #var_9_3 do
				var_9_10 = var_9_10 + 1

				if var_9_3[var_9_10] == 0 then
					break
				end
			end

			var_9_3[var_9_10] = arg_13_0

			return
		end)
	end

	local var_9_11 = {}
	local var_9_12 = var_9_2:GetShipIds()

	table = var_9

	var_9.Foreach(var_9_3, function(arg_14_0, arg_14_1)
		local var_14_0

		if not var_9_12[arg_14_0] then
			var_14_0 = 0
		end

		if var_14_0 ~= arg_14_1 then
			table = var_2_10003

			var_2_10003.insert(var_9_11, {
				key = arg_14_0,
				value = arg_14_1
			})
		end

		return
	end)

	if #var_9_11 > 0 then
		local var_9_13 = arg_9_0
		local var_9_14 = arg_9_0.sendNotification

		GAME = var_12

		local var_9_15 = var_12.ACTIVITY_OPERATION
		local var_9_16 = {
			activity_id = var_9_2.id
		}

		SpringActivity = var_14
		var_9_16.cmd = var_14.OPERATION_SETSHIP
		var_9_16.kvargs1 = var_9_11

		var_9_14(var_9_13, var_9_15, var_9_16)
	end

	arg_9_3()

	return
end

function var_0_1.GetSelectedShipIds(arg_15_0, arg_15_1)
	local var_15_0

	if not arg_15_1 or not arg_15_1.id then
		var_15_0 = -1
	end

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_15_1 = var_1_10003(var_1_10005)
	local var_15_2 = var_3.getActivityByType

	ActivityConst = var_1_10006

	local var_15_3 = var_15_2(var_15_1, var_1_10006.ACTIVITY_TYPE_HOTSPRING)
	local var_15_4 = {}

	ipairs = var_15_1

	for iter_15_0, iter_15_1 in var_15_1(var_15_3:GetShipIds()) do
		local var_15_5

		if 0 < iter_15_1 then
			getProxy = var_10
			BayProxy = var_1_10012
			var_1_10012 = var_10(var_1_10012)
			var_15_5 = var_10.RawGetShipById(var_1_10012, iter_15_1)
		else
			var_15_5 = false
		end

		if false then
			var_15_5 = true
		end

		if var_15_5 and var_15_5.id ~= var_15_0 then
			table = var_11

			var_11.insert(var_15_4, var_15_5.id)
		end
	end

	return var_15_4
end

function var_0_1.OnShip(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	ShipStatus = var_1_10004

	local var_16_0, var_16_1 = var_1_10004.ShipStatusCheck("inBackyard", arg_16_1, function(arg_17_0)
		arg_16_2()

		return
	end)

	return var_16_0, var_16_1
end

function var_0_1.listNotificationInterests(arg_18_0)
	local var_18_0 = {}

	ActivityProxy = var_1_10002
	var_18_0[1] = var_1_10002.ACTIVITY_OPERATION_DONE
	ActivityProxy = var_2
	var_18_0[2] = var_2.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_18_0[3] = var_2.ACTIVITY_SHOW_AWARDS
	var_18_0[4] = var_0_1.OPEN_CHUANWU
	var_18_0[5] = var_0_1.UNLOCK_SLOT

	return var_18_0
end

function var_0_1.handleNotification(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.getName(var_19_0)
	local var_19_2 = arg_19_1
	local var_19_3 = arg_19_1.getBody(var_19_2)

	if var_19_1 == nil then
		-- block empty
	else
		ActivityProxy = var_19_0

		local var_19_4

		if var_19_1 == var_19_0.ACTIVITY_SHOW_AWARDS then
			var_1_10006 = arg_19_0.viewComponent
			var_19_4 = var_19_4.emit
			BaseUI = var_1_10007

			var_19_4(var_1_10006, var_1_10007.ON_ACHIEVE, var_19_3.awards, var_19_3.callback)
		else
			ActivityProxy = var_19_4

			local var_19_5

			if var_19_1 == var_19_4.ACTIVITY_UPDATED then
				var_1_10006 = var_19_3
				var_19_5 = var_19_3.getConfig(var_1_10006, "type")
				ActivityConst = var_19_2

				if var_19_5 == var_19_2.ACTIVITY_TYPE_HOTSPRING then
					var_1_10006 = arg_19_0.viewComponent

					var_19_5.UpdateActivity(var_1_10006, var_19_3)
				end
			else
				ActivityProxy = var_19_5

				if var_19_1 == var_19_5.ACTIVITY_OPERATION_DONE then
					getProxy = var_4
					ActivityProxy = var_1_10006

					local var_19_6 = var_4(var_1_10006)
					local var_19_7 = var_4.getActivityById(var_19_6, var_19_3)
					local var_19_8 = var_4.getConfig(var_19_7, "type")

					ActivityConst = var_19_6

					if var_19_8 == var_19_6.ACTIVITY_TYPE_HOTSPRING then
						local var_19_9 = arg_19_0.viewComponent

						var_5.UpdateActivity(var_19_9, var_4)
					end
				elseif var_19_1 == var_0_1.OPEN_CHUANWU then
					local var_19_10 = arg_19_0.viewComponent
					local var_19_11 = var_4.emit
					local var_19_12 = var_0_1.OPEN_CHUANWU

					unpack = var_1_10008

					var_19_11(var_19_10, var_19_12, var_1_10008(var_19_3))
				elseif var_19_1 == var_0_1.UNLOCK_SLOT then
					local var_19_13 = arg_19_0.viewComponent

					var_4.emit(var_19_13, var_0_1.UNLOCK_SLOT, var_19_3)
				end
			end
		end
	end

	return
end

return var_0_1
