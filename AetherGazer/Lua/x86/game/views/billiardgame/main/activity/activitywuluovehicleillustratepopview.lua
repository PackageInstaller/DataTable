local var_0_0 = class("ActivityWuluoVehicleIllustratePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_IllustratedPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListner()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.refreshRewardHandler_ = handler(arg_4_0, arg_4_0.RefreshBuffRewardState)
	arg_4_0.skillClickHandler_ = handler(arg_4_0, arg_4_0.OnSkillClick)
	arg_4_0.formulaSkillClickHandler_ = handler(arg_4_0, arg_4_0.OnFormulaSkillClick)
	arg_4_0.buffTipsModule_ = BilliardGameSkillTipModule.New(arg_4_0.buffTipsGo_)
	arg_4_0.tabController_ = arg_4_0.transCon_:GetController("tab")
	arg_4_0.rareController_ = arg_4_0.transCon_:GetController("rare")
	arg_4_0.tagsController_ = arg_4_0.transCon_:GetController("tags")
	arg_4_0.mergeController_ = arg_4_0.transCon_:GetController("merge")
	arg_4_0.ultimateController_ = arg_4_0.transCon_:GetController("ultimate")
	arg_4_0.tipsController_ = arg_4_0.transCon_:GetController("tips")
	arg_4_0.rewardController_ = arg_4_0.transCon_:GetController("reward")
	arg_4_0.formulaController_ = arg_4_0.transCon_:GetController("formula")
	arg_4_0.trackController_ = arg_4_0.transCon_:GetController("trackbg")
	arg_4_0.buffTipsController_ = arg_4_0.transCon_:GetController("buffTips")
	arg_4_0.activeSkillItemList_ = {}

	for iter_4_0 = 1, #MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.BASIC] do
		local var_4_0 = BilliardGameSmallSkillItemView.New(arg_4_0["activeItemGo_" .. iter_4_0])

		var_4_0:RegisterClick(arg_4_0.skillClickHandler_)
		table.insert(arg_4_0.activeSkillItemList_, var_4_0)
	end

	arg_4_0.passiveSkillItemList_ = {}

	for iter_4_1 = 1, #MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.PASSIVE] do
		local var_4_1 = BilliardGameSmallSkillItemView.New(arg_4_0["passiveItemGo_" .. iter_4_1])

		var_4_1:RegisterClick(arg_4_0.skillClickHandler_)
		table.insert(arg_4_0.passiveSkillItemList_, var_4_1)
	end

	arg_4_0.ultimateSkillItemList_ = {}

	for iter_4_2 = 1, #MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.ULTIMATE] do
		local var_4_2 = BilliardGameSmallSkillItemView.New(arg_4_0["ultimateItemGo_" .. iter_4_2])

		var_4_2:RegisterClick(arg_4_0.skillClickHandler_)
		table.insert(arg_4_0.ultimateSkillItemList_, var_4_2)
	end

	arg_4_0.selectedSkillItem_ = BilliardGameSmallSkillItemView.New(arg_4_0.selectItemGo_)
	arg_4_0.rewardItem_ = CommonItemView.New(arg_4_0.rewarditemGo_)
	arg_4_0.formulaSkillItemList_ = {}

	for iter_4_3 = 1, 3 do
		local var_4_3 = BilliardGameSmallSkillItemView.New(arg_4_0["formulaItemGo_" .. iter_4_3])

		var_4_3:RegisterClick(arg_4_0.formulaSkillClickHandler_)
		table.insert(arg_4_0.formulaSkillItemList_, var_4_3)
	end

	arg_4_0.tabControllerList_ = {}

	for iter_4_4 = 1, 2 do
		arg_4_0.tabControllerList_[iter_4_4] = arg_4_0["tabCon_" .. iter_4_4]:GetController("select")
	end
end

function var_0_0.AddUIListner(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.tabBtn_1, nil, function()
		if arg_5_0.selectTab_ == 1 then
			return
		end

		arg_5_0.tabControllerList_[1]:SetSelectedState("true")
		arg_5_0.tabControllerList_[2]:SetSelectedState("false")
		arg_5_0:OnTabClick(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tabBtn_2, nil, function()
		if arg_5_0.selectTab_ == 2 then
			return
		end

		arg_5_0.tabControllerList_[1]:SetSelectedState("false")
		arg_5_0.tabControllerList_[2]:SetSelectedState("true")
		arg_5_0:OnTabClick(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsBtn_, nil, function()
		arg_5_0.tipsController_:SetSelectedState("show")
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipsMaskBtn_, nil, function()
		arg_5_0.tipsController_:SetSelectedState("hide")
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		local var_11_0 = VehicleBallData:GetBuffRewardState(arg_5_0.selectedSkillItem_.buffId_)

		if var_11_0 and var_11_0 ~= BilliardGameConst.VehicleBallBuffRewardState.RECEIVED_REWARD then
			VehicleBallAction.GetIllustrateReward({
				buffID = arg_5_0.selectedSkillItem_.buffId_
			})

			return
		end

		ShowPopItem(POP_ITEM, arg_5_0.rewardData_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.trackBtn_, nil, function()
		arg_5_0.trackController_:SetSelectedState("tracking")
		BilliardGameMgr:SetTrackBuffId(arg_5_0.selectedSkillItem_.buffId_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.untrackBtn_, nil, function()
		arg_5_0.trackController_:SetSelectedState("track")
		BilliardGameMgr:SetTrackBuffId(nil)
	end)
	arg_5_0:AddBtnListener(arg_5_0.buffTipsMask_, nil, function()
		arg_5_0.buffTipsController_:SetSelectedState("hide")
	end)
end

function var_0_0.OnEnter(arg_15_0)
	manager.notify:RegistListener(WULUO_VEHICLE_ILLUSTRATE_REWARD_UPDATE, arg_15_0.refreshRewardHandler_)

	arg_15_0.tipsText_.text = GetTips("MERGE_BALL_INDEX_REMINDER")
	arg_15_0.selectTab_ = arg_15_0.params_.selectTab or 1
	arg_15_0.enterSelectedBuffId_ = arg_15_0.params_.selectedBuffId or nil
	arg_15_0.isInGame_ = arg_15_0.params_.isInGame or false

	arg_15_0:CheckTrackState()
	arg_15_0:OnTabClick(arg_15_0.selectTab_)
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.selectItem then
		arg_16_0.selectItem:SetSelectedState(false)
	end

	if arg_16_0.isInGame_ then
		manager.notify:Invoke(BilliardGameEvent.SET_BOTTOM_INFO_GO_ACTIVE, true)
	end

	arg_16_0.buffTipsController_:SetSelectedState("hide")

	arg_16_0.params_.selectTab = nil
	arg_16_0.params_.selectedBuffId = nil

	manager.notify:RemoveListener(WULUO_VEHICLE_ILLUSTRATE_REWARD_UPDATE, arg_16_0.refreshRewardHandler_)
	arg_16_0:RemoveAllEventListener()

	arg_16_0.selectItem = nil
	arg_16_0.enterSelectedBuffId_ = nil

	var_0_0.super.OnExit(arg_16_0)
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.activeSkillItemList_) do
		iter_17_1:Dispose()
	end

	arg_17_0.activeSkillItemList_ = {}

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.passiveSkillItemList_) do
		iter_17_3:Dispose()
	end

	arg_17_0.passiveSkillItemList_ = {}

	for iter_17_4, iter_17_5 in ipairs(arg_17_0.ultimateSkillItemList_) do
		iter_17_5:Dispose()
	end

	arg_17_0.ultimateSkillItemList_ = {}

	for iter_17_6, iter_17_7 in ipairs(arg_17_0.formulaSkillItemList_) do
		iter_17_7:Dispose()
	end

	arg_17_0.formulaSkillItemList_ = {}

	arg_17_0.buffTipsModule_:Dispose()
	arg_17_0.selectedSkillItem_:Dispose()
	arg_17_0.rewardItem_:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.CheckTrackState(arg_18_0)
	local var_18_0 = BilliardGameMgr:GetTrackBuffId()

	if var_18_0 then
		arg_18_0.selectTab_ = 2
		arg_18_0.enterSelectedBuffId_ = var_18_0
	end
end

function var_0_0.OnTabClick(arg_19_0, arg_19_1)
	arg_19_0.selectTab_ = arg_19_1

	arg_19_0.tabController_:SetSelectedIndex(arg_19_1 - 1)

	if arg_19_0.selectTab_ == 1 then
		arg_19_0:RefreshBasicSkill()
	else
		arg_19_0:RefreshMergeSkill()
	end
end

function var_0_0.RefreshBasicSkill(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.BASIC]) do
		arg_20_0:SetBuffData(arg_20_0.activeSkillItemList_[iter_20_0], iter_20_1, iter_20_0 == 1)
	end

	for iter_20_2, iter_20_3 in ipairs(MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.PASSIVE]) do
		arg_20_0:SetBuffData(arg_20_0.passiveSkillItemList_[iter_20_2], iter_20_3)
	end
end

function var_0_0.RefreshMergeSkill(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.ADVANCE]) do
		arg_21_0:SetBuffData(arg_21_0.activeSkillItemList_[iter_21_0], iter_21_1, iter_21_0 == 1)
	end

	local var_21_0 = VehicleBallData:GetStageProcess()

	arg_21_0.ultimateController_:SetSelectedIndex(var_21_0)

	if var_21_0 >= BilliardGameConst.StageCount - 1 then
		if not getData("BilliardGameIllu", "ultimateBuffUnlock") then
			arg_21_0.ultiUnLockAnim_:Play("ultimateBuff_unlock")
			saveData("BilliardGameIllu", "ultimateBuffUnlock", true)
		end

		for iter_21_2, iter_21_3 in ipairs(MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.ULTIMATE]) do
			arg_21_0:SetBuffData(arg_21_0.ultimateSkillItemList_[iter_21_2], iter_21_3)
		end
	end
