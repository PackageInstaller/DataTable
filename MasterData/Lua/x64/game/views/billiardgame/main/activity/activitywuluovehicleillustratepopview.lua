local ActivityWuluoVehicleIllustratePopView = class("ActivityWuluoVehicleIllustratePopView", ReduxView)

function ActivityWuluoVehicleIllustratePopView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_IllustratedPopUI"
end

function ActivityWuluoVehicleIllustratePopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityWuluoVehicleIllustratePopView:Init()
	self:InitUI()
	self:AddUIListner()
end

function ActivityWuluoVehicleIllustratePopView:InitUI()
	self:BindCfgUI()

	self.refreshRewardHandler_ = handler(self, self.RefreshBuffRewardState)
	self.skillClickHandler_ = handler(self, self.OnSkillClick)
	self.formulaSkillClickHandler_ = handler(self, self.OnFormulaSkillClick)
	self.buffTipsModule_ = BilliardGameSkillTipModule.New(self.buffTipsGo_)
	self.tabController_ = self.transCon_:GetController("tab")
	self.rareController_ = self.transCon_:GetController("rare")
	self.tagsController_ = self.transCon_:GetController("tags")
	self.mergeController_ = self.transCon_:GetController("merge")
	self.ultimateController_ = self.transCon_:GetController("ultimate")
	self.tipsController_ = self.transCon_:GetController("tips")
	self.rewardController_ = self.transCon_:GetController("reward")
	self.formulaController_ = self.transCon_:GetController("formula")
	self.trackController_ = self.transCon_:GetController("trackbg")
	self.buffTipsController_ = self.transCon_:GetController("buffTips")
	self.activeSkillItemList_ = {}

	for iter_4_0 = 1, #MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.BASIC] do
		local var_4_0 = BilliardGameSmallSkillItemView.New(self["activeItemGo_" .. iter_4_0])

		var_4_0:RegisterClick(self.skillClickHandler_)
		table.insert(self.activeSkillItemList_, var_4_0)
	end

	self.passiveSkillItemList_ = {}

	for iter_4_1 = 1, #MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.PASSIVE] do
		local var_4_1 = BilliardGameSmallSkillItemView.New(self["passiveItemGo_" .. iter_4_1])

		var_4_1:RegisterClick(self.skillClickHandler_)
		table.insert(self.passiveSkillItemList_, var_4_1)
	end

	self.ultimateSkillItemList_ = {}

	for iter_4_2 = 1, #MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.ULTIMATE] do
		local var_4_2 = BilliardGameSmallSkillItemView.New(self["ultimateItemGo_" .. iter_4_2])

		var_4_2:RegisterClick(self.skillClickHandler_)
		table.insert(self.ultimateSkillItemList_, var_4_2)
	end

	self.selectedSkillItem_ = BilliardGameSmallSkillItemView.New(self.selectItemGo_)
	self.rewardItem_ = CommonItemView.New(self.rewarditemGo_)
	self.formulaSkillItemList_ = {}

	for iter_4_3 = 1, 3 do
		local var_4_3 = BilliardGameSmallSkillItemView.New(self["formulaItemGo_" .. iter_4_3])

		var_4_3:RegisterClick(self.formulaSkillClickHandler_)
		table.insert(self.formulaSkillItemList_, var_4_3)
	end

	self.tabControllerList_ = {}

	for iter_4_4 = 1, 2 do
		self.tabControllerList_[iter_4_4] = self["tabCon_" .. iter_4_4]:GetController("select")
	end
end

function ActivityWuluoVehicleIllustratePopView:AddUIListner()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.tabBtn_1, nil, function()
		if self.selectTab_ == 1 then
			return
		end

		self.tabControllerList_[1]:SetSelectedState("true")
		self.tabControllerList_[2]:SetSelectedState("false")
		self:OnTabClick(1)
	end)
	self:AddBtnListener(self.tabBtn_2, nil, function()
		if self.selectTab_ == 2 then
			return
		end

		self.tabControllerList_[1]:SetSelectedState("false")
		self.tabControllerList_[2]:SetSelectedState("true")
		self:OnTabClick(2)
	end)
	self:AddBtnListener(self.tipsBtn_, nil, function()
		self.tipsController_:SetSelectedState("show")
	end)
	self:AddBtnListener(self.tipsMaskBtn_, nil, function()
		self.tipsController_:SetSelectedState("hide")
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		local var_11_0 = VehicleBallData:GetBuffRewardState(self.selectedSkillItem_.buffId_)

		if var_11_0 and var_11_0 ~= BilliardGameConst.VehicleBallBuffRewardState.RECEIVED_REWARD then
			VehicleBallAction.GetIllustrateReward({
				buffID = self.selectedSkillItem_.buffId_
			})

			return
		end

		ShowPopItem(POP_ITEM, self.rewardData_)
	end)
	self:AddBtnListener(self.trackBtn_, nil, function()
		self.trackController_:SetSelectedState("tracking")
		BilliardGameMgr:SetTrackBuffId(self.selectedSkillItem_.buffId_)
	end)
	self:AddBtnListener(self.untrackBtn_, nil, function()
		self.trackController_:SetSelectedState("track")
		BilliardGameMgr:SetTrackBuffId(nil)
	end)
	self:AddBtnListener(self.buffTipsMask_, nil, function()
		self.buffTipsController_:SetSelectedState("hide")
	end)
