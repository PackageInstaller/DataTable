local var_0_0 = class("RoleStoryCustomIndexLayer", import("..common.CustomIndexLayer"))

function var_0_0.getUIName(arg_1_0)
	return "RoleStoryCustomIndexUI"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)
	setText(arg_2_0._tf:Find("index_panel/Text"), i18n("memory_filter_title_1"))
	setText(arg_2_0._tf:Find("index_panel/Text/Text"), i18n("memory_filter_title_2"))

	return
end

function var_0_0.InitGroup(arg_3_0)
	arg_3_0.onInit = true
	arg_3_0.contextData.indexDatas = arg_3_0.contextData.indexDatas or {}
	arg_3_0.dropdownDic = {}
	arg_3_0.updateList = {}
	arg_3_0.simpleDropdownDic = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0.contextData.groupList) do
		if iter_3_1.dropdown then
			arg_3_0:InitDropdown(iter_3_1)
		else
			arg_3_0:InitCustoms(iter_3_1)
		end
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.updateList) do
		iter_3_3()
	end

	return
end

return var_0_0
