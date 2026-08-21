local var_0_0 = class("BilliardGameBottomInfoModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.ballInfoModule_ = BilliardGameBallInfoModule.New(arg_2_0.ballinfoGo_)
	arg_2_0.tipsModule_ = BilliardGameSkillTipModule.New(arg_2_0.tipsGo_)
	arg_2_0.mergeProcessModule_ = BilliardGameMergeProcessModule.New(arg_2_0.mergeProcessGo_)
	arg_2_0.skillClickHandler_ = handler(arg_2_0, arg_2_0.OnSkillClick)
	arg_2_0.activeBuffItemList_ = {}
	arg_2_0.passiveBuffItemList_ = {}

	for iter_2_0 = 1, BilliardGameConst.ActiveSkillCount + BilliardGameMgr:GetAddActiveSkillCount() do
		local var_2_0 = BilliardGameSmallSkillItemView.New(arg_2_0["activeBuffItem_" .. iter_2_0])

		var_2_0:RegisterClick(arg_2_0.skillClickHandler_)
		table.insert(arg_2_0.activeBuffItemList_, var_2_0)
	end

	for iter_2_1 = 1, BilliardGameConst.PassiveSkillCount do
		local var_2_1 = BilliardGameSmallSkillItemView.New(arg_2_0["passiveBuffItem_" .. iter_2_1])

		var_2_1:RegisterClick(arg_2_0.skillClickHandler_)
		table.insert(arg_2_0.passiveBuffItemList_, var_2_1)
	end

	arg_2_0.activeNumController_ = arg_2_0.mainControllerEx_:GetController("activeNum")
	arg_2_0.tipsController_ = arg_2_0.mainControllerEx_:GetController("tips")
	arg_2_0.trackController_ = arg_2_0.mainControllerEx_:GetController("track")
	arg_2_0.canvas_ = arg_2_0.transform_:GetComponent(typeof(Canvas))
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.illustrateBtn_, nil, function()
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
	arg_3_0:AddBtnListener(arg_3_0.tipsMaskBtn_, nil, function()
		if arg_3_0.selectedSkillItem_ then
			arg_3_0.selectedSkillItem_:SetSelectedState(false)

			arg_3_0.selectedSkillItem_ = nil
		end

		arg_3_0.tipsController_:SetSelectedState("hide")
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.ballInfoModule_:OnEnter(BilliardGameMgr:GetHero())

	arg_6_0.selectedSkillItem_ = nil

	arg_6_0.activeNumController_:SetSelectedIndex(BilliardGameMgr:GetAddActiveSkillCount() ~= 0 and 1 or 0)
	arg_6_0:RefreshBuff()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0.trackController_:SetSelectedState(BilliardGameMgr:GetTrackBuffId() and "show" or "hide")
end

function var_0_0.SetCanvasSortOrder(arg_8_0, arg_8_1)
	arg_8_0.canvas_.sortingOrder = arg_8_1
end

function var_0_0.CheckGuide(arg_9_0)
	arg_9_0.guideTimer_ = Timer.New(function()
		if manager.guide:IsPlaying() then
			if arg_9_0.selectedSkillItem_ then
				arg_9_0.selectedSkillItem_:SetSelectedState(false)

				arg_9_0.selectedSkillItem_ = nil
			end

			arg_9_0.tipsController_:SetSelectedState("hide")
		end
	end, 0.33, 1)

	arg_9_0.guideTimer_:Start()
end

function var_0_0.RefreshHp(arg_11_0, arg_11_1)
	arg_11_0.ballInfoModule_:RefreshHp(arg_11_1)
end

function var_0_0.RefreshVehicleSkill(arg_12_0)
	local var_12_0 = BilliardGameMgr:GetActiveSelectSkillList()
	local var_12_1 = BilliardGameMgr:GetPassiveSelectSkillList()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.activeBuffItemList_) do
		iter_12_1:SetSkillData(var_12_0[iter_12_0], true)
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.passiveBuffItemList_) do
		iter_12_3:SetSkillData(var_12_1[iter_12_2], true)
	end
end

