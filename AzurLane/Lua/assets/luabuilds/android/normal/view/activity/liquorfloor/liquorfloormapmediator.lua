class = var_0_10000

local var_0_0 = "LiquorFloorMapMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ADD_WORKPLACE = "LiquorFloorMapMediator:ADD_WORKPLACE"
var_0_1.ALL_WORKPLACE = "LiquorFloorMapMediator:ALL_WORKPLACE"
var_0_1.OPEN_CHUANWU = "LiquorFloorMapMediator:OPEN_CHUANWU"
var_0_1.UPGRADE_WORKPLACE = "LiquorFloorMapMediator:UPGRADE_WORKPLACE"
var_0_1.CLICK_BUBBLE = "LiquorFloorMapMediator:CLICK_BUBBLE"
var_0_1.GO_FIGHT = "LiquorFloorMapMediator:GO_FIGHT"
var_0_1.OPEN_CLUE_BOOK = "LiquorFloorMapMediator.OPEN_CLUE_BOOK"
var_0_1.OPEN_LAYER = "LiquorFloorMapMediator:OPEN_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0.upgradeplaceData = nil
	arg_1_0.indexplaceData = nil

	arg_1_0:bind(var_0_1.OPEN_CHUANWU, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0

		var_4.OnSelShips(var_2_0, arg_2_1, arg_2_2, arg_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.ADD_WORKPLACE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.ACTIVITY_TOWN_OP
		local var_3_3 = {
			activity_id = arg_1_0.activity.id,
			arg1 = arg_3_1
		}

		TownActivity2 = var_6
		var_3_3.cmd = var_6.OPERATION.SETTLE_GOLD

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.ALL_WORKPLACE, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_4_2 = var_2_10003.ACTIVITY_TOWN_OP
		local var_4_3 = {
			activity_id = arg_1_0.activity.id
		}

		TownActivity2 = var_5
		var_4_3.cmd = var_5.OPERATION.ALL_GOLD

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.UPGRADE_WORKPLACE, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_1_0.upgradeplaceData = arg_5_2
		arg_1_0.indexplaceData = arg_5_3

		local var_5_0 = arg_1_0
		local var_5_1 = var_4.sendNotification

		GAME = var_2_10006

		local var_5_2 = var_2_10006.ACTIVITY_TOWN_OP
		local var_5_3 = {
			activity_id = arg_1_0.activity.id
		}

		TownActivity2 = var_8
		var_5_3.cmd = var_8.OPERATION.UPGRADE_PLACE
		var_5_3.arg1 = arg_5_1

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_BUBBLE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_6_2 = var_2_10004.ACTIVITY_TOWN_OP
		local var_6_3 = {
			activity_id = arg_1_0.activity.id
		}

		TownActivity2 = var_6
		var_6_3.cmd = var_6.OPERATION.CLICK_BUBBLE
		var_6_3.arg_list = arg_6_1

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CLUE_BOOK, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		LiquorFloorBookLayer = var_2_10006
		var_7_3.viewComponent = var_2_10006
		LiquorFloorBookMediator = var_2_10006
		var_7_3.mediator = var_2_10006

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)
	arg_1_0:bind(var_0_1.GO_FIGHT, function(arg_8_0, arg_8_1)
		getProxy = var_2_10002
		ChapterProxy = var_2_10003

		local var_8_0 = var_2_10002(var_2_10003)
		local var_8_1, var_8_2 = var_2.getLastMapForActivity(var_8_0)

		if var_8_1 then
			var_2_10006 = var_2
			var_2_10006 = var_2.getMapById(var_2_10006, var_8_1)

			if not var_2_10005.isUnlock(var_2_10006) then
				getProxy = var_2_10005
				ChapterProxy = var_2_10006
				var_2_10007 = var_2_10005(var_2_10006)

				if var_2_10005.getActiveChapter(var_2_10007) then
					::label_8_0::

					var_2_10008 = var_6
					var_8_1 = var_6.getConfig(var_2_10008, "map")
				end

				if not var_6 then
					var_2_10008 = var_2_10005
					var_8_1 = var_2_10005.GetLastNormalMap(var_2_10008)
				end

				pg = var_2_10007
				var_2_10008 = var_2_10007.m02
				var_2_10007 = var_2_10007.sendNotification
				GAME = var_2_10009

				local var_8_3 = var_2_10009.GO_SCENE

				SCENE = var_2_10010

				var_2_10007(var_2_10008, var_8_3, var_2_10010.LEVEL, {
					chapterId = var_6 and var_6.id,
					mapIdx = var_8_1
				})
			else
				pg = var_2_10005

				local var_8_4 = var_2_10005.m02
				local var_8_5 = var_5.sendNotification

				GAME = var_2_10007

				local var_8_6 = var_2_10007.GO_SCENE

				SCENE = var_2_10008

				var_8_5(var_8_4, var_8_6, var_2_10008.LEVEL, {
					chapterId = var_8_2,
					mapIdx = var_8_1
				})
			end

			return
		end
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_LAYER, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0

		var_2.addSubLayers(var_9_0, arg_9_1)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_3

	if not var_1_2(var_1_1, var_3.ACTIVITY_TYPE_TOWN2) or var_1:isEnd() then
		assert = var_1_1

		var_1_1(nil, "not exist act")

		return
	end

	arg_1_0.activity = var_1

	local var_1_3 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_3, var_1)

	return
end

function var_0_1.ChangeShips(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.sendNotification

	GAME = var_1_10005

	local var_10_2 = var_1_10005.ACTIVITY_TOWN_OP
	local var_10_3 = {
		activity_id = arg_10_0.activity.id
	}

	TownActivity = var_7
	var_10_3.cmd = var_7.OPERATION.CHANGE_SHIPS
	var_10_3.kvargs1 = arg_10_1
	var_10_3.arg1 = arg_10_2

	var_10_1(var_10_0, var_10_2, var_10_3)

	return
end

function var_0_1.OnSelShips(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:GetSelectedShipIds(arg_11_2)
	local var_11_1 = {
		selectedMin = 0,
		callbackQuit = true
	}
	local var_11_2 = arg_11_0.activity

	var_11_1.selectedMax = var_6.GetUnlockSlotCnt(var_11_2)
	var_11_1.quitTeam = arg_11_2 ~= nil
	pg = var_6

	local var_11_3 = var_6.ShipFlagMgr.GetInstance()

	var_11_1.ignoredIds = var_6.FilterShips(var_11_3, {
		isActivityNpc = true
	})
	Clone = var_6
	var_11_1.selectedIds = var_6(var_11_0)
	var_11_1.preView = arg_11_0.viewComponent.__cname
	ShipStatus = var_6
	var_11_1.hideTagFlags = var_6.TAG_HIDE_BACKYARD
	ShipStatus = var_6
	var_11_1.blockTagFlags = var_6.TAG_BLOCK_BACKYARD

	function var_11_1.onSelected(arg_12_0, arg_12_1)
		local var_12_0 = arg_11_0

		var_2.OnSelected(var_12_0, arg_11_1, arg_12_0, arg_12_1, arg_11_3)

		return
	end

	_ = var_6

	local var_11_4 = var_6.filter
	local var_11_5 = arg_11_0.activity

	var_11_1.priorEquipUpShipIDList = var_11_4(var_7.GetShipIds(var_11_5), function(arg_13_0)
		return arg_13_0 > 0
	end)
	i18n = var_6
	var_11_1.leftTopWithFrameInfo = var_6("backyard_longpress_ship_tip")
	var_11_1.isLayer = true
	var_11_1.energyDisplay = true

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.addSubLayers

	Context = var_8

	local var_11_8 = var_8.New
	local var_11_9 = {}

	DockyardScene = var_1_10010
	var_11_9.viewComponent = var_1_10010
	DockyardMediator = var_1_10010
	var_11_9.mediator = var_1_10010
	var_11_9.data = var_11_1

	var_11_7(var_11_6, var_11_8(var_11_9))

	return
end

function var_0_1.OnSelected(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	Clone = var_1_10005

	local var_14_0 = arg_14_0.activity
	local var_14_1 = var_1_10005(var_6.GetShipIds(var_14_0))
	local var_14_2 = {}
	local var_14_3 = {}

	if arg_14_2 == nil or #arg_14_2 == 0 then
		ipairs = var_1_10008

		for iter_14_0, iter_14_1 in var_1_10008(var_14_1) do
			if 0 < iter_14_1 then
				table = var_13

				var_13.insert(var_14_3, {
					value = 0,
					key = iter_14_0
				})
			end
		end
	else
		ipairs = var_1_10008

		for iter_14_2, iter_14_3 in var_1_10008(var_14_1) do
			if not arg_14_2[iter_14_2] then
				table = var_1_10014

				var_1_10014.insert(var_14_3, {
					value = 0,
					key = iter_14_2
				})
			elseif var_13 ~= iter_14_3 then
				table = var_1_10014

				var_1_10014.insert(var_14_3, {
					key = iter_14_2,
					value = var_13
				})
			end
		end
	end

	if #var_14_3 > 0 then
		arg_14_0:ChangeShips(var_14_3, arg_14_4)
	end

	existCall = var_8

	var_8(arg_14_3)

	return
end

function var_0_1.GetSelectedShipIds(arg_15_0, arg_15_1)
	local var_15_0

	if not arg_15_1 or not arg_15_1.id then
		var_15_0 = -1
	end

	local var_15_1 = {}

	ipairs = var_1_10004

	local var_15_2 = arg_15_0.activity

	for iter_15_0, iter_15_1 in var_1_10004(var_5.GetShipIds(var_15_2)) do
		local var_15_3

		if 0 < iter_15_1 then
			getProxy = var_9
			BayProxy = var_1_10010
			var_1_10010 = var_9(var_1_10010)
			var_15_3 = var_9.RawGetShipById(var_1_10010, iter_15_1)
		else
			var_15_3 = false
		end

		if false then
			var_15_3 = true
		end

		if var_15_3 and var_15_3.id ~= var_15_0 then
			table = var_1_10010

			var_1_10010.insert(var_15_1, var_15_3.id)
		end
	end

	return var_15_1
end

function var_0_1.listNotificationInterests(arg_16_0)
	local var_16_0 = {}

	GAME = var_1_10002
	var_16_0[1] = var_1_10002.ACTIVITY_TOWN_OP_DONE
	ActivityProxy = var_2
	var_16_0[2] = var_2.ACTIVITY_UPDATED
	GAME = var_2
	var_16_0[3] = var_2.SUBMIT_TASK_AWARD_DOWN
	GAME = var_2
	var_16_0[4] = var_2.TOTAL_TASK_UPDATED

	return var_16_0
end

function var_0_1.handleNotification(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:getName()
	local var_17_1 = arg_17_1
	local var_17_2 = arg_17_1.getBody(var_17_1)

	GAME = var_17_1

	if var_17_0 == var_17_1.ACTIVITY_TOWN_OP_DONE then
		switch = var_4

		local var_17_3 = var_17_2.cmd
		local var_17_4 = {}

		TownActivity2 = var_1_10007
		var_17_4[var_1_10007.OPERATION.UPGRADE_PLACE] = function()
			local var_18_0 = arg_17_0.viewComponent

			var_0.InitData(var_18_0)

			local var_18_1 = arg_17_0
			local var_18_2 = arg_17_0.activity

			var_18_1.placeData = var_1.GetPlaceList(var_18_2)

			local var_18_3 = arg_17_0.viewComponent

			var_0.OnBox(var_18_3, arg_17_0.placeData[arg_17_0.indexplaceData], arg_17_0.indexplaceData, arg_17_0.activity)

			local var_18_4 = arg_17_0.viewComponent

			var_0.OnBox(var_18_4, arg_17_0.placeData[arg_17_0.indexplaceData], arg_17_0.indexplaceData, arg_17_0.activity)

			arg_17_0.upgradeplaceData = nil
			arg_17_0.indexplaceData = nil

			return
		end
		TownActivity2 = var_7
		var_17_4[var_7.OPERATION.CHANGE_SHIPS] = function()
			local var_19_0 = arg_17_0.viewComponent

			var_0.InitData(var_19_0)

			local var_19_1 = arg_17_0.viewComponent

			var_0.UpdateBubbles(var_19_1)

			setActive = var_0

			var_0(arg_17_0.viewComponent.box, false)

			return
		end
		TownActivity2 = var_7
		var_17_4[var_7.OPERATION.CLICK_BUBBLE] = function()
			local var_20_0 = arg_17_0.viewComponent

			var_0.InitData(var_20_0)

			local var_20_1 = arg_17_0.viewComponent

			var_0.UpdateBubbles(var_20_1)

			local var_20_2 = arg_17_0.viewComponent
			local var_20_3 = var_0.emit

			BaseUI = var_2_10002

			var_20_3(var_20_2, var_2_10002.ON_ACHIEVE, var_17_2.awards)

			return
		end
		TownActivity2 = var_7
		var_17_4[var_7.OPERATION.SETTLE_GOLD] = function()
			local var_21_0 = arg_17_0.viewComponent

			var_0.InitData(var_21_0)

			local var_21_1 = arg_17_0.viewComponent
			local var_21_2 = var_0.emit

			BaseUI = var_2_10002

			var_21_2(var_21_1, var_2_10002.ON_ACHIEVE, var_17_2.awards)

			return
		end
		TownActivity2 = var_7
		var_17_4[var_7.OPERATION.ALL_GOLD] = function()
			local var_22_0 = arg_17_0.viewComponent

			var_0.InitData(var_22_0)

			local var_22_1 = arg_17_0.viewComponent
			local var_22_2 = var_0.emit

			BaseUI = var_2_10002

			var_22_2(var_22_1, var_2_10002.ON_ACHIEVE, var_17_2.awards)

			return
		end

		var_4(var_17_3, var_17_4)

		goto label_17_0
	end

	ActivityProxy = var_4

	local var_17_6

	if var_17_0 == var_4.ACTIVITY_UPDATED then
		local var_17_5 = var_17_2

		var_17_6 = var_17_2.getConfig(var_17_5, "type")
		ActivityConst = var_17_5

		if var_17_6 == var_17_5.ACTIVITY_TYPE_TOWN2 then
			getProxy = var_17_6
			ActivityProxy = var_5

			local var_17_7 = var_17_6(var_5)

			var_17_6 = var_17_6.getActivityByType
			ActivityConst = var_6
			arg_17_0.activity = var_17_6(var_17_7, var_6.ACTIVITY_TYPE_TOWN2)

			local var_17_8 = arg_17_0.viewComponent

			var_17_6.SetActivity(var_17_8, arg_17_0.activity)

			local var_17_9 = arg_17_0.viewComponent

			var_17_6.InitData(var_17_9)
		end

		goto label_17_0
	end

	GAME = var_17_6

	if var_17_0 ~= var_17_6.SUBMIT_TASK_AWARD_DOWN then
		GAME = var_4

		if var_17_0 == var_4.TOTAL_TASK_UPDATED then
			local var_17_10 = arg_17_0.viewComponent

			var_4.RefreshRedPoint(var_17_10)
		end

		::label_17_0::

		local var_17_11 = arg_17_0.viewComponent

		var_4.OnStoryList(var_17_11)

		return
	end
end

return var_0_1
