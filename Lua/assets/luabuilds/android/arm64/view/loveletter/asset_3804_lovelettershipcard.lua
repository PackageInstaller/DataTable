local LoveLetterShipCard = class("LoveLetterShipCard")

function LoveLetterShipCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.btn = GetOrAddComponent(arg_1_1, "Button")
	self.content = findTF(self.tr, "content").gameObject

	setActive(findTF(self.content, "dockyard"), false)

	self.shipFrameImg = findTF(self.content, "front/frame")
	self.iconShip = findTF(self.content, "ship_icon"):GetComponent(typeof(Image))
	self.imageBg = findTF(self.content, "bg"):GetComponent(typeof(Image))
	self.labelName = findTF(self.content, "info/name_mask/name")
	self.iconType = findTF(self.content, "info/top/type"):GetComponent(typeof(Image))
	self.ringTF = findTF(self.content, "front/ring")
	self.maskTF = findTF(self.content, "collection/mask")
	self.imageUnknown = findTF(self.tr, "unknown"):GetComponent(typeof(Image))

	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function LoveLetterShipCard:update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	TweenItemAlphaAndWhite(self.go)

	local var_2_0 = ShipGroup.getState(arg_2_4, arg_2_1, arg_2_2)

	if self.shipGroup ~= arg_2_1 or self.showTrans ~= arg_2_2 or self.propose ~= arg_2_3 or self.state ~= var_2_0 then
		self.shipGroup = arg_2_1
		self.showTrans = arg_2_2
		self.propose = arg_2_3
		self.state = var_2_0

		self:flush()
	end

	return
end

function LoveLetterShipCard:flush()
	if self.shipGroup then
		local var_3_0 = self.shipGroup:rarity2bgPrint(self.showTrans)

		GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_3_0, "", self.imageBg)

		self.iconShip.sprite = GetSpriteFromAtlas("shipYardIcon/unknown", "")

		LoadSpriteAsync("shipYardIcon/" .. self.shipGroup:getPainting(self.showTrans), function(arg_4_0)
			if self.iconShip then
				self.iconShip.sprite = arg_4_0
			end

			return
		end)

		self.iconType.sprite = GetSpriteFromAtlas("shiptype", shipType2print(self.shipGroup:getShipType(self.showTrans)))

		setScrollText(self.labelName, self.shipGroup:getName(self.showTrans))
		setShipCardFrame(self.shipFrameImg, var_3_0)

		local var_3_1 = self.content.transform:Find("love_letter")
		local var_3_2 = getProxy(LoveLetterProxy):GetGroupData(self.shipGroup.id)

		setActive(var_3_1, var_3_2.exp > 0)

		if var_3_2.exp > 0 then
			local var_3_3, var_3_4 = var_3_2:GetDisplayExp()

			if var_3_4 == 0 then
				setSlider(var_3_1, 0, 1, 1)
			else
				setSlider(var_3_1, 0, var_3_4, var_3_3)
			end

			setText(var_3_1:Find("mark/Text"), var_3_2:GetDisplayLevelMark())

			local var_3_5 = var_3_2:GetDisplayRank()

			eachChild(var_3_1:Find("mark/bg"), function(arg_5_0, arg_5_1)
				setActive(arg_5_0, arg_5_1 == var_3_5)

				return
			end)
		end
	end

	self.content:SetActive(tobool(self.shipGroup))
	self.imageUnknown.gameObject:SetActive(not self.shipGroup)

	if self.shipGroup then
		self.btn.targetGraphic = self.imageFrame or self.imageUnknown
	end

	setActive(self.ringTF, self.propose)

	return
end

function LoveLetterShipCard:clear()
	ClearTweenItemAlphaAndWhite(self.go)

	self.shipGroup = nil
	self.showTrans = nil
	self.propose = nil

	return
end

return LoveLetterShipCard
