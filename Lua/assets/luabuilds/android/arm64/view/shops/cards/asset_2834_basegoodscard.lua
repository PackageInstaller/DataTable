local BaseGoodsCard = class("BaseGoodsCard")

function BaseGoodsCard:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.mask = findTF(self.tf, "mask")
	self.selloutTag = findTF(self.tf, "mask/tag/sellout_tag")
	self.sellEndTag = findTF(self.tf, "mask/tag/sellend_tag")
	self.levelTag = findTF(self.tf, "mask/tag/level_tag")
	self.unexchangeTag = findTF(self.tf, "mask/tag/unexchange_tag")
	self.levelTagText = findTF(self.tf, "mask/tag/level_tag/TextGo/Text")
	self.limitTag = findTF(self.tf, "mask/tag/limit_tag")
	self.nameTxt = findTF(self.tf, "name_mask/name")
	self.discountTF = findTF(self.tf, "discount")
	self.discountTextTF = findTF(self.discountTF, "Text")
	self.countTF = findTF(self.tf, "consume/contain/Text")
	self.resIconTF = findTF(self.tf, "consume/contain/icon"):GetComponent(typeof(Image))
	self.limitCountLabelTF = findTF(self.tf, "count_contain/label")
	self.itemTF = findTF(self.tf, "itemBg/item")
	self.itemIconBgTF = findTF(self.itemTF, "icon_bg")
	self.itemIconFrameTF = findTF(self.itemTF, "icon_bg/frame")
	self.stars = findTF(self.itemTF, "icon_bg/stars")
	self.itemIconTF = findTF(self.itemTF, "icon_bg/icon"):GetComponent(typeof(Image))
	self.itemCountTF = findTF(self.itemTF, "icon_bg/count")
	self.maskTip = i18n("buy_countLimit")

	setActive(self.discountTF, false)
	setActive(self.itemTF:Find("group_locked"), false)

	self.groupLocked = findTF(self.tf, "group_locked")

	setActive(self.groupLocked, false)
	setText(findTF(self.tf, "group_locked/Text"), i18n("shop_item_unobtained"))
	setActive(self.tf:Find("limit_time_sell"), false)
	setActive(self.tf:Find("itemBg/item/icon_bg/slv"), false)
	eachChild(self.tf:Find("mask/tag"), function(arg_2_0)
		setActive(arg_2_0, false)

		return
	end)
	ClearAllText(self.go)
	removeAllOnButton(self.go)
	setScrollText(self.tf:Find("mask/tag/limit_tag/TextGo/Text"), i18n("quota_shop_good_limit"))
	setScrollText(self.tf:Find("mask/tag/sellout_tag/TextGo/Text"), i18n("word_sell_out"))
	setScrollText(self.tf:Find("mask/tag/unexchange_tag/TextGo/Text"), i18n("meta_shop_exchange_limit"))
	setScrollText(self.sellEndTag:Find("TextGo/Text"), i18n("shop_sell_ended"))
	setScrollText(self.selloutTag:Find("TextGo/Text"), i18n("common_sale_out"))
	setScrollText(self.levelTag:Find("TextGo/Text"), i18n("shop_charge_level_limit"))
	removeAllChildren(self.stars)

	local var_1_0 = self.tf:Find("itemBg/item/icon_bg/icon")

	var_1_0.offsetMin = Vector2(2, 2)
	var_1_0.offsetMax = Vector2(-2, -2)

	local var_1_1 = self.tf:Find("itemBg/item/icon_bg/frame")

	var_1_1.offsetMin = Vector2(0, 0)
	var_1_1.offsetMax = Vector2(0, 0)

	return
end

function BaseGoodsCard:Dispose()
	self:OnDispose()
	pg.DelegateInfo.Dispose(self)

	return
end

function BaseGoodsCard:OnDispose()
	return
end

return BaseGoodsCard
