local var_0_0 = class("EquipSkillInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/EquipSkillPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, EquipSkillInfoItem2)
end

function var_0_0.OnEnter(arg_4_0)
	if arg_4_0.equipSkillData_ and arg_4_0.equipSkillData_.id == arg_4_0.params_.equipSkillData.id then
		return
	end

	arg_4_0.equipSkillData_ = arg_4_0.params_.equipSkillData

	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.uiList_:Dispose()

	arg_6_0.uiList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0.selectItem_:ShowSelect(false)
		arg_7_0:Back()
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = EquipSkillCfg[arg_9_0.equipSkillData_.id]

	arg_9_0.selectItem_ = arg_9_0.equipSkillData_.selectItem

	arg_9_0.selectItem_:ShowSelect(true)

	arg_9_0.iconImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_9_0.icon)
	arg_9_0.nameText_.text = GetI18NText(var_9_0.name)
	arg_9_0.lvText_.text = string.format("%s/%s", arg_9_0.equipSkillData_.skillLevel, var_9_0.lvmax)

	local var_9_1 = EquipSkillCfg[arg_9_0.equipSkillData_.id]

	arg_9_0.uiList_:StartScroll(var_9_1.lvmax)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.equipSkillData_.id, arg_10_0.equipSkillData_.skillLevel, arg_10_1)
end

return var_0_0
