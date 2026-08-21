local var_0_0 = class("EquipFilterSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("state")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if arg_3_0.data_.cnt <= 0 then
			return
		end

		local var_4_0 = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.REMOVE

		if arg_3_0.selectState_ == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD then
			var_4_0 = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD
		end

		manager.notify:Invoke(EQUIP_FILTER_SELECT_CHANGE, {
			type = arg_3_0.data_.type,
			id = arg_3_0.data_.id,
			state = var_4_0
		})
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.data_ = arg_5_1
	arg_5_0.selectState_ = arg_5_2

	local var_5_0 = arg_5_1.id
	local var_5_1 = arg_5_1.cnt
	local var_5_2 = EquipSkillCfg[var_5_0]

	arg_5_0.name_.text = GetI18NText(var_5_2.name)
	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_5_2.icon)
	arg_5_0.num_.text = var_5_1

	if var_5_1 <= 0 then
		arg_5_0.selectController_:SetSelectedState("lock")
	elseif arg_5_2 then
		arg_5_0.selectController_:SetSelectedState("select")

		arg_5_0.selectState_ = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.REMOVE
	else
		arg_5_0.selectController_:SetSelectedState("false")

		arg_5_0.selectState_ = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD
	end
end

function var_0_0.GetData(arg_6_0)
	return arg_6_0.data_
end

return var_0_0
