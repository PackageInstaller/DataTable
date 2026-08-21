local var_0_0 = class("GuildActivityTeamInfoEnergyItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.currentController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "current")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.maxEnergy_ = arg_6_1
	arg_6_0.currentEnergy_ = arg_6_2

	arg_6_0:UpdateView()
end

function var_0_0.SetCurrent(arg_7_0, arg_7_1)
	arg_7_0.currentController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function var_0_0.UpdateView(arg_8_0)
	if GuildActivityData:IsFirstConfigFightRole() then
		arg_8_0.maxEnergyLabel_.text = arg_8_0.maxEnergy_
	else
		arg_8_0.maxEnergyLabel_.text = "0"
	end

	arg_8_0.currentEnergyLabel_.text = arg_8_0.currentEnergy_
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:AddEventListeners()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.data_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
