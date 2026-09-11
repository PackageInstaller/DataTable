local var_0_0 = {
	EnterChessMap = function()
		NewChessTools.InitNewChessConfig()

		local var_1_0 = GetNewChessDataForExcehange()
		local var_1_1 = NewWarChessData:GetCurrentWarChessMapData()

		var_1_0.mapId = var_1_1.mapId
		var_1_0.bronPos = Vector2(var_1_1.bronPos.x, var_1_1.bronPos.z)
		var_1_0.direction = var_1_1.direction

		local var_1_2 = NewMapConfig.New()

		var_1_2.mapId = var_1_0.mapId
		var_1_2.sceneId = NewWarChessLevelCfg[var_1_0.mapId].scene_id
		var_1_2.minFreeLookX = NewWarChessLevelCfg[var_1_0.mapId].freelook_range[1][1]
		var_1_2.maxFreeLookX = NewWarChessLevelCfg[var_1_0.mapId].freelook_range[1][2]
		var_1_2.minFreeLookZ = NewWarChessLevelCfg[var_1_0.mapId].freelook_range[2][1]
		var_1_2.maxFreeLookZ = NewWarChessLevelCfg[var_1_0.mapId].freelook_range[2][2]
		var_1_2.modelName = NewWarChessLevelCfg[var_1_0.mapId].model
		var_1_2.modelScale = tonumber(NewWarChessLevelCfg[var_1_0.mapId].model_scale)
		var_1_0.MapConfig = var_1_2

		local var_1_3 = {}

		for iter_1_0, iter_1_1 in pairs(var_1_1.mapChangeInfo) do
			local var_1_4 = NewGridChangeData.New()

			var_1_4.tag = iter_1_1.tag
			var_1_4.x = iter_1_1.pos.x
			var_1_4.z = iter_1_1.pos.z
			var_1_4.rotationY = iter_1_1.direction * 60
			var_1_3[iter_1_0] = var_1_4
		end

		for iter_1_2, iter_1_3 in pairs(var_1_1.objectChangeInfo) do
			if var_1_3[iter_1_2] then
				var_1_3[iter_1_2].objecttag = iter_1_3.objecttag
				var_1_3[iter_1_2].objectRotationY = iter_1_3.objectdirection * 60
			else
				local var_1_5 = NewGridChangeData.New()

				var_1_5.tag = -1
				var_1_5.x = iter_1_3.pos.x
				var_1_5.z = iter_1_3.pos.z
				var_1_5.objecttag = iter_1_3.objecttag
				var_1_5.objectRotationY = iter_1_3.objectdirection * 60
				var_1_3[iter_1_2] = var_1_5
			end
		end

		local var_1_6 = {}

		for iter_1_4, iter_1_5 in pairs(var_1_3) do
			table.insert(var_1_6, iter_1_5)
		end

		var_1_0.mapInfoS = var_1_6
		var_1_0.fogInfo = var_1_1.fogInfo

		local var_1_7 = {}

		if NewWarChessLevelCfg[var_1_0.mapId].cache_asset and type(NewWarChessLevelCfg[var_1_0.mapId].cache_asset) == "table" then
			for iter_1_6, iter_1_7 in ipairs(NewWarChessLevelCfg[var_1_0.mapId].cache_asset) do
				local var_1_8 = NewCacheAssetInfo.New()

				var_1_8.assetPath = iter_1_7
				var_1_8.num = 1

				table.insert(var_1_7, var_1_8)
			end
		end

		var_1_0.cacheAssetS = var_1_7

		StartNewChessBattleMode()
	end
}

function var_0_0.RoleMoveByPos(arg_2_0, arg_2_1)
	manager.net:SendWithLoadingNew(80100, {
		next_pos = arg_2_0
	}, 80101, function(arg_3_0, arg_3_1)
		var_0_0.OnRoleMoveByPos(arg_3_0, arg_3_1, arg_2_1)
	end)
end

