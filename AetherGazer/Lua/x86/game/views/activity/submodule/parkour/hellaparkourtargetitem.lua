local var_0_0 = class("HellaParkourTargetItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.m_lab.text = BattleInstance.GetStarMissionText(arg_4_3[1], arg_4_3[2], arg_4_3[3])

	if ParkourData:GetParkourStarState(arg_4_2, arg_4_1) then
		arg_4_0.stateController:SetSelectedIndex(arg_4_4 and 2 or 0)
	else
		arg_4_0.stateController:SetSelectedIndex(1)
	end
end

return var_0_0
