local var_0_0 = class("SeaWarfareStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.lockController_ = arg_3_0.controllerEx_:GetController("lock")
	arg_3_0.completeController_ = arg_3_0.controllerEx_:GetController("complete")
	arg_3_0.numberController_ = arg_3_0.controllerEx_:GetController("number")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.isLock_ then
			ShowTips("NEED_COMPLETE_PRE_STAGE")

			return
		end

		arg_4_0.clickCallback_(arg_4_0.stageID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.stageID_ = arg_6_1
	arg_6_0.stageIndex_ = arg_6_2

	arg_6_0:ResetAnim()
	arg_6_0:RefreshLock()
	arg_6_0:RefreshComplete()
	arg_6_0:RefreshNumber()
	arg_6_0:InitAnimStatus()
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "on" or "off")
end

function var_0_0.RefreshLock(arg_8_0)
	arg_8_0.isLock_ = SeaWarfareTools.IsStageLock(arg_8_0.stageID_)

	arg_8_0.lockController_:SetSelectedState(arg_8_0.isLock_ and "on" or "off")
end

function var_0_0.RefreshComplete(arg_9_0)
	local var_9_0 = SeaWarfareTools.IsStageCompleted(arg_9_0.stageID_)

	arg_9_0.completeController_:SetSelectedState(var_9_0 and "on" or "off")
end

function var_0_0.RefreshNumber(arg_10_0)
	arg_10_0.numberController_:SetSelectedState(tostring(arg_10_0.stageIndex_))
end

function var_0_0.SetClickCallback(arg_11_0, arg_11_1)
	arg_11_0.clickCallback_ = arg_11_1
end

function var_0_0.GetStageID(arg_12_0)
	return arg_12_0.stageID_
end

function var_0_0.InitAnimStatus(arg_13_0)
	if arg_13_0.stageID_ == SeaWarfareTools.GetNeedFirstUnlockAnimStageID() then
		arg_13_0.lockController_:SetSelectedState("on")
	end

	if arg_13_0.stageID_ == SeaWarfareTools.GetNeedFirstCompleteAnimStageID() then
		arg_13_0.completeController_:SetSelectedState("off")
	end
end

function var_0_0.PlayUnlockAnim(arg_14_0, arg_14_1)
	arg_14_0.unlockAnimtimer_ = SeaWarfareTools.PlayAnim(arg_14_0.unlockAnim_, "UI_lock_cx", function()
		arg_14_0.lockController_:SetSelectedState("off")

		if arg_14_1 then
			arg_14_1()
		end
	end)
end

function var_0_0.PlayCompletedAnim(arg_16_0, arg_16_1)
	arg_16_0.completeController_:SetSelectedState("on")

	arg_16_0.completeAnimtimer_ = SeaWarfareTools.PlayAnim(arg_16_0.completeAnim_, "UI_complet_cx", function()
		if arg_16_1 then
			arg_16_1()
		end
	end)
end

function var_0_0.ResetAnim(arg_18_0)
	arg_18_0.unlockAnim_.enabled = false

	if arg_18_0.unlockAnimtimer_ then
		arg_18_0.unlockAnimtimer_:Stop()

		arg_18_0.unlockAnimtimer_ = nil
	end

	arg_18_0.completeAnim_.enabled = false

	if arg_18_0.completeAnimtimer_ then
		arg_18_0.completeAnimtimer_:Stop()

		arg_18_0.completeAnimtimer_ = nil
	end
end

return var_0_0
