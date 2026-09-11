local BilliardGameBottomInfoModule = class("BilliardGameBottomInfoModule", ReduxView)

function BilliardGameBottomInfoModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameBottomInfoModule:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.ballInfoModule_ = BilliardGameBallInfoModule.New(self.ballinfoGo_)
	self.tipsModule_ = BilliardGameSkillTipModule.New(self.tipsGo_)
	self.mergeProcessModule_ = BilliardGameMergeProcessModule.New(self.mergeProcessGo_)
	self.skillClickHandler_ = handler(self, self.OnSkillClick)
	self.activeBuffItemList_ = {}
	self.passiveBuffItemList_ = {}

	for iter_2_0 = 1, BilliardGameConst.ActiveSkillCount + BilliardGameMgr:GetAddActiveSkillCount() do
		local var_2_0 = BilliardGameSmallSkillItemView.New(self["activeBuffItem_" .. iter_2_0])

		var_2_0:RegisterClick(self.skillClickHandler_)
		table.insert(self.activeBuffItemList_, var_2_0)
	end

	for iter_2_1 = 1, BilliardGameConst.PassiveSkillCount do
		local var_2_1 = BilliardGameSmallSkillItemView.New(self["passiveBuffItem_" .. iter_2_1])

		var_2_1:RegisterClick(self.skillClickHandler_)
		table.insert(self.passiveBuffItemList_, var_2_1)
	end

	self.activeNumController_ = self.mainControllerEx_:GetController("activeNum")
	self.tipsController_ = self.mainControllerEx_:GetController("tips")
	self.trackController_ = self.mainControllerEx_:GetController("track")
	self.canvas_ = self.transform_:GetComponent(typeof(Canvas))
end

function BilliardGameBottomInfoModule:AddUIListener()
	self:AddBtnListener(self.illustrateBtn_, nil, function()
		if manager.guide:IsPlaying() then
			if manager.guide:GetCurrentGuideStepID() == 26501 then
				manager.guide:SkipGuideStep()
			else
				return
			end
		end

		manager.notify:Invoke(BilliardGameEvent.SET_BOTTOM_INFO_GO_ACTIVE, false)
		JumpTools.OpenPageByJump("activityWuluoVehicleIllustratePopView", {
			isInGame = true
		})
	end)
	self:AddBtnListener(self.tipsMaskBtn_, nil, function()
		if self.selectedSkillItem_ then
			self.selectedSkillItem_:SetSelectedState(false)

			self.selectedSkillItem_ = nil
		end

		self.tipsController_:SetSelectedState("hide")
	end)
end

function BilliardGameBottomInfoModule:OnEnter()
	self.ballInfoModule_:OnEnter(BilliardGameMgr:GetHero())

	self.selectedSkillItem_ = nil

	self.activeNumController_:SetSelectedIndex(BilliardGameMgr:GetAddActiveSkillCount() ~= 0 and 1 or 0)
	self:RefreshBuff()
end

function BilliardGameBottomInfoModule:OnTop()
	self.trackController_:SetSelectedState(BilliardGameMgr:GetTrackBuffId() and "show" or "hide")
end

function BilliardGameBottomInfoModule:SetCanvasSortOrder(arg_8_1)
	self.canvas_.sortingOrder = arg_8_1
end

function BilliardGameBottomInfoModule:CheckGuide()
	self.guideTimer_ = Timer.New(function()
		if manager.guide:IsPlaying() then
			if self.selectedSkillItem_ then
				self.selectedSkillItem_:SetSelectedState(false)

				self.selectedSkillItem_ = nil
			end

			self.tipsController_:SetSelectedState("hide")
		end
	end, 0.33, 1)

	self.guideTimer_:Start()
end

function BilliardGameBottomInfoModule:RefreshHp(arg_11_1)
	self.ballInfoModule_:RefreshHp(arg_11_1)
end

function BilliardGameBottomInfoModule:RefreshVehicleSkill()
	local var_12_0 = BilliardGameMgr:GetActiveSelectSkillList()
	local var_12_1 = BilliardGameMgr:GetPassiveSelectSkillList()

	for iter_12_0, iter_12_1 in ipairs(self.activeBuffItemList_) do
		iter_12_1:SetSkillData(var_12_0[iter_12_0], true)
	end

	for iter_12_2, iter_12_3 in ipairs(self.passiveBuffItemList_) do
		iter_12_3:SetSkillData(var_12_1[iter_12_2], true)
	end
end

