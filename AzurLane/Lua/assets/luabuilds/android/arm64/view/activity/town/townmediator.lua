class = var_0_10000

local var_0_0 = "TownMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.OPEN_CHUANWU = "TownMediator:OPEN_CHUANWU"
var_0_1.UPGRADE_TOWN = "TownMediator:UPGRADE_TOWN"
var_0_1.UPGRADE_WORKPLACE = "TownMediator:UPGRADE_WORKPLACE"
var_0_1.CLICK_BUBBLE = "TownMediator:CLICK_BUBBLE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_CHUANWU, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.OnSelShips(var_2_0, arg_2_1, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_1.UPGRADE_TOWN, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.ACTIVITY_TOWN_OP
		local var_3_3 = {
			activity_id = arg_1_0.activity.id
		}

		TownActivity = var_6
		var_3_3.cmd = var_6.OPERATION.UPGRADE_TOWN

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.UPGRADE_WORKPLACE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.ACTIVITY_TOWN_OP
		local var_4_3 = {
			activity_id = arg_1_0.activity.id
		}

		TownActivity = var_7
		var_4_3.cmd = var_7.OPERATION.UPGRADE_PLACE
		var_4_3.arg1 = arg_4_1

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.CLICK_BUBBLE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.ACTIVITY_TOWN_OP
		local var_5_3 = {
			activity_id = arg_1_0.activity.id
		}

		TownActivity = var_7
		var_5_3.cmd = var_7.OPERATION.CLICK_BUBBLE
		var_5_3.arg_list = arg_5_1

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_4

	if not var_1_2(var_1_1, var_4.ACTIVITY_TYPE_TOWN) or var_1:isEnd() then
		assert = var_1_10002

		var_1_10002(nil, "not exist act")

		return
	end

	arg_1_0.activity = var_1

	local var_1_3 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_3, var_1)

	return
end

