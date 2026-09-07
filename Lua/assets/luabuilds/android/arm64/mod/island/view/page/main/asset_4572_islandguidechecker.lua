local IslandGuideChecker = class("IslandGuideChecker")

IslandGuideChecker.MOVE_TASK_ID = 10001000
IslandGuideChecker.FIRST_TASK_ID = 10001010
IslandGuideChecker.ORDER_TASK_ID = 10001071
IslandGuideChecker.ORDER_TASK_PRE_ID = 10001070
IslandGuideChecker.ORDER_NEED_ITEMS = {
	{
		2700,
		1
	},
	{
		2800,
		1
	}
}
IslandGuideChecker.TECH_TASK_ID = 10001141
IslandGuideChecker.MAP_GUIDE_ABILITY_ID = 5004
IslandGuideChecker.INVITE_TASK_ID = 10001151
IslandGuideChecker.INVITE_TASK_PRE_ID = 10001150
IslandGuideChecker.MANAGE_ABILITY_ID = 26
IslandGuideChecker.MINING_ABILITY_ID = 2003
IslandGuideChecker.PASTIRE_ABILITY_ID = 2002
IslandGuideChecker.COMBP_ABILITY_ID = 29001
IslandGuideChecker.DAILY_TASK_ABILITY_ID = 30001
IslandGuideChecker.SIGNIN_STORY_NAME = "ISLAND1001032_1"
IslandGuideChecker.TECH_FIRST_ID = 100001
IslandGuideChecker.FISHING_TASK_ID = 3
IslandGuideChecker.PURCHASE_TRADE_TASK_ID = 20017002
IslandGuideChecker.SELL_TRADE_TASK_ID = 20017003
IslandGuideChecker.FINISH_TYPE = {
	ON_GUIDE = 2,
	ON_END = 3,
	ON_BEGIN = 1
}
IslandGuideChecker.loadedConfig = {
	{
		id = "ISLAND_GUIDE_2",
		mapId = 0,
		condition = function()
			return not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(IslandGuideChecker.MOVE_TASK_ID)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_GUIDE
	},
	{
		id = "ISLAND_GUIDE_25",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(IslandGuideChecker.MANAGE_ABILITY_ID)
		end,
		mapId = IslandConst.COFFEE_SHOP_MAP_ID,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	}
}
IslandGuideChecker.interactionConfig = {
	{
		id = "ISLAND_GUIDE_3",
		interactionId = 0,
		condition = function()
			return true
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_34",
		interactionId = 10020071,
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(IslandGuideChecker.FISHING_TASK_ID)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_END
	}
}
IslandGuideChecker.pageConfig = {
	{
		id = "ISLAND_GUIDE_5",
		page = "IslandUpgradeDisplayPage",
		condition = function()
			return true
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_6",
		page = "IslandMapPage",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(IslandGuideChecker.MAP_GUIDE_ABILITY_ID)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_8",
		page = "IslandTechnologyPage",
		condition = function()
			local var_7_0 = getProxy(IslandProxy):GetIsland()
			local var_7_1 = var_7_0:GetTechnologyAgency():GetTechnology(IslandGuideChecker.TECH_FIRST_ID):GetStatus()

			return var_7_0:GetTaskAgency():GetTask(IslandGuideChecker.TECH_TASK_ID) and (var_7_1 == IslandTechnology.STATUS.LOCK or var_7_1 == IslandTechnology.STATUS.UNLOCK or var_7_1 == IslandTechnology.STATUS.NORMAL)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_GUIDE
	},
	{
		id = "ISLAND_GUIDE_9",
		page = "IslandInvitePage",
		condition = function()
			local var_8_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

			return var_8_0:IsFinishTask(IslandGuideChecker.INVITE_TASK_PRE_ID) and not var_8_0:IsFinishTask(IslandGuideChecker.INVITE_TASK_ID)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_GUIDE
	},
	{
		id = "ISLAND_GUIDE_13",
		page = "Island3dTaskPage",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(IslandGuideChecker.DAILY_TASK_ABILITY_ID)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_21",
		page = "IslandShipOrderPage",
		condition = function()
			return true
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_23",
		page = "IslandBookPage",
		condition = function()
			return true
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_28",
		page = "IslandPhotoMainPage",
		condition = function()
			return true
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_29",
		page = "IslandFriendPage",
		condition = function()
			return true
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_31",
		page = "IslandMallDelegationPage",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(IslandGuideChecker.COMBP_ABILITY_ID)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_BEGIN
	},
	{
		id = "ISLAND_GUIDE_32",
		page = "IslandBookFishPage",
		condition = function()
			return true
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_END
	},
	{
		id = "ISLAND_GUIDE_41",
		page = "IslandTradePage",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(IslandGuideChecker.PURCHASE_TRADE_TASK_ID)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_END
	},
	{
		id = "ISLAND_GUIDE_42",
		page = "IslandTradePage",
		condition = function()
			return getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(IslandGuideChecker.SELL_TRADE_TASK_ID)
		end,
		type = IslandGuideChecker.FINISH_TYPE.ON_END
	}
}

