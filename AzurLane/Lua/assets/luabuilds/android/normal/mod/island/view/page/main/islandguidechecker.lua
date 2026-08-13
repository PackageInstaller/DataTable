class = var_0_10000

local var_0_0 = var_0_10000("IslandGuideChecker")

var_0_0.MOVE_TASK_ID = 10001000
var_0_0.FIRST_TASK_ID = 10001010
var_0_0.ORDER_TASK_ID = 10001071
var_0_0.ORDER_TASK_PRE_ID = 10001070
var_0_0.ORDER_NEED_ITEMS = {
	{
		2700,
		1
	},
	{
		2800,
		1
	}
}
var_0_0.TECH_TASK_ID = 10001141
var_0_0.MAP_GUIDE_ABILITY_ID = 5004
var_0_0.INVITE_TASK_ID = 10001151
var_0_0.INVITE_TASK_PRE_ID = 10001150
var_0_0.MANAGE_ABILITY_ID = 26
var_0_0.MINING_ABILITY_ID = 2003
var_0_0.PASTIRE_ABILITY_ID = 2002
var_0_0.COMBP_ABILITY_ID = 29001
var_0_0.DAILY_TASK_ABILITY_ID = 30001
var_0_0.SIGNIN_STORY_NAME = "ISLAND1001032_1"
var_0_0.TECH_FIRST_ID = 100001
var_0_0.FISHING_TASK_ID = 3
var_0_0.PURCHASE_TRADE_TASK_ID = 20017002
var_0_0.SELL_TRADE_TASK_ID = 20017003
var_0_0.FINISH_TYPE = {
	ON_GUIDE = 2,
	ON_END = 3,
	ON_BEGIN = 1
}

