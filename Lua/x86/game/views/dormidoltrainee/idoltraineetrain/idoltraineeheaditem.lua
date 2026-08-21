local var_0_0 = class("IdolTraineeHeadItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("select")
	arg_2_0.defendController_ = arg_2_0.mainControllerEx_:GetController("defend")
	arg_2_0.attackController_ = arg_2_0.mainControllerEx_:GetController("attack")
	arg_2_0.doubleController_ = arg_2_0.mainControllerEx_:GetController("double")
	arg_2_0.lockController_ = arg_2_0.mainControllerEx_:GetController("lock")
	arg_2_0.lockingController_ = arg_2_0.mainControllerEx_:GetController("locking")
	arg_2_0.clearController_ = arg_2_0.mainControllerEx_:GetController("clear")
	arg_2_0.competitionSelController_ = arg_2_0.mainControllerEx_:GetController("competitionSel")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.click_ then
			arg_3_0:click_()
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.heroID_ = arg_5_1
	arg_5_0.click_ = arg_5_3

	local var_5_0 = IdolTraineeTools:GetHeroBattleInfoTemplate(arg_5_1)

	arg_5_0.headIcon_.sprite = var_5_0.heroIcon

	local var_5_1 = false
	local var_5_2 = false

	if not nullable(arg_5_4, "ignoreAttacker") then
		var_5_1 = IdolTraineeTools:CheckHeroIsAttack(arg_5_1)
	end

	if not nullable(arg_5_4, "ignoreDefender") then
		var_5_2 = IdolTraineeTools:CheckHeroIsDefine(arg_5_1)
	end

	arg_5_0:RefreshDanceGameRole(var_5_2, var_5_1)
	arg_5_0.selectController_:SetSelectedState(arg_5_1 == arg_5_2 and "true" or "false")

	if arg_5_0.lockController_ then
		arg_5_0.lockController_:SetSelectedState(HeroTools.GetHeroIsUnlock(arg_5_1) and "off" or "on")
	end

	local var_5_3 = nullable(arg_5_4, "competitionSel")

	if arg_5_0.competitionSelController_ then
		arg_5_0.competitionSelController_:SetSelectedState(var_5_3 and "on" or "off")
	end

	arg_5_0.lockingController_:SetSelectedState(BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_5_1) and "true" or "false")
	arg_5_0.clearController_:SetSelectedState(DormTools.CheckMax(arg_5_1) and "on" or "off")
end

function var_0_0.RefreshDanceGameRole(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 and arg_6_2 then
		arg_6_0.defendController_:SetSelectedState("false")
		arg_6_0.attackController_:SetSelectedState("false")
		arg_6_0.doubleController_:SetSelectedState("true")

		return
	end

	arg_6_0.defendController_:SetSelectedState(arg_6_1 and "true" or "false")
	arg_6_0.attackController_:SetSelectedState(arg_6_2 and "true" or "false")
	arg_6_0.doubleController_:SetSelectedState("false")
end

function var_0_0.SelectOn(arg_7_0)
	arg_7_0.selectController_:SetSelectedState("true")
end

function var_0_0.SelectOff(arg_8_0)
	arg_8_0.selectController_:SetSelectedState("false")
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
