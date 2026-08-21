local var_0_0 = {}

manager.net:Bind(83131, function(arg_1_0)
	SimBusinessData:InitFromServer(arg_1_0)
	var_0_0:BindRedPoint()
	SimBusinessTools.UpdataNotPassNormalStageRedPoint()
	SimBusinessTools.UpdataNotPassSpecialStageRedPoint()
	SimBusinessTools.UpdataCanUnlockGoodRedPoint()
	SimBusinessTools.UpdataCanLevelUpShelfRedPoint()
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_2_0)
	if SimBusinessData.activityID == nil then
		return
	end
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_3_0)
	if SimBusinessData.activityID and nullable(ActivityCfg.get_id_list_by_sub_activity_list, arg_3_0, 1) == SimBusinessData.activityID then
		SimBusinessTools.UpdataNotPassNormalStageRedPoint()
		SimBusinessTools.UpdataNotPassSpecialStageRedPoint()
	end
end)

function var_0_0.SendGameFinish(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1.remain > 0 then
			table.insert(var_4_0, {
				guest_id = iter_4_1.id,
				remain_hp = iter_4_1.remain
			})
		end
	end

	manager.net:SendWithLoadingNew(83132, {
		id = arg_4_0,
		guest_list = var_4_0,
		cost_coin = SimBusinessData:GetShelfUseFund(),
		use_seconds = arg_4_2
	}, 83133, var_0_0.OnSendGameFinishCallBack(arg_4_3))
end

function var_0_0.OnSendGameFinishCallBack(arg_5_0)
	return function(arg_6_0, arg_6_1)
		if isSuccess(arg_6_0.result) then
			SimBusinessData:UpdateLevelStatus(arg_6_1.id, arg_6_0.is_clear, arg_6_1.guest_list, arg_6_1.cost_coin)

			if arg_6_0.is_clear then
				SimBusinessTools.UpdateStageRedPointAfterStageClear(arg_6_1.id)
			end

			local var_6_0, var_6_1 = SimBusinessData:UpdateSimBusinessLevel(arg_6_0.new_business_level)

			if arg_5_0 then
				arg_5_0(arg_6_0, arg_6_1, var_6_0, var_6_1)
			end
		else
			ShowTips(arg_6_0.result)
			SimBusinessBridge.GoToMainPage()
		end
	end
end

function var_0_0.SaveShelfDeployment(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		table.insert(var_7_0, SimBusinessData.LocalToNetLayoutInfo(iter_7_1))
	end

	manager.net:SendWithLoadingNew(83134, {
		activity_id = SimBusinessData.activityID,
		layout = {
			shelf_pos_list = var_7_0
		},
		stage_id = arg_7_1
	}, 83135, var_0_0.OnSaveShelfDeployment(arg_7_0, arg_7_2))
end

function var_0_0.OnSaveShelfDeployment(arg_8_0, arg_8_1)
	return function(arg_9_0, arg_9_1)
		if isSuccess(arg_9_0.result) then
			if arg_9_1.stage_id == nil then
				SimBusinessData:UpdateLocalShelvesDeployment(arg_8_0)
			end

			if arg_8_1 then
				arg_8_1()
			end
		else
			ShowTips(arg_9_0.result)
		end
	end
end

local function var_0_1(arg_10_0, arg_10_1, ...)
	if arg_10_0 > 0 then
		local var_10_0 = {
			...
		}

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTipsF("SIM_BUSINESS_CONFIRM_COST", arg_10_0),
			OkCallback = function()
				arg_10_1(unpack(var_10_0))
			end
		})
	else
		arg_10_1(...)
	end
end

local function var_0_2(arg_12_0, arg_12_1)
	manager.net:SendWithLoadingNew(83136, {
		activity_id = SimBusinessData.activityID,
		id = arg_12_0,
		add_level = arg_12_1
	}, 83137, var_0_0.OnUpgradeShelf)
end

function var_0_0.UpgradeShelf(arg_13_0, arg_13_1)
	var_0_2(arg_13_0, arg_13_1)
end

