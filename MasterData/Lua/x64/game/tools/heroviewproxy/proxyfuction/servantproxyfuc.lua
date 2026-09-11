return {
	GetServantEffect = function(self, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = WeaponServantCfg[arg_1_1].effect[1]
		local var_1_1 = ServantTools.GetServantSpecHero(arg_1_1)
		local var_1_2 = self:GetHeroData(var_1_1)

		if WeaponServantCfg[arg_1_1].effect[1] == 0 then
			return WeaponServantCfg[arg_1_1].effect_desc
		else
			local var_1_3 = var_1_2 and HeroTools:GetModulePowersByHeroIDAndLevel(var_1_2.id, var_1_2.moduleLevel) or HeroTools:GetModulePowersByHeroIDAndLevel(var_1_1, 0)

			if arg_1_3 == true then
				if WeaponEffectCfg[var_1_0].simple_strength_description[1] and table.indexof(var_1_3, WeaponEffectCfg[var_1_0].simple_strength_description[1]) then
					return GetI18NText(WeaponEffectCfg[var_1_0].simple_strength_description[2])
				else
					return GetI18NText(WeaponEffectCfg[var_1_0].simple_description)
				end
			else
				return GetCfgDescription((WeaponEffectCfg[var_1_0].strengthen_description[1] and table.indexof(var_1_3, WeaponEffectCfg[var_1_0].strengthen_description[1]) or nil) and WeaponEffectCfg[var_1_0].strengthen_description[2], arg_1_2)
			end
		end
	end
}
