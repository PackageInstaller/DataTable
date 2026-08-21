local var_0_0 = class("HeroSkillAttrItem", ReduxView)
local var_0_1 = {
	showState = {
		max = "max",
		name = "showState",
		normal = "normal"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.controllerexcollection_:GetController(var_0_1.showState.name)
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.descText_.text = PublicAttrCfg[arg_3_1.attrType] and PublicAttrCfg[arg_3_1.attrType].name or ""
	arg_3_0.valuenowText_.text = arg_3_1.nowValue / 10 .. "%"
	arg_3_0.valuelaterText_.text = arg_3_1.nextValue / 10 .. "%"

	local var_3_0 = var_0_1.showState.normal

	if arg_3_2 == false then
		var_3_0 = var_0_1.showState.max
	else
		var_3_0 = arg_3_1.nextValue ~= 0 and var_0_1.showState.normal or var_0_1.showState.max
	end

	arg_3_0.stateController_:SetSelectedState(var_3_0)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