end

function ActivityWuluoVehicleIllustratePopView:OnEnter()
	manager.notify:RegistListener(WULUO_VEHICLE_ILLUSTRATE_REWARD_UPDATE, self.refreshRewardHandler_)

	self.tipsText_.text = GetTips("MERGE_BALL_INDEX_REMINDER")
	self.selectTab_ = self.params_.selectTab or 1
	self.enterSelectedBuffId_ = self.params_.selectedBuffId or nil
	self.isInGame_ = self.params_.isInGame or false

	self:CheckTrackState()
	self:OnTabClick(self.selectTab_)
end

function ActivityWuluoVehicleIllustratePopView:OnExit()
	if self.selectItem then
		self.selectItem:SetSelectedState(false)
	end

	if self.isInGame_ then
		manager.notify:Invoke(BilliardGameEvent.SET_BOTTOM_INFO_GO_ACTIVE, true)
	end

	self.buffTipsController_:SetSelectedState("hide")

	self.params_.selectTab = nil
	self.params_.selectedBuffId = nil

	manager.notify:RemoveListener(WULUO_VEHICLE_ILLUSTRATE_REWARD_UPDATE, self.refreshRewardHandler_)
	self:RemoveAllEventListener()

	self.selectItem = nil
	self.enterSelectedBuffId_ = nil

	ActivityWuluoVehicleIllustratePopView.super.OnExit(self)
end

function ActivityWuluoVehicleIllustratePopView:Dispose()
	for iter_17_0, iter_17_1 in ipairs(self.activeSkillItemList_) do
		iter_17_1:Dispose()
	end

	self.activeSkillItemList_ = {}

	for iter_17_2, iter_17_3 in ipairs(self.passiveSkillItemList_) do
		iter_17_3:Dispose()
	end

	self.passiveSkillItemList_ = {}

	for iter_17_4, iter_17_5 in ipairs(self.ultimateSkillItemList_) do
		iter_17_5:Dispose()
	end

	self.ultimateSkillItemList_ = {}

	for iter_17_6, iter_17_7 in ipairs(self.formulaSkillItemList_) do
		iter_17_7:Dispose()
	end

	self.formulaSkillItemList_ = {}

	self.buffTipsModule_:Dispose()
	self.selectedSkillItem_:Dispose()
	self.rewardItem_:Dispose()
	ActivityWuluoVehicleIllustratePopView.super.Dispose(self)
end

function ActivityWuluoVehicleIllustratePopView:CheckTrackState()
	local var_18_0 = BilliardGameMgr:GetTrackBuffId()

	if var_18_0 then
		self.selectTab_ = 2
		self.enterSelectedBuffId_ = var_18_0
	end
end

function ActivityWuluoVehicleIllustratePopView:OnTabClick(arg_19_1)
	self.selectTab_ = arg_19_1

	self.tabController_:SetSelectedIndex(arg_19_1 - 1)

	if self.selectTab_ == 1 then
		self:RefreshBasicSkill()
	else
		self:RefreshMergeSkill()
	end
end

function ActivityWuluoVehicleIllustratePopView:RefreshBasicSkill()
	for iter_20_0, iter_20_1 in ipairs(MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.BASIC]) do
		self:SetBuffData(self.activeSkillItemList_[iter_20_0], iter_20_1, iter_20_0 == 1)
	end

	for iter_20_2, iter_20_3 in ipairs(MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.PASSIVE]) do
		self:SetBuffData(self.passiveSkillItemList_[iter_20_2], iter_20_3)
	end
end

