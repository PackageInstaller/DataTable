return {
	GetServantEffect = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = WeaponServantCfg[arg_1_1].effect[1]
		local var_1_1 = ServantTools.GetServantSpecHero(arg_1_1)
		local var_1_2 = arg_1_0:GetHeroData(var_1_1)

		if var_1_0 == 0 then
			return WeaponServantCfg[arg_1_1].effect_desc
		else
			local var_1_3

			if var_1_2 then
				var_1_3 = HeroTools:GetModulePowersByHeroIDAndLevel(var_1_2.id, var_1_2.moduleLevel)
			else
				var_1_3 = HeroTools:GetModulePowersByHeroIDAndLevel(var_1_1, 0)
			end

			if arg_1_3 == true then
				local var_1_4 = WeaponEffectCfg[var_1_0]

				if var_1_4.simple_strength_description[1] and table.indexof(var_1_3, var_1_4.simple_strength_description[1]) then
					return GetI18NText(var_1_4.simple_strength_description[2])
				else
					return GetI18NText(var_1_4.simple_description)
				end
			else
				local var_1_5 = WeaponEffectCfg[var_1_0].description[1]

				if WeaponEffectCfg[var_1_0].strengthen_description[1] and table.indexof(var_1_3, WeaponEffectCfg[var_1_0].strengthen_description[1]) then
					var_1_5 = WeaponEffectCfg[var_1_0].strengthen_description[2]
				end

				return GetCfgDescription(var_1_5, arg_1_2)
			end
		end
	end
}
