local var_0_0 = {}

manager.net:Bind(90001, function(arg_1_0)
	if isSuccess(arg_1_0.result) then
		AutoChessTools.ClearExportData()
		manager.notify:Invoke("AUTO_CHESS_MATCH_SUCCESS")
	else
		ShowTips(arg_1_0.result)
	end
end)
manager.net:Bind(90115, function(arg_2_0)
	AutoChessData:UpdateGameStatus(arg_2_0, AutoChessConst.GAME_TYPE.ONLINE)

	if arg_2_0.state == AutoChessConst.GAME_STATUS.PREPARE_END then
		AutoChessData:SetIsInPrepareEnd(true)
	end
end)
manager.net:Bind(90101, function(arg_3_0)
	print("AutoChessMatchAction:Receive Prepare Info", tostring(AutoChessData:GetIsInPrepareEnd()))

	if AutoChessData:GetIsInPrepareEnd() and AutoChessBattleSimulator.GetInstance().isInit then
		AutoChessData:SaveNextRoundPrepareData(arg_3_0.player_info, AutoChessConst.GAME_TYPE.ONLINE)
	else
		AutoChessData:SetIsInMatch(false)

		local var_3_0 = math.random(1, #AutoChessConst.BACKGROUND_ID)

		AutoChessData:SetRandomBgIndex(var_3_0)
		AutoChessData:InitPrepareData(arg_3_0.player_info, AutoChessConst.GAME_TYPE.ONLINE)
		AutoChessData:SaveOnlineShopLevel()
		AutoChessTools.GoToGameView(AutoChessConst.GAME_TYPE.ONLINE, false, true)
	end
end)
manager.net:Bind(90113, function(arg_4_0)
	AutoChessData:SaveBattleRoundData(arg_4_0)
end)
manager.net:Bind(90133, function(arg_5_0)
	AutoChessData:UpdatePrepareActionList(AutoChessConst.GAME_TYPE.ONLINE, arg_5_0.action_list, arg_5_0.client_cache_sign)
end)
manager.net:Bind(90111, function(arg_6_0)
	AutoChessData:SaveOnlineBattleData(arg_6_0.battle_info)
end)
manager.net:Bind(90139, function(arg_7_0)
	AutoChessData:UpdateRoundSettlePlayerData(arg_7_0.users_info)
end)
manager.net:Bind(90137, function(arg_8_0)
	AutoChessData:UpdateTotalSettlePlayerData(arg_8_0)
	print("AutoChessMatchAction:IsCanReconnectAutoChess:", tostring(AutoChessData:GetIsCanReconnectAutoChess()))

	if AutoChessData:GetIsCanReconnectAutoChess() then
		AutoChessData:ResetChessData()
		AutoChessData:SetIsCanReconnectAutoChess(false)

		if gameContext:GetLastOpenPage() == "autoChessQuitPopView" then
			JumpTools.Back()
		end
	elseif AutoChessData:GetOnlineBattleData() ~= nil then
		local var_8_0 = manager.time:GetServerTime()
		local var_8_1 = 0
		local var_8_2 = AutoChessTools.GetCurRound(AutoChessConst.GAME_TYPE.ONLINE)
		local var_8_3 = GameSetting.auto_chess_2_count_down.value

		for iter_8_0 = #var_8_3, 1, -1 do
			if var_8_2 > var_8_3[iter_8_0][1] then
				var_8_1 = var_8_3[iter_8_0][2]

				break
			end
		end

		AutoChessData:SetTimeStamp(AutoChessConst.GAME_TYPE.ONLINE, var_8_0, var_8_0 + var_8_1)
	else
		AutoChessData:UpdateGameStatus({
			game_type = AutoChessConst.GAME_TYPE.ONLINE,
			state = AutoChessConst.GAME_STATUS.TOTAL_SETTLE_LOSE
		})
		AutoChessTools.GoToGameSettleView(AutoChessConst.GAME_TYPE.ONLINE)
		AutoChessData:ClearBattleData(AutoChessConst.GAME_TYPE.ONLINE)
	end
end)

function var_0_0.StartMatch()
	manager.net:SendWithLoadingNew(90002, {}, 90003, var_0_0.OnStartMatchBack)
end

function var_0_0.OnStartMatchBack(arg_10_0, arg_10_1)
	if isSuccess(arg_10_0.result) then
		AutoChessData:SetIsInMatch(true)
		JumpTools.OpenPageByJump("autoChessPVPMatchView", {
			expectTime = arg_10_0.present_time
		})
	else
		ShowTips(arg_10_0.result)
	end
end

function var_0_0.StopMatch()
	manager.net:SendWithLoadingNew(90004, {}, 90005, var_0_0.OnStopMatchBack)
end

function var_0_0.OnStopMatchBack(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		AutoChessData:SetIsInMatch(false)

		if gameContext:GetLastOpenPage() == "autoChessPVPMatchView" then
			JumpTools.Back()
		end
	else
		ShowTips(arg_12_0.result)
	end
end

function var_0_0.StopPrepare(arg_13_0)
	manager.net:SendWithLoadingNew(90108, {
		round = arg_13_0
	}, 90109, var_0_0.OnStopPrepareBack)
end

function var_0_0.OnStopPrepareBack(arg_14_0, arg_14_1)
	if isSuccess(arg_14_0.result) then
		AutoChessData:SetIsInPrepareEnd(true)
	else
		ShowTips(arg_14_0.result)
	end
end

manager.net:Bind(90149, function(arg_15_0)
	if AutoChessData:GetIsInPrepareEnd() then
		AutoChessData:UpdatePrepareReadyData(AutoChessConst.GAME_TYPE.ONLINE, arg_15_0.close_info)
	end
end)
manager.net:Bind(90151, function(arg_16_0)
	AutoChessData:SetIsInPrepareEnd(true)
end)
manager.net:Bind(90153, function(arg_17_0)
	AutoChessData:SetTimeStamp(AutoChessConst.GAME_TYPE.ONLINE, arg_17_0.start_timestamp, arg_17_0.end_timestamp)
	manager.notify:Invoke(AUTO_CHESS_UPDATE_COUNTDOWN)
end)

function var_0_0.CancelGame(arg_18_0)
	manager.net:SendWithLoadingNew(90126, {}, 90127, var_0_0.OnCancelGameBack)
end

function var_0_0.OnCancelGameBack(arg_19_0, arg_19_1)
	if isSuccess(arg_19_0.result) then
		-- block empty
	else
		ShowTips(arg_19_0.result)

		if AutoChessData:GetIsCanReconnectAutoChess() then
			AutoChessData:ResetChessData()
			AutoChessData:SetIsCanReconnectAutoChess(false)

			if gameContext:GetLastOpenPage() == "autoChessQuitPopView" then
				JumpTools.Back()
			end
		end
	end
end

function var_0_0.BuyChess(arg_20_0, arg_20_1, arg_20_2)
	var_0_0.shopData = arg_20_1

	AutoChessData:SetIsInBuyChess(true)
	manager.net:SendWithLoadingNew(90102, {
		round = arg_20_0,
		shop_type = arg_20_1.shopType,
		shop_unique_id = arg_20_1.uniqueId,
		to_index = arg_20_2
	}, 90103, var_0_0.OnBuyChessBack)
end

function var_0_0.OnBuyChessBack(arg_21_0, arg_21_1)
	if isSuccess(arg_21_0.result) then
		manager.notify:Invoke("AUTO_CHESS_SHOP_BUY_CHESS", var_0_0.shopData, arg_21_1.to_index)

		local var_21_0 = AutoChessItemCfg[var_0_0.shopData.chessId]

		if arg_21_1.shop_type == AutoChessConst.SHOP_TYPE.PROP and var_21_0 and AutoChessTools.IsPrepareStatus() and not AutoChessData:GetIsInUseProp() then
			AutoChessData:SetIsInUseProp(true)

			local var_21_1 = AutoChessBattleRenderer.GetInstance():GetPrepareView()

			if var_21_1 then
				if AutoChessTools.IsTargetProp(var_21_0.id) then
					local var_21_2 = var_21_1:GetChessItemByTargetIndex(arg_21_1.to_index)

					if var_21_2 then
						var_21_2:PlayPropAnimator(var_21_0.icon)
					end
				else
					var_21_1:PlayPropAnimator(var_21_0.icon)
				end
			end
		end

		var_0_0.shopData = nil
	else
		AutoChessData:SetIsInBuyChess(false)
		AutoChessData:SetIsInUseProp(false)
		ShowTips(arg_21_0.result)
	end
end

function var_0_0.SellChess(arg_22_0, arg_22_1)
	manager.net:SendWithLoadingNew(90122, {
		round = arg_22_0,
		uid = arg_22_1
	}, 90123, var_0_0.OnSellChessBack)
end

function var_0_0.OnSellChessBack(arg_23_0, arg_23_1)
	if isSuccess(arg_23_0.result) then
		-- block empty
	else
		ShowTips(arg_23_0.result)
	end
end

function var_0_0.RefreshShop(arg_24_0)
	manager.net:SendWithLoadingNew(90118, {
		round = arg_24_0
	}, 90119, var_0_0.OnRefreshShopBack)
end

function var_0_0.OnRefreshShopBack(arg_25_0, arg_25_1)
	if isSuccess(arg_25_0.result) then
		-- block empty
	else
		ShowTips(arg_25_0.result)
	end
end

function var_0_0.LockShop(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = {
		round = arg_26_0,
		type = arg_26_1,
		info_list = arg_26_2
	}

	manager.net:SendWithLoadingNew(90120, var_26_0, 90121, var_0_0.OnLockShopBack)
end

function var_0_0.OnLockShopBack(arg_27_0, arg_27_1)
	if isSuccess(arg_27_0.result) then
		arg_27_1.game_type = AutoChessConst.GAME_TYPE.ONLINE

		AutoChessData:UpdateShopItemLock(arg_27_1)
		manager.notify:Invoke("AUTO_CHESS_LOCK_SHOP_SHOW", arg_27_1)
	else
		ShowTips(arg_27_0.result)
	end
end

function var_0_0.ChangeChessTeam(arg_28_0, arg_28_1)
	trace("Changing chess team:%o", arg_28_1)
	AutoChessData:SetIsInChangeTeam(true)
	manager.net:SendWithLoadingNew(90104, {
		round = arg_28_0,
		chess_list = arg_28_1
	}, 90105, var_0_0.OnChangeChessTeamBack)
end

function var_0_0.OnChangeChessTeamBack(arg_29_0, arg_29_1)
	if isSuccess(arg_29_0.result) then
		local var_29_0 = {}
		local var_29_1 = AutoChessData:GetPointChessData()

		for iter_29_0, iter_29_1 in ipairs(arg_29_0.chess_list or {}) do
			if not var_29_1 or var_29_1 and var_29_1.shopType ~= nil or iter_29_1 and iter_29_1.key ~= var_29_1.uniqueId then
				local var_29_2 = AutoChessData:GetChessData(iter_29_1.key)

				var_29_2.index = iter_29_1.value

				table.insert(var_29_0, var_29_2)
			end
		end

		AutoChessData:ClearPlayerChessData(AutoChessConst.GAME_TYPE.ONLINE)
		AutoChessData:UpdateChessTeamDataList(AutoChessConst.GAME_TYPE.ONLINE, var_29_0)
	else
		ShowTips(arg_29_0.result)
	end
end

function var_0_0.MergeChess(arg_30_0, arg_30_1, arg_30_2)
	manager.net:SendWithLoadingNew(90128, {
		round = arg_30_0,
		source_uid = arg_30_1,
		loss_uid = arg_30_2
	}, 90129, var_0_0.OnMergeChessBack)
end

function var_0_0.OnMergeChessBack(arg_31_0, arg_31_1)
	if isSuccess(arg_31_0.result) then
		-- block empty
	else
		ShowTips(arg_31_0.result)
	end
end

function var_0_0.PlayerCheesUpgrade(arg_32_0, arg_32_1, arg_32_2)
	manager.net:SendWithLoadingNew(90106, {
		round = arg_32_0,
		attr_index = arg_32_1,
		buff_index = arg_32_2
	}, 90107, var_0_0.OnPlayerChessUpgradeBack)
end

function var_0_0.OnPlayerChessUpgradeBack(arg_33_0, arg_33_1)
	if isSuccess(arg_33_0.result) then
		AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.ONLINE):ResetHeroUpgradeInfo()
		JumpTools.Back()
		manager.notify:Invoke(AUTO_CHESS_IS_IN_SKILL_POP, false)
	else
		ShowTips(arg_33_0.result)
	end
end

function var_0_0.CheckScoreBoard()
	manager.net:SendWithLoadingNew(90134, {}, 90135, var_0_0.OnCheckScoreBoardBack)
end

function var_0_0.OnCheckScoreBoardBack(arg_35_0)
	if isSuccess(arg_35_0.result) then
		AutoChessData:UpdateScoreBoardData(arg_35_0.all_score_info)
		JumpTools.OpenPageByJump("autoChessScoreBoardPopView")
	else
		ShowTips(arg_35_0.result)
	end
end

function var_0_0.SendSticker(arg_36_0)
	manager.net:SendWithLoadingNew(90140, {
		pic_id = arg_36_0
	}, 90141, var_0_0.OnSendStickerBack)
end

function var_0_0.OnSendStickerBack(arg_37_0)
	if isSuccess(arg_37_0.result) then
		-- block empty
	else
		ShowTips(arg_37_0.result)
	end
end

manager.net:Bind(90143, function(arg_38_0)
	manager.notify:Invoke("AUTO_CHESS_RECEIVE_STICKER", arg_38_0.pic_id, arg_38_0.user_id)
end)

function var_0_0.ExportChessInfo()
	manager.net:SendWithLoadingNew(90144, {}, 90145, var_0_0.OnExPortChessInfoBack)
end

function var_0_0.OnExPortChessInfoBack(arg_40_0, arg_40_1)
	if isSuccess(arg_40_0.result) then
		AutoChessTools.SetCurExportData(arg_40_0.export_info)
	else
		ShowTips(arg_40_0.result)
	end
end

manager.net:Bind(90147, function(arg_41_0)
	AutoChessTools.SetCurExportData(arg_41_0.export_info, true)
end)

function var_0_0.OpenTeamnfoPopAfterFetch(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1.user_id

	if var_42_0 then
		var_0_0.FetchRankTeamInfo(arg_42_0, var_42_0, function(arg_43_0)
			local var_43_0 = arg_43_0.record

			JumpTools.OpenPageByJump("autoChessRankTeamInfoPop", {
				rankData = arg_42_1,
				teamData = var_43_0
			})
		end)
	end
end

function var_0_0.FetchRankTeamInfo(arg_44_0, arg_44_1, arg_44_2)
	manager.net:SendWithLoadingNew(90082, {
		activity_id = arg_44_0,
		user_id = arg_44_1
	}, 90083, var_0_0.OnFetchRankTeamInfo(arg_44_2))
end

function var_0_0.OnFetchRankTeamInfo(arg_45_0)
	return function(arg_46_0)
		if isSuccess(arg_46_0.result) then
			if arg_45_0 then
				arg_45_0(arg_46_0)
			end
		else
			ShowTips(arg_46_0.result)
		end
	end
end

function var_0_0.RequestRecord(arg_47_0, arg_47_1)
	local var_47_0 = 1

	if arg_47_0 == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
		var_47_0 = 0
	end

	local var_47_1 = {
		type = var_47_0
	}

	manager.net:SendWithLoadingNew(90080, var_47_1, 90081, function(arg_48_0, arg_48_1)
		var_0_0.OnRequestRecordBack(arg_48_0, arg_48_1, arg_47_0, arg_47_1)
	end)
end

function var_0_0.OnRequestRecordBack(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	if isSuccess(arg_49_0.result) then
		AutoChessData:InitOnlineBattleRecord(arg_49_0, arg_49_2)

		if arg_49_3 then
			arg_49_3()
		end
	else
		ShowTips(arg_49_0.result)
	end
end

function var_0_0.ReconnectAutoChess()
	manager.net:SendWithLoadingNew(90008, {}, 90009, var_0_0.OnReconnectAutoChessBack)
end

function var_0_0.OnReconnectAutoChessBack(arg_51_0, arg_51_1)
	if isSuccess(arg_51_0.result) then
		AutoChessData:SetIsCanReconnectAutoChess(false)
		AutoChessData:SetActivityID(ActivityConst.ACTIVITY_AUTO_CHESS_4_8)
	else
		ShowTips(arg_51_0.result)
		AutoChessData:SetIsCanReconnectAutoChess(false)
	end
end

manager.net:Bind(90007, function(arg_52_0)
	AutoChessData:SetIsCanReconnectAutoChess(arg_52_0.can_reload)

	if AutoChessData:GetIsInMatch() then
		AutoChessData:SetIsInMatch(false)

		if gameContext:GetLastOpenPage() == "autoChessPVPMatchView" then
			JumpTools.Back()
		end

		if arg_52_0.can_reload then
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = AutoChessConst.GAME_TYPE.ONLINE,
				type = AutoChessConst.POP_TYPE.PVP_SYNC_RECONNECT,
				okCb = function()
					AutoChessMatchAction.ReconnectAutoChess()
				end
			})
		else
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("AUTO_CHESS_2_MATCH_CANCELED"),
				OkCallback = function()
					return
				end
			})
		end
	end
end)

