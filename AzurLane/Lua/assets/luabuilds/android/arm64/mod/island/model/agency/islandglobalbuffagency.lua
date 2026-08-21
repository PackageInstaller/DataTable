local var_0_0 = class("IslandGlobalBuffAgency", import(".IslandBaseAgency"))

function var_0_0.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.global_buff or {}

	arg_1_0.shipIds = var_1_0.forever_list
	arg_1_0.statusBuffDic = {}

	local var_1_1 = var_1_0.limit_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		arg_1_0:_AddBuff(arg_1_0.statusBuffDic, iter_1_1)
	end

	return
end

function var_0_0.InitShipSkillGlobalBuff(arg_2_0)
	local var_2_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	arg_2_0.skillBuffDic = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.shipIds) do
		local var_2_1 = var_2_0:GetShipById(iter_2_1):GetSkill()

		for iter_2_2, iter_2_3 in ipairs((var_2_1:GetEffectIds())) do
			arg_2_0:_AddBuff(arg_2_0.skillBuffDic, {
				isSkill = true,
				id = iter_2_3
			})
		end
	end

	return
end

function var_0_0.OnShipSkillUnlock(arg_3_0, arg_3_1)
	local var_3_9000
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	if #var_3_0 > 0 then
		underscore.each(arg_3_0:_SelectGlobalType((var_3_0.GetShipById(var_3_9000, arg_3_1):GetSkill():GetEffectIds())), function(arg_4_0)
			arg_3_0:_AddBuff(arg_3_0.skillBuffDic, {
				isSkill = true,
				id = arg_4_0
			})

			return
		end)
		table.insert(arg_3_0.shipIds, arg_3_1)
	end

	return
end

function var_0_0.OnShipSkillUpgrade(arg_5_0, arg_5_1)
	local var_5_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_5_1):GetSkill()

	if table.contains(arg_5_0.shipIds, arg_5_1) then
		underscore.each(arg_5_0:_SelectGlobalType((var_5_0:GetLastEffectIds())), function(arg_6_0)
			arg_5_0:_RemoveById(arg_5_0.skillBuffDic, arg_6_0)

			return
		end)
		table.removebyvalue(arg_5_0.shipIds, arg_5_1)
	end

	local var_5_1 = arg_5_0:_SelectGlobalType((var_5_0:GetEffectIds()))

	if #var_5_1 > 0 then
		underscore.each(var_5_1, function(arg_7_0)
			arg_5_0:_AddBuff(arg_5_0.skillBuffDic, {
				isSkill = true,
				id = arg_7_0
			})

			return
		end)
		table.insert(arg_5_0.shipIds, arg_5_1)
	end

	return
end

function var_0_0.GetBuffsByType(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.statusBuffDic[arg_8_1] or {}
	local var_8_1 = underscore.select(var_8_0, function(arg_9_0)
		return not arg_9_0:IsExpiration()
	end)
	local var_8_2 = arg_8_0.skillBuffDic[arg_8_1] or {}

	return table.mergeArray(var_8_1, var_8_2)
end

function var_0_0._AddBuff(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = IslandShipStatus.New(arg_10_2)
	local var_10_1 = var_10_0:GetBuffType()

	arg_10_1[var_10_1] = arg_10_1[var_10_1] or {}

	table.insert(arg_10_1[var_10_1], var_10_0)

	return
end

function var_0_0._RemoveById(arg_11_0, arg_11_1, arg_11_2)
	table.removebyvalue(arg_11_1[pg.island_buff_template[arg_11_2].buff_type], (underscore.detect(arg_11_1[pg.island_buff_template[arg_11_2].buff_type], function(arg_12_0)
		return arg_12_0.id == arg_11_2
	end)))

	return
end

function var_0_0._SelectGlobalType(arg_13_0, arg_13_1)
	return underscore.select(arg_13_1, function(arg_14_0)
		return IslandBuffType.IsGlobalType(pg.island_buff_template[arg_14_0].buff_type)
	end)
end

return var_0_0
