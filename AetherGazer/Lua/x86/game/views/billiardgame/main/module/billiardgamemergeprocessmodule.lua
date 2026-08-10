local var_0_0 = class("BilliardGameMergeProcessModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.infoController_ = arg_2_0.con_:GetController("info")

	arg_2_0:InitMergeProcess()
end

function var_0_0.InitMergeProcess(arg_3_0)
	local var_3_0 = MergeBallStageCfg[BilliardGameMgr:GetStageId()]

	arg_3_0.maxProcessList_ = var_3_0.merge_progress
	arg_3_0.maxProcess_ = var_3_0.merge_progress[#var_3_0.merge_progress]
	arg_3_0.mergeCallback_ = mergeCallback
	arg_3_0.mergeLevel_ = 1
	arg_3_0.mergeProcess_ = 0
	arg_3_0.totalNeedProcess_ = 0
	arg_3_0.processImg_.fillAmount = 0
	arg_3_0.nowNeedProcess_ = arg_3_0.maxProcessList_[arg_3_0.mergeLevel_]
	arg_3_0.lastNeedProcess_ = arg_3_0.nowNeedProcess_
	arg_3_0.processText_.text = string.format("%d/%d", arg_3_0.mergeProcess_, arg_3_0.nowNeedProcess_)
	arg_3_0.mergeInfoText_.text = GetTips("MERGE_BALL_MERGER_TIP")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mergeInfoBtn_, nil, function()
		if manager.guide:IsPlaying() then
			return
		end

		arg_4_0.infoController_:SetSelectedState("show")
	end)
	arg_4_0:AddBtnListener(arg_4_0.mergeInfoMask_, nil, function()
		if manager.guide:IsPlaying() then
			return
		end

		arg_4_0.infoController_:SetSelectedState("hide")
	end)
end

function var_0_0.RefreshMergeProcess(arg_7_0, arg_7_1)
	arg_7_0.mergeProcess_ = arg_7_0.mergeProcess_ + arg_7_1
	arg_7_0.processText_.text = string.format("%d/%d", arg_7_0.mergeProcess_, arg_7_0.nowNeedProcess_)
	arg_7_0.processImg_.fillAmount = arg_7_0.mergeProcess_ / arg_7_0.nowNeedProcess_

	if arg_7_0.mergeProcess_ / arg_7_0.nowNeedProcess_ >= 1 then
		arg_7_0.isNeedMerge_ = true

		if not arg_7_0.isShowAnim then
			arg_7_0.anim_:Play("modify", -1, 0)

			arg_7_0.isShowAnim = true
		end
	end
end

function var_0_0.OnMergeBack(arg_8_0)
	arg_8_0.mergeProcess_ = math.max(0, arg_8_0.mergeProcess_ - arg_8_0.nowNeedProcess_)
	arg_8_0.mergeLevel_ = arg_8_0.mergeLevel_ + 1
	arg_8_0.nowNeedProcess_ = arg_8_0.mergeLevel_ <= #arg_8_0.maxProcessList_ and arg_8_0.maxProcessList_[arg_8_0.mergeLevel_] or arg_8_0.maxProcess_
	arg_8_0.processText_.text = string.format("%d/%d", arg_8_0.mergeProcess_, arg_8_0.nowNeedProcess_)
	arg_8_0.processImg_.fillAmount = arg_8_0.mergeProcess_ / arg_8_0.nowNeedProcess_
	arg_8_0.isNeedMerge_ = arg_8_0.mergeProcess_ / arg_8_0.nowNeedProcess_ >= 1
end

function var_0_0.GetIsNeedMerge(arg_9_0)
	return arg_9_0.isNeedMerge_
end

function var_0_0.HideMergePop(arg_10_0)
	arg_10_0.isNeedMerge_ = false
	arg_10_0.isShowAnim = false
	arg_10_0.lastNeedProcess_ = arg_10_0.nowNeedProcess_
end

function var_0_0.FeedbackMergeProcess(arg_11_0, arg_11_1)
	local var_11_0 = math.floor(arg_11_0.lastNeedProcess_ * arg_11_1)

	arg_11_0:RefreshMergeProcess(var_11_0)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
