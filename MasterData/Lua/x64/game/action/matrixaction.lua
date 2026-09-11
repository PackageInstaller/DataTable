local var_0_0 = {}

manager.net:Bind(48001, function(arg_1_0)
	local var_1_0 = MatrixData:GetNextRefreshTime()

	if var_1_0 ~= 0 and var_1_0 ~= arg_1_0.matrix_system.next_refresh_timestamp then
		manager.notify:CallUpdateFunc(MATRIX_SYSTEM_OVERDUE)
	end

	MatrixData:InitMatrixSystem(arg_1_0.matrix_system)
	manager.notify:CallUpdateFunc(MATRIX_SYSTEM_UPDATE)
end)
manager.net:Bind(48003, function(arg_2_0)
	MatrixData:InitMatrixUser(arg_2_0.user_matrix)
	manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	var_0_0.CheckExchangeScoreRedPoint()
	var_0_0.CheckBeaconRedPoint()
	var_0_0.CheckTerminalGiftRedPoint(MatrixData:GetTerminalGift())
end)
manager.net:Bind(48005, function(arg_3_0)
	MatrixData:MatrixOverData(arg_3_0.end_info)
	manager.notify:CallUpdateFunc(MATRIX_OVER_UPDATE)
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_4_0)
	if arg_4_0 == CurrencyConst.CURRENCY_TYPE_MATRIX_PT then
		var_0_0.CheckExchangeScoreRedPoint()
	elseif arg_4_0 == CurrencyConst.CURRENCY_TYPE_MATRIX_TERMINAL_EXP then
		MatrixData:UpdateTerminalLevel()

		if MatrixData:GetTerminalLevel() ~= MatrixData:GetTerminalLevel() then
			MatrixTools.UpdateSortScoreList()
			var_0_0.CheckExchangeScoreRedPoint()
		end
	end
end)

function var_0_0.CheckExchangeScoreRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		manager.redPoint:setTip(RedPointConst.MATRIX_EXCHANGE_BONUS, 0)

		return
	end

	local var_5_0 = false
	local var_5_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT)
	local var_5_2 = MatrixData:GetTerminalLevel()

	for iter_5_0, iter_5_1 in ipairs((MatrixData:GetPointRewardList())) do
		if MatrixPointRankCfg[iter_5_1.rank] and var_5_1 >= MatrixPointRankCfg[iter_5_1.rank].point and iter_5_1.is_got_reward <= 0 and var_5_2 >= iter_5_1.need_level then
			var_5_0 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.MATRIX_EXCHANGE_BONUS, var_5_0 and 1 or 0)
end

function var_0_0.CheckBeaconRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		manager.redPoint:setTip(RedPointConst.MATRIX_BEACON_UNLOCK, 0)

		return
	end

	for iter_6_0, iter_6_1 in ipairs(MatrixBeaconCfg.all) do
		if MatrixData:GetBeaconIsLock(iter_6_1) then
			if MatrixTools.GetBeaconIsUnlockCondition(iter_6_1) then
				manager.redPoint:setTip(RedPointConst.MATRIX_BEACON_UNLOCK, 1)

				return
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.MATRIX_BEACON_UNLOCK, 0)
end

function var_0_0.CheckTerminalGiftRedPoint(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		for iter_7_2 = 1, iter_7_1 do
			var_7_0 = var_7_0 + MatrixTerminalGiftCfg[iter_7_0].cost[iter_7_2]
		end
	end

	local var_7_1 = MatrixTerminalLevelCfg[MatrixData:GetTerminalLevel()].point - var_7_0

	return MatrixAction.CheckSubTerminalGiftRedPoint(arg_7_0, var_7_1, 1, RedPointConst.MATRIX_TERMINAL_GIFT_STRUGGLE) or MatrixAction.CheckSubTerminalGiftRedPoint(arg_7_0, var_7_1, 2, RedPointConst.MATRIX_TERMINAL_GIFT_SHELTER)
end

function var_0_0:CheckSubTerminalGiftRedPoint(arg_8_1, arg_8_2, arg_8_3)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		manager.redPoint:setTip(arg_8_3, 0)

		return false
	end

	if arg_8_1 <= 0 then
		manager.redPoint:setTip(arg_8_3, 0)

		return false
	end

	local var_8_0 = MatrixData:GetTerminalLevel()

	for iter_8_0, iter_8_1 in ipairs(MatrixTerminalGiftCfg.get_id_list_by_group[arg_8_2] or {}) do
		if MatrixTerminalGiftCfg[iter_8_1].pre_id == 0 or self[MatrixTerminalGiftCfg[iter_8_1].pre_id] and self[MatrixTerminalGiftCfg[iter_8_1].pre_id] > 0 then
			local var_8_1 = self[iter_8_1] or 0

			if var_8_1 < #MatrixTerminalGiftCfg[iter_8_1].effect_id_list then
				if (MatrixTerminalGiftCfg[iter_8_1].cost[var_8_1 + 1] or 0) <= arg_8_1 and var_8_0 >= MatrixTerminalGiftCfg[iter_8_1].limit_level then
					manager.redPoint:setTip(arg_8_3, 1)

					return true
				end
			end
		end
	end

	manager.redPoint:setTip(arg_8_3, 0)

	return false
end

function var_0_0.QueryStartMatrix(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	return manager.net:SendWithLoadingNew(48012, {
		hero_id_list = arg_9_0,
		difficulty = arg_9_1,
		custom_affix_id_list = arg_9_2,
		beacon_id_list = arg_9_3
	}, 48013, var_0_0.StartMatrixCallBack)
end

function var_0_0:StartMatrixCallBack()
	if isSuccess(self.result) then
		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX), 0)
		ComboSkillData:SetMatrixNeedRefresh(true)
		JumpTools.GoToSystem("/matrixBlank/matrixOrigin")
		MatrixData:SetMatrixBattleHeroTeam(nil)
	else
		ShowTips(self.result)
	end
