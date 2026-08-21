local var_0_0 = class("IslandGuideChecker")

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
var_0_0.loadedConfig = {
	{
		id = "ISLAND_GUIDE_2",
		mapId = 0,
		condition = function()
			return not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(var_0_0.MOVE_TASK_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_GUIDE
	},
	{
		id = "ISLAND_GUIDE_25",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(var_0_0.MANAGE_ABILITY_ID)
		end,
		mapId = IslandConst.COFFEE_SHOP_MAP_ID,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	}
}
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
			return getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(var_0_0.FISHING_TASK_ID)
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
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(var_0_0.MAP_GUIDE_ABILITY_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_8",
		page = "IslandTechnologyPage",
		condition = function()
			local var_7_9000
			local var_7_0 = getProxy(IslandProxy)
			local var_7_1 = var_7_0.GetIsland(var_7_9000)
			local var_7_2 = var_7_1:GetTechnologyAgency().GetTechnology(var_7_0, var_0_0.TECH_FIRST_ID):GetStatus()

			return var_7_1:GetTaskAgency():GetTask(var_0_0.TECH_TASK_ID) and (var_7_2 == IslandTechnology.STATUS.LOCK or var_7_2 == IslandTechnology.STATUS.UNLOCK or var_7_2 == IslandTechnology.STATUS.NORMAL)
		end,
		type = var_0_0.FINISH_TYPE.ON_GUIDE
	},
	{
		id = "ISLAND_GUIDE_9",
		page = "IslandInvitePage",
		condition = function()
			local var_8_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

			return var_8_0:IsFinishTask(var_0_0.INVITE_TASK_PRE_ID) and not var_8_0:IsFinishTask(var_0_0.INVITE_TASK_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_GUIDE
	},
	{
		id = "ISLAND_GUIDE_13",
		page = "Island3dTaskPage",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(var_0_0.DAILY_TASK_ABILITY_ID)
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
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(var_0_0.COMBP_ABILITY_ID)
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
			return getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(var_0_0.PURCHASE_TRADE_TASK_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_END
	},
	{
		id = "ISLAND_GUIDE_42",
		page = "IslandTradePage",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(var_0_0.SELL_TRADE_TASK_ID)
		end,
		type = var_0_0.FINISH_TYPE.ON_END
	}
}

function var_0_0.CheckOnLoaded(arg_18_0, arg_18_1)
	local var_18_0 = _.detect(var_0_0.loadedConfig, function(arg_19_0)
		local var_19_0 = arg_19_0.mapId
		local var_19_2 = pg.NewStoryMgr.GetInstance()

		return not var_19_2:IsPlayed(arg_19_0.id) and (var_19_0 == 0 or var_19_0 == arg_18_0) and var_19_1()
	end)

	if not var_18_0 then
		existCall(arg_18_1)

		return
	end

	var_0_0._PlayGuide(var_18_0.id, var_18_0.type, arg_18_1)

	return
end

function var_0_0.CheckOnShowInteraction(arg_20_0, arg_20_1)
	local var_20_0 = _.detect(var_0_0.interactionConfig, function(arg_21_0)
		local var_21_0 = arg_21_0.interactionId
		local var_21_2 = pg.NewStoryMgr.GetInstance()

		return not var_21_2:IsPlayed(arg_21_0.id) and (var_21_0 == 0 or var_21_0 == arg_20_0) and var_21_1()
	end)

	if not var_20_0 then
		existCall(arg_20_1)

		return
	end

	var_0_0._PlayGuide(var_20_0.id, var_20_0.type, arg_20_1)

	return
end

function var_0_0.CheckOnOpenPage(arg_22_0, arg_22_1)
	local var_22_0 = _.detect(var_0_0.pageConfig, function(arg_23_0)
		local var_23_0 = arg_23_0.page
		local var_23_2 = pg.NewStoryMgr.GetInstance()

		return not var_23_2:IsPlayed(arg_23_0.id) and var_23_0 == arg_22_0 and var_23_1()
	end)

	if not var_22_0 then
		existCall(arg_22_1)

		return
	end

	var_0_0._PlayGuide(var_22_0.id, var_22_0.type, arg_22_1)

	return
end

function var_0_0.CheckGuide(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0

	if pg.NewStoryMgr.GetInstance():IsPlayed(arg_24_0) then
		do return end

		var_24_0 = var_0_0._PlayGuide
	end

	var_24_0(arg_24_0, arg_24_1 or var_0_0.FINISH_TYPE.ON_BEGIN, arg_24_2)

	return
end

function var_0_0.CheckGuideWithArgs(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0

	if pg.NewStoryMgr.GetInstance():IsPlayed(arg_25_0) then
		do return end

		var_25_0 = var_0_0._PlayGuide
	end

	var_25_0(arg_25_0, arg_25_1 or var_0_0.FINISH_TYPE.ON_BEGIN, arg_25_2, arg_25_3)

	return
end

function var_0_0._PlayGuide(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if LOCK_ISLAND_GUIDE then
		if arg_26_2 then
			arg_26_2()
		end

		return
	end

	print("GUIDE:..................." .. arg_26_0)

	if pg.SeriesGuideMgr.GetInstance():isRunning() then
		existCall(arg_26_2)

		return
	end

	local var_26_0 = pg.NewGuideMgr.GetInstance()

	if not var_26_0:CanPlay() then
		existCall(arg_26_2)

		return
	end

	if arg_26_1 and arg_26_1 == var_0_0.FINISH_TYPE.ON_BEGIN then
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_26_0
		})
	end

	if _IslandCore then
		_IslandCore:Link(ISLAND_EVT.START_GUIDE)
	end

	pg.NewGuideMgr.GetInstance():Play(arg_26_0, arg_26_3, function()
		if _IslandCore then
			_IslandCore:Link(ISLAND_EVT.END_GUIDE)
		end

		if arg_26_1 and arg_26_1 == var_0_0.FINISH_TYPE.ON_END then
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
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
	local var_29_9000
	local var_29_0 = pg.TimeMgr.GetInstance()

	pg.GameTrackerMgr.GetInstance().Record(var_29_0, GameTrackerBuilder.BuildIslandGuide(arg_29_0, var_29_0.GetServerTime(var_29_9000) - arg_29_1, arg_29_2))

	return
end

return var_0_0