function var_0_0:OnRoleMoveByPos(arg_4_1, arg_4_2)
	if isSuccess(self.result) then
		if arg_4_2 then
			arg_4_2(true)
		end
	else
		ShowTips(self.result)

		if arg_4_2 then
			arg_4_2(false)
		end
	end
end

function var_0_0.OpenFogByPos(arg_5_0, arg_5_1, arg_5_2)
	manager.net:Push(80110, {
		central_pos = arg_5_0,
		fog = arg_5_1
	}, 80111, function(arg_6_0, arg_6_1)
		var_0_0.OnOpenFogByPos(arg_6_0, arg_6_1, arg_5_2)
	end)
end

function var_0_0:OnOpenFogByPos(arg_7_1, arg_7_2)
	if isSuccess(self.result) then
		if arg_7_2 then
			arg_7_2(true)
		end
	else
		ShowTips(self.result)

		if arg_7_2 then
			arg_7_2(false)
		end
	end
end

function var_0_0.EnterNewWarChess(arg_8_0)
	NewWarChessData:SetTemporaryData("CurEnterMapID", arg_8_0)
	manager.net:SendWithLoadingNew(80030, {
		chapter_id = arg_8_0
	}, 80031, var_0_0.OnEnterNewWarChess)
end

function var_0_0:OnEnterNewWarChess(arg_9_1)
	if isSuccess(self.result) then
		NewWarChessData:SetWarChessData(arg_9_1.chapter_id, self.map)
		var_0_0.EnterChessMap()
	else
		ShowTips(self.result)
	end

	NewWarChessData:SetTemporaryData("CurEnterMapID", nil)
end

manager.net:Bind(80051, function(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.choose_list) do
		table.insert(var_10_0, {
			chanceItemID = iter_10_1.id,
			state = iter_10_1.state,
			ispre = iter_10_1.is_pre
		})
	end

	NewWarChessData:SetChanceInfo(arg_10_0.chance_id, var_10_0)
end)
manager.net:Bind(80055, function(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.hero) do
		table.insert(var_11_0, {
			iter_11_1.id,
			iter_11_1.hp_ratio
		})
	end

	NewWarChessData:SetServerHeroList(var_11_0)
end)
manager.net:Bind(80057, function(arg_12_0)
	local var_12_0 = NewWarChessData:GetCurrentWarChessMapID()

	NewWarChessData:SetCurMapExploreValue(var_12_0, arg_12_0.exchange_point)

	if NewWarChessData:GetExploreValue(var_12_0) < 100 and arg_12_0.exchange_point >= 100 then
		ShowMessageBox({
			content = GetTips("ACTIVITY_NEW_WARCHESS_EXPLORE_MAX"),
			OkCallback = function()
				NewChessTools.ExitNewChessScene(false)
			end,
			BtnText = {
				"1",
				"2",
				"3"
			}
		})
	end

	var_0_0.UpdateNewWarChessExploreRewardRedPoint()
	manager.notify:CallUpdateFunc(NEWWARCHESS_EXPLOREVALUE_UPDATE, arg_12_0.exchange_point)
end)
manager.net:Bind(80059, function(arg_14_0)
	local var_14_0 = {
		timing = arg_14_0.event_pool.type,
		timingParams = cleanProtoTable(arg_14_0.event_pool.param),
		eventList = {}
	}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.event_pool.event_list) do
		local var_14_1 = {}

		for iter_14_2, iter_14_3 in ipairs(iter_14_1.event_pool) do
			if iter_14_2 == 1 then
				var_14_1.eventID = iter_14_3.integer
				var_14_1.params = {}

				table.insert(var_14_1.params, (cleanProtoTable(iter_14_1.params)))
			elseif iter_14_3.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.INT then
				table.insert(var_14_1.params, iter_14_3.integer)
			elseif iter_14_3.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.ARRAY then
				table.insert(var_14_1.params, (cleanProtoTable(iter_14_3.array)))
			elseif iter_14_3.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.ARRAY2 then
				local var_14_2 = {}

				for iter_14_4, iter_14_5 in ipairs(iter_14_3.array2) do
					table.insert(var_14_2, (cleanProtoTable(iter_14_5.array)))
				end

				table.insert(var_14_1.params, var_14_2)
			elseif iter_14_3.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.TYPEID_AND_EVENTINFO then
				local var_14_3 = {}

				for iter_14_6, iter_14_7 in ipairs(iter_14_3.array3) do
					local var_14_4 = {}

					table.insert(var_14_4, iter_14_7.integer)

					local var_14_5 = {}

					for iter_14_8, iter_14_9 in ipairs(iter_14_7.two_array) do
						table.insert(var_14_5, (cleanProtoTable(iter_14_9.array)))
					end

					table.insert(var_14_4, var_14_5)
					table.insert(var_14_3, var_14_4)
				end

				table.insert(var_14_1.params, var_14_3)
			elseif iter_14_3.type == NewChessConst.SERVER_SEND_EVENTPARAMS_TYPE.TYPEIDLIST_AND_EVENTINFO then
				local var_14_6 = {}

				for iter_14_10, iter_14_11 in ipairs(iter_14_3.array4) do
					local var_14_7 = {}
					local var_14_8 = {}

					for iter_14_12, iter_14_13 in ipairs(iter_14_11.list) do
						table.insert(var_14_8, iter_14_13)
					end

					table.insert(var_14_7, var_14_8)

					local var_14_9 = {}

					for iter_14_14, iter_14_15 in ipairs(iter_14_11.two_array) do
						table.insert(var_14_9, (cleanProtoTable(iter_14_15.array)))
					end

					table.insert(var_14_7, var_14_9)
					table.insert(var_14_6, var_14_7)
				end

				table.insert(var_14_1.params, var_14_6)
			end
		end

		table.insert(var_14_0.eventList, var_14_1)
	end

	NewWarChessData:AddServerEvent(var_14_0)
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0.UpdateNewWarChessTaskRedPoint()
end)

