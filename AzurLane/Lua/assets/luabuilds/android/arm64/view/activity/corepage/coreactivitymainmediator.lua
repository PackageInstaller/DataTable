class = var_0_10000

local var_0_0 = "CoreActivityMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.ActivityMediator"))

var_0_1.OPEN_CHUANWU = "CoreActivityMainMediator:Open chuanwu"

function var_0_1.getDisplayActivity(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	return var_1.getCorePanelActivities(var_1_0, arg_1_0.contextData.coreName)
end

function var_0_1.register(arg_2_0)
	var_0_1.super.register(arg_2_0)
	arg_2_0:bind(var_0_1.OPEN_CHUANWU, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		local var_3_0 = arg_2_0

		var_5.OnSelShips(var_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	var_0_1.super.initNotificationHandleDic(arg_4_0)

	local var_4_0 = arg_4_0.handleDic

	ActivityProxy = var_1_10002
	var_4_0[var_1_10002.ACTIVITY_SHOW_RED_PACKET_AWARDS] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getBody()
		local var_5_1 = arg_5_0.viewComponent
		local var_5_2 = var_3.emit

		BaseUI = var_2_10006

		var_5_2(var_5_1, var_2_10006.ON_ACHIEVE, var_5_0.awards, var_5_0.callback)

		return
	end

	local var_4_1 = arg_4_0.handleDic

	GAME = var_2
	var_4_1[var_2.ACT_NEW_PT_DONE] = function(arg_6_0, arg_6_1)
		getProxy = var_2_10002
		ContextProxy = var_2_10004

		local var_6_0 = var_2_10002(var_2_10004)
		local var_6_1 = var_2.getContextByMediator

		ActivityBossMediatorTemplate = var_2_10006

		if var_6_1(var_6_0, var_2_10006) then
			local var_6_2 = arg_6_0.viewComponent

			var_4.updateTaskLayers(var_6_2)

			return
		end

		local var_6_3 = arg_6_1:getBody()
		local var_6_4 = arg_6_0.viewComponent
		local var_6_5 = var_5.emit

		BaseUI = var_2_10008

		var_6_5(var_6_4, var_2_10008.ON_ACHIEVE, var_6_3.awards, function()
			local var_7_0 = arg_6_0.viewComponent

			var_0.updateTaskLayers(var_7_0)

			existCall = var_0

			var_0(var_6_3.callback)

			return
		end)

		return
	end

	return
end

function var_0_1.tryColoringAchieve(arg_8_0)
	getProxy = var_1_10001
	ColoringProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.getColorGroups(var_8_0)

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(var_8_1) do
		local var_8_2 = iter_8_1:getState()

		ColorGroup = var_1_10009

		if var_8_2 == var_1_10009.StateFinish and iter_8_1:getHasAward() then
			local var_8_3 = arg_8_0
			local var_8_4 = arg_8_0.sendNotification

			GAME = var_1_10011

			var_8_4(var_8_3, var_1_10011.COLORING_ACHIEVE, {
				activityId = arg_8_0.viewComponent.activity.id,
				id = iter_8_1.id
			})

			break
		end
	end

	return
end

function var_0_1.OnSelShips(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	getProxy = var_1_10005
	ActivityProxy = var_1_10007

	local var_9_0 = var_1_10005(var_1_10007)
	local var_9_1 = var_5.getActivityById(var_9_0, arg_9_1)
	local var_9_2 = arg_9_0:GetSelectedShipIds(arg_9_1, arg_9_3)
	local var_9_3 = {
		callbackQuit = true,
		selectedMax = arg_9_4,
		quitTeam = arg_9_3 ~= nil
	}

	pg = var_8

	local var_9_4 = var_8.ShipFlagMgr.GetInstance()

	var_9_3.ignoredIds = var_8.FilterShips(var_9_4, {
		isActivityNpc = true
	})
	Clone = var_8
	var_9_3.selectedIds = var_8(var_9_2)
	var_9_3.preView = arg_9_0.viewComponent.__cname
	ShipStatus = var_8
	var_9_3.hideTagFlags = var_8.TAG_HIDE_BACKYARD
	ShipStatus = var_8
	var_9_3.blockTagFlags = var_8.TAG_BLOCK_BACKYARD

	function var_9_3.onShip(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_9_0

		return var_3.OnShip(var_10_0, arg_10_0, arg_10_1, arg_10_2)
	end

	function var_9_3.onSelected(arg_11_0, arg_11_1)
		local var_11_0 = arg_9_0

		var_2.OnSelected(var_11_0, arg_9_1, arg_9_2, arg_11_0, arg_11_1)

		return
	end

	_ = var_8
	var_9_3.priorEquipUpShipIDList = var_8.filter(var_9_1:GetShipIds(), function(arg_12_0)
		return arg_12_0 > 0
	end)
	i18n = var_8
	var_9_3.leftTopWithFrameInfo = var_8("backyard_longpress_ship_tip")
	var_9_3.isLayer = true
	var_9_3.energyDisplay = true

	local var_9_5 = arg_9_0
	local var_9_6 = arg_9_0.addSubLayers

	Context = var_11

	local var_9_7 = var_11.New
	local var_9_8 = {}

	DockyardScene = var_1_10014
	var_9_8.viewComponent = var_1_10014
	DockyardMediator = var_1_10014
	var_9_8.mediator = var_1_10014
	var_9_8.data = var_9_3

	var_9_6(var_9_5, var_9_7(var_9_8))

	return
end

function var_0_1.GetSelectedShipIds(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if not arg_13_2 or not arg_13_2.id then
		var_13_0 = -1
	end

	getProxy = var_1_10004
	ActivityProxy = var_1_10006

	local var_13_1 = var_1_10004(var_1_10006)
	local var_13_2 = var_4.getActivityById(var_13_1, arg_13_1)
	local var_13_3 = {}

	ipairs = var_13_1

	for iter_13_0, iter_13_1 in var_13_1(var_13_2:GetShipIds()) do
		local var_13_4

		if 0 < iter_13_1 then
			getProxy = var_11
			BayProxy = var_1_10013
			var_1_10013 = var_11(var_1_10013)
			var_13_4 = var_11.RawGetShipById(var_1_10013, iter_13_1)
		else
			var_13_4 = false
		end

		if false then
			var_13_4 = true
		end

		if var_13_4 and var_13_4.id ~= var_13_0 then
			table = var_12

			var_12.insert(var_13_3, var_13_4.id)
		end
	end

	return var_13_3
end

function var_0_1.OnShip(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	ShipStatus = var_1_10004

	local var_14_0, var_14_1 = var_1_10004.ShipStatusCheck("inBackyard", arg_14_1, function(arg_15_0)
		arg_14_2()

		return
	end)

	return var_14_0, var_14_1
end

function var_0_1.OnSelected(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	getProxy = var_1_10005
	ActivityProxy = var_1_10007

	local var_16_0 = var_1_10005(var_1_10007)
	local var_16_1 = var_5.getActivityById(var_16_0, arg_16_1)

	Clone = var_1_10006

	local var_16_2 = var_1_10006(var_16_1:GetShipIds())

	_ = var_16_0

	local var_16_3 = var_16_0.each

	_ = var_1_10009

	var_16_3(var_1_10009.range(var_16_1:GetSlotCount()), function(arg_17_0)
		local var_17_0 = var_16_2
		local var_17_1

		if not var_16_2[arg_17_0] then
			var_17_1 = 0
		end

		var_17_0[arg_17_0] = var_17_1

		return
	end)

	local var_16_5

	if arg_16_3 == nil or #arg_16_3 == 0 then
		var_16_3 = var_16_2[arg_16_2]

		if 0 < var_16_3 then
			local var_16_4 = arg_16_0

			var_16_5 = arg_16_0.sendNotification
			GAME = var_11

			local var_16_6 = var_11.ACTIVITY_OPERATION
			local var_16_7 = {
				activity_id = var_16_1.id
			}

			Spring2Activity = var_13
			var_16_7.cmd = var_13.OPERATION_SETSHIP
			var_16_7.kvargs1 = {
				{
					value = 0,
					key = arg_16_2
				}
			}

			var_16_5(var_16_4, var_16_6, var_16_7)
		end

		existCall = var_16_5

		var_16_5(arg_16_4)

		return
	end

	_ = var_16_3

	local var_16_8 = var_16_3.filter(arg_16_3, function(arg_18_0)
		table = var_2_10001

		return not var_2_10001.contains(var_16_2, arg_18_0)
	end)

	table = var_16_5

	var_16_5.Foreach(var_16_2, function(arg_19_0, arg_19_1)
		if arg_19_1 ~= 0 then
			table = var_2_10002

			if var_2_10002.contains(arg_16_3, arg_19_1) then
				return
			end

			var_16_2[arg_19_0] = 0

			return
		end
	end)

	if #var_16_8 == 1 and var_16_2[arg_16_2] == 0 then
		var_16_2[arg_16_2] = var_16_8[1]
	else
		local var_16_9 = 0

		_ = var_9

		var_9.each(var_16_8, function(arg_20_0)
			while var_16_9 <= #var_16_2 do
				var_16_9 = var_16_9 + 1

				if var_16_2[var_16_9] == 0 then
					break
				end
			end

			var_16_2[var_16_9] = arg_20_0

			return
		end)
	end

	local var_16_10 = {}
	local var_16_11 = var_16_1:GetShipIds()

	table = var_10

	var_10.Foreach(var_16_2, function(arg_21_0, arg_21_1)
		local var_21_0

		if not var_16_11[arg_21_0] then
			var_21_0 = 0
		end

		if var_21_0 ~= arg_21_1 then
			table = var_2_10003

			var_2_10003.insert(var_16_10, {
				key = arg_21_0,
				value = arg_21_1
			})
		end

		return
	end)

	if #var_16_10 > 0 then
		local var_16_12 = arg_16_0
		local var_16_13 = arg_16_0.sendNotification

		GAME = var_13

		local var_16_14 = var_13.ACTIVITY_OPERATION
		local var_16_15 = {
			activity_id = var_16_1.id
		}

		Spring2Activity = var_15
		var_16_15.cmd = var_15.OPERATION_SETSHIP
		var_16_15.kvargs1 = var_16_10

		var_16_13(var_16_12, var_16_14, var_16_15)
	end

	arg_16_4()

	return
end

return var_0_1
