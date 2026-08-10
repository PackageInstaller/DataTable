local var_0_0 = class("EquipSkillLocationItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.handler_ = arg_2_1
	arg_2_0.info_ = arg_2_2

	arg_2_0:RefreshUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = arg_3_0.stateCon_:GetController("state")
	arg_3_0.posController_ = arg_3_0.stateCon_:GetController("pos")
end

function var_0_0.RefreshUI(arg_4_0)
	if arg_4_0.info_.isEquip then
		arg_4_0.stateController_:SetSelectedState("equip")

		local var_4_0 = EquipCfg[arg_4_0.info_.prefab_id]

		arg_4_0.equipIcon_.sprite = ItemTools.getItemSprite(arg_4_0.info_.prefab_id)

		arg_4_0.posController_:SetSelectedState(var_4_0.pos)

		arg_4_0.nameText_.text = ItemTools.getItemName(arg_4_0.info_.prefab_id)
	else
		arg_4_0.stateController_:SetSelectedState("transition")

		arg_4_0.nameText_.text = GetTips("UPGRADE_STAR")
	end

	arg_4_0.lvText_.text = "+" .. arg_4_0.info_.level
end

function var_0_0.GetItemInfo(arg_5_0)
	return arg_5_0.info_
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
