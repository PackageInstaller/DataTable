local BackYardDecorationCard = class("BackYardDecorationCard")

function BackYardDecorationCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self._bg = findTF(self._tf, "bg")
	self.maskTF = findTF(self._tf, "bg/mask")
	self.iconImg = findTF(self._tf, "bg/icon"):GetComponent(typeof(Image))
	self.comfortableTF = findTF(self._tf, "bg/comfortable")
	self.newTF = findTF(self._tf, "bg/new_bg")
	self.countTxt = findTF(self._tf, "bg/count")
	self.mark = findTF(self._tf, "bg/mark")
	self.animation = self._tf:GetComponent(typeof(Animation))

	return
end

function BackYardDecorationCard:Update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.furniture = arg_2_1

	LoadSpriteAtlasAsync("furnitureicon/" .. arg_2_1:getConfig("icon"), "", function(arg_3_0)
		if IsNil(self.iconImg) then
			return
		end

		self.iconImg.sprite = arg_3_0

		return
	end)
	setText(self.comfortableTF, shortenString(HXSet.hxLan(arg_2_1:getConfig("name")), 4))

	local var_2_0 = arg_2_1:getConfig("count")
	local var_2_1 = arg_2_1:GetOwnCnt()

	self.showMask = var_2_1 <= arg_2_2

	SetActive(self.maskTF, self.showMask)
	setText(self.maskTF:Find("Text"), i18n("courtyard_label_using", arg_2_3))
	self:UpdateMark(arg_2_4)

	if var_2_0 > 1 then
		setText(self.countTxt, arg_2_2 .. "/" .. var_2_1)
		SetActive(self.maskTF, arg_2_2 == var_2_1)
	else
		setText(self.countTxt, "")
	end

	SetActive(self.newTF, arg_2_1.newFlag)

	return
end

function BackYardDecorationCard:PlayEnterAnimation()
	self.animation:Play("anim_backyard_furniture_itemin")

	return
end

function BackYardDecorationCard:UpdateMark(arg_5_1)
	if not self.furniture then
		setActive(self.mark, false)

		return
	end

	setActive(self.mark, arg_5_1 and arg_5_1 == self.furniture.id)

	return
end

function BackYardDecorationCard:Flush(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1.id == self.furniture.id then
		self:Update(arg_6_1, arg_6_2, arg_6_3)
	else
		self:Update(self.furniture, arg_6_2, arg_6_3)
	end

	return
end

function BackYardDecorationCard:HasMask()
	return self.showMask
end

function BackYardDecorationCard:Dispose()
	return
end

return BackYardDecorationCard