end

local var_0_1
local var_0_2

function var_0_0.QueryNextProgress(arg_11_0)
	arg_11_0 = arg_11_0 or {
		0
	}
	var_0_1 = MatrixData:GetMatrixPhaseData()
	var_0_2 = MatrixData:GetTierID()

	manager.net:SendWithLoadingNew(48010, {
		params = arg_11_0
	}, 48011, var_0_0.NextProgressCallBack)
end

function var_0_0:NextProgressCallBack(arg_12_1)
	if isSuccess(self.result) then
		local var_12_0 = MatrixData:GetGameState()

		if var_12_0 == MatrixConst.STATE_TYPE.STARTED then
			local var_12_1 = var_0_1:GetPhase()
			local var_12_2 = arg_12_1.params and arg_12_1.params[1]

			if MatrixConst.PHASE_TYPE.REWARD == var_12_1 then
				local var_12_3 = false

				if not var_12_2 then
					var_12_3 = true
					var_12_2 = var_0_1:GetGiveUpItemId() or 0
				end

				var_0_0.DoReward(var_12_2, var_12_3)
			elseif MatrixConst.PHASE_TYPE.ACTION == var_12_1 then
				if MatrixConst.EVENT_TYPE.INCIDENT == MatrixEventCfg[var_0_1:GetParams()[1]].event_type then
					var_0_0.DoEffect(MatrixChanceCfg[var_12_2].toll)
				end

				var_0_0.DoAfterEvnet(var_0_2)
			end

			if MatrixData:GetMatrixPhaseData():GetPhase() == 2 then
				var_0_0.DoEvent()
			end
		elseif var_12_0 == MatrixConst.STATE_TYPE.SUCCESS or var_12_0 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/matrixOver")
		else
			OpenPageUntilLoaded("/matrixBlank/matrixPrepare")
		end
	else
		ShowTips(self.result)
	end

	cur_phase = nil
	var_0_2 = nil
end

function var_0_0.DoEvent()
	local var_13_0 = MatrixData:GetMatrixPhaseData()
	local var_13_1 = var_13_0:GetParams()[1]
	local var_13_2 = var_13_1 and MatrixEventCfg[var_13_1]

	if not (var_13_1 and MatrixEventCfg[var_13_1]) then
		error("MatrixEventCfg cant find event by id :" .. var_13_1)

		return
	end

	if MatrixConst.EVENT_TYPE.SHOP == var_13_2.event_type then
		JumpTools.GoToSystem("/matrixBlank/matrixProcessShop", {
			shops = var_13_0:GetShops()
		})
	elseif MatrixConst.EVENT_TYPE.INCIDENT == var_13_2.event_type then
		-- block empty
	else
		local var_13_3 = var_13_0:GetData()

		MatrixData:SetBattleTier((MatrixData:GetTierID()))
		BattleController.GetInstance():LaunchBattle((BattleMatrixStageTemplate.New(var_13_3)))
	end
end

function var_0_0.DoReward(arg_14_0, arg_14_1)
	if not MatrixItemCfg[arg_14_0] then
		return
	end

	if MatrixConst.ITEM_TYPE.ITEM == MatrixItemCfg[arg_14_0].matrix_item_type then
		-- block empty
	elseif MatrixConst.ITEM_TYPE.EFFECT == MatrixItemCfg[arg_14_0].matrix_item_type then
		var_0_0.DoEffect(MatrixItemCfg[arg_14_0].params[1] or 0)
	end
end

function var_0_0.DoAfterEvnet(arg_15_0)
	return
end

function var_0_0.DoEffect(arg_16_0)
	if not MatrixEffectCfg[arg_16_0] then
		return
	end
end

function var_0_0.QueryMatrixOver(arg_17_0)
	manager.net:SendWithLoadingNew(48020, {}, 48021, arg_17_0)
end

function var_0_0.QueryMatrixGiveUp(arg_18_0)
	manager.net:SendWithLoadingNew(48024, {}, 48025, arg_18_0)
end

function var_0_0.QuerySetMatrixTerminalGift(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0) do
		table.insert(var_19_0, {
			id = iter_19_0,
			level = iter_19_1
		})
	end

	manager.net:SendWithLoadingNew(48022, {
		gift_list = var_19_0
	}, 48023, var_0_0.SetMatrixTerminalGiftCallBack)
