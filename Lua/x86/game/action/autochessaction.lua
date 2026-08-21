local var_0_0 = {}

manager.net:Bind(89125, function(arg_1_0)
	AutoChessData:UpdateGameStatus(arg_1_0)
end)
manager.net:Bind(89101, function(arg_2_0)
	AutoChessData:InitPrepareData(arg_2_0)
	AutoChessData:InitGlobalPrepareData(arg_2_0.game_type)
	manager.notify:Invoke("AUTO_CHESS_REFRESH_SHOP_SHOW")
end)
manager.net:Bind(89111, function(arg_3_0)
	AutoChessData:UpdateAttrData(arg_3_0.game_type, arg_3_0.attr_list)
end)
manager.net:Bind(89113, function(arg_4_0)
	AutoChessData:InitRoundBattleData(arg_4_0)

	if AutoChessTools.IsPreapreToBattle(arg_4_0.game_type) then
		AutoChessTools.PlayRoundBattle(arg_4_0.game_type)
	end
end)
manager.net:Bind(89133, function(arg_5_0)
	AutoChessData:UpdateChessTeamDataList(arg_5_0.game_type, arg_5_0.chess_list)
end)
manager.net:Bind(89115, function(arg_6_0)
	AutoChessData:UpdateShopItemData(arg_6_0.game_type, arg_6_0.shop_item)
end)
manager.net:Bind(89201, function(arg_7_0)
	AutoChessData:InitMedal(arg_7_0.medal)
	AutoChessData:UpdateStageData(arg_7_0.stage_list)
end)
manager.net:Bind(89203, function(arg_8_0)
	AutoChessData:UpdateStageData(arg_8_0.stage_list)
end)
manager.net:Bind(89205, function(arg_9_0)
	AutoChessData:InitMedal(arg_9_0.medal)
end)
manager.net:Bind(89137, function(arg_10_0)
	AutoChessData:UpdatePrepareActionList(arg_10_0.game_type, arg_10_0.action_list)
end)
manager.net:Bind(89109, function(arg_11_0)
	AutoChessData:InitBattleData(arg_11_0.replay_info)
end)

