local var_0_0 = class("EquipFilterSelectItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		manager.notify:Invoke(EQUIP_FILTER_SELECT_CHANGE, {
			type = arg_3_0.data_.type,
			id = arg_3_0.data_.id,
			state = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.REMOVE
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.data_ = arg_5_1

	arg_5_0:Show(true)

	if arg_5_1.type == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		local var_5_0 = EquipSuitCfg[arg_5_1.id]

		arg_5_0.nameText_.text = GetI18NText(var_5_0.name)
	else
		local var_5_1 = EquipSkillCfg[arg_5_1.id]

		arg_5_0.nameText_.text = GetI18NText(var_5_1.name)
	end
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

return var_0_0
