local ActivityMartixHeroWeaponPage = class("ActivityMartixHeroWeaponPage", MartixHeroWeaponPage)

function ActivityMartixHeroWeaponPage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	ActivityMartixHeroWeaponPage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function ActivityMartixHeroWeaponPage:GetHeroData(arg_2_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_2_1)
end

return ActivityMartixHeroWeaponPage
