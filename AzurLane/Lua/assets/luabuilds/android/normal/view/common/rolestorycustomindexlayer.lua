class = var_0_10000

local var_0_0 = "RoleStoryCustomIndexLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..common.CustomIndexLayer"))

function var_0_1.getUIName(arg_1_0)
	return "RoleStoryCustomIndexUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "index_panel/Text")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("memory_filter_title_1"))

	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "index_panel/Text/Text")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("memory_filter_title_2"))

	return
end

function var_0_1.InitGroup(arg_3_0)
	arg_3_0.onInit = true

	local var_3_0 = arg_3_0.contextData
	local var_3_1

	if not arg_3_0.contextData.indexDatas then
		var_3_1 = {}
	end

	var_3_0.indexDatas = var_3_1
	arg_3_0.dropdownDic = {}
	arg_3_0.updateList = {}
	arg_3_0.simpleDropdownDic = {}
	pairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.contextData.groupList) do
		if iter_3_1.dropdown then
			arg_3_0:InitDropdown(iter_3_1)
		else
			arg_3_0:InitCustoms(iter_3_1)
		end
	end

	ipairs = var_1

	for iter_3_2, iter_3_3 in var_1(arg_3_0.updateList) do
		iter_3_3()
	end

	return
end

return var_0_1
