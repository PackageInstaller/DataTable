local var_0_0 = {}

manager.net:Bind(49001, function(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.chess_map_list) do
		WarChessData:InitData(iter_1_1)
	end

	var_0_0.UpdateWarChessRedPoint()
end)
manager.net:Bind(49011, function(arg_2_0)
	local var_2_0 = cleanProtoTable(arg_2_0.attribute)
	local var_2_1 = arg_2_0.event_id

	if var_2_1 == 10202 then
		WarChessData:SetTemporaryData(ChessConst.TEMPORARY_KEY.TREASURE, var_2_0)
	elseif var_2_1 == 10205 then
		WarChessData:SetTemporaryData(ChessConst.TEMPORARY_KEY.DEBUFF, var_2_0)
	end
end)
manager.net:Bind(49023, function(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.chess_open_info_list) do
		var_3_0[iter_3_1.chapter_id] = iter_3_1.timestamp
	end

	if var_0_0.cdTimer_ then
		var_0_0.cdTimer_:Stop()

		var_0_0.cdTimer_ = nil
	end

	WarChessData:InitChessTime(var_3_0)

	var_0_0.cdTimer_ = Timer.New(function()
		for iter_4_0, iter_4_1 in pairs(var_3_0) do
			var_0_0.ChessOpen(iter_4_0, iter_4_1, var_3_0)
		end
	end, 1, -1)

	var_0_0.cdTimer_:Start()
end)
manager.notify:RegistListener(CHESS_BOX_OPEN, function(arg_5_0)
	if WarchessLevelCfg[arg_5_0].type == ActivityConst.SUMMER_CHESS_ISLAND then
		var_0_0.UpdateSummerChessPlotRedPoint()
	end
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_0.UpdateWarChessRedPoint()
end)

