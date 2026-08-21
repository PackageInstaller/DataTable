local var_0_0 = {}

manager.net:Bind(26001, function(arg_1_0)
	ActivityMatrixData:InitMatrixUser(arg_1_0.matrix)
	var_0_0.CheckRewardRedPonit()
	var_0_0.CheckReadRedPonit()
end)
manager.net:Bind(26005, function(arg_2_0)
	ActivityMatrixData:InitMatrixOver(arg_2_0.end_info)
end)
manager.net:Bind(26007, function(arg_3_0)
	ActivityMatrixData:InitMatrixClue(arg_3_0)
	var_0_0.CheckClueRedPoint(arg_3_0.activity_id)
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_4_0)
	local var_4_0 = ActivityTools.GetActivityType(arg_4_0)

	if var_4_0 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
		var_0_0.CheckRewardRedPonit()
		var_0_0.CheckReadRedPonit()
	end

	if var_4_0 == ActivityTemplateConst.SINGLE_MATRIX then
		var_0_0.CheckClueRedPoint(arg_4_0)
	end
end)

function var_0_0.QueryStartMatrix(arg_5_0, arg_5_1, arg_5_2)
	manager.net:SendWithLoadingNew(26012, {
		select_hero_list = arg_5_0,
		activity_id = arg_5_1,
		custom_affix_id_list = arg_5_2
	}, 26013, var_0_0.StartMatrixCallBack)
end

function var_0_0.StartMatrixCallBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		ActivityMatrixData:UpdateMatrixProcess(arg_6_1.activity_id, MatrixConst.STATE_TYPE.STARTED, arg_6_0.progress)
		JumpTools.GoToSystem("/matrixBlank/activityMatrixOrigin", {
			matrix_activity_id = arg_6_1.activity_id
		})
		ActivityMatrixData:SetMatrixBattleHeroTeam(arg_6_1.activity_id, nil)
	else
		ShowTips(arg_6_0.result)
	end
end

local var_0_1
local var_0_2

function var_0_0.QueryNextProgress(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {
		0
	}
	var_0_1 = ActivityMatrixData:GetMatrixPhaseData(arg_7_0)
	var_0_2 = ActivityMatrixData:GetTierID(arg_7_0)

	manager.net:SendWithLoadingNew(26010, {
		activity_id = arg_7_0,
		params = arg_7_1
	}, 26011, var_0_0.NextProgressCallBack)
end

function var_0_0.NextProgressCallBack(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.activity_id

	if isSuccess(arg_8_0.result) then
		ActivityMatrixData:UpdateMatrixProcess(arg_8_1.activity_id, MatrixConst.STATE_TYPE.STARTED, arg_8_0.progress)

		local var_8_1 = ActivityMatrixData:GetGameState(var_8_0)

		if var_8_1 == MatrixConst.STATE_TYPE.STARTED then
			local var_8_2 = var_0_1:GetPhase()
			local var_8_3 = arg_8_1.params and arg_8_1.params[1]

			if MatrixConst.PHASE_TYPE.REWARD == var_8_2 then
				local var_8_4 = false

				if not var_8_3 then
					var_8_4 = true
					var_8_3 = var_0_1:GetGiveUpItemId() or 0
				end

				var_0_0.DoReward(var_8_3, var_8_4, var_8_0)
			elseif MatrixConst.PHASE_TYPE.ACTION == var_8_2 then
				local var_8_5 = var_0_1:GetParams()[1]
				local var_8_6 = ActivityMatrixEventTemplateCfg[var_8_5]

				if MatrixConst.EVENT_TYPE.INCIDENT == var_8_6.event_type then
					local var_8_7 = MatrixChanceCfg[var_8_3]

					var_0_0.DoEffect(var_8_7.toll)
				end

				var_0_0.DoAfterEvnet(var_8_0, var_0_2)
			end

			if ActivityMatrixData:GetMatrixPhaseData(var_8_0):GetPhase() == 2 then
				var_0_0.DoEvent(var_8_0)
			end
		elseif var_8_1 == MatrixConst.STATE_TYPE.SUCCESS or var_8_1 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/matrixOver")
		else
			OpenPageUntilLoaded("/matrixBlank/matrixPrepare")
		end

		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_8_0.result)
	end

	var_0_1 = nil
	var_0_2 = nil
end

function var_0_0.DoEvent(arg_9_0)
	local var_9_0 = ActivityMatrixData:GetMatrixPhaseData(arg_9_0)
	local var_9_1 = var_9_0:GetParams()[1]
	local var_9_2 = var_9_1 and ActivityMatrixEventTemplateCfg[var_9_1]

	if not var_9_2 then
		error("ActivityMatrixEventTemplateCfg cant find event by id :" .. var_9_1)

		return
	end

	if MatrixConst.EVENT_TYPE.SHOP == var_9_2.event_type then
		local var_9_3 = var_9_0:GetShops()

		JumpTools.GoToSystem("/matrixBlank/activityMatrixProcessShop", {
			matrix_activity_id = arg_9_0,
			shops = var_9_3
		})
	elseif MatrixConst.EVENT_TYPE.INCIDENT == var_9_2.event_type then
		-- block empty
	else
		local var_9_4 = var_9_0:GetData()
		local var_9_5 = BattleActivityMatrixTemplate.New(var_9_4, arg_9_0)

		BattleController.GetInstance():LaunchBattle(var_9_5)
	end
end

function var_0_0.DoReward(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = MatrixItemCfg[arg_10_0]

	if not var_10_0 then
		return
	end

	if MatrixConst.ITEM_TYPE.ITEM == var_10_0.matrix_item_type then
		-- block empty
	elseif MatrixConst.ITEM_TYPE.EFFECT == var_10_0.matrix_item_type then
		local var_10_1 = var_10_0.params[1] or 0

		var_0_0.DoEffect(var_10_1)
	end
end

function var_0_0.DoAfterEvnet(arg_11_0, arg_11_1)
	return
end

function var_0_0.DoEffect(arg_12_0)
	if not MatrixEffectCfg[arg_12_0] then
		return
	end
end

function var_0_0.QueryMatrixOver(arg_13_0)
	manager.net:SendWithLoadingNew(26020, {
		activity_id = arg_13_0
	}, 26021, var_0_0.MatrixOverCallBack)
end

function var_0_0.MatrixOverCallBack(arg_14_0, arg_14_1)
	if isSuccess(arg_14_0.result) then
		ActivityMatrixData:UpdateMatrixProcess(arg_14_1.activity_id, MatrixConst.STATE_TYPE.NOTSTARTED, arg_14_0.progress)

		local var_14_0 = ActivityMatrixData:GetMainActivityId(arg_14_1.activity_id)

		JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
			main_matrix_activity_id = var_14_0,
			matrix_activity_id = arg_14_1.activity_id
		})
		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_14_0.result)
	end