function var_0_0.OnSkillClick(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_1.buffId_ or manager.guide:IsPlaying() then
		return
	end

	if arg_13_0.selectedSkillItem_ then
		arg_13_0.selectedSkillItem_:SetSelectedState(false)
	end

	arg_13_0.selectedSkillItem_ = arg_13_1

	arg_13_1:SetSelectedState(true)

	local var_13_0 = BilliardGameMgr:GetSkillByMainBuffId(arg_13_1.buffId_)

	if var_13_0 then
		arg_13_0.tipsModule_:SetData(var_13_0)
	else
		arg_13_0.tipsModule_:SetOneBuffData(arg_13_1.buffId_, 1)
	end

	local var_13_1 = arg_13_3 and 40 or 70
	local var_13_2 = arg_13_0.tipsGo_.transform.parent
	local var_13_3 = var_13_2.parent:InverseTransformPoint(arg_13_1.transform_.position)

	var_13_2.transform.localPosition = Vector3.New(0, 0, 0)
	var_13_2.transform.localPosition = Vector3.New(var_13_3.x, var_13_3.y + var_13_1, 0)

	arg_13_0.tipsController_:SetSelectedState("show")
end

function var_0_0.OnSingleSkillUpgrade(arg_14_0, arg_14_1)
	if arg_14_1.mainBuffId then
		if MergeBallBuffCfg[arg_14_1.mainBuffId].type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			for iter_14_0, iter_14_1 in ipairs(arg_14_0.passiveBuffItemList_) do
				if iter_14_1.buffId_ == arg_14_1.mainBuffId then
					iter_14_1:ShowStarLevelAnim(arg_14_1.level)
				end
			end
		else
			for iter_14_2, iter_14_3 in ipairs(arg_14_0.activeBuffItemList_) do
				if iter_14_3.buffId_ == arg_14_1.mainBuffId then
					iter_14_3:ShowStarLevelAnim(arg_14_1.level)
				end
			end
		end
	end
end

function var_0_0.RefreshBuff(arg_15_0)
	local var_15_0, var_15_1 = BilliardGameMgr:GetAnimBuffIdList()

	BilliardGameMgr:ClearAnimBuffIdList()

	local var_15_2 = false

	if #var_15_1 > 0 then
		arg_15_0:FindAnimBuffAndShow(var_15_1, false)

		var_15_2 = true
	end

	local function var_15_3()
		arg_15_0:RefreshVehicleSkill()

		if #var_15_0 > 0 then
			arg_15_0:FindAnimBuffAndShow(var_15_0, true)
		end
	end

	if var_15_2 then
		arg_15_0.delayTimer_ = Timer.New(function()
			var_15_3()
		end, 0.35, 1)

		arg_15_0.delayTimer_:Start()
	else
		var_15_3()
	end
end

function var_0_0.FindAnimBuffAndShow(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0 = 1, #arg_18_1 do
		if MergeBallBuffCfg[arg_18_1[iter_18_0]].type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			for iter_18_1, iter_18_2 in ipairs(arg_18_0.passiveBuffItemList_) do
				if table.indexof(arg_18_1, iter_18_2.buffId_) then
					iter_18_2:ShowBuffAnim(arg_18_2)
				end
			end
		else
			for iter_18_3, iter_18_4 in ipairs(arg_18_0.activeBuffItemList_) do
				if table.indexof(arg_18_1, iter_18_4.buffId_) then
					iter_18_4:ShowBuffAnim(arg_18_2)
				end
			end
		end
	end
end

function var_0_0.RefreshMergeProcess(arg_19_0, arg_19_1)
	arg_19_0.mergeProcessModule_:RefreshMergeProcess(arg_19_1)
end

function var_0_0.FeedbackMergeProcess(arg_20_0, arg_20_1)
	arg_20_0.mergeProcessModule_:FeedbackMergeProcess(arg_20_1)
end

function var_0_0.OnMergeBack(arg_21_0)
	arg_21_0.mergeProcessModule_:OnMergeBack()
end

function var_0_0.GetIsNeedMerge(arg_22_0)
	return arg_22_0.mergeProcessModule_:GetIsNeedMerge()
end

function var_0_0.HideMergePop(arg_23_0)
	arg_23_0.mergeProcessModule_:HideMergePop()
end

function var_0_0.SetLastNeedProcess(arg_24_0, arg_24_1)
	arg_24_0.mergeProcessModule_:SetLastNeedProcess(arg_24_1)
end

function var_0_0.SetMergeAndBallActive(arg_25_0, arg_25_1)
	SetActive(arg_25_0.ballinfoGo_, arg_25_1)
	SetActive(arg_25_0.mergeProcessGo_, arg_25_1)
end

function var_0_0.SetDragState(arg_26_0, arg_26_1)
	arg_26_0.canvas_.overrideSorting = not arg_26_1
end

function var_0_0.OnExit(arg_27_0)
	if arg_27_0.delayTimer_ then
		arg_27_0.delayTimer_:Stop()

		arg_27_0.delayTimer_ = nil
	end

	if arg_27_0.guideTimer_ then
		arg_27_0.guideTimer_:Stop()

		arg_27_0.guideTimer_ = nil
	end
end

function var_0_0.Dispose(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.activeBuffItemList_) do
		iter_28_1:Dispose()
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.passiveBuffItemList_) do
		iter_28_3:Dispose()
	end

	arg_28_0.ballInfoModule_:Dispose()
	arg_28_0.tipsModule_:Dispose()
	arg_28_0.mergeProcessModule_:Dispose()
	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