function var_0_0.StartNewGame(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or 0

	local var_12_0 = {
		game_type = arg_12_0,
		other_param = arg_12_1
	}

	manager.net:SendWithLoadingNew(89116, var_12_0, 89117, var_0_0.OnStartNewGameBack)
end

function var_0_0.OnStartNewGameBack(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		if arg_13_1.game_type == AutoChessConst.GAME_TYPE.PVE then
			saveData("auto_chess", "error", 0)
		end

		AutoChessTools.ClearExportData()
		AutoChessTools.GoToGameView(arg_13_1.game_type, false, true)
	else
		ShowTips(arg_13_0.result)
	end
end

function var_0_0.LaunchRoundBattle(arg_14_0)
	local var_14_0 = {
		game_type = arg_14_0
	}

	manager.net:SendWithLoadingNew(89108, var_14_0, 89109, var_0_0.OnLaunchRoundBattleBack)
end

function var_0_0.OnLaunchRoundBattleBack(arg_15_0, arg_15_1)
	if isSuccess(arg_15_0.result) then
		if arg_15_1.game_type == AutoChessConst.GAME_TYPE.PVE then
			saveData("auto_chess", "error", 0)
		end

		AutoChessData:InitBattleData(arg_15_0.replay_info)
	else
		if arg_15_1.game_type == AutoChessConst.GAME_TYPE.PVE then
			local var_15_0 = getData("auto_chess", "error") or 0

			if var_15_0 > GameSetting.auto_chess_disconnect_count.value[1] then
				JumpTools.OpenPageByJump("/autoChessQuitPopView", {
					gameType = arg_15_1.game_type,
					type = AutoChessConst.POP_TYPE.PVE_FALLBACK,
					okCb = function()
						AutoChessTools.CancelGame(arg_15_1.game_type)
					end
				})
			end

			saveData("auto_chess", "error", var_15_0 + 1)
		end

		ShowTips(arg_15_0.result)
	end
end

function var_0_0.SettleBattle(arg_17_0)
	local var_17_0 = {
		game_type = arg_17_0
	}

	manager.net:SendWithLoadingNew(89126, var_17_0, 89127, var_0_0.OnSettleBattleBack)
end

function var_0_0.OnSettleBattleBack(arg_18_0, arg_18_1)
	if isSuccess(arg_18_0.result) then
		AutoChessTools.QuitSettle(arg_18_1.game_type)
	else
		ShowTips(arg_18_0.result)
	end
end

function var_0_0.BuyChess(arg_19_0, arg_19_1, arg_19_2)
	var_0_0.shopData = arg_19_1

	AutoChessData:SetIsInBuyChess(true)
	manager.net:SendWithLoadingNew(89102, {
		game_type = arg_19_0,
		shop_type = arg_19_1.shopType,
		shop_unique_id = arg_19_1.uniqueId,
		to_index = arg_19_2
	}, 89103, var_0_0.OnBuyChessBack)
end

function var_0_0.OnBuyChessBack(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		manager.notify:Invoke("AUTO_CHESS_SHOP_BUY_CHESS", var_0_0.shopData, arg_20_1.to_index)

		local var_20_0 = AutoChessItemCfg[var_0_0.shopData.chessId]

		if arg_20_1.shop_type == AutoChessConst.SHOP_TYPE.PROP and var_20_0 and AutoChessTools.IsPrepareStatus() and not AutoChessData:GetIsInUseProp() then
			AutoChessData:SetIsInUseProp(true)

			local var_20_1 = AutoChessBattleRenderer.GetInstance():GetPrepareView()

			if var_20_1 then
				if AutoChessTools.IsTargetProp(var_20_0.id) then
					local var_20_2 = var_20_1:GetChessItemByTargetIndex(arg_20_1.to_index)

					if var_20_2 then
						var_20_2:PlayPropAnimator(var_20_0.icon)
					end
				else
					var_20_1:PlayPropAnimator(var_20_0.icon)
				end
			end
		end

		var_0_0.shopData = nil
	else
		AutoChessData:SetIsInBuyChess(false)
		AutoChessData:SetIsInUseProp(nil)
		ShowTips(arg_20_0.result)
	end
end

function var_0_0.SellChess(arg_21_0, arg_21_1)
	manager.net:SendWithLoadingNew(89122, {
		game_type = arg_21_0,
		uid = arg_21_1
	}, 89123, var_0_0.OnSellChessBack)
end

function var_0_0.OnSellChessBack(arg_22_0, arg_22_1)
	if isSuccess(arg_22_0.result) then
		-- block empty
	else
		ShowTips(arg_22_0.result)
	end
end

function var_0_0.RefreshShop(arg_23_0)
	manager.net:SendWithLoadingNew(89118, {
		game_type = arg_23_0
	}, 89119, var_0_0.OnRefreshShopBack)
end

function var_0_0.OnRefreshShopBack(arg_24_0, arg_24_1)
	if isSuccess(arg_24_0.result) then
		-- block empty
	else
		ShowTips(arg_24_0.result)
	end
end

function var_0_0.LockShop(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {
		game_type = arg_25_0,
		type = arg_25_1,
		info_list = arg_25_2
	}

	manager.net:SendWithLoadingNew(89120, var_25_0, 89121, var_0_0.OnLockShopBack)
end

function var_0_0.OnLockShopBack(arg_26_0, arg_26_1)
	if isSuccess(arg_26_0.result) then
		AutoChessData:UpdateShopItemLock(arg_26_1)
		manager.notify:Invoke("AUTO_CHESS_LOCK_SHOP_SHOW", arg_26_1)
	else
		ShowTips(arg_26_0.result)
	end
end

function var_0_0.ChangeChessTeam(arg_27_0, arg_27_1)
	AutoChessData:SetIsInChangeTeam(true)
	manager.net:SendWithLoadingNew(89104, {
		game_type = arg_27_0,
		chess_list = arg_27_1
	}, 89105, var_0_0.OnChangeChessTeamBack)
end

function var_0_0.OnChangeChessTeamBack(arg_28_0, arg_28_1)
	if isSuccess(arg_28_0.result) then
		local var_28_0 = {}
		local var_28_1 = AutoChessData:GetPointChessData()

		for iter_28_0, iter_28_1 in ipairs(arg_28_0.chess_list) do
			if not var_28_1 or var_28_1.shopType ~= nil or iter_28_1.key ~= var_28_1.uniqueId then
				local var_28_2 = AutoChessData:GetChessData(iter_28_1.key)

				var_28_2.index = iter_28_1.value

				table.insert(var_28_0, var_28_2)
			end
		end

		AutoChessData:ClearPlayerChessData(arg_28_1.game_type)
		AutoChessData:UpdateChessTeamDataList(arg_28_1.game_type, var_28_0)
	else
		ShowTips(arg_28_0.result)
	end
end

function var_0_0.MergeChess(arg_29_0, arg_29_1, arg_29_2)
	manager.net:SendWithLoadingNew(89130, {
		game_type = arg_29_0,
		source_uid = arg_29_1,
		loss_uid = arg_29_2
	}, 89131, var_0_0.OnMergeChessBack)
end

function var_0_0.OnMergeChessBack(arg_30_0, arg_30_1)
	if isSuccess(arg_30_0.result) then
		-- block empty
	else
		ShowTips(arg_30_0.result)
	end
end

function var_0_0.BuyChessOneKey(arg_31_0)
	manager.net:SendWithLoadingNew(89140, {
		game_type = arg_31_0
	}, 89141, var_0_0.OnBueChessOneKeyBack)
end

function var_0_0.OnBueChessOneKeyBack(arg_32_0, arg_32_1)
	if isSuccess(arg_32_0.result) then
		-- block empty
	else
		ShowTips(arg_32_0.result)
	end
end

function var_0_0.PlayerCheesUpgrade(arg_33_0, arg_33_1, arg_33_2)
	manager.net:SendWithLoadingNew(89134, {
		game_type = arg_33_0,
		attr_index = arg_33_1,
		buff_index = arg_33_2
	}, 89135, var_0_0.OnPlayerChessUpgradeBack)
end

function var_0_0.OnPlayerChessUpgradeBack(arg_34_0, arg_34_1)
	if isSuccess(arg_34_0.result) then
		AutoChessData:GetPrepareData(arg_34_1.game_type):ResetHeroUpgradeInfo()
		JumpTools.Back()
		manager.notify:Invoke(AUTO_CHESS_IS_IN_SKILL_POP, false)
	else
		ShowTips(arg_34_0.result)
	end
end

function var_0_0.SkipStage(arg_35_0)
	manager.net:SendWithLoadingNew(89212, {
		stage_id = arg_35_0
	}, 89213, var_0_0.OnSkipStageBack)
end

function var_0_0.OnSkipStageBack(arg_36_0)
	if isSuccess(arg_36_0.result) then
		-- block empty
	else
		ShowTips(arg_36_0.result)
	end
end

function var_0_0.LookEnemyInfo(arg_37_0, arg_37_1)
	manager.net:SendWithLoadingNew(89138, {
		group_id = arg_37_0,
		round = arg_37_1
	}, 89139, var_0_0.OnLookEnemyInfoBack)
end

function var_0_0.OnLookEnemyInfoBack(arg_38_0)
	if isSuccess(arg_38_0.result) then
		AutoChessData:GetPrepareData(AutoChessConst.GAME_TYPE.PVE):InitEnemyData(arg_38_0.enemy_auto_chess_board)
		JumpTools.OpenPageByJump("/autoChessLookFormationView")
	else
		ShowTips(arg_38_0.result)
	end
end

manager.net:Bind(89207, function(arg_39_0)
	AutoChessData:InitBattleRecord(arg_39_0)
end)
manager.net:Bind(89211, function(arg_40_0)
	AutoChessData:UpdateBattleRecord(arg_40_0)
end)

function var_0_0.CancelGame(arg_41_0, arg_41_1, arg_41_2)
	var_0_0.isNoLoading = arg_41_1

	manager.net:SendWithLoadingNew(89128, {
		game_type = arg_41_0
	}, 89129, function(arg_42_0, arg_42_1)
		var_0_0.OnCancelGameBack(arg_42_0, arg_42_1, arg_41_2)
	end)
end

function var_0_0.OnCancelGameBack(arg_43_0, arg_43_1, arg_43_2)
	if isSuccess(arg_43_0.result) then
		AutoChessData:ClearBattleData(arg_43_1.game_type)

		if arg_43_2 then
			manager.net:ResetForceReconnect()
			AutoChessTools.ResetPrepareState()
			AutoChessData:ResetChessData()
			arg_43_2()
		else
			AutoChessTools.QuitGame(arg_43_1.game_type, var_0_0.isNoLoading)
		end

		var_0_0.isNoLoading = false
	else
		ShowTips(arg_43_0.result)
	end
end

function var_0_0.OpenTeamnfoPopAfterFetch(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1.user_id

	if var_44_0 then
		var_0_0.FetchRankTeamInfo(arg_44_0, var_44_0, function(arg_45_0)
			local var_45_0 = arg_45_0.record

			JumpTools.OpenPageByJump("autoChessRankTeamInfoPop", {
				rankData = arg_44_1,
				teamData = var_45_0
			})
		end)
	end
end

function var_0_0.FetchRankTeamInfo(arg_46_0, arg_46_1, arg_46_2)
	manager.net:SendWithLoadingNew(89208, {
		activity_id = arg_46_0,
		user_id = arg_46_1
	}, 89209, var_0_0.OnFetchRankTeamInfo(arg_46_2))
end

function var_0_0.OnFetchRankTeamInfo(arg_47_0)
	return function(arg_48_0)
		if isSuccess(arg_48_0.result) then
			if arg_47_0 then
				arg_47_0(arg_48_0)
			end
		else
			ShowTips(arg_48_0.result)
		end
	end
end

function var_0_0.LookReplay(arg_49_0)
	if AutoChessData:GetReplayBattleData(arg_49_0) then
		AutoChessData:UpdateGameStatus({
			game_type = arg_49_0,
			state = AutoChessConst.GAME_STATUS.REPLAY
		})
		AutoChessTools.PlayRoundBattle(arg_49_0)
	else
		if AutoChessTools.GetCurRound(arg_49_0) == 1 then
			ShowTips("AUTO_CHESS_NO_PLAYBACK")

			return
		end

		manager.net:SendWithLoadingNew(89142, {
			game_type = arg_49_0
		}, 89143, var_0_0.OnLookReplayBack)
	end
end

function var_0_0.OnLookReplayBack(arg_50_0, arg_50_1)
	if isSuccess(arg_50_0.result) then
		AutoChessData:UpdateGameStatus({
			game_type = arg_50_1.game_type,
			state = AutoChessConst.GAME_STATUS.REPLAY
		})
		AutoChessData:InitBattleData(arg_50_0.replay_info)
	else
		ShowTips(arg_50_0.result)
	end
end

function var_0_0.PrepareEnd(arg_51_0)
	AutoChessData:SetIsInPrepareEnd(true)
	manager.net:SendWithLoadingNew(89144, {
		game_type = arg_51_0
	}, 89145, var_0_0.OnPrepareEndBack)
end

function var_0_0.OnPrepareEndBack(arg_52_0, arg_52_1)
	if isSuccess(arg_52_0.result) then
		-- block empty
	else
		ShowTips(arg_52_0.result)
	end
end

function var_0_0.ExportChessInfo()
	manager.net:SendWithLoadingNew(89146, {
		game_type = AutoChessData:GetCurGameType()
	}, 89147, var_0_0.OnExPortChessInfoBack)
end

function var_0_0.OnExPortChessInfoBack(arg_54_0, arg_54_1)
	if isSuccess(arg_54_0.result) then
		AutoChessTools.SetCurExportData(arg_54_0.export_info)
	else
		ShowTips(arg_54_0.result)
	end
end

function var_0_0.SetGamePause(arg_55_0, arg_55_1)
	manager.net:SendWithLoadingNew(89148, {
		game_type = arg_55_0,
		opt = arg_55_1
	}, 89149, var_0_0.OnSetGamePauseBack)
end

function var_0_0.OnSetGamePauseBack(arg_56_0, arg_56_1)
	if isSuccess(arg_56_0.result) then
		-- block empty
	else
		ShowTips(arg_56_0.result)
	end
end

function var_0_0.InitRedPoint()
	AutoChessData:InitRedPointGroup()
	AutoChessData:UpdateTaskRedPoint()
end

return var_0_0
