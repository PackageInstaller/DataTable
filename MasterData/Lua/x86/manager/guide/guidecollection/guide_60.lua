local Guide_60 = class("Guide_60", BaseGuide)

function Guide_60:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()

	self.nowEquipData_ = self:CheckNowHeroData()
	self.targetEquip_ = EquipData:GetEquipListComplex(ItemConst.SORT_TYPE.DOWN, EquipConst.EQUIP_SORT.LEVEL, 1)[1]

	table.insert(var_1_0, 6001)
	table.insert(var_1_0, 6002)
	table.insert(var_1_0, 6003)
	table.insert(var_1_0, 6004)

	if self.nowEquipData_ then
		table.insert(var_1_0, 6005)
	end

	if (self.nowEquipData_ and self.nowEquipData_.star == 2 and self.nowEquipData_.equipConfig.suit == 29 and self.nowEquipData_.equip_id ~= self.targetEquip_.equip_id or nil) and true then
		table.insert(var_1_0, 6006)
		table.insert(var_1_0, 6007)

		if self.targetEquip_:GetEquipHero() then
			print("HERO")
			table.insert(var_1_0, 6008)
		end

		self.nowEquipData_ = self.targetEquip_
	end

	table.insert(var_1_0, 6009)
	table.insert(var_1_0, 6010)

	if self.nowEquipData_ and self.nowEquipData_:GetLevel() <= 1 and self:HaveAddEquipExpMaterial() then
		table.insert(var_1_0, 6011)
		table.insert(var_1_0, 6012)
	end

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_2 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_2 then
			table.insert(self._steps, var_1_2)
		end
	end
end

function Guide_60:CheckNowHeroData()
	local var_2_0 = HeroData:GetHeroList()

	if var_2_0[1084] and var_2_0[1084].equip then
		if var_2_0[1084].equip[1].equip_id and var_2_0[1084].equip[1].equip_id ~= 0 then
			return EquipData:GetEquipData(var_2_0[1084].equip[1].equip_id)
		end
	end

	return nil
end

function Guide_60:HaveAddEquipExpMaterial()
	for iter_3_0, iter_3_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		if ItemCfg[iter_3_1].sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and ItemTools.getItemNum(iter_3_1) > 0 then
			return true
		end
	end

	return false
end

function Guide_60:CheckGuide()
	local var_4_0

	if not GuideTool.SatisfyCondition(self.open_condition) then
		do return false end

		var_4_0 = next
	end

	return var_4_0((EquipData:GetEquipList())) ~= nil
end

return Guide_60
