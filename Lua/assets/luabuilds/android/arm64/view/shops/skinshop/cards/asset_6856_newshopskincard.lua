local NewShopSkinCard = class("NewShopSkinCard")

function NewShopSkinCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self._content = self._tf:Find("frame/content")
	self._icon = self._tf:Find("frame/content/main/bg/mask/icon"):GetComponent(typeof(Image))
	self._priceTF = self._tf:Find("frame/content/main/bg/price")

	setActive(self._priceTF, false)

	self._priceIcon = self._priceTF:Find("gem"):GetComponent(typeof(Image))
	self._priceTxt = self._priceTF:Find("gem/Text"):GetComponent(typeof(Text))
	self._opriceTxt = self._priceTF:Find("originalprice"):GetComponent(typeof(Text))
	self.tagImg = self._tf:Find("frame/content/top/tag_activity"):GetComponent(typeof(Image))
	self.discountTag = self._tf:Find("frame/content/top/tag_discount")
	self.discountTagOffTxt = self.discountTag:Find("Text"):GetComponent(typeof(Text))
	self.isSelected = false
	self.probability = self._tf:Find("frame/content/top/tag_probability")

	setActive(self.probability, false)

	return
end

local var_0_1 = 5
local var_0_2 = 6
local var_0_3 = -2
local var_0_4 = -3
local var_0_5 = -4
local var_0_6 = {
	[302053] = 39
}
local var_0_7 = {
	{
		"rexiao",
		"hot_sells"
	},
	{
		"xinpin",
		"xinpin"
	},
	{
		"tuijian",
		"tujian"
	},
	{
		"huodong",
		"huodong"
	},
	{
		"",
		""
	},
	{
		"fanchang_2",
		""
	},
	[-2] = {
		"",
		""
	},
	[-3] = {
		"yigoumai",
		"clothing"
	},
	[-4] = {
		"",
		"clothing"
	}
}

function NewShopSkinCard:GetTagId(arg_2_1)
	local var_2_0 = self.buyCount == 0

	if arg_2_1 and var_2_0 then
		return var_0_2
	end

	if self:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
		return var_0_3
	end

	if not var_2_0 then
		return var_0_4
	end

	local var_2_1 = self:getConfig("tag")

	if (self:isDisCount() or var_2_1 == var_0_1) and not self:IsItemDiscountType() then
		return var_0_1
	elseif var_0_7[var_2_1] then
		return var_2_1
	else
		return var_0_5
	end

	return
end

function NewShopSkinCard:Update(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.commodity = arg_3_1
	self.isReturn = arg_3_3

	local var_3_0 = arg_3_1:getSkinId()

	self.shipSkinConfig = pg.ship_skin_template[var_3_0]
	self._icon.sprite = nil

	LoadSpriteAsync("shipYardIcon/" .. pg.ship_skin_template[var_3_0].prefab, function(arg_4_0)
		if not IsNil(self._icon) then
			self._icon.sprite = arg_4_0
		end

		return
	end)

	local var_3_1 = false
	local var_3_2 = false
	local var_3_3 = self.commodity.type == Goods.TYPE_SKIN

	if self.commodity.type == Goods.TYPE_SKIN then
		LoadSpriteAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = arg_3_1:getConfig("resource_type")
		}):getIcon(), function(arg_5_0)
			if IsNil(self._priceIcon) then
				return
			end

			self._priceIcon.sprite = arg_5_0

			return
		end)

		local var_3_4, var_3_5 = arg_3_1:GetPrice()

		self._priceTxt.text = var_3_4
		self._opriceTxt.text = arg_3_1:getConfig("resource_num")

		setActive(go(self._opriceTxt), arg_3_1:isDisCount() and var_3_5 > 0)

		local var_3_6 = NewShopSkinCard.GetTagId(arg_3_1, arg_3_3)

		if var_3_6 == var_0_1 then
			var_3_1 = true
			self.discountTagOffTxt.text = string.format("%0.2f", var_3_5) .. "%"
		elseif var_3_6 == var_0_3 then
			var_3_2 = true
		else
			local var_3_7 = var_0_7[var_3_6][1]

			self.tagImg.enabled = var_0_7[var_3_6][1] and var_3_7 ~= ""

			if self.tagImg.enabled then
				self.tagImg.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", "tag_" .. var_3_7)
			end
		end
	end

	setActive(self.tagImg.gameObject, var_3_3 and not var_3_1 and not var_3_2)
	setActive(self.discountTag, var_3_3 and var_3_1)
	setAnchoredPosition(self._icon.gameObject, {
		y = var_0_6[var_3_0] or 0
	})
	self:UpdateSelected(arg_3_2)

	if arg_3_4 then
		setActive(self.probability, true)
		setText(self.probability:Find("Text"), " " .. string.format("%0.1f", (arg_3_4 or 0) / 100) .. "%")
	end

	return
end

function NewShopSkinCard:UpdateSelected(arg_6_1)
	if self.isSelected ~= arg_6_1 then
		self.isSelected = arg_6_1
		self._content.localPosition = Vector3(0, arg_6_1 and -7.8 or -61, 0)

		setActive(self._priceTF, arg_6_1 and self.commodity.type == Goods.TYPE_SKIN)
	end

	return
end

function NewShopSkinCard:Dispose()
	self:UpdateSelected(false)

	self._go = nil
	self._tf = nil

	return
end

return NewShopSkinCard
