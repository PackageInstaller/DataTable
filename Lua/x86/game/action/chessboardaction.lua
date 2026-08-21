local var_0_0 = {
	EnterChessMap = function()
		ChessBoardTools.InitChessBoardConfig()

		local var_1_0 = GetChessBoardDataForExcehange()
		local var_1_1 = ChessBoardData:GetCurrentChessBoardMapData()

		var_1_0.mapId = var_1_1.mapId
		var_1_0.bronPos = Vector2(var_1_1.heroInfos.pos.x, var_1_1.heroInfos.pos.z)
		var_1_0.direction = var_1_1.heroInfos.dir

		local var_1_2 = ChessBoardLevelCfg[var_1_0.mapId]
		local var_1_3 = MapConfig.New()

		var_1_3.mapId = var_1_0.mapId
		var_1_3.sceneId = var_1_2.scene_id
		var_1_3.minFreeLookX = var_1_2.freelook_range[1][1]
		var_1_3.maxFreeLookX = var_1_2.freelook_range[1][2]
		var_1_3.minFreeLookZ = var_1_2.freelook_range[2][1]
		var_1_3.maxFreeLookZ = var_1_2.freelook_range[2][2]
		var_1_3.modelName = var_1_2.model
		var_1_3.modelScale = tonumber(var_1_2.model_scale)
		var_1_0.MapConfig = var_1_3

		local var_1_4 = {}

		for iter_1_0, iter_1_1 in pairs(var_1_1.mapChangeInfo) do
			local var_1_5 = ChessBoardGirdChangeData.New()

			var_1_5.x = iter_1_1.pos.x
			var_1_5.z = iter_1_1.pos.z
			var_1_5.tag = iter_1_1.tag
			var_1_5.rotationY = iter_1_1.rotationY * 60

			table.insert(var_1_4, var_1_5)
		end

		local var_1_6 = {}

		for iter_1_2, iter_1_3 in pairs(var_1_1.thingChangeInfo) do
			local var_1_7 = ChessBoardThingChangeData.New()

			var_1_7.x = iter_1_3.pos.x
			var_1_7.z = iter_1_3.pos.z
			var_1_7.thingtag = iter_1_3.thingtag
			var_1_7.thingRotationY = iter_1_3.thingRotationY * 60

			table.insert(var_1_6, var_1_7)
		end

		local var_1_8 = {}

		for iter_1_4, iter_1_5 in pairs(var_1_1.banDirChangeInfo) do
			local var_1_9 = ChessBoardBanDirChangeData.New()

			var_1_9.x = iter_1_5.pos.x
			var_1_9.z = iter_1_5.pos.z
			var_1_9.banDir = {
				false,
				false,
				false,
				false,
				false,
				false
			}
			var_1_9.banDirIsHide = {
				false,
				false,
				false,
				false,
				false,
				false
			}

			for iter_1_6, iter_1_7 in pairs(iter_1_5.banDirList) do
				var_1_9.banDir[iter_1_7.dir] = true
				var_1_9.banDirIsHide[iter_1_7.isHide] = true
			end

			table.insert(var_1_8, var_1_9)
		end

		local var_1_10 = {}

		for iter_1_8, iter_1_9 in pairs(var_1_1.NPCInfoList) do
			local var_1_11 = ChessBoardNPCData.New()

			var_1_11.entityID = iter_1_9.id
			var_1_11.x = iter_1_9.pos.x
			var_1_11.z = iter_1_9.pos.z
			var_1_11.dir = iter_1_9.dir
			var_1_11.prefab = ChessBoardNPCPoolCfg[iter_1_9.typeID].prefab

			table.insert(var_1_10, var_1_11)
		end

		var_1_0.mapInfoS = var_1_4
		var_1_0.thingInfoS = var_1_6
		var_1_0.banDirInfoS = var_1_8
		var_1_0.NPCInfos = var_1_10

		StartChessBoardBattleMode()
	end
}

function var_0_0.EnterChessBoard(arg_2_0)
	ChessBoardData:SetTemporaryData("CurEnterMapID", arg_2_0)
	manager.net:SendWithLoadingNew(85000, {
		chapter_id = arg_2_0
	}, 85001, var_0_0.OnEnterChessBoard)
end

