local Guide_8 = class("Guide_8", BaseGuide)

function Guide_8:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 801)
	table.insert(var_1_0, 802)
	table.insert(var_1_0, 804)

	local var_1_1 = HeroData:GetHeroData(1084)

	if var_1_1.weapon_info and var_1_1.weapon_info.level == 1 and self:HaveAddWeaponExpMaterial() then
		table.insert(var_1_0, 805)
		table.insert(var_1_0, 806)
		table.insert(var_1_0, 807)

		if not self.skipLevelUpClick_ then
			table.insert(var_1_0, 808)
		end

		table.insert(var_1_0, 809)
	end

	local var_1_2 = HeroTools.GetHeroServantInfo(1084)

	if (not var_1_2 or var_1_2 == 0) and self:GetSameRaceServant() then
		table.insert(var_1_0, 810)
		table.insert(var_1_0, 811)
		table.insert(var_1_0, 812)
		table.insert(var_1_0, 813)
		table.insert(var_1_0, 814)
		table.insert(var_1_0, 815)
	end

	table.insert(var_1_0, 816)
	table.insert(var_1_0, 817)
	table.insert(var_1_0, 818)

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_3 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_3 then
			table.insert(self._steps, var_1_3)
		end
	end
end

function Guide_8:HaveAddWeaponExpMaterial()
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

function Guide_8:GetSameRaceServant()
	for iter_3_0, iter_3_1 in pairs((WeaponServantData:GetWeaponServantList())) do
		if WeaponServantCfg[iter_3_1.id].race == HeroCfg[1084].race then
			return true
		end
	end
end

return Guide_8
