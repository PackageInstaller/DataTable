local var_0_0 = class("EquipBreakThroughMaterialBuffStageItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectHandler_ = handler(arg_1_0, arg_1_0.SelectItem)

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, arg_1_0.selectHandler_)

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_SELECT_BUFF, arg_2_0.index_)
	end)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, arg_4_0.selectHandler_)

	arg_4_0.selectHandler_ = nil
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.index_ = arg_5_1
	arg_5_0.mapStageID_ = arg_5_2

	arg_5_0:RefreshUI()
	arg_5_0:SelectItem(arg_5_3)
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = EquipBreakThroughMaterialData:GetStageData()[arg_6_0.mapStageID_].buffList[arg_6_0.index_]
	local var_6_1 = EquipBreakThroughMaterialItemCfg[var_6_0]

	arg_6_0.nameText_.text = GetI18NText(var_6_1.name)
	arg_6_0.descText_.text = getAffixDesc(var_6_1.params)
	arg_6_0.icon_.sprite = getSprite("Atlas/EquipBreakThroughMaterialIcon", var_6_1.icon)
end

function var_0_0.SelectItem(arg_7_0, arg_7_1)
	if arg_7_0.index_ == arg_7_1 then
		arg_7_0.controller_:SetSelectedState("1")
	else
		arg_7_0.controller_:SetSelectedState("0")
	end
end

return var_0_0