local var_0_1 = {
	{
		id = "ISLAND_GUIDE_2",
		mapId = 0,
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_1_0 = var_1_10000(var_1_10001)
			local var_1_1 = var_0.GetIsland(var_1_0)
			local var_1_2 = var_0.GetTaskAgency(var_1_1)

			return not var_0.IsFinishTask(var_1_2, var_0_0.MOVE_TASK_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_GUIDE
	}
}
local var_0_2 = {
	id = "ISLAND_GUIDE_25",
	condition = function()
		getProxy = var_1_10000
		IslandProxy = var_1_10001

		local var_2_0 = var_1_10000(var_1_10001)
		local var_2_1 = var_0.GetIsland(var_2_0)
		local var_2_2 = var_0.GetAblityAgency(var_2_1)

		return var_0.HasAbility(var_2_2, var_0_0.MANAGE_ABILITY_ID)
	end
}

IslandConst = var_3
var_0_2.mapId = var_3.COFFEE_SHOP_MAP_ID
var_0_2.type = var_0_0.FINISH_TYPE.ON_BEGIN
var_0_1[2] = var_0_2
var_0_0.loadedConfig = var_0_1
var_0_0.interactionConfig = {
	{
		id = "ISLAND_GUIDE_3",
		interactionId = 0,
		condition = function()
			return true
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_34",
		interactionId = 10020071,
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_4_0 = var_1_10000(var_1_10001)
			local var_4_1 = var_0.GetIsland(var_4_0)
			local var_4_2 = var_0.GetTaskAgency(var_4_1)

			return var_0.IsFinishTask(var_4_2, var_0_0.FISHING_TASK_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_END
	}
}
var_0_0.pageConfig = {
	{
		id = "ISLAND_GUIDE_5",
		page = "IslandUpgradeDisplayPage",
		condition = function()
			return true
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_6",
		page = "IslandMapPage",
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_6_0 = var_1_10000(var_1_10001)
			local var_6_1 = var_0.GetIsland(var_6_0)
			local var_6_2 = var_0.GetAblityAgency(var_6_1)

			return var_0.HasAbility(var_6_2, var_0_0.MAP_GUIDE_ABILITY_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_8",
		page = "IslandTechnologyPage",
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_7_0 = var_1_10000(var_1_10001)
			local var_7_1 = var_0.GetIsland(var_7_0)
			local var_7_2 = var_0.GetTaskAgency(var_7_1)
			local var_7_3 = var_1.GetTask(var_7_2, var_0_0.TECH_TASK_ID)
			local var_7_4 = var_0:GetTechnologyAgency()
			local var_7_5 = var_2.GetTechnology(var_7_4, var_0_0.TECH_FIRST_ID)
			local var_7_6 = var_2.GetStatus(var_7_5)

			if var_7_3 then
				::label_7_0::

				IslandTechnology = var_7_5

				if var_7_6 ~= var_7_5.STATUS.LOCK then
					IslandTechnology = var_7_5

					if var_7_6 ~= var_7_5.STATUS.UNLOCK then
						IslandTechnology = var_7_5

						if var_7_6 ~= var_7_5.STATUS.NORMAL then
							var_7_5 = false

							goto label_7_1
						end
					end
				end

				var_7_5 = true
			end

			::label_7_1::

			return var_7_5
		end,
		type = var_0_0.FINISH_TYPE.ON_GUIDE
	},
	{
		id = "ISLAND_GUIDE_9",
		page = "IslandInvitePage",
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_8_0 = var_1_10000(var_1_10001)
			local var_8_1 = var_0.GetIsland(var_8_0)
			local var_8_2 = var_0.GetTaskAgency(var_8_1)
			local var_8_3

			if var_0.IsFinishTask(var_8_2, var_0_0.INVITE_TASK_PRE_ID) then
				var_8_3 = not var_0:IsFinishTask(var_0_0.INVITE_TASK_ID)
			end

			return var_8_3
		end,
		type = var_0_0.FINISH_TYPE.ON_GUIDE
	},
	{
		id = "ISLAND_GUIDE_13",
		page = "Island3dTaskPage",
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_9_0 = var_1_10000(var_1_10001)
			local var_9_1 = var_0.GetIsland(var_9_0)
			local var_9_2 = var_0.GetAblityAgency(var_9_1)

			return var_0.HasAbility(var_9_2, var_0_0.DAILY_TASK_ABILITY_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_21",
		page = "IslandShipOrderPage",
		condition = function()
			return true
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_23",
		page = "IslandBookPage",
		condition = function()
			return true
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_28",
		page = "IslandPhotoMainPage",
		condition = function()
			return true
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_29",
		page = "IslandFriendPage",
		condition = function()
			return true
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_31",
		page = "IslandMallDelegationPage",
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_14_0 = var_1_10000(var_1_10001)
			local var_14_1 = var_0.GetIsland(var_14_0)
			local var_14_2 = var_0.GetAblityAgency(var_14_1)

			return var_0.HasAbility(var_14_2, var_0_0.COMBP_ABILITY_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_32",
		page = "IslandBookFishPage",
		condition = function()
			return true
		end,
		type = var_0_0.FINISH_TYPE.ON_END
	},
	{
		id = "ISLAND_GUIDE_41",
		page = "IslandTradePage",
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_16_0 = var_1_10000(var_1_10001)
			local var_16_1 = var_0.GetIsland(var_16_0)
			local var_16_2 = var_0.GetTaskAgency(var_16_1)

			return var_0.IsFinishTask(var_16_2, var_0_0.PURCHASE_TRADE_TASK_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_END
	},
	{
		id = "ISLAND_GUIDE_42",
		page = "IslandTradePage",
		condition = function()
			getProxy = var_1_10000
			IslandProxy = var_1_10001

			local var_17_0 = var_1_10000(var_1_10001)
			local var_17_1 = var_0.GetIsland(var_17_0)
			local var_17_2 = var_0.GetTaskAgency(var_17_1)

			return var_0.IsFinishTask(var_17_2, var_0_0.SELL_TRADE_TASK_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_END
	}
}

function var_0_0.CheckOnLoaded(arg_18_0, arg_18_1)
	_ = var_1_10002

	if not var_1_10002.detect(var_0_0.loadedConfig, function(arg_19_0)
		local var_19_0 = arg_19_0.id
		local var_19_1 = arg_19_0.mapId
		local var_19_2 = arg_19_0.condition

		pg = var_2_10004

		local var_19_3 = var_2_10004.NewStoryMgr.GetInstance()

		return not var_4.IsPlayed(var_19_3, var_19_0) and (var_19_1 == 0 or var_19_1 == arg_18_0) and var_19_2()
	end) then
		existCall = var_3

		var_3(arg_18_1)

		return
	end

	var_0_0._PlayGuide(var_2.id, var_2.type, arg_18_1)

	return
end

function var_0_0.CheckOnShowInteraction(arg_20_0, arg_20_1)
	_ = var_1_10002

	if not var_1_10002.detect(var_0_0.interactionConfig, function(arg_21_0)
		local var_21_0 = arg_21_0.id
		local var_21_1 = arg_21_0.interactionId
		local var_21_2 = arg_21_0.condition

		pg = var_2_10004

		local var_21_3 = var_2_10004.NewStoryMgr.GetInstance()

		return not var_4.IsPlayed(var_21_3, var_21_0) and (var_21_1 == 0 or var_21_1 == arg_20_0) and var_21_2()
	end) then
		existCall = var_3

		var_3(arg_20_1)

		return
	end

	var_0_0._PlayGuide(var_2.id, var_2.type, arg_20_1)

	return
end

function var_0_0.CheckOnOpenPage(arg_22_0, arg_22_1)
	_ = var_1_10002

	if not var_1_10002.detect(var_0_0.pageConfig, function(arg_23_0)
		local var_23_0 = arg_23_0.id
		local var_23_1 = arg_23_0.page
		local var_23_2 = arg_23_0.condition

		pg = var_2_10004

		local var_23_3 = var_2_10004.NewStoryMgr.GetInstance()

		return not var_4.IsPlayed(var_23_3, var_23_0) and var_23_1 == arg_22_0 and var_23_2()
	end) then
		existCall = var_3

		var_3(arg_22_1)

		return
	end

	var_0_0._PlayGuide(var_2.id, var_2.type, arg_22_1)

	return
end

function var_0_0.CheckGuide(arg_24_0, arg_24_1, arg_24_2)
	pg = var_1_10003

	local var_24_0 = var_1_10003.NewStoryMgr.GetInstance()

	if var_3.IsPlayed(var_24_0, arg_24_0) then
		return
	end

	local var_24_1 = arg_24_1 or var_0_0.FINISH_TYPE.ON_BEGIN

	var_0_0._PlayGuide(arg_24_0, var_24_1, arg_24_2)

	return
end

function var_0_0.CheckGuideWithArgs(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	pg = var_1_10004

	local var_25_0 = var_1_10004.NewStoryMgr.GetInstance()

	if var_4.IsPlayed(var_25_0, arg_25_0) then
		return
	end

	local var_25_1 = arg_25_1 or var_0_0.FINISH_TYPE.ON_BEGIN

	var_0_0._PlayGuide(arg_25_0, var_25_1, arg_25_2, arg_25_3)

	return
end

function var_0_0._PlayGuide(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	LOCK_ISLAND_GUIDE = var_1_10004

	if var_1_10004 then
		if arg_26_2 then
			arg_26_2()
		end

		return
	end

	print = var_1_10004

	var_1_10004("GUIDE:..................." .. arg_26_0)

	pg = var_1_10004

	local var_26_0 = var_1_10004.SeriesGuideMgr.GetInstance()

	if var_4.isRunning(var_26_0) then
		existCall = var_4

		var_4(arg_26_2)

		return
	end

	pg = var_4

	local var_26_1 = var_4.NewGuideMgr.GetInstance()

	if not var_4.CanPlay(var_26_1) then
		existCall = var_26_3

		var_26_3(arg_26_2)

		return
	end

	local var_26_3

	if arg_26_1 and arg_26_1 == var_0_0.FINISH_TYPE.ON_BEGIN then
		pg = var_26_3

		local var_26_2 = var_26_3.m02

		var_26_3 = var_26_3.sendNotification
		GAME = var_6

		var_26_3(var_26_2, var_6.STORY_UPDATE, {
			storyId = arg_26_0
		})
	end

	_IslandCore = var_26_3

	if var_26_3 then
		_IslandCore = var_26_3

		local var_26_4 = var_26_3

		var_26_3 = var_26_3.Link
		ISLAND_EVT = var_6

		var_26_3(var_26_4, var_6.START_GUIDE)
	end

	pg = var_26_3

	local var_26_5 = var_26_3.NewGuideMgr.GetInstance()

	var_4.Play(var_26_5, arg_26_0, arg_26_3, function()
		_IslandCore = var_2_10000

		if var_2_10000 then
			_IslandCore = var_2_10000

			local var_27_0 = var_2_10000
			local var_27_1 = var_2_10000.Link

			ISLAND_EVT = var_2_10002

			var_27_1(var_27_0, var_2_10002.END_GUIDE)
		end

		if arg_26_1 and arg_26_1 == var_0_0.FINISH_TYPE.ON_END then
			pg = var_0

			local var_27_2 = var_0.m02
			local var_27_3 = var_0.sendNotification

			GAME = var_2_10002

			var_27_3(var_27_2, var_2_10002.STORY_UPDATE, {
				storyId = arg_26_0
			})
		end

		return
	end, arg_26_2, function(arg_28_0, arg_28_1)
		var_0_0.Record(arg_28_0, arg_28_1, arg_26_0)

		return
	end)

	return
end

function var_0_0.Record(arg_29_0, arg_29_1, arg_29_2)
	pg = var_1_10003

	local var_29_0 = var_1_10003.TimeMgr.GetInstance()
	local var_29_1 = var_3.GetServerTime(var_29_0) - arg_29_1

	pg = var_1_10005

	local var_29_2 = var_1_10005.GameTrackerMgr.GetInstance()
	local var_29_3 = var_5.Record

	GameTrackerBuilder = var_1_10007

	var_29_3(var_29_2, var_1_10007.BuildIslandGuide(arg_29_0, var_29_1, arg_29_2))

	return
end

return var_0_0
