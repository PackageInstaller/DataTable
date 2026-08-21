local var_0_0 = class("WhackMoleStageItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.controllerEx_:GetController("state")
	arg_2_0.selectController_ = arg_2_0.controllerEx_:GetController("select")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0.clickCallback_(arg_3_0.whackMoleID_, arg_3_0.transform_.position)
	end)
end

function var_0_0.SetClickCallback(arg_5_0, arg_5_1)
	arg_5_0.clickCallback_ = arg_5_1
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.activityID_ = arg_6_1
	arg_6_0.whackMoleID_ = arg_6_2

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = ActivityWhackMoleCfg[arg_7_0.whackMoleID_].stage_id

	arg_7_0.name_.text = BattleWhackMoleStageCfg[var_7_0].name

	arg_7_0:RefreshState()
end

function var_0_0.RefreshState(arg_8_0)
	if WhackMoleTools.GetStageIsLock(arg_8_0.whackMoleID_) then
		arg_8_0.state_ = WhackMoleConst.STAGE_STATE.LOCK
	elseif WhackMoleData:IsCompletedStage(arg_8_0.whackMoleID_) then
		arg_8_0.state_ = WhackMoleConst.STAGE_STATE.COMPLETED
	else
		arg_8_0.state_ = WhackMoleConst.STAGE_STATE.UNLOCK
	end

	arg_8_0.stateController_:SetSelectedState(arg_8_0.state_)
end

function var_0_0.RefreshSelect(arg_9_0, arg_9_1)
	arg_9_0.selectController_:SetSelectedState(arg_9_1 == arg_9_0.whackMoleID_ and "on" or "off")
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

return var_0_0
