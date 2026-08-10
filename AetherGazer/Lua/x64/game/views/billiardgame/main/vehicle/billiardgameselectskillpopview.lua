local var_0_0 = class("BilliardGameSelectSkillPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_BuffSelectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:OnInit()
	arg_3_0:AddUIListner()
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillCardItemList = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = BilliardGameSelectSkillCardItemView.New(arg_4_0["skillCardItemGo_" .. iter_4_0])

		table.insert(arg_4_0.skillCardItemList, var_4_0)
	end

	arg_4_0.refreshController_ = arg_4_0.transCon_:GetController("refreshBtn")
end

function var_0_0.AddUIListner(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.refreshBtn_, nil, function()
		if arg_5_0.refreshCount_ == 0 then
			return
		end

		if arg_5_0.refreshCount_ <= BilliardGameConst.PassStageParams.ADDREFRESHCOUNT then
			for iter_6_0 = 1, #arg_5_0.skillCardItemList do
				arg_5_0.skillCardItemList[iter_6_0].changeAnim_:Play("card_change", -1, 0)
			end

			arg_5_0:RefreshSkillCardItem()

			arg_5_0.refreshCount_ = arg_5_0.refreshCount_ - 1
			arg_5_0.refreshCountText_.text = string.format("%d/%d", arg_5_0.refreshCount_, BilliardGameConst.PassStageParams.ADDREFRESHCOUNT)

			arg_5_0.refreshController_:SetSelectedState(arg_5_0.refreshCount_ == 0 and "red" or "white")
			BilliardGameMgr:SetRefreshCount(arg_5_0.refreshCount_)
			BilliardGameMgr:OnSkillChange(BilliardGameConst.ChangeSkillType.ADD, BilliardGameConst.ChangeSkillOpt.RESET, {})
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.isSelected_ = false
	arg_7_0.refreshCount_ = BilliardGameMgr:GetRefreshCount()

	arg_7_0.refreshController_:SetSelectedState(arg_7_0.refreshCount_ == 0 and "red" or "white")

	arg_7_0.refreshCountText_.text = string.format("%d/%d", arg_7_0.refreshCount_, BilliardGameConst.PassStageParams.ADDREFRESHCOUNT)

	arg_7_0:RefreshSkillCardItem()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({})
	arg_8_0:RefreshItemTrack()
end

function var_0_0.OnExit(arg_9_0)
	AnimatorTools.Stop()
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.skillCardItemList do
		arg_10_0.skillCardItemList[iter_10_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.RefreshSkillCardItem(arg_11_0)
	arg_11_0.buffIdList_ = BilliardGameMgr:GetRoundSelectBuffList()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.skillCardItemList) do
		iter_11_1:SetData(arg_11_0.buffIdList_[iter_11_0])
		iter_11_1:RegisterClickListener(function(arg_12_0)
			arg_11_0:OnClickSkillCardItem(arg_12_0, iter_11_0)
		end)
	end
end

function var_0_0.RefreshItemTrack(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.skillCardItemList) do
		iter_13_1:RefreshTrackState()
	end
end

function var_0_0.OnClickSkillCardItem(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.isSelected_ then
		return
	end

	arg_14_0.isSelected_ = true

	AnimatorTools.PlayAnimationWithCallback(arg_14_0.skillCardItemList[arg_14_2].selectAnim_, "card_select", function()
		AnimatorTools.PlayAnimationWithCallback(arg_14_0.exitAnim_, "exit", function()
			arg_14_0:Back()
			BilliardGameMgr:AddSelectedSkill(arg_14_1)
			BilliardGameLuaBridge.SetSelectBuffOver(true)
		end)
	end)
end

return var_0_0