end

function var_0_0.QueryMatrixGiveUp(arg_15_0)
	manager.net:SendWithLoadingNew(26024, {
		activity_id = arg_15_0
	}, 26025, var_0_0.MatrixGiveUpCallBack)
end

function var_0_0.MatrixGiveUpCallBack(arg_16_0, arg_16_1)
	if isSuccess(arg_16_0.result) then
		ActivityMatrixData:UpdateMatrixProcess(arg_16_1.activity_id, MatrixConst.STATE_TYPE.FAIL, arg_16_0.progress)
		JumpTools.GoToSystem("/matrixBlank/activityMatrixOver", {
			matrix_activity_id = arg_16_1.activity_id
		})
		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_16_0.result)
	end
end

local var_0_3

function var_0_0.BuyShopItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0, var_17_1 = ActivityMatrixData:GetMatrixPhaseData(arg_17_0):GetData()

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if iter_17_1.index == arg_17_1 then
			var_0_3 = iter_17_1
			arg_17_3 = arg_17_3 or 0

			manager.net:SendWithLoadingNew(26010, {
				activity_id = arg_17_0,
				params = {
					2,
					arg_17_1,
					arg_17_2,
					arg_17_3
				}
			}, 26011, var_0_0.OnBuyShopItem)

			return
		end
	end
end

function var_0_0.OnBuyShopItem(arg_18_0, arg_18_1)
	if isSuccess(arg_18_0.result) then
		ActivityMatrixData:UpdateMatrixProcess(arg_18_1.activity_id, MatrixConst.STATE_TYPE.STARTED, arg_18_0.progress)
		ShowTips("TRANSACTION_SUCCESS")
		manager.notify:CallUpdateFunc(MATRIX_SHOP_BUY_SUCCESS)

		if var_0_3 ~= nil then
			local var_18_0 = var_0_3.id

			var_0_0.DoReward(var_18_0)

			var_0_3 = nil
		end

		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_18_0.result)
	end
end