function var_0_0.OnUpgradeShelf(arg_14_0, arg_14_1)
	if isSuccess(arg_14_0.result) then
		SimBusinessData:UpgradeShelf(arg_14_1.id, arg_14_1.add_level)
		manager.notify:CallUpdateFunc(ACTIVITY_SIM_BUSINESS_UPDATE_VIEW)

		if arg_14_1.add_level > 0 then
			ShowTips("SIM_BUSINESS_SHELF_UPGRADE_SUCCESS")
		else
			ShowTips("SIM_BUSINESS_SHELF_REVOKE_SUCCESS")
			SimBusinessTools.MarkShelfRedPointNeverShowAgain(arg_14_1.id)
		end
	else
		ShowTips(arg_14_0.result)
	end
end

local function var_0_3(arg_15_0)
	manager.net:SendWithLoadingNew(83138, {
		is_unlock = true,
		activity_id = SimBusinessData.activityID,
		goods_id_list = arg_15_0
	}, 83139, var_0_0.OnUnlockGoods(nil))
end

function var_0_0.UnlockGoods(arg_16_0)
	var_0_3(arg_16_0)
end

function var_0_0.RevokeUnlockGoods(arg_17_0, arg_17_1)
	manager.net:SendWithLoadingNew(83138, {
		is_unlock = false,
		activity_id = SimBusinessData.activityID,
		goods_id_list = arg_17_0
	}, 83139, var_0_0.OnUnlockGoods(arg_17_1))
end

function var_0_0.OnUnlockGoods(arg_18_0)
	return function(arg_19_0, arg_19_1)
		if isSuccess(arg_19_0.result) then
			SimBusinessData:SetGoodsUnlock(arg_19_1.goods_id_list, arg_19_1.is_unlock)
			manager.notify:CallUpdateFunc(ACTIVITY_SIM_BUSINESS_UPDATE_VIEW)
			ShowTips(arg_19_1.is_unlock and "SIM_BUSINESS_GOODS_UNLOCK_SUCCESS" or "SIM_BUSINESS_GOODS_REVOKE_SUCCESS")

			if not arg_19_1.is_unlock then
				SimBusinessData:ClearLocalShelfGoods(arg_19_1.goods_id_list)

				for iter_19_0, iter_19_1 in ipairs(arg_19_1.goods_id_list) do
					SimBusinessTools.MarkGoodsRedPointNeverShowAgain(iter_19_1)
				end
			end

			if arg_18_0 then
				arg_18_0(arg_19_0, arg_19_1)
			end
		else
			ShowTips(arg_19_0.result)
		end
	end
end

function var_0_0.BindRedPoint(arg_20_0)
	local var_20_0 = SimBusinessData.activityID

	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(var_20_0) .. var_20_0, {
		RedPointConst.ACTIVITY_SIM_BUSINESS_NORMAL_STAGE,
		RedPointConst.ACTIVITY_SIM_BUSINESS_SPECIAL_STAGE,
		RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP,
		RedPointConst.ACTIVITY_SIM_BUSINESS_EXPLAN,
		RedPointConst.ACTIVITY_SIM_BUSINESS_NOT_CHOOSE_GOOD_SHELF
	})
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_SIM_BUSINESS_EXPLAN, {
		RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP,
		RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD
	})

	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(SimBusinessStageCfg.get_id_list_by_type[SimBusinessConst.LevelType.CHALLENGE]) do
		table.insert(var_20_1, SimBusinessTools.GetSpStageRedPoint(iter_20_1))
	end

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_SIM_BUSINESS_SPECIAL_STAGE, var_20_1)

	local var_20_2 = {}

	for iter_20_2, iter_20_3 in ipairs(SimBusinessShelfCfg.all) do
		table.insert(var_20_2, string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP, iter_20_3))
	end

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP, var_20_2)

	local var_20_3 = {}

	for iter_20_4, iter_20_5 in ipairs(SimBusinessGoodsCfg.all) do
		table.insert(var_20_3, string.format("%s_%s", RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD, iter_20_5))
	end

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD, var_20_3)
end

return var_0_0
