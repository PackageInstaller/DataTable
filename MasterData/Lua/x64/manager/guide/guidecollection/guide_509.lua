local Guide_509 = class("Guide_509", BaseGuide)

function Guide_509:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 50901)
	table.insert(var_1_0, 50902)
	table.insert(var_1_0, 50903)

	local var_1_1 = HeroData:GetHeroData(1084)

	if var_1_1.weapon_info and var_1_1.weapon_info.level == 1 and self:HaveAddWeaponExpMaterial() then
		table.insert(var_1_0, 50904)
		table.insert(var_1_0, 50905)
		table.insert(var_1_0, 50906)

		if not self.skipLevelUpClick_ then
			table.insert(var_1_0, 50907)
		end

		table.insert(var_1_0, 50908)
	end

	local var_1_2 = HeroTools.GetHeroServantInfo(1084)

	if (not var_1_2 or var_1_2 == 0) and self:GetSameRaceServant() then
		table.insert(var_1_0, 50909)
		table.insert(var_1_0, 50910)
		table.insert(var_1_0, 50911)
		table.insert(var_1_0, 50912)
		table.insert(var_1_0, 50913)
		table.insert(var_1_0, 50914)
	end

	table.insert(var_1_0, 50915)
	table.insert(var_1_0, 50916)
	table.insert(var_1_0, 50917)
	table.insert(var_1_0, 50918)

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_3 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_3 then
			table.insert(self._steps, var_1_3)
		end
	end
end

function Guide_509:HaveAddWeaponExpMaterial()
	for iter_2_0, iter_2_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		if ItemCfg[iter_2_1].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and ItemTools.getItemNum(iter_2_1) > 0 then
			if ItemCfg[iter_2_1].param[1] < GameLevelSetting[1].weapon_level_exp then
				self.skipLevelUpClick_ = true
			end

			return true
		end
	end

	return false
end

function Guide_509:GetSameRaceServant()
	for iter_3_0, iter_3_1 in pairs((WeaponServantData:GetWeaponServantList())) do
		if WeaponServantCfg[iter_3_1.id].race == HeroCfg[1084].race then
			return true
		end
	end
end

return Guide_509
