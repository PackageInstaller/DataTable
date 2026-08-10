local var_0_0 = class("EquipSkillPreviewPage", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/EnchantPopUPUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.titleHieght_ = 75
	arg_3_0.itemHeight_ = 156

	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
	var_0_0.super.Init(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.enchantList_ = EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]

	arg_4_0:InitPreview()

	arg_4_0.attackScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexAttackItem), arg_4_0.skillListGo_1, EnchantSkillItem)
	arg_4_0.defenceScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDefenceItem), arg_4_0.skillListGo_2, EnchantSkillItem)
	arg_4_0.subScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexSubItem), arg_4_0.skillListGo_3, EnchantSkillItem)
end

function var_0_0.InitPreview(arg_5_0)
	arg_5_0.skillList_ = {
		{},
		{},
		{}
	}
	arg_5_0.skillLine_ = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.enchantList_) do
		local var_5_0 = EquipSkillCfg[iter_5_1]

		table.insert(arg_5_0.skillList_[var_5_0.type], iter_5_1)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.skillList_) do
		arg_5_0.skillLine_[iter_5_2] = math.ceil(#iter_5_3 / 2)
	end

	for iter_5_4 = 1, 3 do
		local var_5_1 = arg_5_0["skillRect_" .. iter_5_4].transform
		local var_5_2 = arg_5_0["skillListGo_" .. iter_5_4].transform
		local var_5_3 = arg_5_0.skillLine_[iter_5_4]
		local var_5_4 = arg_5_0.titleHieght_ + arg_5_0.itemHeight_ * var_5_3

		var_5_1:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, var_5_4)
		var_5_2:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, arg_5_0.itemHeight_ * var_5_3)
	end
end

function var_0_0.IndexAttackItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		id = arg_6_0.skillList_[1][arg_6_1]
	}

	var_6_0.num = 1
	var_6_0.preview = true

	arg_6_2:RefreshData(var_6_0)
end

function var_0_0.IndexDefenceItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {
		id = arg_7_0.skillList_[2][arg_7_1]
	}

	var_7_0.num = 1
	var_7_0.preview = true

	arg_7_2:RefreshData(var_7_0)
end

function var_0_0.IndexSubItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		id = arg_8_0.skillList_[3][arg_8_1]
	}

	var_8_0.num = 1
	var_8_0.preview = true

	arg_8_2:RefreshData(var_8_0)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.attackScrollHelper_:StartScroll(#arg_9_0.skillList_[1])
	arg_9_0.defenceScrollHelper_:StartScroll(#arg_9_0.skillList_[2])
	arg_9_0.subScrollHelper_:StartScroll(#arg_9_0.skillList_[3])
end

function var_0_0.AddUIListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.btnBack_, nil, function()
		arg_10_0:Back()
	end)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	arg_12_0.attackScrollHelper_:Dispose()
	arg_12_0.defenceScrollHelper_:Dispose()
	arg_12_0.subScrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
