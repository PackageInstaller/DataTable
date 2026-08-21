local var_0_0 = class("BattleBossChallengeDifficultItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.lightGo_ = Object.Instantiate(arg_1_3, arg_1_4.transform)

	SetActive(arg_1_0.lightGo_, true)

	arg_1_0.difficult_ = arg_1_5

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lightController_ = ControllerUtil.GetController(arg_1_0.lightGo_.transform, "conName")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")

	local var_1_0 = GetTips("BOSS_LEVEL_" .. arg_1_5)

	arg_1_0.textName_.text = var_1_0
	arg_1_0.textName2_.text = var_1_0
	arg_1_0.textName3_.text = var_1_0

	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.buttonSelect_, nil, function()
		BattleBossChallengeNormalData:SetSelectDifficult(arg_2_0.bossIndex_, arg_2_0.difficult_)
		manager.notify:Invoke(BOSS_CHALLENGE_SWITCH_DIFFICULT, arg_2_0.difficult_)
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.bossIndex_ = arg_4_1

	local var_4_0 = arg_4_0.difficult_ > BattleBossChallengeNormalData:GetFinishIndex(arg_4_0.bossIndex_)

	if var_4_0 then
		arg_4_0.lightController_:SetSelectedState("1")
		arg_4_0.lockController_:SetSelectedState("1")
	else
		arg_4_0.lightController_:SetSelectedState("0")
		arg_4_0.lockController_:SetSelectedState("0")
	end

	arg_4_0.isLock_ = var_4_0
end

function var_0_0.SwitchDifficult(arg_5_0, arg_5_1)
	if arg_5_0.difficult_ == arg_5_1 then
		arg_5_0.selectController_:SetSelectedState("0")
	else
		arg_5_0.selectController_:SetSelectedState("1")
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.lightGo_)
	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.lightGo_ = nil
	arg_6_0.transform_ = nil
	arg_6_0.gameObject_ = nil
end

return var_0_0