end

function var_0_0.SetBuffData(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3 or arg_22_2 == arg_22_0.enterSelectedBuffId_ then
		arg_22_0:OnSkillClick(arg_22_1, arg_22_2)

		if arg_22_2 == arg_22_0.enterSelectedBuffId_ then
			arg_22_0.enterSelectedBuffId_ = nil
		end
	end

	arg_22_1:SetBuffData(arg_22_2)

	local var_22_0 = VehicleBallData:GetBuffRewardState(arg_22_2)
	local var_22_1 = var_22_0 and var_22_0 == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD

	manager.redPoint:setRedPoint({
		display = arg_22_1.transform_.parent
	}, var_22_1)
end

function var_0_0.OnSkillClick(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.descScroll_.verticalNormalizedPosition = 1

	if arg_23_0.selectItem then
		arg_23_0.selectItem:SetSelectedState(false)
	end

	arg_23_0.selectItem = arg_23_1

	arg_23_1:SetSelectedState(true)

	local var_23_0 = MergeBallBuffCfg[arg_23_2]

	arg_23_0.selectedSkillItem_:SetBuffData(arg_23_2)
	arg_23_0.rareController_:SetSelectedState(var_23_0.type)

	local var_23_1 = VehicleBallData:IsBuffUnlocked(arg_23_2)

	arg_23_0.selectItemNameText_.text = var_23_1 and var_23_0.name or "???"
	arg_23_0.selectItemDescText_.text = var_23_1 and string.format(var_23_0.desc, unpack(var_23_0.param_level[1])) or "???"

	local var_23_2 = #var_23_0.tag

	arg_23_0.tagsController_:SetSelectedIndex(var_23_2)

	for iter_23_0, iter_23_1 in ipairs(var_23_0.tag) do
		arg_23_0["selectItemTagText_" .. iter_23_0].text = GetTips("MERGE_BALL_TAG_" .. iter_23_1)
	end

	local var_23_3 = clone(ItemTemplateData)

	var_23_3.id = var_23_0.reward[1]
	var_23_3.number = var_23_0.reward[2]
	arg_23_0.rewardData_ = var_23_3

	arg_23_0.rewardItem_:SetData(var_23_3)
	arg_23_0:RefreshBuffRewardState()

	if #var_23_0.formula > 0 then
		arg_23_0.mergeController_:SetSelectedState("show")
		arg_23_0.formulaController_:SetSelectedState(#var_23_0.formula)

		for iter_23_2, iter_23_3 in ipairs(var_23_0.formula) do
			arg_23_0.formulaSkillItemList_[iter_23_2]:SetBuffData(iter_23_3)
		end
	else
		arg_23_0.mergeController_:SetSelectedState("hide")
	end

	if #var_23_0.formula > 0 and arg_23_0.isInGame_ then
		if BilliardGameMgr:GetTrackBuffId() == arg_23_2 then
			arg_23_0.trackController_:SetSelectedState("tracking")
		else
			arg_23_0.trackController_:SetSelectedState("track")
		end
	else
		arg_23_0.trackController_:SetSelectedState("hide")
	end
end

function var_0_0.OnFormulaSkillClick(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 then
		arg_24_0.buffTipsModule_:SetOneBuffData(arg_24_2, 1)
		arg_24_0.buffTipsController_:SetSelectedState("show")
	end
end

function var_0_0.RefreshBuffRewardState(arg_25_0)
	local var_25_0 = VehicleBallData:GetBuffRewardState(arg_25_0.selectedSkillItem_.buffId_)
	local var_25_1 = var_25_0 and var_25_0 == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD

	manager.redPoint:setRedPoint({
		display = arg_25_0.selectItem.transform_.parent
	}, var_25_1)

	if var_25_0 then
		if var_25_0 == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD then
			arg_25_0.rewardController_:SetSelectedState("canget")
		else
			arg_25_0.rewardController_:SetSelectedState("received")
		end
	else
		arg_25_0.rewardController_:SetSelectedState("normal")
	end
end

return var_0_0