function var_0_0.OnEnterChessBoard(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		ChessBoardData:SetChessBoardData(arg_3_1.chapter_id, arg_3_0.map)
		var_0_0.EnterChessMap()
	else
		ShowTips(arg_3_0.result)
	end

	ChessBoardData:SetTemporaryData("CurEnterMapID", nil)
end

manager.net:Bind(85031, function(arg_4_0)
	local var_4_0 = {
		timing = arg_4_0.event.trigger_type,
		timingParams = cleanProtoTable(arg_4_0.event.trigger_type_param),
		playerA = arg_4_0.event.trigger_player_a,
		playerB = arg_4_0.event.trigger_player_b,
		eventList = {}
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.event.event_list) do
		local var_4_1 = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1.event) do
			if iter_4_2 == 1 then
				var_4_1.eventID = iter_4_3.integer
				var_4_1.params = {}

				local var_4_2 = cleanProtoTable(iter_4_1.params)

				var_4_2.playerA = var_4_0.playerA
				var_4_2.playerB = var_4_0.playerB

				table.insert(var_4_1.params, var_4_2)
			elseif iter_4_3.type == ChessBoardConst.SERVER_SEND_EVENTPARAMS_TYPE.INT then
				table.insert(var_4_1.params, iter_4_3.integer)
			elseif iter_4_3.type == ChessBoardConst.SERVER_SEND_EVENTPARAMS_TYPE.ARRAY then
				local var_4_3 = cleanProtoTable(iter_4_3.array)

				table.insert(var_4_1.params, var_4_3)
			elseif iter_4_3.type == ChessBoardConst.SERVER_SEND_EVENTPARAMS_TYPE.ARRAY2 then
				local var_4_4 = {}

				for iter_4_4, iter_4_5 in ipairs(iter_4_3.array2) do
					local var_4_5 = cleanProtoTable(iter_4_5.array)

					table.insert(var_4_4, var_4_5)
				end

				table.insert(var_4_1.params, var_4_4)
			elseif iter_4_3.type == ChessBoardConst.SERVER_SEND_EVENTPARAMS_TYPE.TYPEID_AND_EVENTINFO then
				local var_4_6 = {}

				for iter_4_6, iter_4_7 in ipairs(iter_4_3.array3) do
					local var_4_7 = {}

					table.insert(var_4_7, iter_4_7.integer)

					local var_4_8 = {}

					for iter_4_8, iter_4_9 in ipairs(iter_4_7.two_array) do
						local var_4_9 = cleanProtoTable(iter_4_9.array)

						table.insert(var_4_8, var_4_9)
					end

					table.insert(var_4_7, var_4_8)
					table.insert(var_4_6, var_4_7)
				end

				table.insert(var_4_1.params, var_4_6)
			elseif iter_4_3.type == ChessBoardConst.SERVER_SEND_EVENTPARAMS_TYPE.TYPEIDLIST_AND_EVENTINFO then
				local var_4_10 = {}

				for iter_4_10, iter_4_11 in ipairs(iter_4_3.array4) do
					local var_4_11 = {}
					local var_4_12 = {}

					for iter_4_12, iter_4_13 in ipairs(iter_4_11.list) do
						table.insert(var_4_12, iter_4_13)
					end

					table.insert(var_4_11, var_4_12)

					local var_4_13 = {}

					for iter_4_14, iter_4_15 in ipairs(iter_4_11.two_array) do
						local var_4_14 = cleanProtoTable(iter_4_15.array)

						table.insert(var_4_13, var_4_14)
					end

					table.insert(var_4_11, var_4_13)
					table.insert(var_4_10, var_4_11)
				end

				table.insert(var_4_1.params, var_4_10)
			end
		end

		table.insert(var_4_0.eventList, var_4_1)
	end

	ChessBoardData:AddServerEvent(var_4_0)
end)
manager.net:Bind(85033, function(arg_5_0)
	local var_5_0 = {
		chanceID = arg_5_0.chance.chance_id,
		isUnLock = arg_5_0.chance.is_unlock,
		chancePropList = cleanProtoTable(arg_5_0.chance.item_list),
		chanceChooseList = cleanProtoTable(arg_5_0.chance.choose_list)
	}

	manager.ChessBoardManager:SetChanceServerData(var_5_0)
end)
manager.net:Bind(85035, function(arg_6_0)
	ChessBoardData:SetSystemServerData(arg_6_0)
end)

function var_0_0.HeroWantToMoveByPos(arg_7_0, arg_7_1)
	local var_7_0 = {
		next_pos = arg_7_0
	}

	manager.net:SendWithLoadingNew(85010, var_7_0, 85011, function(arg_8_0, arg_8_1)
		var_0_0.OnHeroWantToMoveByPos(arg_8_0, arg_8_1, arg_7_1)
	end)
end

