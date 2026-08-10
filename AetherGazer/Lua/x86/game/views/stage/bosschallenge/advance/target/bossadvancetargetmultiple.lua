local var_0_0 = class("BossAdvanceTargetMultiple", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "Item")
	arg_1_0.switchMultipleHandler_ = handler(arg_1_0, arg_1_0.SwitchMultiple)

	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, arg_1_0.switchMultipleHandler_)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, arg_2_0.switchMultipleHandler_)

	arg_2_0.switchMultipleHandler_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		BattleBossChallengeAdvanceData:SetBossMultipleIndex(arg_3_0.bossIndex_, arg_3_0.index_)
		manager.notify:Invoke(BOSS_CHALLENGE_CHOOSE_MULTIPLE, arg_3_0.index_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.bossIndex_ = arg_5_1
	arg_5_0.index_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = BattleBossChallengeAdvanceData:GetBossList()[arg_6_0.bossIndex_]

	arg_6_0:SwitchMultiple(var_6_0.multipleIndex)

	arg_6_0.nameText_.text = string.format("%s%s", GetTips("HARDLEVEL"), GetTips(string.format("NUM_%s", arg_6_0.index_)))

	local var_6_1 = BattleBossChallengeAdvanceData:GetChooseModeID()
	local var_6_2 = BossChallengeAdvanceCfg[var_6_1]

	arg_6_0.pointText_.text = var_6_2.difficult_point[arg_6_0.index_]
end

function var_0_0.SwitchMultiple(arg_7_0, arg_7_1)
	if arg_7_0.index_ == arg_7_1 then
		arg_7_0.controller_:SetSelectedState("on")
	else
		arg_7_0.controller_:SetSelectedState("off")
	end
end

return var_0_0
