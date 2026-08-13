class = var_0_10000

local var_0_0 = var_0_10000("IslandMainBtnTipHelper")

function var_0_0.IsTip(arg_1_0)
	switch = var_1_10001

	return var_1_10001(arg_1_0, {
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
	getProxy = var_1_10000
	IslandProxy = var_1_10001

	local var_12_0 = var_1_10000(var_1_10001)
	local var_12_1 = var_0.GetIsland(var_12_0)
	local var_12_2 = var_0.GetTaskAgency(var_12_1)

	if var_1.GetTraceTask(var_12_2) then
		local var_12_3 = var_1
		local var_12_4 = var_1.GetTraceParam(var_12_3)

		tonumber = var_12_3

		if var_12_3(var_12_4) then
			local var_12_5 = var_0
			local var_12_6 = var_0.GetMapId(var_12_5)

			pg = var_12_5

			if var_12_6 ~= var_12_5.island_world_objects[var_3].mapId then
				return true
			end
		end
	end

	local var_12_7 = var_0:GetTaskAgency()

	if var_2.GetMainTraceTask(var_12_7) then
		local var_12_8 = var_2
		local var_12_9 = var_2.GetTraceParam(var_12_8)

		tonumber = var_12_8

		if var_12_8(var_12_9) then
			local var_12_10 = var_0
			local var_12_11 = var_0.GetMapId(var_12_10)

			pg = var_12_10

			if var_12_11 ~= var_12_10.island_world_objects[var_4].mapId then
				return true
			end
		end
	end

	return false
end

function var_0_0.IsDeviceTip()
	getProxy = var_1_10000
	IslandProxy = var_1_10001

	local var_13_0 = var_1_10000(var_1_10001)
	local var_13_1 = var_0.GetIsland(var_13_0)
	local var_13_2 = var_0.GetAblityAgency(var_13_1)

	ipairs = var_13_1
	pg = var_1_10002

	for iter_13_0, iter_13_1 in var_13_1(var_1_10002.island_main_btns.get_id_list_by_main_type[2]) do
		pg = var_1_10006

		local var_13_3 = var_1_10006.island_main_btns[iter_13_1].btn_name
		local var_13_4 = var_1_10006.ability_id

		if var_13_2:HasAbility(var_13_4) and var_0_0.IsTip(var_13_3) then
			return true
		end
	end

	return false
end

function var_0_0.IsMailTip()
	getProxy = var_1_10000
	MailProxy = var_1_10001

	local var_14_0 = var_1_10000(var_1_10001)

	return var_0.GetUnreadCount(var_14_0) > 0
end

function var_0_0.IsFriendTip()
	getProxy = var_1_10000
	NotificationProxy = var_1_10001

	local var_15_0 = var_1_10000(var_1_10001)

	return var_0.getRequestCount(var_15_0) > 0
end

function var_0_0.IsTechnologyTip()
	getProxy = var_1_10000
	IslandProxy = var_1_10001

	local var_16_0 = var_1_10000(var_1_10001)
	local var_16_1 = var_0.GetIsland(var_16_0)
	local var_16_2 = var_0.GetTechnologyAgency(var_16_1)

	return var_0.IsTip(var_16_2)
end

function var_0_0.IsAchievementTip()
	getProxy = var_1_10000
	IslandProxy = var_1_10001

	local var_17_0 = var_1_10000(var_1_10001)
	local var_17_1 = var_0.GetIsland(var_17_0)
	local var_17_2 = var_0.GetAchievementAgency(var_17_1)

	return var_0.IsTip(var_17_2)
end

function var_0_0.IsPostManageTip()
	local var_18_0

	if not var_0_0.IsPostProdTip() then
		var_18_0 = var_0_0.IsPostRestTip()
	end

	return var_18_0
end

function var_0_0.IsPostProdTip()
	pg = var_1_10000

	local var_19_0 = var_1_10000.island_set.post_manage_produce.key_value_varchar

	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_19_1 = var_1_10001(var_1_10002)
	local var_19_2 = var_1.GetIsland(var_19_1)
	local var_19_3 = var_1.GetBuildingAgency(var_19_2)

	underscore = var_19_2

	return var_19_2.any(var_19_0, function(arg_20_0)
		local var_20_0 = var_19_3
		local var_20_1

		var_20_1 = var_1.GetBuilding(var_20_0, arg_20_0) and var_1:IsPostTip()

		return var_20_1
	end)
end

function var_0_0.IsPostRestTip()
	pg = var_1_10000

	local var_21_0 = var_1_10000.island_set.post_manage_operate.key_value_varchar

	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_21_1 = var_1_10001(var_1_10002)
	local var_21_2 = var_1.GetIsland(var_21_1)
	local var_21_3 = var_1.GetManageAgency(var_21_2)

	underscore = var_21_2

	return var_21_2.any(var_21_0, function(arg_22_0)
		local var_22_0 = var_21_3
		local var_22_1

		var_22_1 = var_1.GetRestaurant(var_22_0, arg_22_0) and var_1:IsPostTip()

		return var_22_1
	end)
end

function var_0_0.IsPostCollectionTip()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_23_0 = var_1_10000(var_1_10001)
	local var_23_1 = var_0.getPlayerId(var_23_0)
	local var_23_2 = "IslandSignAutoCollectTime"

	tostring = var_1_10002

	local var_23_3 = var_23_2 .. var_1_10002(var_23_1)

	PlayerPrefs = var_2

	if var_2.GetInt(var_23_3, 0) == 0 then
		return true
	end

	pg = var_3

	local var_23_4 = var_3.TimeMgr.GetInstance()
	local var_23_5 = var_3.GetServerTime(var_23_4)

	pg = var_23_4

	local var_23_6 = var_23_4.TimeMgr.GetInstance()

	return not var_4.IsSameDay(var_23_6, var_23_5, var_2)
end

function var_0_0.IsBookTip()
	getProxy = var_1_10000
	IslandProxy = var_1_10001

	local var_24_0 = var_1_10000(var_1_10001)
	local var_24_1 = var_0.GetIsland(var_24_0)
	local var_24_2 = var_0.GetBookAgency(var_24_1)
	local var_24_3 = var_0.IsTipFromTypes
	local var_24_4 = {}

	IslandIllustration = var_1_10003
	var_24_4[1] = var_1_10003.TYPES.CHAR
	IslandIllustration = var_3
	var_24_4[2] = var_3.TYPES.NPC
	IslandIllustration = var_3
	var_24_4[3] = var_3.TYPES.ITEM
	IslandIllustration = var_3
	var_24_4[4] = var_3.TYPES.FISH

	return var_24_3(var_24_2, var_24_4)
end

function var_0_0.IsUnlock(arg_25_0)
	underscore = var_1_10001

	local var_25_0 = var_1_10001.detect

	pg = var_1_10002

	if not var_25_0(var_1_10002.island_main_btns.all, function(arg_26_0)
		pg = var_2_10001

		return var_2_10001.island_main_btns[arg_26_0].btn_name == arg_25_0
	end) then
		return false
	end

	pg = var_2

	local var_25_1 = var_2.island_main_btns[var_1].ability_id

	getProxy = var_3
	IslandProxy = var_1_10004

	local var_25_2 = var_3(var_1_10004)
	local var_25_3 = var_3.GetIsland(var_25_2)
	local var_25_4 = var_3.GetAblityAgency(var_25_3)

	return var_3.HasAbility(var_25_4, var_25_1)
end

function var_0_0.IsSeasonTip()
	IslandSeasonRedDotHelper = var_1_10000

	return var_1_10000.TipSeason()
end

return var_0_0
