local var_0_0 = {}

manager.net:Bind(29001, function(arg_1_0)
	StrategyMatrixData:InitMatrixUser(arg_1_0.activity)
	StrategyMatrixAction.CheckAllRedPoint()
end)
manager.net:Bind(29005, function(arg_2_0)
	StrategyMatrixData:InitMatrixOver(arg_2_0.end_info)
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_3_0)
	if ActivityTools.GetActivityType(arg_3_0) == ActivityTemplateConst.STRATEGY_MATRIX then
		StrategyMatrixAction.CheckRedPoint(arg_3_0)
	end
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0.CheckAllRedPoint()
end)

function var_0_0.QueryStartMatrix(arg_5_0, arg_5_1, arg_5_2)
	manager.net:SendWithLoadingNew(29012, {
		hero_id_list = arg_5_0,
		activity_id = arg_5_1,
		custom_affix_id_list = arg_5_2
	}, 29013, var_0_0.StartMatrixCallBack)
end

function var_0_0.StartMatrixCallBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		StrategyMatrixData:UpdateMatrixProcess(arg_6_1.activity_id, MatrixConst.STATE_TYPE.STARTED, arg_6_0.progress)
		StrategyMatrixAction.JumpToStrategyMatrix(arg_6_1.activity_id)
		StrategyMatrixData:SetMatrixBattleHeroTeam(arg_6_1.activity_id, nil)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.QueryNextProgress(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {
		0
	}

	manager.net:SendWithLoadingNew(29010, {
		activity_id = arg_7_0,
		params = arg_7_1
	}, 29011, var_0_0.NextProgressCallBack)
end

function var_0_0.NextProgressCallBack(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.activity_id

	if isSuccess(arg_8_0.result) then
		StrategyMatrixData:UpdateMatrixProcess(arg_8_1.activity_id, MatrixConst.STATE_TYPE.STARTED, arg_8_0.progress)

		local var_8_1 = StrategyMatrixData:GetGameState(var_8_0)

		if var_8_1 == MatrixConst.STATE_TYPE.STARTED then
			local var_8_2 = StrategyMatrixData:GetMatrixPhaseData(var_8_0):GetPhase()

			if var_8_2 == 2 then
				var_0_0.DoEvent(var_8_0)
			elseif var_8_2 == 1 then
				StrategyMatrixAction.JumpToStrategyMatrix(var_8_0)
			else
				JumpTools.GoToSystem("/matrixBlank/strategyMatrixProcess", {
					matrix_activity_id = var_8_0
				})
			end
		elseif var_8_1 == MatrixConst.STATE_TYPE.SUCCESS or var_8_1 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/strategyMatrixOver", {
				matrix_activity_id = var_8_0
			})
		else
			StrategyMatrixAction.GotoStrategyMatrixPrepare(var_8_0)
		end

		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_8_0.result)
	end
end

function var_0_0.DoEvent(arg_9_0)
	local var_9_0 = StrategyMatrixData:GetMatrixPhaseData(arg_9_0)
	local var_9_1 = var_9_0:GetParams()[1]
	local var_9_2 = var_9_1 and StrategyMatrixEventTemplateCfg[var_9_1]

	if not var_9_2 then
		error("StrategyMatrixEventTemplateCfg cant find event by id :" .. var_9_1)

		return
	end

	if MatrixConst.EVENT_TYPE.SHOP == var_9_2.event_type then
		local var_9_3 = var_9_0:GetShops()

		JumpTools.GoToSystem("/matrixBlank/strategyMatrixProcessShop", {
			matrix_activity_id = arg_9_0,
			shops = var_9_3
		})
	elseif MatrixConst.EVENT_TYPE.INCIDENT == var_9_2.event_type then
		JumpTools.GoToSystem("/strategyMatrixIncident", {
			matrix_activity_id = arg_9_0
		})
	else
		local var_9_4 = var_9_0:GetData()
		local var_9_5 = StrategyMatrixData:GetTierID(arg_9_0)
		local var_9_6 = BattleStrategyMatrixTemplate.New(var_9_4, arg_9_0, var_9_5)

		BattleController.GetInstance():LaunchBattle(var_9_6)
	end
end

function var_0_0.QueryMatrixOver(arg_10_0)
	manager.net:SendWithLoadingNew(29020, {
		activity_id = arg_10_0
	}, 29021, var_0_0.MatrixOverCallBack)
end

function var_0_0.MatrixOverCallBack(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		StrategyMatrixData:UpdateMatrixProcess(arg_11_1.activity_id, MatrixConst.STATE_TYPE.NOTSTARTED, arg_11_0.progress)

		local var_11_0 = arg_11_1.activity_id

		if var_11_0 == ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1 or var_11_0 == ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6 or var_11_0 == ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5 then
			JumpTools.OpenPageByJump("/matrixBlank/roguelikeAffix", {
				activity_id = var_11_0
			})
		else
			local var_11_1 = StrategyMatrixCfg[var_11_0]

			StrategyMatrixAction.QueryStartMatrix(var_11_1.hero_standard_system_id_list, var_11_0, {})
		end

		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_11_0.result)
	end
