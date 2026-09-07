local IslandMainBtnTipHelper = class("IslandMainBtnTipHelper")

function IslandMainBtnTipHelper:IsTip()
	return switch(self, {
		map = function()
			return IslandMainBtnTipHelper.IsMapTip()
		end,
		device = function()
			return IslandMainBtnTipHelper.IsDeviceTip()
		end,
		mail = function()
			return IslandMainBtnTipHelper.IsMailTip()
		end,
		friend = function()
			return IslandMainBtnTipHelper.IsFriendTip()
		end,
		technology = function()
			return IslandMainBtnTipHelper.IsTechnologyTip()
		end,
		achievement = function()
			return IslandMainBtnTipHelper.IsAchievementTip()
		end,
		post_manage = function()
			return IslandMainBtnTipHelper.IsPostManageTip()
		end,
		book = function()
			return IslandMainBtnTipHelper.IsBookTip()
		end,
		season = function()
			return IslandMainBtnTipHelper.IsSeasonTip()
		end
	}, function()
		return false
	end)
end

function IslandMainBtnTipHelper.IsMapTip()
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

function IslandMainBtnTipHelper.IsDeviceTip()
	local var_13_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

	for iter_13_0, iter_13_1 in ipairs(pg.island_main_btns.get_id_list_by_main_type[2]) do
		if var_13_0:HasAbility(pg.island_main_btns[iter_13_1].ability_id) and IslandMainBtnTipHelper.IsTip(pg.island_main_btns[iter_13_1].btn_name) then
			return true
		end
	end

	return false
end

function IslandMainBtnTipHelper.IsMailTip()
	return getProxy(MailProxy):GetUnreadCount() > 0
end

function IslandMainBtnTipHelper.IsFriendTip()
	return getProxy(NotificationProxy):getRequestCount() > 0
end

function IslandMainBtnTipHelper.IsTechnologyTip()
	return getProxy(IslandProxy):GetIsland():GetTechnologyAgency():IsTip()
end

function IslandMainBtnTipHelper.IsAchievementTip()
	return getProxy(IslandProxy):GetIsland():GetAchievementAgency():IsTip()
end

function IslandMainBtnTipHelper.IsPostManageTip()
	return IslandMainBtnTipHelper.IsPostProdTip() or IslandMainBtnTipHelper.IsPostRestTip()
end

function IslandMainBtnTipHelper.IsPostProdTip()
	local var_19_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency()

	return underscore.any(pg.island_set.post_manage_produce.key_value_varchar, function(arg_20_0)
		local var_20_0 = var_19_0:GetBuilding(arg_20_0)

		return var_20_0 and var_20_0:IsPostTip()
	end)
end

function IslandMainBtnTipHelper.IsPostRestTip()
	local var_21_0 = getProxy(IslandProxy):GetIsland():GetManageAgency()

	return underscore.any(pg.island_set.post_manage_operate.key_value_varchar, function(arg_22_0)
		local var_22_0 = var_21_0:GetRestaurant(arg_22_0)

		return var_22_0 and var_22_0:IsPostTip()
	end)
end

function IslandMainBtnTipHelper.IsPostCollectionTip()
	local var_23_0 = getProxy(PlayerProxy)

	if var_23_0 == 0 then
		return true
	end

	return not pg.TimeMgr.GetInstance():IsSameDay(pg.TimeMgr.GetInstance():GetServerTime(), (PlayerPrefs.GetInt("IslandSignAutoCollectTime" .. tostring((var_23_0:getPlayerId())), 0)))
end

function IslandMainBtnTipHelper.IsBookTip()
	return getProxy(IslandProxy):GetIsland():GetBookAgency():IsTipFromTypes({
		IslandIllustration.TYPES.CHAR,
		IslandIllustration.TYPES.NPC,
		IslandIllustration.TYPES.ITEM,
		IslandIllustration.TYPES.FISH
	})
end

function IslandMainBtnTipHelper:IsUnlock()
	local var_25_0 = underscore.detect(pg.island_main_btns.all, function(arg_26_0)
		return pg.island_main_btns[arg_26_0].btn_name == self
	end)

	if not var_25_0 then
		return false
	end

	return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_main_btns[var_25_0].ability_id)
end

function IslandMainBtnTipHelper.IsSeasonTip()
	return IslandSeasonRedDotHelper.TipSeason()
end

return IslandMainBtnTipHelper