function ActivityWuluoVehicleIllustratePopView:RefreshMergeSkill()
	for iter_21_0, iter_21_1 in ipairs(MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.ADVANCE]) do
		self:SetBuffData(self.activeSkillItemList_[iter_21_0], iter_21_1, iter_21_0 == 1)
	end

	local var_21_0 = VehicleBallData:GetStageProcess()

	self.ultimateController_:SetSelectedIndex(var_21_0)

	if var_21_0 >= BilliardGameConst.StageCount - 1 then
		if not getData("BilliardGameIllu", "ultimateBuffUnlock") then
			self.ultiUnLockAnim_:Play("ultimateBuff_unlock")
			saveData("BilliardGameIllu", "ultimateBuffUnlock", true)
		end

		for iter_21_2, iter_21_3 in ipairs(MergeBallBuffCfg.get_id_list_by_type[BilliardGameConst.MergeBallBuffType.ULTIMATE]) do
			self:SetBuffData(self.ultimateSkillItemList_[iter_21_2], iter_21_3)
		end
	end
end

function ActivityWuluoVehicleIllustratePopView:SetBuffData(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3 or arg_22_2 == self.enterSelectedBuffId_ then
		self:OnSkillClick(arg_22_1, arg_22_2)

		if arg_22_2 == self.enterSelectedBuffId_ then
			self.enterSelectedBuffId_ = nil
		end
	end

	arg_22_1:SetBuffData(arg_22_2)

	local var_22_0 = VehicleBallData:GetBuffRewardState(arg_22_2)

	manager.redPoint:setRedPoint({
		display = arg_22_1.transform_.parent
	}, var_22_0 and var_22_0 == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD)
end

function ActivityWuluoVehicleIllustratePopView:OnSkillClick(arg_23_1, arg_23_2)
	self.descScroll_.verticalNormalizedPosition = 1

	if self.selectItem then
		self.selectItem:SetSelectedState(false)
	end

	self.selectItem = arg_23_1

	arg_23_1:SetSelectedState(true)

	local var_23_0 = MergeBallBuffCfg[arg_23_2]

	self.selectedSkillItem_:SetBuffData(arg_23_2)
	self.rareController_:SetSelectedState(var_23_0.type)

	local var_23_1 = VehicleBallData:IsBuffUnlocked(arg_23_2)

	if var_23_1 then
		self.selectItemNameText_.text = var_23_0.name or "???"
	end

	self.selectItemDescText_.text = var_23_1 and string.format(var_23_0.desc, unpack(var_23_0.param_level[1])) or "???"

	self.tagsController_:SetSelectedIndex(#var_23_0.tag)

	for iter_23_0, iter_23_1 in ipairs(var_23_0.tag) do
		self["selectItemTagText_" .. iter_23_0].text = GetTips("MERGE_BALL_TAG_" .. iter_23_1)
	end

	local var_23_3 = clone(ItemTemplateData)

	var_23_3.id = var_23_0.reward[1]
	var_23_3.number = var_23_0.reward[2]
	self.rewardData_ = var_23_3

	self.rewardItem_:SetData(var_23_3)
	self:RefreshBuffRewardState()

	if #var_23_0.formula > 0 then
		self.mergeController_:SetSelectedState("show")
		self.formulaController_:SetSelectedState(#var_23_0.formula)

		for iter_23_2, iter_23_3 in ipairs(var_23_0.formula) do
			self.formulaSkillItemList_[iter_23_2]:SetBuffData(iter_23_3)
		end
	else
		self.mergeController_:SetSelectedState("hide")
	end

	if #var_23_0.formula > 0 and self.isInGame_ then
		if BilliardGameMgr:GetTrackBuffId() == arg_23_2 then
			self.trackController_:SetSelectedState("tracking")
		else
			self.trackController_:SetSelectedState("track")
		end
	else
		self.trackController_:SetSelectedState("hide")
	end
end

function ActivityWuluoVehicleIllustratePopView:OnFormulaSkillClick(arg_24_1, arg_24_2)
	if arg_24_1 then
		self.buffTipsModule_:SetOneBuffData(arg_24_2, 1)
		self.buffTipsController_:SetSelectedState("show")
	end
end

function ActivityWuluoVehicleIllustratePopView:RefreshBuffRewardState()
	local var_25_0 = VehicleBallData:GetBuffRewardState(self.selectedSkillItem_.buffId_)

	manager.redPoint:setRedPoint({
		display = self.selectItem.transform_.parent
	}, var_25_0 and var_25_0 == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD)

	if var_25_0 then
		if var_25_0 == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD then
			self.rewardController_:SetSelectedState("canget")
		else
			self.rewardController_:SetSelectedState("received")
		end
	else
		self.rewardController_:SetSelectedState("normal")
	end
end

return ActivityWuluoVehicleIllustratePopView