function var_0_0.OnHeroWantToMoveByPos(arg_9_0, arg_9_1, arg_9_2)
	if isSuccess(arg_9_0.result) then
		if manager.ChessBoardManager and arg_9_2 then
			arg_9_2()
		end
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.HeroRollDice(arg_10_0)
	manager.net:SendWithLoadingNew(85012, {}, 85013, function(arg_11_0, arg_11_1)
		var_0_0.OnHeroRollDice(arg_11_0, arg_11_1, arg_10_0)
	end)
end

function var_0_0.OnHeroRollDice(arg_12_0, arg_12_1, arg_12_2)
	if isSuccess(arg_12_0.result) then
		if arg_12_2 then
			local var_12_0 = cleanProtoTable(arg_12_0.dice_list)

			arg_12_2(var_12_0)
		end
	else
		ShowTips(arg_12_0.result)
	end
end

function var_0_0.RollChanceDice(arg_13_0)
	manager.net:SendWithLoadingNew(85038, {}, 85039, function(arg_14_0, arg_14_1)
		var_0_0.OnRollChanceDice(arg_14_0, arg_14_1, arg_13_0)
	end)
end

function var_0_0.OnRollChanceDice(arg_15_0, arg_15_1, arg_15_2)
	if isSuccess(arg_15_0.result) then
		if arg_15_2 then
			local var_15_0 = cleanProtoTable(arg_15_0.dice_list)
			local var_15_1 = arg_15_0.total_cnt

			arg_15_2(var_15_0, {
				curAuraDiceNum = var_15_1
			})
		end
	else
		ShowTips(arg_15_0.result)
	end
end

function var_0_0.HeroMoveEnd(arg_16_0)
	manager.ChessBoardManager:SendTmpPropToServer(nil, function()
		manager.net:SendWithLoadingNew(85014, {}, 85015, function(arg_18_0, arg_18_1)
			var_0_0.OnHeroMoveEnd(arg_18_0, arg_18_1, arg_16_0)
		end)
	end)
end

function var_0_0.OnHeroMoveEnd(arg_19_0, arg_19_1, arg_19_2)
	if isSuccess(arg_19_0.result) then
		if manager.ChessBoardManager then
			manager.ChessBoardManager.NPCManager_:SetNPCMoveListServerData(arg_19_0.npc_path_list)

			if arg_19_2 then
				arg_19_2()
			end
		end
	else
		ShowTips(arg_19_0.result)
	end
end

function var_0_0.UseProp(arg_20_0, arg_20_1, arg_20_2)
	if manager.ChessBoardManager:GetIsArenaChance() then
		if manager.ChessBoardManager:GetCurChanceInfo().chanceChooseList[3] > 0 then
			ShowTips("CHESSBOARD_TURN_USED_PROP")

			return
		end
	elseif manager.ChessBoardManager.heroEntity_:GetCurUsedPropID() > 0 then
		ShowTips("CHESSBOARD_TURN_USED_PROP")

		return
	end

	arg_20_1 = arg_20_1 or {}

	manager.net:SendWithLoadingNew(85016, {
		prop_id = arg_20_0,
		params = arg_20_1
	}, 85017, function(arg_21_0, arg_21_1)
		var_0_0.OnUseProp(arg_21_0, arg_21_1, arg_20_2)
	end)
end

function var_0_0.OnUseProp(arg_22_0, arg_22_1, arg_22_2)
	if isSuccess(arg_22_0.result) then
		if manager.ChessBoardManager then
			if arg_22_2 then
				arg_22_2()
			end

			manager.ChessBoardManager:RemoveHeroProp(arg_22_1.prop_id)
		end
	else
		ShowTips(arg_22_0.result)
	end
end

function var_0_0.UnlockChance(arg_23_0, arg_23_1)
	manager.net:SendWithLoadingNew(85020, {
		chance_id = arg_23_0
	}, 85021, function(arg_24_0, arg_24_1)
		var_0_0.OnUnlockChance(arg_24_0, arg_24_1, arg_23_1)
	end)
end

function var_0_0.OnUnlockChance(arg_25_0, arg_25_1, arg_25_2)
	if isSuccess(arg_25_0.result) then
		if manager.ChessBoardManager then
			manager.ChessBoardManager:UnlockChance(arg_25_1.chance_id)

			if arg_25_2 then
				arg_25_2()
			end
		end
	else
		ShowTips(arg_25_0.result)
	end
end