function var_0_0.ClickGrid(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	manager.net:SendWithLoadingNew(80102, {
		pos = {
			x = arg_16_0,
			z = arg_16_1
		},
		is_far = (arg_16_2 or nil) and 1
	}, 80103, function(arg_17_0, arg_17_1)
		var_0_0.OnClickGrid(arg_17_0, arg_17_1, arg_16_3)
	end)
end

function var_0_0:OnClickGrid(arg_18_1, arg_18_2)
	if isSuccess(self.result) then
		if arg_18_2 then
			arg_18_2()
		end
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.SelectChanceItem(arg_19_0, arg_19_1, arg_19_2)
	manager.net:SendWithLoadingNew(80104, {
		choose_id = arg_19_0,
		dice_list = arg_19_1
	}, 80105, function(arg_20_0, arg_20_1)
		var_0_0.OnSelectChanceItem(arg_20_0, arg_20_1, arg_19_2)
	end)
end

function var_0_0:OnSelectChanceItem(arg_21_1, arg_21_2)
	if isSuccess(self.result) then
		if arg_21_2 then
			arg_21_2()
		end
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.UseDiceSkill(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		table.insert(var_22_0, iter_22_1)
	end

	manager.net:SendWithLoadingNew(80106, {
		skill_id = arg_22_0,
		dice_list = var_22_0
	}, 80107, function(arg_23_0, arg_23_1)
		if isSuccess(arg_23_0.result) then
			var_0_0.OnUseDiceSkill(arg_23_0, arg_23_1, arg_22_2)

			local var_23_0 = {}

			if arg_23_0.dice_list then
				for iter_23_0, iter_23_1 in ipairs(arg_23_0.dice_list) do
					table.insert(var_23_0, iter_23_1)
				end
			end

			var_0_0.AddNewDice(var_23_0)
		else
			ShowTips(GetTips(arg_23_0.result))
		end
	end)
end

function var_0_0:OnUseDiceSkill(arg_24_1, arg_24_2)
	if isSuccess(self.result) then
		ShowTips("ACTIVITY_NEW_WARCHESS_USE_SKILL_SUCCESS")

		if arg_24_2 then
			arg_24_2()
		end
	else
		ShowTips(self.result)
	end
end

function var_0_0.FinishTask(arg_25_0, arg_25_1)
	manager.net:SendWithLoadingNew(80108, {
		task_id = arg_25_0
	}, 80109, function(arg_26_0, arg_26_1)
		var_0_0.OnFinishTask(arg_26_0, arg_26_1, arg_25_1)
	end)
end

function var_0_0:OnFinishTask(arg_27_1, arg_27_2)
	if isSuccess(self.result) then
		if arg_27_2 then
			arg_27_2()
		end
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.DiceToMovePoint(arg_28_0, arg_28_1)
	manager.net:SendWithLoadingNew(80112, {
		dice = arg_28_0
	}, 80113, function(arg_29_0, arg_29_1)
		var_0_0.OnDiceToMovePoint(arg_29_0, arg_29_1, arg_28_1)
	end)
end

function var_0_0:OnDiceToMovePoint(arg_30_1, arg_30_2)
	if isSuccess(self.result) then
		if arg_30_2 then
			arg_30_2()
		end
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0:AddNewDice()
	NewWarChessData:ReCacheDiceData()

	local var_31_0 = false

	for iter_31_0 = 1, #self do
		var_31_0 = var_0_0.AddSingleDice(self[iter_31_0])
	end

	if var_31_0 then
		ShowTips("ACTIVITY_NEW_WARCHESS_DICE_MAX")
	end

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function var_0_0.AddSingleDice(arg_32_0)
	local var_32_0 = NewWarChessData:CheckDiceNum()

	if var_32_0 then
		local var_32_1 = math.floor(arg_32_0 * (NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_TO_MOVE_POINT_TIMES") / 1000))

		NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", var_32_1)
		manager.NewChessManager:CreateTips({
			tipsType = NewChessConst.TIPS_TYPE.SWITCH,
			tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_TO_MOVEPOINT"), arg_32_0, var_32_1),
			tipsDiceNum = arg_32_0
		})
	else
		NewWarChessData:AddDice(arg_32_0)

		if manager.NewChessManager then
			manager.NewChessManager:CreateTips({
				tipsType = NewChessConst.TIPS_TYPE.DICE,
				tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_DICE"), arg_32_0),
				tipsDiceNum = arg_32_0
			})
		end
	end

	return var_32_0
end

manager.net:Bind(80060, function(arg_33_0)
	if manager.NewChessManager then
		local var_33_0 = {}

		for iter_33_0, iter_33_1 in ipairs(arg_33_0.global_event.event_pos) do
			table.insert(var_33_0, {
				iter_33_1.x,
				iter_33_1.z
			})
		end

		manager.NewChessManager.globalManager_:UpdateGlobalEventServerData(arg_33_0.global_event.global_event_id, arg_33_0.global_event.status, var_33_0)
	end
end)
manager.net:Bind(80115, function(arg_34_0)
	var_0_0.InitRedPoint()
	NewWarChessData:SetSystemServerData(arg_34_0)
	manager.notify:CallUpdateFunc(NEWWARCHESS_LEVEL_INFO_UPDATE)
	NewWarChessData:FixCurMapNewDayMovePoint()
	var_0_0.UpdateNewWarChessRedPoint()
end)

function var_0_0.GetActivityReward(arg_35_0, arg_35_1, arg_35_2)
	manager.net:SendWithLoadingNew(80116, {
		activity_id = arg_35_1,
		chapter_id = arg_35_0,
		value_list = arg_35_2
	}, 80117, function(arg_36_0, arg_36_1)
		if isSuccess(arg_36_0.result) then
			local var_36_0 = {}

			for iter_36_0, iter_36_1 in ipairs(arg_36_0.item_list) do
				table.insert(var_36_0, {
					iter_36_1.id,
					iter_36_1.num
				})
			end

			sortMergeGetReward(var_36_0)

			for iter_36_2, iter_36_3 in pairs(arg_35_2) do
				NewWarChessData:ReceiveReward(arg_35_0, iter_36_3)
			end

			var_0_0.UpdateNewWarChessExploreRewardRedPoint()
			manager.notify:Invoke(ACTIVITY_NEWWARCHESS_REWARD_UPDATE, arg_35_0, arg_35_2)
		else
			ShowTips(GetTips(arg_36_0.result))
		end
	end)
end

function var_0_0.InitRedPoint()
	for iter_37_0, iter_37_1 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.NEW_WARCHESS]) do
		if ActivityData:GetActivityIsOpen(iter_37_1) then
			local var_37_0 = {}

			for iter_37_2, iter_37_3 in pairs(ActivityCfg[iter_37_1].sub_activity_list) do
				table.insert(var_37_0, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. iter_37_3)
			end

			manager.redPoint:addGroup(RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. iter_37_1, var_37_0)
			manager.redPoint:addGroup(RedPointConst.NEW_WARCHESS .. "_" .. iter_37_1, {
				RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. iter_37_1,
				RedPointConst.NEW_WARCHESS_TASK_REWARD .. "_" .. iter_37_1,
				RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. iter_37_1
			})
		end
	end
end

function var_0_0.UpdateNewWarChessRedPoint()
	var_0_0.UpdateNewWarChessNewMapRedPoint()
	var_0_0.UpdateNewWarChessTaskRedPoint()
	var_0_0.UpdateNewWarChessExploreRewardRedPoint()
end

function var_0_0.UpdateNewWarChessNewMapRedPoint()
	for iter_39_0, iter_39_1 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.NEW_WARCHESS]) do
		if ActivityData:GetActivityIsOpen(iter_39_1) then
			local var_39_0 = false

			for iter_39_2, iter_39_3 in pairs(ActivityCfg[iter_39_1].sub_activity_list) do
				if NewWarChessLevelCfg.get_id_list_by_activity[iter_39_3] then
					if NewWarChessData:GetExploreValue(NewWarChessLevelCfg.get_id_list_by_activity[iter_39_3][1]) == 0 and NewWarChessData:GetLevelIsFinish(NewWarChessLevelCfg[NewWarChessLevelCfg.get_id_list_by_activity[iter_39_3][1]].front_level_id) == true then
						var_39_0 = true

						break
					end
				end
			end

			if var_39_0 then
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. iter_39_1, 1)
			else
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. iter_39_1, 0)
			end
		else
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. iter_39_1, 0)
		end
	end
