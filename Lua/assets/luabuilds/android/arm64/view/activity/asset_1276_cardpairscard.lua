local CardPairsCard = class("CardPairsCard")

CardPairsCard.CARD_STATE_BACK = 0
CardPairsCard.CARD_STATE_FRONT = 1
CardPairsCard.CARD_STATE_HIDE = 2
CardPairsCard.ANI_TIME = 0.5

function CardPairsCard:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	pg.DelegateInfo.New(self)

	self.cardTf = arg_1_1
	self.pics = arg_1_2
	self.img = findTF(self.cardTf, "img")
	self.back = findTF(self.cardTf, "back")
	self.front = findTF(self.cardTf, "front")
	self.clearSign = findTF(self.cardTf, "gray")
	self.outline = GetComponent(self.front, typeof(Outline))

	self:setOutline(false)

	self.cardState = self.CARD_STATE_BACK
	self.canClick = true
	self.enable = true
	self.aniCallBack = arg_1_6
	self.aniStartCallBak = arg_1_5

	self:initCard(arg_1_3)
	onButton(self, self.cardTf, function()
		arg_1_4(self)

		return
	end)

	return
end

function CardPairsCard:getCardIndex()
	return self.cardIndex
end

function CardPairsCard:setEnable(arg_4_1)
	self.enable = arg_4_1

	return
end

function CardPairsCard:setClear()
	setActive(self.clearSign, true)
	self:setOutline(false)

	self.canClick = false

	return
end

function CardPairsCard:setOutline(arg_6_1)
	self.outline.enabled = arg_6_1

	return
end

function CardPairsCard:initCard(arg_7_1)
	self.cardIndex = arg_7_1

	self:setSpriteTo(findTF(self.pics, "pic" .. arg_7_1), self.img, false)
	setActive(self.clearSign, false)
	self:showBack()

	self.canClick = true

	return
end

function CardPairsCard:showBack()
	setActive(self.back, true)
	setActive(self.front, false)
	setActive(self.img, false)

	self.cardState = self.CARD_STATE_BACK

	self:setOutline(false)

	return
end

function CardPairsCard:showFront()
	setActive(self.back, false)
	setActive(self.front, true)
	setActive(self.img, true)

	self.cardState = self.CARD_STATE_FRONT

	return
end

function CardPairsCard:aniShowBack(arg_10_1, arg_10_2, arg_10_3)
	self.canClick = false

	if arg_10_1 then
		self:showBack()
	else
		self:showFront()
	end

	if not arg_10_2 then
		self:aniStartCallBak(arg_10_1)
	end

	self.cardTf.localScale = Vector3(1, 1, 1)

	LeanTween.scale(go(self.cardTf), Vector3(0, 1, 1), self.ANI_TIME):setDelay(defaultValue(arg_10_3, 0)):setOnComplete(System.Action(function()
		if arg_10_1 then
			self:showFront()
		else
			self:showBack()
		end

		LeanTween.scale(go(self.cardTf), Vector3(1, 1, 1), self.ANI_TIME):setOnComplete(System.Action(function()
			self.canClick = true

			if not arg_10_2 then
				self:aniCallBack(arg_10_1)
			end

			return
		end))

		return
	end))

	return
end

function CardPairsCard:setSpriteTo(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_2:GetComponent(typeof(Image))

	var_13_0.sprite = arg_13_1:GetComponent(typeof(Image)).sprite

	if arg_13_3 then
		var_13_0:SetNativeSize()
	end

	return
end

function CardPairsCard:clear()
	LeanTween.cancel(go(self.cardTf))

	return
end

function CardPairsCard:destroy()
	pg.DelegateInfo.Dispose(self)
	LeanTween.cancel(go(self.cardTf))

	return
end

return CardPairsCard