function var_0_0.ChessOpen(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = WarchessLevelCfg[arg_7_0]
	local var_7_1 = var_7_0.unlock_level

	if var_7_1 ~= 0 and ChessTools.GetChapterProgress(var_7_1) < var_7_0.success_progress then
		return
	end

	if arg_7_1 < manager.time:GetServerTime() then
		local var_7_2 = true

		if var_7_0.type ~= 0 then
			local var_7_3 = var_7_0.unlock_condition

			if var_7_3 ~= "" then
				if var_7_3[1] == 1 then
					local var_7_4 = StoryStageActivityData:GetStageData(var_7_3[2][1])[var_7_3[2][2]]

					if var_7_4 and var_7_4.clear_times >= 1 then
						-- block empty
					else
						var_7_2 = false
					end
				elseif var_7_3[1] == 2 then
					var_7_2 = ChapterTools.IsClearStage(var_7_3[2][2])
				end
			end
		end

		if var_7_2 then
			local var_7_5 = string.format("%s_%s_%s", RedPointConst.WAR_CHESS, var_7_0.tag, arg_7_0)

			if WarChessAction.GetChessLevelIsLock(arg_7_0) then
				manager.redPoint:setTip(var_7_5, 0)
			elseif not RedPointData:GetIsRedPointOpen(RedPointConst.WARCHESS_RANGE + arg_7_0) then
				manager.redPoint:setTip(var_7_5, 1)
			else
				manager.redPoint:setTip(var_7_5, 0)
			end

			arg_7_2[arg_7_0] = nil
		end
	end
end

function var_0_0.GetChessLevelIsLock(arg_8_0)
	local var_8_0 = WarchessLevelCfg[arg_8_0]
	local var_8_1 = var_8_0.unlock_level

	if var_8_1 ~= 0 and ChessTools.GetChapterProgress(var_8_1) < var_8_0.success_progress then
		return true
	end

	local var_8_2 = WarchessLevelCfg[arg_8_0].unlock_condition

	if var_8_2 ~= "" then
		if var_8_2[1] == 1 then
			local var_8_3 = StoryStageActivityData:GetStageData(var_8_2[2][1])[var_8_2[2][2]]

			if var_8_3 and var_8_3.clear_times >= 1 then
				-- block empty
			else
				return true
			end
		elseif var_8_2[1] == 2 then
			return not ChapterTools.IsClearStage(var_8_2[2][2])
		end
	end

	return false
end

function var_0_0.RequireWarChessInfo(arg_9_0)
	WarChessData:SetIsGoingWarChess(true)
	manager.net:SendWithLoadingNew(49002, {
		chapter_id = arg_9_0
	}, 49003, var_0_0.OnRequireWarChessInfo)
end

function var_0_0.OnRequireWarChessInfo(arg_10_0, arg_10_1)
	WarChessData:SetIsGoingWarChess(false)

	if isSuccess(arg_10_0.result) then
		WarChessData:SetWarChessData(arg_10_1.chapter_id, arg_10_0.map_info)
		var_0_0.EnterChessMap()
	else
		ShowTips(arg_10_0.result)
	end
end

function var_0_0.FireByPlayer(arg_11_0)
	manager.net:SendWithLoadingNew(49016, {}, 49017, function(arg_12_0, arg_12_1)
		var_0_0.OnFireByPlayer(arg_12_0, arg_12_1, arg_11_0)
	end)
end

function var_0_0.OnFireByPlayer(arg_13_0, arg_13_1, arg_13_2)
	if not isSuccess(arg_13_0.result) then
		ShowTips(arg_13_0.result)

		return
	end

	WarChessData:ModifyItemData(ChessConst.BULLET, -1)

	if arg_13_2 then
		arg_13_2()
	end
end

function var_0_0.EnterChessMap()
	local var_14_0 = GetChessDataForExcehange()
	local var_14_1 = WarChessData:GetCurrentWarChessMapData()

	var_14_0.mapId = var_14_1.mapId
	var_14_0.bronPos = Vector2(var_14_1.bronPos.x, var_14_1.bronPos.z)
	var_14_0.direction = var_14_1.direction
	var_14_0.GridConfig = WarchessHexCfg.AllGridConfig

	local var_14_2 = WarchessLevelCfg[var_14_0.mapId]
	local var_14_3 = MapConfig.New()

	var_14_3.mapId = var_14_0.mapId
	var_14_3.sceneId = var_14_2.scene_id
	var_14_3.minFreeLookX = var_14_2.freelook_range[1][1]
	var_14_3.maxFreeLookX = var_14_2.freelook_range[1][2]
	var_14_3.minFreeLookZ = var_14_2.freelook_range[2][1]
	var_14_3.maxFreeLookZ = var_14_2.freelook_range[2][2]
	var_14_3.modelName = var_14_2.model
	var_14_3.modelScale = tonumber(var_14_2.model_scale)
	var_14_0.MapConfig = var_14_3

	local var_14_4 = {}

	for iter_14_0, iter_14_1 in pairs(var_14_1.mapChangeInfo) do
		local var_14_5 = GridChangeData.New()

		var_14_5.tag = iter_14_1.tag
		var_14_5.x = iter_14_1.pos.x
		var_14_5.z = iter_14_1.pos.z
		var_14_5.status = iter_14_1.status
		var_14_5.rotationY = iter_14_1.direction * 60

		table.insert(var_14_4, var_14_5)
	end

	var_14_0.mapInfoS = var_14_4
	var_14_0.fogInfo = var_14_1.fogInfo

	local var_14_6 = {}

	if var_14_2.cache_asset and type(var_14_2.cache_asset) == "table" then
		for iter_14_2, iter_14_3 in ipairs(var_14_2.cache_asset) do
			local var_14_7 = CacheAssetInfo.New()

			var_14_7.assetPath = iter_14_3
			var_14_7.num = 1

			table.insert(var_14_6, var_14_7)
		end
	end

	var_14_0.cacheAssetS = var_14_6

	StartChessBattleMode()
end

local var_0_1

function var_0_0.RoleMoveByPath(arg_15_0, arg_15_1)
	var_0_1 = arg_15_1

	manager.net:SendWithLoadingNew(49004, {
		path = arg_15_0
	}, 49005, var_0_0.OnRoleMoveByPath)
end

function var_0_0.OnRoleMoveByPath(arg_16_0, arg_16_1)
	if var_0_1 then
		var_0_1(arg_16_0.result)
	end
end

local var_0_2

function var_0_0.TouchGrid(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	var_0_2 = arg_17_3

	manager.net:SendWithLoadingNew(49006, {
		pos = arg_17_0,
		param = arg_17_1,
		type = arg_17_2
	}, 49007, var_0_0.OnTouchGrid)
end

function var_0_0.OnTouchGrid(arg_18_0, arg_18_1)
	if isSuccess(arg_18_0.result) then
		manager.notify:CallUpdateFunc(TOUCH_GRID, arg_18_0, arg_18_1)
	end

	if var_0_2 then
		var_0_2()
	end
end

function var_0_0.SkipBattle(arg_19_0)
	manager.net:SendWithLoadingNew(49006, {
		param = 0,
		type = 1,
		pos = arg_19_0
	}, 49007, var_0_0.OnSkipBattle)
end

function var_0_0.OnSkipBattle(arg_20_0, arg_20_1)
	if not isSuccess(arg_20_0.result) then
		ShowTips(arg_20_0.result)
	end
end

function var_0_0.GetTreasure(arg_21_0, arg_21_1)
	manager.net:SendWithLoadingNew(49006, {
		type = 1,
		pos = arg_21_0,
		param = arg_21_1
	}, 49007, var_0_0.OnGetTreasure)
end

function var_0_0.OnGetTreasure(arg_22_0, arg_22_1)
	manager.notify:CallUpdateFunc(GET_TREASURE, arg_22_0, arg_22_1)
end

local var_0_3

function var_0_0.ForceBattle(arg_23_0, arg_23_1)
	var_0_3 = arg_23_1

	manager.net:SendWithLoadingNew(49006, {
		type = 1,
		pos = arg_23_0
	}, 49007, var_0_0.OnForceBattle)
end

function var_0_0.OnForceBattle(arg_24_0, arg_24_1)
	if var_0_3 then
		var_0_3()

		var_0_3 = nil
	end
end

function var_0_0.PurifyDeBuff(arg_25_0, arg_25_1)
	manager.net:SendWithLoadingNew(49006, {
		type = 1,
		pos = arg_25_0,
		param = arg_25_1
	}, 49007, var_0_0.OnPurifyDeBuff)
end

function var_0_0.OnPurifyDeBuff(arg_26_0, arg_26_1)
	manager.notify:CallUpdateFunc(PURIFY_DEBUFF, arg_26_0, arg_26_1)
end

function var_0_0.ReviveHero(arg_27_0, arg_27_1)
	manager.net:SendWithLoadingNew(49006, {
		type = 1,
		pos = arg_27_0,
		param = arg_27_1
	}, 49007, var_0_0.OnReviveHero)
end

function var_0_0.OnReviveHero(arg_28_0, arg_28_1)
	manager.notify:CallUpdateFunc(REVIVE_HERO, arg_28_0, arg_28_1)
end

function var_0_0.AddLog(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	WarChessData:AddLog(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
end

function var_0_0.AddAllHp(arg_30_0)
	WarChessData:AddAllHp(arg_30_0)
end

function var_0_0.FinishExplore()
	manager.net:SendWithLoadingNew(49008, {}, 49009, var_0_0.OnFinishExplore)
end

function var_0_0.OnFinishExplore(arg_32_0, arg_32_1)
	if isSuccess(arg_32_0.result) then
		WarChessData:SetCurrentChapter(0)
		WarChessData:RemoveCurrentActivity()
	else
		ShowTips(arg_32_0.result)
	end
end

function var_0_0.UpdateSummerChessPlotRedPoint()
	local var_33_0 = ActivityConst.SUMMER_CHESS_ISLAND

	if not ActivityData:GetActivityIsOpen(var_33_0) then
		return
	end

	local var_33_1, var_33_2 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.HELLA)
	local var_33_3 = var_33_1 / var_33_2
	local var_33_4 = ActivityCfg[var_33_0].activity_theme
	local var_33_5 = ActivityStoryCollect[var_33_4]

	for iter_33_0, iter_33_1 in pairs(var_33_5.story_id) do
		local var_33_6 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, var_33_4, iter_33_1)

		if var_33_3 >= var_33_5.unlock_value[iter_33_0] and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_PLOT_RANGE + iter_33_1) then
			manager.redPoint:setTip(var_33_6, 1)
		else
			manager.redPoint:setTip(var_33_6, 0)
		end
	end
end

function var_0_0.SetActivityChessPlotRedPoint(arg_34_0, arg_34_1)
	if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_PLOT_RANGE + arg_34_1) then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_PLOT_RANGE + arg_34_1)

		local var_34_0 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, arg_34_0, arg_34_1)

		manager.redPoint:setTip(var_34_0, 0)
	end