function var_0_0.QueryRefreshShopItem(arg_19_0)
	local var_19_0 = ActivityMatrixData:GetMatrixPhaseData(arg_19_0):GetData()
	local var_19_1 = ActivityMatrixData:GetShoRefreshTimes(arg_19_0)
	local var_19_2 = ActivityMatrixData:GetShopFressRefreshTimes(arg_19_0)

	if var_19_0 < var_19_1 then
		local var_19_3 = GameSetting.matrix_shop_refresh_cost_item_list.value

		if var_19_2 <= var_19_0 then
			local var_19_4 = var_19_0 - var_19_2
			local var_19_5 = var_19_3[math.min(var_19_4 + 1, #var_19_3)]

			if ActivityMatrixData:GetMatrixCoint(arg_19_0) < var_19_5[2] then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

				return
			end

			manager.net:SendWithLoadingNew(26010, {
				activity_id = arg_19_0,
				params = {
					1
				}
			}, 26011, var_0_0.OnRefrshShopItem)
		else
			manager.net:SendWithLoadingNew(26010, {
				activity_id = arg_19_0,
				params = {
					1
				}
			}, 26011, var_0_0.OnRefrshShopItem)
		end
	end
end

function var_0_0.OnRefrshShopItem(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		ActivityMatrixData:UpdateMatrixProcess(arg_20_1.activity_id, MatrixConst.STATE_TYPE.STARTED, arg_20_0.progress)
		ShowTips("ASTROLABE_RESET")
		manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
	else
		ShowTips(arg_20_0.result)
	end
end

function var_0_0.OnReceivePointReward(arg_21_0, arg_21_1)
	ActivityMatrixData:OnReceivePointReward(arg_21_0, arg_21_1)
	var_0_0.CheckRewardRedPonit()
end

function var_0_0.CheckRewardRedPonit()
	local var_22_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SINGLE_MATRIX] or {}

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if ActivityData:GetActivityIsOpen(iter_22_1) then
			local var_22_1 = ActivityCfg[iter_22_1]
			local var_22_2 = false

			for iter_22_2, iter_22_3 in ipairs(var_22_1.sub_activity_list) do
				if ActivityMatrixData:GetMatrixPointCanReward(iter_22_3) then
					var_22_2 = true

					break
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_REWARD, iter_22_1), var_22_2 and 1 or 0)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_REWARD, iter_22_1), 0)
		end
	end
end

function var_0_0.CheckReadRedPonit()
	local var_23_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SINGLE_MATRIX] or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_1 = ActivityCfg[iter_23_1]
		local var_23_2 = false

		if ActivityData:GetActivityIsOpen(iter_23_1) then
			for iter_23_2, iter_23_3 in ipairs(var_23_1.sub_activity_list) do
				if var_0_0.CheckSubReadRedPonit(iter_23_3) then
					var_23_2 = true

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_READ, iter_23_1), var_23_2 and 1 or 0)
	end
end

function var_0_0.CheckSubReadRedPonit(arg_24_0)
	if not ActivityMatrixData:GetRead(arg_24_0) then
		local var_24_0 = ActivityMatrixData:GetMatrixData(arg_24_0)
		local var_24_1 = ActivityMatrixCfg[arg_24_0]

		if var_24_0 and var_24_0.point == 0 and MatrixConst.STATE_TYPE.NOTSTARTED == var_24_0.game_state and ActivityMatrixData:GetIsClearance(var_24_1.preconditions) and ActivityData:GetActivityIsOpen(arg_24_0) then
			return true
		end
	end

	return false
end

function var_0_0.SetActivityMtairxRead(arg_25_0, arg_25_1)
	local var_25_0 = ActivityMatrixCfg[arg_25_1]

	if not ActivityMatrixData:GetIsClearance(var_25_0.preconditions) or not ActivityData:GetActivityIsOpen(arg_25_1) then
		return
	end

	ActivityMatrixData:SetRead(arg_25_1)

	local var_25_1 = ActivityCfg[arg_25_0]
	local var_25_2 = false

	for iter_25_0, iter_25_1 in ipairs(var_25_1.sub_activity_list) do
		if var_0_0.CheckSubReadRedPonit(iter_25_1) then
			var_25_2 = true

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_READ, arg_25_0), var_25_2 and 1 or 0)
end

function var_0_0.CheckClueRedPoint(arg_26_0)
	if ActivityData:GetActivityIsOpen(arg_26_0) then
		local var_26_0 = ActivityMatrixData:GetMatrixClue(arg_26_0)

		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			if not ActivityMatrixData:GetClueRead(arg_26_0, iter_26_1.clue_id) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, arg_26_0), 1)

				return
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, arg_26_0), 0)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, arg_26_0), 0)
	end
end

function var_0_0.SetClueRead(arg_27_0, arg_27_1)
	ActivityMatrixData:SetClueRead(arg_27_0, arg_27_1)
	var_0_0.CheckClueRedPoint(arg_27_0)
end

local var_0_4

function var_0_0.GetSelectCamp()
	if not var_0_4 then
		var_0_4 = getData("AcvityMatrixClue", "selectCamp")
	end

	if type(var_0_4) ~= "number" then
		var_0_4 = 1
	end

	return var_0_4
end

function var_0_0.SetSelectCamp(arg_29_0)
	var_0_4 = arg_29_0

	saveData("AcvityMatrixClue", "selectCamp", var_0_4)
end

local var_0_5

function var_0_0.GetSelectClue()
	if not var_0_5 then
		var_0_5 = 1
	end

	return var_0_5
end

function var_0_0.SetSelectClue(arg_31_0)
	var_0_5 = arg_31_0
end

return var_0_0
