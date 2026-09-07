local DressSkinEncoreLoginPage = class("DressSkinEncoreLoginPage", import(".SkinEncoreLoginPage"))

function DressSkinEncoreLoginPage:GetTips()
	return pg.gametip.SkinDiscountHelp_Carnival.tip
end

function DressSkinEncoreLoginPage:GetCouponCountText()
	return string.format("<color=#FFFFFF>%s</color>", self.couponCount)
end

function DressSkinEncoreLoginPage:GetGiftShopType()
	return ChargeScene.TYPE_PICK
end

return DressSkinEncoreLoginPage
