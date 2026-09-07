local SkinEncoreLoginRePage = class("SkinEncoreLoginRePage", import(".SkinEncoreLoginPage"))

function SkinEncoreLoginRePage:GetTips()
	return pg.gametip.SkinDiscountHelp_Carnival.tip
end

function SkinEncoreLoginRePage:GetCouponCountText()
	return string.format("<color=#FFFFFF>%s</color>", self.couponCount)
end

function SkinEncoreLoginRePage:GetGiftShopType()
	return ChargeScene.TYPE_PICK
end

return SkinEncoreLoginRePage
