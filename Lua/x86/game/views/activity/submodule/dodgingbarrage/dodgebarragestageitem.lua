local var_0_0 = class("DodgeBarrageStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()

	arg_2_0.stausController_ = arg_2_0.transCon_:GetController("stage")
	arg_2_0.lockController_ = arg_2_0.transCon_:GetController("lock")
	arg_2_0.posController_ = arg_2_0.transCon_:GetController("pos")
	arg_2_0.finishController_ = arg_2_0.transCon_:GetController("finished")
	arg_2_0.isSelect_ = false
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0.clickCallBack_(arg_4_0.index_)
	end)
end

function var_0_0.RegisterClick(arg_6_0, arg_6_1)
	arg_6_0.clickCallBack_ = arg_6_1
end

function var_0_0.SelectItem(arg_7_0)
	arg_7_0.stausController_:SetSelectedState(arg_7_0.isNormal_ and "select" or "hardSelect")
end

function var_0_0.UnSelectItem(arg_8_0)
	arg_8_0.stausController_:SetSelectedState(arg_8_0.isNormal_ and "normal" or "hardNormal")
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.index_ = arg_9_1
	arg_9_0.data_ = ActivityDodgeBarrageCfg[arg_9_2]
	arg_9_0.stageData_ = BattleDodgeBarrageCfg[arg_9_0.data_.stage_id]
	arg_9_0.isNormal_ = arg_9_0.data_.diff == 0
	arg_9_0.stageName_.text = arg_9_0.stageData_.name

	arg_9_0.posController_:SetSelectedState(arg_9_1 % 2 == 1 and "right" or "left")

	arg_9_0.isActivityOpen_ = ActivityData:GetActivityIsOpen(arg_9_0.data_.sub_activity_id)

	local var_9_0 = ActivityDodgeBarrageCfg[arg_9_0.index_].pre
	local var_9_1 = var_9_0 == 0 or DodgeBarrageData:IsStageFinished(var_9_0)

	arg_9_0.isLock_ = not arg_9_0.isActivityOpen_ or not var_9_1

	arg_9_0.lockController_:SetSelectedState(arg_9_0.isLock_ and "show" or "hide")

	arg_9_0.isFinished_ = DodgeBarrageData:IsStageFinished(arg_9_0.stageData_.id)

	arg_9_0.finishController_:SetSelectedState(arg_9_0.isNormal_ and arg_9_0.isFinished_ and "finished" or "unfinished")

	if arg_9_3 and arg_9_1 == arg_9_3 then
		arg_9_0:SelectItem()
	else
		arg_9_0:UnSelectItem()
	end
end

function var_0_0.GetIsNormal(arg_10_0)
	return arg_10_0.isNormal_
end

function var_0_0.GetIsLock(arg_11_0)
	return arg_11_0.isLock_
end

function var_0_0.GetActivityOpen(arg_12_0)
	return arg_12_0.isActivityOpen_
end

function var_0_0.GetStageData(arg_13_0)
	return arg_13_0.stageData_
end

function var_0_0.GetStageActivityId(arg_14_0)
	return arg_14_0.data_.sub_activity_id
end

function var_0_0.GetLockText(arg_15_0)
	if arg_15_0.isActivityOpen_ then
		return GetTips("ACTIVITY_MONSTER_COSPLAY_STAGE_CONDITION")
	else
		local var_15_0 = ActivityData:GetActivityData(arg_15_0.data_.sub_activity_id).startTime

		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(var_15_0, nil, true))
	end
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
