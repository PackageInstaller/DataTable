local var_0_0 = class("ProposalEquipItem", EquipBaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	var_0_0.super.Init(arg_1_0, 1)
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.equipInfoGo_ = arg_2_0:FindGo("EquipInfoUI")
	arg_2_0.equipSkillGo_ = arg_2_0:FindGo("EquipSkillInfoUI")
	arg_2_0.maskGo_ = arg_2_0:FindGo("mask")
end

function var_0_0.ShowEquipInfo(arg_3_0, arg_3_1)
	SetActive(arg_3_0.equipInfoGo_, true)
	SetActive(arg_3_0.maskGo_, true)

	local var_3_0 = EquipData:GetEquipData(arg_3_1)

	arg_3_0:RefreshEquipInfo(var_3_0)
end

return var_0_0
