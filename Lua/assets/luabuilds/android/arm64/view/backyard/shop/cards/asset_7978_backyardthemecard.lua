local BackYardThemeCard = class("BackYardThemeCard")

function BackYardThemeCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.content = self._tf:Find("content")
	self.icon = self.content:Find("icon_mask/icon"):GetComponent(typeof(Image))
	self.nameTxt = self.content:Find("Text"):GetComponent(typeof(Text))
	self.discountTF = self.content:Find("discount")
	self.discountTxt = self.discountTF:Find("Text"):GetComponent(typeof(Text))
	self.hotTF = self.content:Find("hot")
	self.newTF = self.content:Find("new")
	self.maskPurchased = self.content:Find("mask1")

	return
end

function BackYardThemeCard:Update(arg_2_1, arg_2_2)
	self.themeVO = arg_2_1

	LoadSpriteAtlasAsync("BackYardTheme/" .. arg_2_1.id, "", function(arg_3_0)
		self.icon.sprite = arg_3_0

		return
	end)

	self.nameTxt.text = string.gsub(string.gsub(shortenString(arg_2_1:GetName(), 7), "<size=%d+>", ""), "</size>", "")

	local var_2_0 = arg_2_1:HasDiscount()

	setActive(self.discountTF, var_2_0)

	if var_2_0 then
		self.discountTxt.text = arg_2_1:GetDiscount() .. "%"
	end

	local var_2_2 = arg_2_1:getConfig("new") > 0

	setActive(self.hotTF, (not var_2_2 or nil) and arg_2_1:getConfig("hot") > 0 and not arg_2_2)
	setActive(self.newTF, var_2_2 and not arg_2_2)
	setActive(self.maskPurchased, arg_2_2)

	return
end

function BackYardThemeCard:UpdateSelected(arg_4_1)
	local var_4_0 = arg_4_1 and arg_4_1.id == self.themeVO.id

	if IsNil(self.content) then
		return
	end

	local var_4_1

	if LeanTween.isTweening(self.content.gameObject) then
		LeanTween.cancel(self.content.gameObject)

		var_4_1 = var_4_0 and 0 or -70
	end

	LeanTween.value(self.content.gameObject, self.content.anchoredPosition.y, var_4_1, 0.264):setOnUpdate(System.Action_float(function(arg_5_0)
		setAnchoredPosition(self.content, {
			y = arg_5_0
		})

		return
	end))

	return
end

function BackYardThemeCard:Dispose()
	if LeanTween.isTweening(self.content.gameObject) then
		LeanTween.cancel(self.content.gameObject)
	end

	return
end

return BackYardThemeCard
