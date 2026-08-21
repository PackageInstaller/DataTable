local var_0_0 = class("IslandMainBtnTipHelper")

function var_0_0.IsTip(arg_1_0)
	return switch(arg_1_0, {
		map = function()
			return var_0_0.IsMapTip()
		end,
		device = function()
			return var_0_0.IsDeviceTip()
		end,
		mail = function()
			return var_0_0.IsMailTip()
		end,
		friend = function()
			return var_0_0.IsFriendTip()
		end,
		technology = function()
			return var_0_0.IsTechnologyTip()
		end,
		achievement = function()
			return var_0_0.IsAchievementTip()
		end,
		post_manage = function()
			return var_0_0.IsPostManageTip()
		end,
		book = function()
			return var_0_0.IsBookTip()
		end,
		season = function()
			return var_0_0.IsSeasonTip()
		end
	}, function()
		return false
	end)
end

function var_0_0.IsMapTip()
	local var_12_0 = getProxy(IslandProxy):GetIsland()
	local var_12_1 = var_12_0:GetTaskAgency():GetTraceTask()

	if var_12_1 then
		local var_12_2 = tonumber((var_12_1:GetTraceParam()))

		if var_12_2 and var_12_0:GetMapId() ~= pg.island_world_objects[var_12_2].mapId then
			return true
		end
	end

	local var_12_3 = var_12_0:GetTaskAgency():GetMainTraceTask()

	if var_12_3 then
		local var_12_4 = tonumber((var_12_3:GetTraceParam()))

		if var_12_4 and var_12_0:GetMapId() ~= pg.island_world_objects[var_12_4].mapId then
			return true
		end
	end

	return false
end

function var_0_0.IsDeviceTip()
	local var_13_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

	for iter_13_0, iter_13_1 in ipairs(pg.island_main_btns.get_id_list_by_main_type[2]) do
		if var_13_0:HasAbility(pg.island_main_btns[iter_13_1].ability_id) and var_0_0.IsTip(pg.island_main_btns[iter_13_1].btn_name) then
			return true
		end
	end

	return false
end

function var_0_0.IsMailTip()
	local var_14_0 = getProxy(MailProxy)

	return var_14_0:GetUnreadCount() > 0
end

function var_0_0.IsFriendTip()
	local var_15_0 = getProxy(NotificationProxy)

	return var_15_0:getRequestCount() > 0
end

function var_0_0.IsTechnologyTip()
	return getProxy(IslandProxy):GetIsland():GetTechnologyAgency():IsTip()
end

function var_0_0.IsAchievementTip()
	return getProxy(IslandProxy):GetIsland():GetAchievementAgency():IsTip()
end

function var_0_0.IsPostManageTip()
	return var_0_0.IsPostProdTip() or var_0_0.IsPostRestTip()
end

function var_0_0.IsPostProdTip()
	local var_19_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency()

	return underscore.any(pg.island_set.post_manage_produce.key_value_varchar, function(arg_20_0)
		local var_20_0 = var_19_0:GetBuilding(arg_20_0)

		return var_20_0 and var_20_0:IsPostTip()
	end)
end

function var_0_0.IsPostRestTip()
	local var_21_0 = getProxy(IslandProxy):GetIsland():GetManageAgency()

	return underscore.any(pg.island_set.post_manage_operate.key_value_varchar, function(arg_22_0)
		local var_22_0 = var_21_0:GetRestaurant(arg_22_0)

		return var_22_0 and var_22_0:IsPostTip()
	end)
end

function var_0_0.IsPostCollectionTip()
	local var_23_9000
	local var_23_0 = getProxy(PlayerProxy)

	if var_23_0 == 0 then
		return true
	end

	local var_23_1 = pg.TimeMgr.GetInstance()

	return not pg.TimeMgr.GetInstance():IsSameDay(var_23_1:GetServerTime(), (PlayerPrefs.GetInt("IslandSignAutoCollectTime" .. tostring((var_23_0.getPlayerId(var_23_9000))), 0)))
end

function var_0_0.IsBookTip()
	return getProxy(IslandProxy):GetIsland():GetBookAgency():IsTipFromTypes({
		IslandIllustration.TYPES.CHAR,
		IslandIllustration.TYPES.NPC,
		IslandIllustration.TYPES.ITEM,
		IslandIllustration.TYPES.FISH
	})
end

function var_0_0.IsUnlock(arg_25_0)
	local var_25_0 = underscore.detect(pg.island_main_btns.all, function(arg_26_0)
		return pg.island_main_btns[arg_26_0].btn_name == arg_25_0
	end)

	if not var_25_0 then
		return false
	end

	return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_main_btns[var_25_0].ability_id)
end

function var_0_0.IsSeasonTip()
	return IslandSeasonRedDotHelper.TipSeason()
end

return var_0_0
