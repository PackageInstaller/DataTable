local SportAndRacingSkinEncoreLoginPage = class("SportAndRacingSkinEncoreLoginPage", import(".SkinEncoreLoginPage"))

function SportAndRacingSkinEncoreLoginPage:GetTips()
	return pg.gametip.SkinDiscountHelp_Carnival.tip
end

function SportAndRacingSkinEncoreLoginPage:GetCouponCountText()
	return string.format("<color=#FFFFFF>%s</color>", self.couponCount)
end

function SportAndRacingSkinEncoreLoginPage:GetGiftShopType()
	return ChargeScene.TYPE_PICK
end

return SportAndRacingSkinEncoreLoginPage