end

function var_0_0.QueryMatrixGiveUp(arg_12_0)
	manager.net:SendWithLoadingNew(29024, {
		activity_id = arg_12_0
	}, 29025, var_0_0.MatrixGiveUpCallBack)
end

function var_0_0.MatrixGiveUpCallBack(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		StrategyMatrixData:UpdateMatrixProcess(arg_13_1.activity_id, MatrixConst.STATE_TYPE.FAIL, arg_13_0.progress)
		StrategyMatrixData:SetActivityId(arg_13_1.activity_id)
		JumpTools.GoToSystem("/matrixBlank/strategyMatrixOver", {
			matrix_activity_id = arg_13_1.activity_id
		})
		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_13_0.result)
	end
end

function var_0_0.BuyShopItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0, var_14_1 = StrategyMatrixData:GetMatrixPhaseData(arg_14_0):GetData()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1.index == arg_14_1 then
			arg_14_3 = arg_14_3 or 0

			manager.net:SendWithLoadingNew(29010, {
				activity_id = arg_14_0,
				params = {
					2,
					arg_14_1,
					arg_14_2,
					arg_14_3
				}
			}, 29011, var_0_0.OnBuyShopItem)

			return
		end
	end
end

function var_0_0.OnBuyShopItem(arg_15_0, arg_15_1)
	if isSuccess(arg_15_0.result) then
		StrategyMatrixData:UpdateMatrixProcess(arg_15_1.activity_id, MatrixConst.STATE_TYPE.STARTED, arg_15_0.progress)
		ShowTips("TRANSACTION_SUCCESS")
		manager.notify:CallUpdateFunc(MATRIX_SHOP_BUY_SUCCESS)
		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_15_0.result)
	end
end

function var_0_0.QueryRefreshShopItem(arg_16_0)
	local var_16_0 = StrategyMatrixData:GetMatrixPhaseData(arg_16_0):GetData()
	local var_16_1 = StrategyMatrixData:GetShoRefreshTimes(arg_16_0)
	local var_16_2 = StrategyMatrixData:GetShopFressRefreshTimes(arg_16_0)

	if var_16_0 < var_16_1 then
		local var_16_3 = GameSetting.matrix_shop_refresh_cost_item_list.value

		if var_16_2 <= var_16_0 then
			local var_16_4 = var_16_0 - var_16_2
			local var_16_5 = var_16_3[math.min(var_16_4 + 1, #var_16_3)]

			if StrategyMatrixData:GetMatrixCoint(arg_16_0) < var_16_5[2] then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

				return
			end

			manager.net:SendWithLoadingNew(29010, {
				activity_id = arg_16_0,
				params = {
					1
				}
			}, 29011, var_0_0.OnRefrshShopItem)
		else
			manager.net:SendWithLoadingNew(29010, {
				activity_id = arg_16_0,
				params = {
					1
				}
			}, 29011, var_0_0.OnRefrshShopItem)
		end
	end
end

function var_0_0.OnRefrshShopItem(arg_17_0, arg_17_1)
	if isSuccess(arg_17_0.result) then
		StrategyMatrixData:UpdateMatrixProcess(arg_17_1.activity_id, MatrixConst.STATE_TYPE.STARTED, arg_17_0.progress)
		ShowTips("ASTROLABE_RESET")
		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_17_0.result)
	end
end

function var_0_0.GotoStrategyMatrix(arg_18_0, arg_18_1)
	if not ActivityTools.GetActivityIsOpenWithTip(arg_18_0) then
		return
	end

	local var_18_0 = StrategyMatrixData:GetGameState(arg_18_0)

	if var_18_0 == MatrixConst.STATE_TYPE.SUCCESS or var_18_0 == MatrixConst.STATE_TYPE.FAIL then
		OpenPageUntilLoaded("/matrixBlank/strategyMatrixOver", {
			matrix_activity_id = arg_18_0
		})
	elseif var_18_0 == MatrixConst.STATE_TYPE.NOTSTARTED then
		local var_18_1 = StrategyMatrixCfg[arg_18_0]

		StrategyMatrixAction.QueryStartMatrix(var_18_1.hero_standard_system_id_list, arg_18_0, {})
	elseif var_18_0 == MatrixConst.STATE_TYPE.STARTED then
		if StrategyMatrixData:GetMatrixPhaseData(arg_18_0):GetPhase() == 3 then
			JumpTools.GoToSystem("/matrixBlank/strategyMatrixProcess", {
				matrix_activity_id = arg_18_0
			})
		else
			StrategyMatrixAction.JumpToStrategyMatrix(arg_18_0, arg_18_1)
		end
	end
end

function var_0_0.GotoAfterBattleMatirx(arg_19_0)
	if not ActivityTools.GetActivityIsOpenWithTip(arg_19_0) then
		OpenPageUntilLoaded("/home", {})

		return
	end

	local var_19_0 = StrategyMatrixData:GetGameState(arg_19_0)

	if var_19_0 == MatrixConst.STATE_TYPE.SUCCESS or var_19_0 == MatrixConst.STATE_TYPE.FAIL then
		OpenPageUntilLoaded("/matrixBlank/strategyMatrixOver", {
			matrix_activity_id = arg_19_0
		})
	elseif var_19_0 == MatrixConst.STATE_TYPE.STARTED then
		if StrategyMatrixData:GetMatrixPhaseData(arg_19_0):GetPhase() == 3 then
			OpenPageUntilLoaded("/matrixBlank/strategyMatrixProcess", {
				matrix_activity_id = arg_19_0
			})
		else
			StrategyMatrixAction.JumpToStrategyMatrix(arg_19_0)
		end
	end
end

function var_0_0.GotoStrategyMatrixPrepare(arg_20_0)
	OpenPageUntilLoaded("/thirdVolumePart2Main", {})
end

function var_0_0.CheckAllRedPoint()
	local var_21_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRATEGY_MATRIX] or {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		StrategyMatrixAction.CheckRedPoint(iter_21_1)
	end
end

function var_0_0.CheckRedPoint(arg_22_0)
	if not ActivityData:GetActivityIsOpen(arg_22_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, arg_22_0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, arg_22_0), 0)

		return
	end

	StrategyMatrixAction.UpdateTaskRedTip(TaskConst.TASK_TYPE.STRATEGY_MATRIX, arg_22_0)

	local var_22_0 = StrategyMatrixCfg[arg_22_0]

	if var_22_0.activity_difficulty == 1 then
		StrategyMatrixAction.UpdateOpenRedPoint(TaskConst.TASK_TYPE.STRATEGY_MATRIX, arg_22_0)
	else
		local var_22_1 = var_22_0.pre_condition_args[1] and var_22_0.pre_condition_args[1][2][1]

		if not var_22_1 then
			return
		end

		if StrategyMatrixData:GetIsClearance(var_22_1) then
			if not StrategyMatrixData:GetRead(arg_22_0) then
				local var_22_2 = TaskData2:GetActivityTaskSortList(var_22_1)

				for iter_22_0, iter_22_1 in pairs(var_22_2) do
					if iter_22_1.complete_flag < 1 then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, arg_22_0), 1)

						return
					end
				end

				return
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, arg_22_0), 0)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, arg_22_0), 0)
		end
	end
