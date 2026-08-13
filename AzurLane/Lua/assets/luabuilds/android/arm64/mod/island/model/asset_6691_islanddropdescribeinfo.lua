class = var_0_10000

local var_0_0 = "IslandDropDescribeInfo"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.drop = arg_1_1

	return
end

function var_0_1.GetName(arg_2_0)
	local var_2_0 = arg_2_0.drop
	local var_2_1

	if not var_1.getName(var_2_0) then
		var_2_1 = ""
	end

	return var_2_1
end

function var_0_1.GetDes(arg_3_0)
	local var_3_0

	if not arg_3_0.drop.desc then
		var_3_0 = ""
	end

	return var_3_0
end

function var_0_1.GetOwnCount(arg_4_0)
	local var_4_0 = arg_4_0.drop

	return var_1.getOwnedCount(var_4_0)
end

function var_0_1.GetDrop(arg_5_0)
	return arg_5_0.drop
end

function var_0_1.GetAcquiringWay(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0
	local var_6_2

	if not arg_6_0.GetDropConfig(var_6_1).jump_page then
		var_6_2 = {}
	end

	var_6_2 = var_6_2 == "" and {} or var_6_2
	ipairs = var_6_1

	for iter_6_0, iter_6_1 in var_6_1(var_6_2) do
		table = var_1_10009

		var_1_10009.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function var_0_1.IsTecUnlocked(arg_7_0)
	if arg_7_0:GetDropConfig().tech_id == 0 or var_1.tech_id == nil then
		return true
	end

	getProxy = var_2
	IslandProxy = var_1_10004

	local var_7_0 = var_2(var_1_10004)
	local var_7_1 = var_2.GetIsland(var_7_0)
	local var_7_2 = var_2.GetTechnologyAgency(var_7_1)

	return var_3.IsUnlockTech(var_7_2, var_1.tech_id)
end

function var_0_1.GetTecDes(arg_8_0)
	local var_8_0 = arg_8_0

	if arg_8_0.GetDropConfig(var_8_0).tech_id == 0 then
		return ""
	end

	pg = var_8_0

	local var_8_1 = var_8_0.island_technology_template[var_2]

	IslandTechBelong = var_1_10004

	local var_8_2 = var_1_10004.Names[var_8_1.tech_belong]
	local var_8_3 = var_8_1.tech_name

	i18n = var_1_10006

	return var_1_10006("island_information_tech", var_8_2, var_8_3)
end

function var_0_1.GetDropConfig(arg_9_0)
	local var_9_0 = arg_9_0.drop

	return var_1.getConfigTable(var_9_0)
end

return var_0_1