end

function var_0_0.CostShipHp(arg_35_0)
	WarChessData:CostShipHp(arg_35_0)
end

function var_0_0.SwitchShipControl(arg_36_0)
	manager.net:SendWithLoadingNew(49024, {
		type = arg_36_0
	}, 49025, var_0_0.OnSwitchShipControl)
end

function var_0_0.OnSwitchShipControl(arg_37_0, arg_37_1)
	if not isSuccess(arg_37_0.result) then
		ShowTips(arg_37_0.result)
	end
end

function var_0_0.UpdateWarChessRedPoint()
	local var_38_0 = PlayerData:GetPlayerInfo().userLevel
	local var_38_1 = ChapterClientCfg[404]

	if JumpTools.GetSystemLockedText(var_38_1.jump_system) then
		return
	end

	local var_38_2 = var_0_0.GetChapterList()
	local var_38_3 = false

	for iter_38_0, iter_38_1 in ipairs(var_38_2) do
		if var_38_0 >= (ChapterClientCfg[iter_38_1].level or 0) then
			if ChessTools.GetChapterProgress(iter_38_1) <= 100 and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_38_1) == nil then
				var_38_3 = true
			end

			if ChessTools.GetChapterProgress(iter_38_1) <= 0 and RedPointData:GetIsRedPointOpen(RedPointConst.WAR_CHESS_NEW_LEVEL + iter_38_1) == nil then
				manager.redPoint:setTip(RedPointConst.WAR_CHESS_NEW_LEVEL + iter_38_1, 1, RedPointStyle.SHOW_NEW_TAG)
			else
				manager.redPoint:setTip(RedPointConst.WAR_CHESS_NEW_LEVEL + iter_38_1, 0, RedPointStyle.SHOW_NEW_TAG)
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.WARCHESS, var_38_3 and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.CancelWarChessRedPoint()
	local var_39_0 = var_0_0.GetChapterList()
	local var_39_1 = PlayerData:GetPlayerInfo().userLevel

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		if var_39_1 >= (ChapterClientCfg[iter_39_1].level or 0) and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_39_1) == nil then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_39_1)
		end
	end

	manager.redPoint:setTip(RedPointConst.WARCHESS, 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.GetChapterList()
	return ChapterClientCfg[404].chapter_list
end

return var_0_0
