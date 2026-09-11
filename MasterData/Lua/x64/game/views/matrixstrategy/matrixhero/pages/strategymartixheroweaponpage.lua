local StrategyMartixHeroWeaponPage = class("StrategyMartixHeroWeaponPage", MartixHeroWeaponPage)

function StrategyMartixHeroWeaponPage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	StrategyMartixHeroWeaponPage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function StrategyMartixHeroWeaponPage:GetHeroData(arg_2_1)
	return StrategyMatrixData:GetHeroData(arg_2_1)
end

return StrategyMartixHeroWeaponPage
