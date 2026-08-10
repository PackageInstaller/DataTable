local var_0_0 = class("TransitionSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	local var_3_0 = arg_3_0.gameObject_:GetComponent("ControllerExCollection")

	arg_3_0.selectController = var_3_0:GetController("sel")
	arg_3_0.useController = var_3_0:GetController("use")
	arg_3_0.lvController = var_3_0:GetController("lv")
	arg_3_0.recommandContorller = var_3_0:GetController("good")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_(arg_4_0.skillID_)
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:SetLevel(arg_7_2)

	arg_7_0.level_ = arg_7_2
	arg_7_0.skillID_ = arg_7_1
	arg_7_0.cfg_ = EquipSkillCfg[arg_7_0.skillID_]
	arg_7_0.icon_.sprite = getEquipSkillSprite(arg_7_0.skillID_)
	arg_7_0.levelTxt_.text = GetTips("LEVEL") .. arg_7_0.level_
	arg_7_0.name_.text = GetI18NText(arg_7_0.cfg_.name)
end

function var_0_0.SetUsed(arg_8_0, arg_8_1)
	arg_8_0.useController:SetSelectedState(arg_8_1 and "state1" or "state0")
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	arg_9_0.selectController:SetSelectedState(arg_9_1 and "state1" or "state0")
end

function var_0_0.SetLevel(arg_10_0, arg_10_1)
	arg_10_0.selectController:SetSelectedState(arg_10_1 == 0 and "state1" or "state0")
end

function var_0_0.SetRecommand(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0.recommandContorller:SetSelectedState("state1")
	else
		arg_11_0.recommandContorller:SetSelectedState("state0")
	end
end

function var_0_0.RegistCallBack(arg_12_0, arg_12_1)
	arg_12_0.clickFunc_ = arg_12_1
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