function var_0_0.InitRedPoint()
	var_0_0.InitRedPointGroup()
	var_0_0.UpdateTaskRedPoint()
end

function var_0_0.InitRedPointGroup()
	local var_56_0 = RedPointConst.AUTO_CHESS_4_8_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8
	local var_56_1 = RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK
	local var_56_2 = ActivityCfg[ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK]
	local var_56_3 = {
		RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK_TAG .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK
	}

	for iter_56_0, iter_56_1 in pairs(var_56_2.sub_activity_list) do
		local var_56_4 = RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK_TAG .. iter_56_1

		table.insert(var_56_3, var_56_4)
	end

	manager.redPoint:addGroup(var_56_1, var_56_3)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0:UpdateTaskRedPoint()
	end)

	local var_56_5 = RedPointConst.AUTO_CHESS_4_8_RESIDENT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8
	local var_56_6 = RedPointConst.AUTO_CHESS_4_8_DESIRE .. ActivityConst.ACTIVITY_AUTO_CHESS_EXCHANGE_CARD

	manager.redPoint:addGroup(var_56_6, {
		RedPointConst.AUTO_CHESS_4_8_DESIRE_VIEW
	})

	local var_56_7 = RedPointConst.AUTO_CHESS_4_8_OPEN_CARD

	manager.redPoint:addGroup(var_56_7, {
		RedPointConst.AUTO_CHESS_4_8_OPEN_CARD_VIEW
	})
	manager.redPoint:addGroup(RedPointConst.AUTO_CHESS_4_8_GO_BTN, {
		var_56_1,
		var_56_5,
		var_56_6,
		var_56_7
	})
	manager.redPoint:addGroup(var_56_0, {
		RedPointConst.AUTO_CHESS_4_8_GO_BTN,
		var_56_1
	})