end

function var_0_0.UpdateNewWarChessTaskRedPoint()
	for iter_40_0, iter_40_1 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.NEW_WARCHESS]) do
		if ActivityData:GetActivityIsOpen(iter_40_1) then
			if #TaskTools:GetCanGetActivityTaskList(iter_40_1) > 0 then
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_TASK_REWARD .. "_" .. iter_40_1, 1)
			else
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_TASK_REWARD .. "_" .. iter_40_1, 0)
			end
		else
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_TASK_REWARD .. "_" .. iter_40_1, 0)
		end
	end
end

function var_0_0.UpdateNewWarChessExploreRewardRedPoint()
	for iter_41_0, iter_41_1 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.NEW_WARCHESS]) do
		if ActivityData:GetActivityIsOpen(iter_41_1) then
			for iter_41_2, iter_41_3 in pairs(ActivityCfg[iter_41_1].sub_activity_list) do
				if ActivityData:GetActivityIsOpen(iter_41_3) then
					local var_41_0 = false
					local var_41_1 = NewWarChessData:GetExploreValue(NewWarChessLevelCfg.get_id_list_by_activity[iter_41_3][1])

					for iter_41_4, iter_41_5 in pairs(NewWarChessLevelCfg[NewWarChessLevelCfg.get_id_list_by_activity[iter_41_3][1]].explore) do
						if iter_41_5 <= var_41_1 and NewWarChessData:GetRewardIsGet(NewWarChessLevelCfg.get_id_list_by_activity[iter_41_3][1], iter_41_5) == false then
							var_41_0 = true

							break
						end
					end

					if var_41_0 then
						manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. iter_41_3, 1)
					else
						manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. iter_41_3, 0)
					end
				end
			end
		end
	end
end

return var_0_0