function IslandGuideChecker:CheckOnLoaded(arg_18_1)
	local var_18_0 = _.detect(IslandGuideChecker.loadedConfig, function(arg_19_0)
		local var_19_0 = arg_19_0.mapId

		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_19_0.id) and (var_19_0 == 0 or var_19_0 == self) and arg_19_0.condition()
	end)

	if not var_18_0 then
		existCall(arg_18_1)

		return
	end

	IslandGuideChecker._PlayGuide(var_18_0.id, var_18_0.type, arg_18_1)

	return
end

function IslandGuideChecker:CheckOnShowInteraction(arg_20_1)
	local var_20_0 = _.detect(IslandGuideChecker.interactionConfig, function(arg_21_0)
		local var_21_0 = arg_21_0.interactionId

		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_21_0.id) and (var_21_0 == 0 or var_21_0 == self) and arg_21_0.condition()
	end)

	if not var_20_0 then
		existCall(arg_20_1)

		return
	end

	IslandGuideChecker._PlayGuide(var_20_0.id, var_20_0.type, arg_20_1)

	return
end

function IslandGuideChecker:CheckOnOpenPage(arg_22_1)
	local var_22_0 = _.detect(IslandGuideChecker.pageConfig, function(arg_23_0)
		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_23_0.id) and arg_23_0.page == self and arg_23_0.condition()
	end)

	if not var_22_0 then
		existCall(arg_22_1)

		return
	end

	IslandGuideChecker._PlayGuide(var_22_0.id, var_22_0.type, arg_22_1)

	return
end

function IslandGuideChecker:CheckGuide(arg_24_1, arg_24_2)
	if pg.NewStoryMgr.GetInstance():IsPlayed(self) then
		return
	end

	IslandGuideChecker:_PlayGuide(arg_24_1 or IslandGuideChecker.FINISH_TYPE.ON_BEGIN, arg_24_2)

	return
end

function IslandGuideChecker:CheckGuideWithArgs(arg_25_1, arg_25_2, arg_25_3)
	if pg.NewStoryMgr.GetInstance():IsPlayed(self) then
		return
	end

	IslandGuideChecker:_PlayGuide(arg_25_1 or IslandGuideChecker.FINISH_TYPE.ON_BEGIN, arg_25_2, arg_25_3)

	return
end

function IslandGuideChecker:_PlayGuide(arg_26_1, arg_26_2, arg_26_3)
	if LOCK_ISLAND_GUIDE then
		if arg_26_2 then
			arg_26_2()
		end

		return
	end

	print("GUIDE:..................." .. self)

	if pg.SeriesGuideMgr.GetInstance():isRunning() then
		existCall(arg_26_2)

		return
	end

	if not pg.NewGuideMgr.GetInstance():CanPlay() then
		existCall(arg_26_2)

		return
	end

	if arg_26_1 and arg_26_1 == IslandGuideChecker.FINISH_TYPE.ON_BEGIN then
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = self
		})
	end

	if _IslandCore then
		_IslandCore:Link(ISLAND_EVT.START_GUIDE)
	end

	pg.NewGuideMgr.GetInstance():Play(self, arg_26_3, function()
		if _IslandCore then
			_IslandCore:Link(ISLAND_EVT.END_GUIDE)
		end

		if arg_26_1 and arg_26_1 == IslandGuideChecker.FINISH_TYPE.ON_END then
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = self
			})
		end

		return
	end, arg_26_2, function(arg_28_0, arg_28_1)
		IslandGuideChecker.Record(arg_28_0, arg_28_1, self)

		return
	end)

	return
end

function IslandGuideChecker:Record(arg_29_1, arg_29_2)
	local var_29_0 = pg.TimeMgr.GetInstance()

	pg.GameTrackerMgr.GetInstance().Record(var_29_0, GameTrackerBuilder.BuildIslandGuide(self, var_29_0:GetServerTime() - arg_29_1, arg_29_2))

	return
end

return IslandGuideChecker