end

function var_0_0:SetMatrixTerminalGiftCallBack(arg_20_1)
	if isSuccess(self.result) then
		local var_20_0 = {}

		for iter_20_0, iter_20_1 in ipairs(arg_20_1.gift_list) do
			var_20_0[iter_20_1.id] = iter_20_1.level
		end

		MatrixData:SetTerminalGift(var_20_0)
	else
		ShowTips(self.result)
	end
end

local var_0_3

function var_0_0.BuyShopItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0, var_21_1 = MatrixData:GetMatrixPhaseData():GetData()

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		if iter_21_1.index == arg_21_0 then
			var_0_3 = iter_21_1
			arg_21_2 = arg_21_2 or 0

			manager.net:SendWithLoadingNew(48010, {
				params = {
					2,
					arg_21_0,
					arg_21_1,
					arg_21_2
				}
			}, 48011, var_0_0.OnBuyShopItem)

			return
		end
	end
end

function var_0_0:OnBuyShopItem(arg_22_1)
	if isSuccess(self.result) then
		ShowTips("TRANSACTION_SUCCESS")
		manager.notify:CallUpdateFunc(MATRIX_SHOP_BUY_SUCCESS)

		if var_0_3 ~= nil then
			var_0_0.DoReward(var_0_3.id)

			var_0_3 = nil
		end
	else
		ShowTips(self.result)
	end
end

local var_0_4

function var_0_0.QueryRefreshShopItem()
	local var_23_0, var_23_1 = MatrixData:GetMatrixPhaseData():GetData()
	local var_23_2 = MatrixData:GetShopFressRefreshTimes()

	if var_23_0 < MatrixData:GetShoRefreshTimes() then
		if var_23_2 <= var_23_0 then
			local var_23_3 = GameSetting.matrix_shop_refresh_cost_item_list.value[math.min(var_23_0 - var_23_2 + 1, #GameSetting.matrix_shop_refresh_cost_item_list.value)]

			if ItemTools.getItemNum(var_23_3[1]) < var_23_3[2] then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

				return
			end

			var_0_4 = var_23_3

			manager.net:SendWithLoadingNew(48010, {
				params = {
					1
				}
			}, 48011, var_0_0.OnRefrshShopItem)
		else
			var_0_4 = nil

			manager.net:SendWithLoadingNew(48010, {
				params = {
					1
				}
			}, 48011, var_0_0.OnRefrshShopItem)
		end
	end
end

function var_0_0:OnRefrshShopItem(arg_24_1)
	if isSuccess(self.result) then
		ShowTips("ASTROLABE_RESET")
	else
		ShowTips(self.result)
	end
end

local var_0_5 = {}

function var_0_0:GetBonus()
	var_0_5 = {}

	for iter_25_0, iter_25_1 in ipairs(self.reward) do
		table.insert(var_0_5, {
			iter_25_1.item_id,
			iter_25_1.item_num
		})
	end

	manager.net:SendWithLoadingNew(48014, {
		rank = self.rank
	}, 48015, var_0_0.OnGetBonusCallback)
end

function var_0_0:OnGetBonusCallback(arg_26_1)
	if isSuccess(self.result) then
		getReward((mergeReward((formatRewardCfgList(var_0_5)))))

		var_0_5 = {}

		manager.notify:CallUpdateFunc(MATRIX_ON_GET_BONUS)
	else
		ShowTips(self.result)
	end
end

function var_0_0.OneKeyGetBonus()
	local var_27_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT)
	local var_27_1 = MatrixData:GetTerminalLevel()
	local var_27_2 = {}

	var_0_5 = {}

	for iter_27_0, iter_27_1 in pairs(MatrixData:GetPointRewardList()) do
		if var_27_0 >= MatrixPointRankCfg[iter_27_1.rank].point and iter_27_1.is_got_reward == 0 and var_27_1 >= iter_27_1.need_level then
			for iter_27_2, iter_27_3 in ipairs(iter_27_1.item_list) do
				table.insert(var_0_5, {
					iter_27_3.item_id,
					iter_27_3.item_num
				})
			end

			table.insert(var_27_2, iter_27_1.rank)
		end
	end

	manager.net:SendWithLoadingNew(48016, {
		rank_list = var_27_2
	}, 48017, var_0_0.OnOneKeyGetBonusCallback)
end

function var_0_0:OnOneKeyGetBonusCallback(arg_28_1)
	if isSuccess(self.result) then
		getReward((mergeReward((formatRewardCfgList(var_0_5)))))

		var_0_5 = {}

		manager.notify:CallUpdateFunc(MATRIX_ON_GET_BONUS)
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryUnlockBeacon(arg_29_0)
	manager.net:SendWithLoadingNew(48018, {
		beacon_id = arg_29_0
	}, 48019, var_0_0.OnUnlockBeacon)
end

function var_0_0:OnUnlockBeacon()
	if isSuccess(self.result) then
		ShowTips(GetTips("MATRIX_BEACON_UNLOCK_SUCCESS"))
	else
		ShowTips(self.result)
	end
end

return var_0_0
