return {
	GetHeroWeaponInfo = function(self, arg_1_1)
		local var_1_0 = self.dataClass:GetHeroWeaponInfo(arg_1_1, self.tempHeroList)

		if self:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			local var_1_1 = deepClone(var_1_0)

			var_1_1.level, var_1_1.exp, var_1_1.breakthrough = 1, 0, 0

			return (deepClone(var_1_0))
		end

		return var_1_0
	end
}
