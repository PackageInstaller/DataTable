class = var_0_10000

local var_0_0 = "IslandGlobalBuffAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.global_buff then
		var_1_0 = {}
	end

	arg_1_0.shipIds = var_1_0.forever_list
	arg_1_0.statusBuffDic = {}
	ipairs = var_3

	local var_1_1

	if not var_1_0.limit_list then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_1) do
		arg_1_0:_AddBuff(arg_1_0.statusBuffDic, iter_1_1)
	end

	return
end

function var_0_1.InitShipSkillGlobalBuff(arg_2_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.GetIsland(var_2_0)
	local var_2_2 = var_1.GetCharacterAgency(var_2_1)

	arg_2_0.skillBuffDic = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0.shipIds) do
		local var_2_3 = var_2_2
		local var_2_4 = var_2_2.GetShipById(var_2_3, iter_2_1)
		local var_2_5 = var_7.GetSkill(var_2_4)
		local var_2_6 = var_8.GetEffectIds(var_2_5)

		ipairs = var_2_3

		for iter_2_2, iter_2_3 in var_2_3(var_2_6) do
			arg_2_0:_AddBuff(arg_2_0.skillBuffDic, {
				isSkill = true,
				id = iter_2_3
			})
		end
	end

	return
end

function var_0_1.OnShipSkillUnlock(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)
	local var_3_1 = var_2.GetIsland(var_3_0)
	local var_3_2 = var_2.GetCharacterAgency(var_3_1)
	local var_3_3 = var_2.GetShipById(var_3_2, arg_3_1)
	local var_3_4 = var_2.GetSkill(var_3_3)
	local var_3_5 = var_3.GetEffectIds(var_3_4)

	if #arg_3_0:_SelectGlobalType(var_3_5) > 0 then
		underscore = var_5

		var_5.each(var_4, function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1._AddBuff(var_4_0, arg_3_0.skillBuffDic, {
				isSkill = true,
				id = arg_4_0
			})

			return
		end)

		table = var_5

		var_5.insert(arg_3_0.shipIds, arg_3_1)
	end

	return
end

function var_0_1.OnShipSkillUpgrade(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_5_0 = var_1_10002(var_1_10004)
	local var_5_1 = var_2.GetIsland(var_5_0)
	local var_5_2 = var_2.GetCharacterAgency(var_5_1)
	local var_5_3 = var_2.GetShipById(var_5_2, arg_5_1)
	local var_5_4 = var_2.GetSkill(var_5_3)
	local var_5_5 = var_2.GetLastEffectIds(var_5_4)
	local var_5_6 = var_2:GetEffectIds()

	table = var_5_4

	if var_5_4.contains(arg_5_0.shipIds, arg_5_1) then
		underscore = var_5

		var_5.each(arg_5_0:_SelectGlobalType(var_5_5), function(arg_6_0)
			local var_6_0 = arg_5_0

			var_1._RemoveById(var_6_0, arg_5_0.skillBuffDic, arg_6_0)

			return
		end)

		table = var_5

		var_5.removebyvalue(arg_5_0.shipIds, arg_5_1)
	end

	if #arg_5_0:_SelectGlobalType(var_5_6) > 0 then
		underscore = var_6

		var_6.each(var_5, function(arg_7_0)
			local var_7_0 = arg_5_0

			var_1._AddBuff(var_7_0, arg_5_0.skillBuffDic, {
				isSkill = true,
				id = arg_7_0
			})

			return
		end)

		table = var_6

		var_6.insert(arg_5_0.shipIds, arg_5_1)
	end

	return
end

function var_0_1.GetBuffsByType(arg_8_0, arg_8_1)
	underscore = var_1_10002

	local var_8_0 = var_1_10002.select
	local var_8_1

	if not arg_8_0.statusBuffDic[arg_8_1] then
		var_8_1 = {}
	end

	local var_8_2 = var_8_0(var_8_1, function(arg_9_0)
		return not arg_9_0:IsExpiration()
	end)

	table = var_1_10003

	local var_8_3 = var_1_10003.mergeArray
	local var_8_4 = var_8_2
	local var_8_5

	if not arg_8_0.skillBuffDic[arg_8_1] then
		var_8_5 = {}
	end

	return var_8_3(var_8_4, var_8_5)
end

function var_0_1._AddBuff(arg_10_0, arg_10_1, arg_10_2)
	IslandShipStatus = var_1_10003

	local var_10_0 = var_1_10003.New(arg_10_2)

	if not arg_10_1[var_3.GetBuffType(var_10_0)] then
		arg_10_1[var_4] = {}
	end

	table = var_5

	var_5.insert(arg_10_1[var_4], var_3)

	return
end

function var_0_1._RemoveById(arg_11_0, arg_11_1, arg_11_2)
	pg = var_1_10003

	local var_11_0 = arg_11_1[var_1_10003.island_buff_template[arg_11_2].buff_type]

	underscore = var_1_10004

	local var_11_1 = var_1_10004.detect(var_11_0, function(arg_12_0)
		return arg_12_0.id == arg_11_2
	end)

	table = var_1_10005

	var_1_10005.removebyvalue(var_11_0, var_11_1)

	return
end

function var_0_1._SelectGlobalType(arg_13_0, arg_13_1)
	underscore = var_1_10002

	return var_1_10002.select(arg_13_1, function(arg_14_0)
		IslandBuffType = var_2_10001

		local var_14_0 = var_2_10001.IsGlobalType

		pg = var_2_10003

		return var_14_0(var_2_10003.island_buff_template[arg_14_0].buff_type)
	end)
end

return var_0_1
