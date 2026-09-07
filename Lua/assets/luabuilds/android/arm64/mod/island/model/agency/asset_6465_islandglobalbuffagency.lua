local IslandGlobalBuffAgency = class("IslandGlobalBuffAgency", import(".IslandBaseAgency"))

function IslandGlobalBuffAgency:OnInit(arg_1_1)
	local var_1_0 = arg_1_1.global_buff or {}

	self.shipIds = var_1_0.forever_list
	self.statusBuffDic = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.limit_list or {}) do
		self:_AddBuff(self.statusBuffDic, iter_1_1)
	end

	return
end

function IslandGlobalBuffAgency:InitShipSkillGlobalBuff()
	local var_2_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	self.skillBuffDic = {}

	for iter_2_0, iter_2_1 in ipairs(self.shipIds) do
		for iter_2_2, iter_2_3 in ipairs((var_2_0:GetShipById(iter_2_1):GetSkill():GetEffectIds())) do
			self:_AddBuff(self.skillBuffDic, {
				isSkill = true,
				id = iter_2_3
			})
		end
	end

	return
end

function IslandGlobalBuffAgency:OnShipSkillUnlock(arg_3_1)
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	if #var_3_0 > 0 then
		underscore.each(self:_SelectGlobalType((var_3_0:GetShipById(arg_3_1):GetSkill():GetEffectIds())), function(arg_4_0)
			self:_AddBuff(self.skillBuffDic, {
				isSkill = true,
				id = arg_4_0
			})

			return
		end)
		table.insert(self.shipIds, arg_3_1)
	end

	return
end

function IslandGlobalBuffAgency:OnShipSkillUpgrade(arg_5_1)
	local var_5_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_5_1):GetSkill()

	if table.contains(self.shipIds, arg_5_1) then
		underscore.each(self:_SelectGlobalType((var_5_0:GetLastEffectIds())), function(arg_6_0)
			self:_RemoveById(self.skillBuffDic, arg_6_0)

			return
		end)
		table.removebyvalue(self.shipIds, arg_5_1)
	end

	local var_5_1 = self:_SelectGlobalType((var_5_0:GetEffectIds()))

	if #var_5_1 > 0 then
		underscore.each(var_5_1, function(arg_7_0)
			self:_AddBuff(self.skillBuffDic, {
				isSkill = true,
				id = arg_7_0
			})

			return
		end)
		table.insert(self.shipIds, arg_5_1)
	end

	return
end

function IslandGlobalBuffAgency:GetBuffsByType(arg_8_1)
	return table.mergeArray(underscore.select(self.statusBuffDic[arg_8_1] or {}, function(arg_9_0)
		return not arg_9_0:IsExpiration()
	end), self.skillBuffDic[arg_8_1] or {})
end

function IslandGlobalBuffAgency:_AddBuff(arg_10_1, arg_10_2)
	local var_10_0 = IslandShipStatus.New(arg_10_2)
	local var_10_1 = var_10_0:GetBuffType()

	arg_10_1[var_10_1] = arg_10_1[var_10_1] or {}

	table.insert(arg_10_1[var_10_1], var_10_0)

	return
end

function IslandGlobalBuffAgency:_RemoveById(arg_11_1, arg_11_2)
	table.removebyvalue(arg_11_1[pg.island_buff_template[arg_11_2].buff_type], (underscore.detect(arg_11_1[pg.island_buff_template[arg_11_2].buff_type], function(arg_12_0)
		return arg_12_0.id == arg_11_2
	end)))

	return
end

function IslandGlobalBuffAgency:_SelectGlobalType(arg_13_1)
	return underscore.select(arg_13_1, function(arg_14_0)
		return IslandBuffType.IsGlobalType(pg.island_buff_template[arg_14_0].buff_type)
	end)
end

return IslandGlobalBuffAgency