end

function var_0_0.UpdateTaskRedPoint()
	local var_58_0 = ActivityCfg[ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK]

	var_0_0.TaskRedSet(var_58_0.sub_activity_list, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK_TAG)
	var_0_0.TaskRedSet({
		ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK
	}, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK_TAG)
	var_0_0.TaskRedSet({
		ActivityConst.ACTIVITY_AUTO_CHESS_4_8
	}, RedPointConst.AUTO_CHESS_4_8_RESIDENT_TASK)
end

function var_0_0.TaskRedSet(arg_59_0, arg_59_1)
	for iter_59_0, iter_59_1 in pairs(arg_59_0) do
		local var_59_0 = ActivityData:GetActivityIsOpen(iter_59_1)

		for iter_59_2, iter_59_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_59_1]) do
			local var_59_1 = arg_59_1 .. iter_59_1

			if var_59_0 then
				local var_59_2 = TaskData2:GetTaskProgress(iter_59_3)
				local var_59_3 = AssignmentCfg[iter_59_3]

				if TaskData2:GetTaskComplete(iter_59_3) then
					manager.redPoint:setTip(var_59_1, 0)
				elseif var_59_2 >= var_59_3.need then
					manager.redPoint:setTip(var_59_1, 1)

					break
				else
					manager.redPoint:setTip(var_59_1, 0)
				end
			else
				manager.redPoint:setTip(var_59_1, 0)
			end
		end
	end
end

return var_0_0