function BilliardGameBottomInfoModule:OnSkillClick(arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_1.buffId_ or manager.guide:IsPlaying() then
		return
	end

	if self.selectedSkillItem_ then
		self.selectedSkillItem_:SetSelectedState(false)
	end

	self.selectedSkillItem_ = arg_13_1

	arg_13_1:SetSelectedState(true)

	local var_13_0 = BilliardGameMgr:GetSkillByMainBuffId(arg_13_1.buffId_)

	if var_13_0 then
		self.tipsModule_:SetData(var_13_0)
	else
		self.tipsModule_:SetOneBuffData(arg_13_1.buffId_, 1)
	end

	local var_13_1 = arg_13_3 and 40 or 70
	local var_13_2 = self.tipsGo_.transform.parent
	local var_13_3 = self.tipsGo_.transform.parent.parent:InverseTransformPoint(arg_13_1.transform_.position)

	self.tipsGo_.transform.parent.transform.localPosition = Vector3.New(0, 0, 0)
	var_13_2.transform.localPosition = Vector3.New(var_13_3.x, var_13_3.y + var_13_1, 0)

	self.tipsController_:SetSelectedState("show")
end

function BilliardGameBottomInfoModule:OnSingleSkillUpgrade(arg_14_1)
	if arg_14_1.mainBuffId then
		if MergeBallBuffCfg[arg_14_1.mainBuffId].type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			for iter_14_0, iter_14_1 in ipairs(self.passiveBuffItemList_) do
				if iter_14_1.buffId_ == arg_14_1.mainBuffId then
					iter_14_1:ShowStarLevelAnim(arg_14_1.level)
				end
			end
		else
			for iter_14_2, iter_14_3 in ipairs(self.activeBuffItemList_) do
				if iter_14_3.buffId_ == arg_14_1.mainBuffId then
					iter_14_3:ShowStarLevelAnim(arg_14_1.level)
				end
			end
		end
	end
end

function BilliardGameBottomInfoModule:RefreshBuff()
	local var_15_0, var_15_1 = BilliardGameMgr:GetAnimBuffIdList()

	BilliardGameMgr:ClearAnimBuffIdList()

	local var_15_2 = false

	if #var_15_1 > 0 then
		self:FindAnimBuffAndShow(var_15_1, false)

		var_15_2 = true
	end

	local function var_15_3()
		self:RefreshVehicleSkill()

		if #var_15_0 > 0 then
			self:FindAnimBuffAndShow(var_15_0, true)
		end
	end

	if var_15_2 then
		self.delayTimer_ = Timer.New(function()
			var_15_3()
		end, 0.35, 1)

		self.delayTimer_:Start()
	else
		var_15_3()
	end
end

function BilliardGameBottomInfoModule:FindAnimBuffAndShow(arg_18_1, arg_18_2)
	for iter_18_0 = 1, #arg_18_1 do
		if MergeBallBuffCfg[arg_18_1[iter_18_0]].type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			for iter_18_1, iter_18_2 in ipairs(self.passiveBuffItemList_) do
				if table.indexof(arg_18_1, iter_18_2.buffId_) then
					iter_18_2:ShowBuffAnim(arg_18_2)
				end
			end
		else
			for iter_18_3, iter_18_4 in ipairs(self.activeBuffItemList_) do
				if table.indexof(arg_18_1, iter_18_4.buffId_) then
					iter_18_4:ShowBuffAnim(arg_18_2)
				end
			end
		end
	end
end

function BilliardGameBottomInfoModule:RefreshMergeProcess(arg_19_1)
	self.mergeProcessModule_:RefreshMergeProcess(arg_19_1)
end

function BilliardGameBottomInfoModule:FeedbackMergeProcess(arg_20_1)
	self.mergeProcessModule_:FeedbackMergeProcess(arg_20_1)
end

function BilliardGameBottomInfoModule:OnMergeBack()
	self.mergeProcessModule_:OnMergeBack()
end

function BilliardGameBottomInfoModule:GetIsNeedMerge()
	return self.mergeProcessModule_:GetIsNeedMerge()
end

function BilliardGameBottomInfoModule:HideMergePop()
	self.mergeProcessModule_:HideMergePop()
end

function BilliardGameBottomInfoModule:SetLastNeedProcess(arg_24_1)
	self.mergeProcessModule_:SetLastNeedProcess(arg_24_1)
end

function BilliardGameBottomInfoModule:SetMergeAndBallActive(arg_25_1)
	SetActive(self.ballinfoGo_, arg_25_1)
	SetActive(self.mergeProcessGo_, arg_25_1)
end

function BilliardGameBottomInfoModule:SetDragState(arg_26_1)
	self.canvas_.overrideSorting = not arg_26_1
end

function BilliardGameBottomInfoModule:OnExit()
	if self.delayTimer_ then
		self.delayTimer_:Stop()

		self.delayTimer_ = nil
	end

	if self.guideTimer_ then
		self.guideTimer_:Stop()

		self.guideTimer_ = nil
	end
end

function BilliardGameBottomInfoModule:Dispose()
	for iter_28_0, iter_28_1 in ipairs(self.activeBuffItemList_) do
		iter_28_1:Dispose()
	end

	for iter_28_2, iter_28_3 in ipairs(self.passiveBuffItemList_) do
		iter_28_3:Dispose()
	end

	self.ballInfoModule_:Dispose()
	self.tipsModule_:Dispose()
	self.mergeProcessModule_:Dispose()
	BilliardGameBottomInfoModule.super.Dispose(self)
end

return BilliardGameBottomInfoModule
