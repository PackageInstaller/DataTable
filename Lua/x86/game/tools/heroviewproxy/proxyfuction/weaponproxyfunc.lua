return {
	GetHeroWeaponInfo = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_0.dataClass:GetHeroWeaponInfo(arg_1_1, arg_1_0.tempHeroList)

		if arg_1_0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			local var_1_1 = deepClone(var_1_0)

			var_1_1.level, var_1_1.exp, var_1_1.breakthrough = 1, 0, 0

			return var_1_1
		end

		return var_1_0
	end
}