function var_0_0.FinishChance(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	manager.net:SendWithLoadingNew(85022, {
		chance_id = arg_26_0,
		result = arg_26_1,
		score = arg_26_2
	}, 85023, function(arg_27_0, arg_27_1)
		var_0_0.OnFinishChance(arg_27_0, arg_27_1, arg_26_3)
	end)
end

function var_0_0.OnFinishChance(arg_28_0, arg_28_1, arg_28_2)
	if isSuccess(arg_28_0.result) then
		if manager.ChessBoardManager then
			if arg_28_2 then
				arg_28_2()
			end

			local var_28_0 = ChessBoardChanceCfg[arg_28_1.chance_id]
			local var_28_1 = true

			if var_28_0.type == ChessBoardConst.CHANCE_TYPE.QTE then
				local var_28_2 = ChessBoardData:GetCurrentChessBoardMapData().heroInfos.tmp_item

				if var_28_2 and #var_28_2 > 0 then
					var_28_1 = false
				end
			end

			if var_28_1 then
				manager.ChessBoardManager:FinishChance(arg_28_1.chance_id, arg_28_1.result, arg_28_1.score)
			end
		end
	else
		ShowTips(arg_28_0.result)
	end
end

function var_0_0.GetSelectProp(arg_29_0, arg_29_1, arg_29_2)
	arg_29_1 = arg_29_1 or 0

	manager.net:SendWithLoadingNew(85024, {
		prop_id = arg_29_0,
		replace_prop_id = arg_29_1
	}, 85025, function(arg_30_0, arg_30_1)
		var_0_0.OnGetSelectProp(arg_30_0, arg_30_1, arg_29_2)
	end)
end

function var_0_0.OnGetSelectProp(arg_31_0, arg_31_1, arg_31_2)
	if isSuccess(arg_31_0.result) then
		if manager.ChessBoardManager and arg_31_2 then
			arg_31_2()
		end
	else
		ShowTips(arg_31_0.result)
	end
end

function var_0_0.GiveUpProp(arg_32_0)
	manager.net:SendWithLoadingNew(85036, {
		prop_id = arg_32_0
	}, 85037, function(arg_33_0, arg_33_1)
		var_0_0.OnGiveUpProp(arg_33_0, arg_33_1, callBack)
	end)
end

function var_0_0.OnGiveUpProp(arg_34_0, arg_34_1, arg_34_2)
	if isSuccess(arg_34_0.result) then
		if arg_34_2 then
			arg_34_2()
		end
	else
		ShowTips(arg_34_0.result)
	end
end

function var_0_0.BuyShopProp(arg_35_0, arg_35_1, arg_35_2)
	manager.net:SendWithLoadingNew(85018, {
		prop_id = arg_35_0,
		chance_id = arg_35_1
	}, 85019, function(arg_36_0, arg_36_1)
		var_0_0.OnBuyShopProp(arg_36_0, arg_36_1, arg_35_2)
	end)
end

function var_0_0.OnBuyShopProp(arg_37_0, arg_37_1, arg_37_2)
	if isSuccess(arg_37_0.result) then
		ShowTips("CHESSBOARD_BUY_PROP_SUCCESS")

		if arg_37_2 then
			arg_37_2()
		end
	else
		ShowTips(arg_37_0.result)
	end
end

function var_0_0.FinishTask(arg_38_0, arg_38_1)
	manager.net:SendWithLoadingNew(85026, {
		task_id = arg_38_0
	}, 85027, function(arg_39_0, arg_39_1)
		var_0_0.OnFinishTask(arg_39_0, arg_39_1, arg_38_1)
	end)
end

function var_0_0.OnFinishTask(arg_40_0, arg_40_1, arg_40_2)
	if isSuccess(arg_40_0.result) then
		if arg_40_2 then
			arg_40_2()
		end
	else
		ShowTips(arg_40_0.result)
	end
end

function var_0_0.FinishCurrentBoard(arg_41_0)
	manager.net:SendWithLoadingNew(85028, {}, 85029, function(arg_42_0, arg_42_1)
		var_0_0.OnFinishCurrentBoard(arg_42_0, arg_42_1, arg_41_0)
	end)
end

function var_0_0.OnFinishCurrentBoard(arg_43_0, arg_43_1, arg_43_2)
	if isSuccess(arg_43_0.result) then
		ChessBoardData:ClearCurrentPlayingChessBoardLevelID()

		if arg_43_2 then
			arg_43_2()
		end
	else
		ShowTips(arg_43_0.result)
	end
end

function var_0_0.GoBackFromSmallGame(arg_44_0, arg_44_1)
	manager.ChessBoardManager:SetSmallGamePoint(arg_44_0, arg_44_1)
	var_0_0.EnterChessMap()
end

return var_0_0
