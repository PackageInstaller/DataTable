local var_0_0 = {}

manager.net:Bind(49001, function(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.chess_map_list) do
		WarChessData:InitData(iter_1_1)
	end

	var_0_0.UpdateWarChessRedPoint()
end)
manager.net:Bind(49011, function(arg_2_0)
	local var_2_0 = cleanProtoTable(arg_2_0.attribute)

	if arg_2_0.event_id == 10202 then
		WarChessData:SetTemporaryData(ChessConst.TEMPORARY_KEY.TREASURE, var_2_0)
	elseif arg_2_0.event_id == 10205 then
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
	if WarchessLevelCfg[arg_7_0].unlock_level ~= 0 and ChessTools.GetChapterProgress(WarchessLevelCfg[arg_7_0].unlock_level) < WarchessLevelCfg[arg_7_0].success_progress then
		return
	end

	if arg_7_1 < manager.time:GetServerTime() then
		local var_7_0 = true

		if WarchessLevelCfg[arg_7_0].type ~= 0 then
			if WarchessLevelCfg[arg_7_0].unlock_condition ~= "" then
				if WarchessLevelCfg[arg_7_0].unlock_condition[1] == 1 then
					local var_7_1 = StoryStageActivityData:GetStageData(WarchessLevelCfg[arg_7_0].unlock_condition[2][1])[WarchessLevelCfg[arg_7_0].unlock_condition[2][2]]

					if var_7_1 and var_7_1.clear_times >= 1 then
						-- block empty
					else
						var_7_0 = false
					end
				elseif WarchessLevelCfg[arg_7_0].unlock_condition[1] == 2 then
					var_7_0 = ChapterTools.IsClearStage(WarchessLevelCfg[arg_7_0].unlock_condition[2][2])
				end
			end
		end

		if var_7_0 then
			local var_7_2 = string.format("%s_%s_%s", RedPointConst.WAR_CHESS, WarchessLevelCfg[arg_7_0].tag, arg_7_0)

			if WarChessAction.GetChessLevelIsLock(arg_7_0) then
				manager.redPoint:setTip(var_7_2, 0)
			elseif not RedPointData:GetIsRedPointOpen(RedPointConst.WARCHESS_RANGE + arg_7_0) then
				manager.redPoint:setTip(var_7_2, 1)
			else
				manager.redPoint:setTip(var_7_2, 0)
			end

			arg_7_2[arg_7_0] = nil
		end
	end
end

function var_0_0.GetChessLevelIsLock(arg_8_0)
	if WarchessLevelCfg[arg_8_0].unlock_level ~= 0 and ChessTools.GetChapterProgress(WarchessLevelCfg[arg_8_0].unlock_level) < WarchessLevelCfg[arg_8_0].success_progress then
		return true
	end

	local var_8_0 = WarchessLevelCfg[arg_8_0].unlock_condition

	if WarchessLevelCfg[arg_8_0].unlock_condition ~= "" then
		if var_8_0[1] == 1 then
			local var_8_1 = StoryStageActivityData:GetStageData(var_8_0[2][1])[var_8_0[2][2]]

			if var_8_1 and var_8_1.clear_times >= 1 then
				-- block empty
			else
				return true
			end
		elseif var_8_0[1] == 2 then
			return not ChapterTools.IsClearStage(var_8_0[2][2])
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

function var_0_0:OnRequireWarChessInfo(arg_10_1)
	WarChessData:SetIsGoingWarChess(false)

	if isSuccess(self.result) then
		WarChessData:SetWarChessData(arg_10_1.chapter_id, self.map_info)
		var_0_0.EnterChessMap()
	else
		ShowTips(self.result)
	end
end

function var_0_0.FireByPlayer(arg_11_0)
	manager.net:SendWithLoadingNew(49016, {}, 49017, function(arg_12_0, arg_12_1)
		var_0_0.OnFireByPlayer(arg_12_0, arg_12_1, arg_11_0)
	end)
end

function var_0_0:OnFireByPlayer(arg_13_1, arg_13_2)
	if not isSuccess(self.result) then
		ShowTips(self.result)

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

	local var_14_2 = MapConfig.New()

	var_14_2.mapId = var_14_0.mapId
	var_14_2.sceneId = WarchessLevelCfg[var_14_0.mapId].scene_id
	var_14_2.minFreeLookX = WarchessLevelCfg[var_14_0.mapId].freelook_range[1][1]
	var_14_2.maxFreeLookX = WarchessLevelCfg[var_14_0.mapId].freelook_range[1][2]
	var_14_2.minFreeLookZ = WarchessLevelCfg[var_14_0.mapId].freelook_range[2][1]
	var_14_2.maxFreeLookZ = WarchessLevelCfg[var_14_0.mapId].freelook_range[2][2]
	var_14_2.modelName = WarchessLevelCfg[var_14_0.mapId].model
	var_14_2.modelScale = tonumber(WarchessLevelCfg[var_14_0.mapId].model_scale)
	var_14_0.MapConfig = var_14_2

	local var_14_3 = {}

	for iter_14_0, iter_14_1 in pairs(var_14_1.mapChangeInfo) do
		local var_14_4 = GridChangeData.New()

		var_14_4.tag = iter_14_1.tag
		var_14_4.x = iter_14_1.pos.x
		var_14_4.z = iter_14_1.pos.z
		var_14_4.status = iter_14_1.status
		var_14_4.rotationY = iter_14_1.direction * 60

		table.insert(var_14_3, var_14_4)
	end

	var_14_0.mapInfoS = var_14_3
	var_14_0.fogInfo = var_14_1.fogInfo

	local var_14_5 = {}

	if WarchessLevelCfg[var_14_0.mapId].cache_asset and type(WarchessLevelCfg[var_14_0.mapId].cache_asset) == "table" then
		for iter_14_2, iter_14_3 in ipairs(WarchessLevelCfg[var_14_0.mapId].cache_asset) do
			local var_14_6 = CacheAssetInfo.New()

			var_14_6.assetPath = iter_14_3
			var_14_6.num = 1

			table.insert(var_14_5, var_14_6)
		end
	end

	var_14_0.cacheAssetS = var_14_5

	StartChessBattleMode()
end

local var_0_1

function var_0_0.RoleMoveByPath(arg_15_0, arg_15_1)
	var_0_1 = arg_15_1

	manager.net:SendWithLoadingNew(49004, {
		path = arg_15_0
	}, 49005, var_0_0.OnRoleMoveByPath)
end

function var_0_0:OnRoleMoveByPath(arg_16_1)
	if var_0_1 then
		var_0_1(self.result)
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

function var_0_0:OnTouchGrid(arg_18_1)
	if isSuccess(self.result) then
		manager.notify:CallUpdateFunc(TOUCH_GRID, self, arg_18_1)
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

function var_0_0:OnSkipBattle(arg_20_1)
	if not isSuccess(self.result) then
		ShowTips(self.result)
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

function var_0_0:OnFinishExplore(arg_32_1)
	if isSuccess(self.result) then
		WarChessData:SetCurrentChapter(0)
		WarChessData:RemoveCurrentActivity()
	else
		ShowTips(self.result)
	end
end

function var_0_0.UpdateSummerChessPlotRedPoint()
	if not ActivityData:GetActivityIsOpen(ActivityConst.SUMMER_CHESS_ISLAND) then
		return
	end

	local var_33_0, var_33_1 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.HELLA)

	for iter_33_0, iter_33_1 in pairs(ActivityStoryCollect[ActivityCfg[ActivityConst.SUMMER_CHESS_ISLAND].activity_theme].story_id) do
		local var_33_2 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityCfg[ActivityConst.SUMMER_CHESS_ISLAND].activity_theme, iter_33_1)

		if var_33_0 / var_33_1 >= ActivityStoryCollect[ActivityCfg[ActivityConst.SUMMER_CHESS_ISLAND].activity_theme].unlock_value[iter_33_0] and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_PLOT_RANGE + iter_33_1) then
			manager.redPoint:setTip(var_33_2, 1)
		else
			manager.redPoint:setTip(var_33_2, 0)
		end
	end
