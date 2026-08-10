local var_0_0 = class("CivilizationHeroHexItem", ReduxView)

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

	arg_3_0.stateController_ = arg_3_0.mainControllerEx_:GetController("state")
	arg_3_0.selectController_ = arg_3_0.mainControllerEx_:GetController("select")
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.hexID_ = arg_4_1

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	local var_5_0 = ActivityCivilizationFactorCfg[arg_5_0.hexID_]

	arg_5_0.img_.sprite = getSpriteViaConfig("CivilizationGame", var_5_0.icon)
	arg_5_0.descText_.text = var_5_0.description

	if CivilizationGameTools.GetTechUnlock(arg_5_0.hexID_) then
		arg_5_0.stateController_:SetSelectedState("on")
	else
		arg_5_0.stateController_:SetSelectedState("off")
	end

	if CivilizationGameTools.GetTechSelect(arg_5_0.hexID_) then
		arg_5_0.selectController_:SetSelectedState("on")
	else
		arg_5_0.selectController_:SetSelectedState("off")
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
