local BaseOldGoodsCard = class("BaseOldGoodsCard")

function BaseOldGoodsCard:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.go = arg_1_1
	self.tf = arg_1_1.transform

	setActive(self.tf:Find("item/discount"), false)
	setActive(self.tf:Find("item/group_locked"), false)
	setActive(self.tf:Find("item/limit_time_sell"), false)
	setActive(self.tf:Find("item/icon_bg/slv"), false)
	eachChild(self.tf:Find("mask/tag"), function(arg_2_0)
		setActive(arg_2_0, false)

		return
	end)
	ClearAllText(self.go)
	removeAllOnButton(self.go)
	setText(self.tf:Find("mask/tag/limit_tag"), i18n("quota_shop_good_limit"))
	setText(self.tf:Find("mask/tag/limit_tag/limit_tag_en"), "LIMIT")
	setText(self.tf:Find("mask/tag/sellout_tag"), i18n("word_sell_out"))
	setText(self.tf:Find("mask/tag/sellout_tag/sellout_tag_en"), "SELL OUT")
	setText(self.tf:Find("mask/tag/unexchange_tag"), i18n("meta_shop_exchange_limit"))
	setText(self.tf:Find("mask/tag/unexchange_tag/sellout_tag_en"), "LIMIT")
	removeAllChildren(self.tf:Find("item/icon_bg/stars"))

	local var_1_0 = self.tf:Find("item/icon_bg/icon")

	var_1_0.offsetMin = Vector2(2, 2)
	var_1_0.offsetMax = Vector2(-2, -2)

	local var_1_1 = self.tf:Find("item/icon_bg/frame")

	var_1_1.offsetMin = Vector2(0, 0)
	var_1_1.offsetMax = Vector2(0, 0)

	return
end

function BaseOldGoodsCard:Dispose()
	self:OnDispose()
	eachChild(self.tf:Find("item/icon_bg/frame"), function(arg_4_0)
		setActive(arg_4_0, false)

		return
	end)
	pg.DelegateInfo.Dispose(self)

	return
end

function BaseOldGoodsCard:OnDispose()
	return
end

return BaseOldGoodsCard