end

function var_0_0.UpdateTaskRedTip(arg_23_0, arg_23_1)
	local var_23_0 = TaskData2:GetActivityTaskSortList(arg_23_1)

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if iter_23_1.progress >= AssignmentCfg[iter_23_1.id].need and iter_23_1.complete_flag < 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, arg_23_1), 1)

			return true
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, arg_23_1), 0)
end

function var_0_0.UpdateOpenRedPoint(arg_24_0, arg_24_1)
	if not StrategyMatrixData:GetRead(arg_24_1) then
		local var_24_0 = TaskData2:GetActivityTaskSortList(arg_24_1)

		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			if iter_24_1.complete_flag < 1 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, arg_24_1), 1)

				return
			end
		end

		return
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, arg_24_1), 0)
end

function var_0_0.SetStrategyRead(arg_25_0)
	StrategyMatrixData:SetRead(arg_25_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, arg_25_0), 0)
end

function var_0_0.JumpToStrategyMatrix(arg_26_0, arg_26_1)
	local var_26_0 = ActivityTools.GetActivityTheme(arg_26_0)

	if var_26_0 == ActivityConst.THEME.VOLUME_DOWN then
		OpenPageUntilLoaded("/matrixBlank/strategyMatrix", {
			matrix_activity_id = arg_26_0,
			playerAnim = arg_26_1
		})
	elseif var_26_0 == 12 then
		OpenPageUntilLoaded("/matrixBlank/strategyMatrixThor", {
			matrix_activity_id = arg_26_0,
			playerAnim = arg_26_1
		})
	elseif var_26_0 == ActivityConst.THEME.ACTIVITY_2_1 then
		OpenPageUntilLoaded("/matrixBlank/roguelikeMap_2_1", {
			activity_id = arg_26_0,
			playerAnim = arg_26_1
		})
	elseif var_26_0 == ActivityConst.THEME.ACTIVITY_2_6 then
		OpenPageUntilLoaded("/matrixBlank/roguelikeMap_2_6", {
			activity_id = arg_26_0,
			playerAnim = arg_26_1
		})
	elseif var_26_0 == ActivityConst.THEME.ACTIVITY_3_5 then
		OpenPageUntilLoaded("/matrixBlank/roguelikeMap_3_5", {
			activity_id = arg_26_0,
			playerAnim = arg_26_1
		})
	end
end

return var_0_0