end

function var_0_0.SetActivityChessPlotRedPoint(arg_34_0, arg_34_1)
	if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_PLOT_RANGE + arg_34_1) then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_PLOT_RANGE + arg_34_1)
		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, arg_34_0, arg_34_1), 0)
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

function var_0_0:OnSwitchShipControl(arg_37_1)
	if not isSuccess(self.result) then
		ShowTips(self.result)
	end
end

function var_0_0.UpdateWarChessRedPoint()
	local var_38_0 = PlayerData:GetPlayerInfo().userLevel
	local var_38_1

	if JumpTools.GetSystemLockedText(ChapterClientCfg[404].jump_system) then
		do return end

		var_38_1 = false
	end

	for iter_38_0, iter_38_1 in ipairs((var_0_0.GetChapterList())) do
		if (ChapterClientCfg[iter_38_1].level or 0) <= var_38_0 then
			if ChessTools.GetChapterProgress(iter_38_1) <= 100 and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_38_1) == nil then
				var_38_1 = true
			end

			if ChessTools.GetChapterProgress(iter_38_1) <= 0 and RedPointData:GetIsRedPointOpen(RedPointConst.WAR_CHESS_NEW_LEVEL + iter_38_1) == nil then
				manager.redPoint:setTip(RedPointConst.WAR_CHESS_NEW_LEVEL + iter_38_1, 1, RedPointStyle.SHOW_NEW_TAG)
			else
				manager.redPoint:setTip(RedPointConst.WAR_CHESS_NEW_LEVEL + iter_38_1, 0, RedPointStyle.SHOW_NEW_TAG)
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.WARCHESS, var_38_1 and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.CancelWarChessRedPoint()
	local var_39_0 = PlayerData:GetPlayerInfo().userLevel

	for iter_39_0, iter_39_1 in ipairs((var_0_0.GetChapterList())) do
		if (ChapterClientCfg[iter_39_1].level or 0) <= var_39_0 and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_39_1) == nil then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_39_1)
		end
	end

	manager.redPoint:setTip(RedPointConst.WARCHESS, 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.GetChapterList()
	return ChapterClientCfg[404].chapter_list
end

return var_0_0