function var_0_1.ChangeShips(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.sendNotification

	GAME = var_1_10005

	local var_6_2 = var_1_10005.ACTIVITY_TOWN_OP
	local var_6_3 = {
		activity_id = arg_6_0.activity.id
	}

	TownActivity = var_7
	var_6_3.cmd = var_7.OPERATION.CHANGE_SHIPS
	var_6_3.kvargs1 = arg_6_1

	var_6_1(var_6_0, var_6_2, var_6_3)

	return
end

function var_0_1.OnSelShips(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetSelectedShipIds(arg_7_2)
	local var_7_1 = {
		selectedMin = 0,
		callbackQuit = true
	}
	local var_7_2 = arg_7_0.activity

	var_7_1.selectedMax = var_5.GetUnlockSlotCnt(var_7_2)
	var_7_1.quitTeam = arg_7_2 ~= nil
	pg = var_5

	local var_7_3 = var_5.ShipFlagMgr.GetInstance()

	var_7_1.ignoredIds = var_5.FilterShips(var_7_3, {
		isActivityNpc = true
	})
	Clone = var_5
	var_7_1.selectedIds = var_5(var_7_0)
	var_7_1.preView = arg_7_0.viewComponent.__cname
	ShipStatus = var_5
	var_7_1.hideTagFlags = var_5.TAG_HIDE_BACKYARD
	ShipStatus = var_5
	var_7_1.blockTagFlags = var_5.TAG_BLOCK_BACKYARD

	function var_7_1.onSelected(arg_8_0, arg_8_1)
		local var_8_0 = arg_7_0

		var_2.OnSelected(var_8_0, arg_7_1, arg_8_0, arg_8_1)

		return
	end

	_ = var_5

	local var_7_4 = var_5.filter
	local var_7_5 = arg_7_0.activity

	var_7_1.priorEquipUpShipIDList = var_7_4(var_7.GetShipIds(var_7_5), function(arg_9_0)
		return arg_9_0 > 0
	end)
	i18n = var_5
	var_7_1.leftTopWithFrameInfo = var_5("backyard_longpress_ship_tip")
	var_7_1.isLayer = true
	var_7_1.energyDisplay = true

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.addSubLayers

	Context = var_8

	local var_7_8 = var_8.New
	local var_7_9 = {}

	DockyardScene = var_1_10011
	var_7_9.viewComponent = var_1_10011
	DockyardMediator = var_1_10011
	var_7_9.mediator = var_1_10011
	var_7_9.data = var_7_1

	var_7_7(var_7_6, var_7_8(var_7_9))

	return
end

function var_0_1.OnSelected(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	Clone = var_1_10004

	local var_10_0 = arg_10_0.activity
	local var_10_1 = var_1_10004(var_6.GetShipIds(var_10_0))
	local var_10_2 = {}
	local var_10_3 = {}

	if arg_10_2 == nil or #arg_10_2 == 0 then
		ipairs = var_1_10007

		for iter_10_0, iter_10_1 in var_1_10007(var_10_1) do
			if 0 < iter_10_1 then
				table = var_12

				var_12.insert(var_10_3, {
					value = 0,
					key = iter_10_0
				})
			end
		end
	else
		ipairs = var_1_10007

		for iter_10_2, iter_10_3 in var_1_10007(var_10_1) do
			if not arg_10_2[iter_10_2] then
				table = var_1_10013

				var_1_10013.insert(var_10_3, {
					value = 0,
					key = iter_10_2
				})
			elseif var_12 ~= iter_10_3 then
				table = var_1_10013

				var_1_10013.insert(var_10_3, {
					key = iter_10_2,
					value = var_12
				})
			end
		end
	end

	if #var_10_3 > 0 then
		arg_10_0:ChangeShips(var_10_3)
	end

	existCall = var_7

	var_7(arg_10_3)

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

	for iter_11_0, iter_11_1 in var_1_10004(var_6.GetShipIds(var_11_2)) do
		local var_11_3

		if 0 < iter_11_1 then
			getProxy = var_9
			BayProxy = var_1_10011
			var_1_10011 = var_9(var_1_10011)
			var_11_3 = var_9.RawGetShipById(var_1_10011, iter_11_1)
		else
			var_11_3 = false
		end

		if false then
			var_11_3 = true
		end

		if var_11_3 and var_11_3.id ~= var_11_0 then
			table = var_10

			var_10.insert(var_11_1, var_11_3.id)
		end
	end

	return var_11_1
end

function var_0_1.listNotificationInterests(arg_12_0)
	local var_12_0 = {}

	GAME = var_1_10002
	var_12_0[1] = var_1_10002.ACTIVITY_TOWN_OP_DONE
	ActivityProxy = var_2
	var_12_0[2] = var_2.ACTIVITY_UPDATED

	return var_12_0
end

function var_0_1.handleNotification(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_1.getName(var_13_0)
	local var_13_2 = arg_13_1
	local var_13_3 = arg_13_1.getBody(var_13_2)

	GAME = var_13_0

	if var_13_1 == var_13_0.ACTIVITY_TOWN_OP_DONE then
		switch = var_4

		local var_13_4 = var_13_3.cmd
		local var_13_5 = {}

		TownActivity = var_1_10008
		var_13_5[var_1_10008.OPERATION.UPGRADE_TOWN] = function()
			pg = var_2_10000

			local var_14_0 = var_2_10000.activity_town_level
			local var_14_1 = arg_13_0.activity
			local var_14_2 = var_14_0[var_1.GetTownLevel(var_14_1)]

			seriesAsync = var_1

			var_1({
				function(arg_15_0)
					local var_15_0 = arg_13_0.viewComponent

					var_1.OnTownUpgrade(var_15_0, arg_15_0)

					return
				end,
				function(arg_16_0)
					if var_14_2.unlock_story ~= "" then
						pg = var_3_10002

						local var_16_0 = var_3_10002.NewStoryMgr.GetInstance()

						var_2.Play(var_16_0, var_1, arg_16_0)
					else
						arg_16_0()
					end

					return
				end,
				function(arg_17_0)
					if #var_14_2.unlock_work[1] > 0 or #var_1[2] > 0 then
						local var_17_0 = arg_13_0
						local var_17_1 = var_2.addSubLayers

						Context = var_3_10005

						local var_17_2 = var_3_10005.New
						local var_17_3 = {}

						TownUnlockMediator = var_3_10008
						var_17_3.mediator = var_3_10008
						TownUnlockLayer = var_3_10008
						var_17_3.viewComponent = var_3_10008
						var_17_3.data = {
							newIds = var_1[1],
							limitIds = var_1[2],
							removeFunc = arg_17_0
						}

						var_17_1(var_17_0, var_17_2(var_17_3))
					else
						arg_17_0()
					end

					return
				end
			}, function()
				return
			end)

			return
		end
		TownActivity = var_8
		var_13_5[var_8.OPERATION.UPGRADE_PLACE] = function()
			seriesAsync = var_2_10000

			var_2_10000({
				function(arg_20_0)
					local var_20_0 = arg_13_0.viewComponent

					var_1.OnPlaceUpgrade(var_20_0, arg_20_0)

					return
				end,
				function(arg_21_0)
					local var_21_0 = arg_13_0.viewComponent
					local var_21_1 = var_1.emit

					BaseUI = var_3_10004

					var_21_1(var_21_0, var_3_10004.ON_ACHIEVE, var_13_3.awards)

					return
				end
			}, function()
				return
			end)

			return
		end
		TownActivity = var_8
		var_13_5[var_8.OPERATION.CHANGE_SHIPS] = function()
			local var_23_0 = arg_13_0.viewComponent

			var_0.UpdateShips(var_23_0)

			local var_23_1 = arg_13_0.viewComponent

			var_0.UpdateInfoPage(var_23_1)

			return
		end
		TownActivity = var_8
		var_13_5[var_8.OPERATION.CLICK_BUBBLE] = function()
			local var_24_0 = arg_13_0.viewComponent

			var_0.UpdateBubbles(var_24_0)

			local var_24_1 = arg_13_0.viewComponent
			local var_24_2 = var_0.emit

			BaseUI = var_2_10003

			var_24_2(var_24_1, var_2_10003.ON_ACHIEVE, var_13_3.awards)

			return
		end

		var_4(var_13_4, var_13_5)
	else
		ActivityProxy = var_4

		if var_13_1 == var_4.ACTIVITY_UPDATED then
			local var_13_6 = var_13_3
			local var_13_7 = var_13_3.getConfig(var_13_6, "type")

			ActivityConst = var_13_2

			if var_13_7 == var_13_2.ACTIVITY_TYPE_TOWN then
				getProxy = var_13_7
				ActivityProxy = var_13_6

				local var_13_8 = var_13_7(var_13_6)
				local var_13_9 = var_4.getActivityByType

				ActivityConst = var_7
				arg_13_0.activity = var_13_9(var_13_8, var_7.ACTIVITY_TYPE_TOWN)

				local var_13_10 = arg_13_0.viewComponent

				var_4.SetActivity(var_13_10, arg_13_0.activity)

				local var_13_11 = arg_13_0.viewComponent

				var_4.UpdateGold(var_13_11)

				local var_13_12 = arg_13_0.viewComponent

				var_4.OnExpUpdate(var_13_12)
			end
		end
	end

	return
end

return var_0_1
