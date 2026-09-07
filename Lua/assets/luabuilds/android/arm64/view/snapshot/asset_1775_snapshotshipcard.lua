local SnapshotShipCard = class("SnapshotShipCard")

SnapshotShipCard.TypeCard = 1
SnapshotShipCard.TypeTrans = 2

local var_0_1 = pg.ship_data_group

function SnapshotShipCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.btn = GetOrAddComponent(arg_1_1, "Button")
	self.content = findTF(self.tr, "content").gameObject

	setActive(findTF(self.content, "dockyard"), false)
	setActive(findTF(self.content, "collection"), true)

	self.shipFrameImg = findTF(self.content, "front/frame")
	self.iconShip = findTF(self.content, "ship_icon"):GetComponent(typeof(Image))
	self.imageBg = findTF(self.content, "bg"):GetComponent(typeof(Image))
	self.labelName = findTF(self.content, "info/name_mask/name")
	self.iconType = findTF(self.content, "info/top/type"):GetComponent(typeof(Image))
	self.ringTF = findTF(self.content, "front/ring")
	self.maskTF = findTF(self.content, "collection/mask")
	self.heart = findTF(self.content, "collection/heart")
	self.labelHeart = findTF(self.heart, "heart"):GetComponent(typeof(Text))
	self.labelHeartIcon = findTF(self.heart, "icon"):GetComponent(typeof(Image))
	self.labelHeartPlus = findTF(self.heart, "heart+"):GetComponent(typeof(Text))
	self.imageUnknown = findTF(self.tr, "unknown"):GetComponent(typeof(Image))

	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function SnapshotShipCard:update(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	TweenItemAlphaAndWhite(self.go)

	local var_2_0 = ShipGroup.getState(arg_2_5, arg_2_2, arg_2_3)

	if self.code ~= arg_2_1 or self.shipGroup ~= arg_2_2 or self.showTrans ~= arg_2_3 or self.propose ~= arg_2_4 or self.state ~= var_2_0 then
		self.code = arg_2_1
		self.shipGroup = arg_2_2
		self.showTrans = arg_2_3
		self.propose = arg_2_4
		self.state = var_2_0
		self.config = var_0_1[arg_2_5]

		self:flush()
	end

	return
end

function SnapshotShipCard:flush()
	if self.shipGroup then
		local var_3_0 = self.shipGroup:rarity2bgPrint(self.showTrans)

		GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_3_0, "", self.imageBg)

		self.iconShip.sprite = GetSpriteFromAtlas("shipYardIcon/unknown", "")

		LoadSpriteAsync("shipYardIcon/" .. self.shipGroup:getPainting(self.showTrans), function(arg_4_0)
			if self.go then
				self.iconShip.sprite = arg_4_0
			end

			return
		end)

		self.iconType.sprite = GetSpriteFromAtlas("shiptype", shipType2print(self.shipGroup:getShipType(self.showTrans)))

		setScrollText(self.labelName, self.shipGroup:getName(self.showTrans))

		self.labelHeart.text = self.shipGroup.hearts > 999 and "999" or tostring(self.shipGroup.hearts)

		setActive(self.labelHeartPlus, self.shipGroup.hearts > 999)

		self.labelHeart.color = self.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)
		self.labelHeartIcon.color = self.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)
		self.labelHeartPlus.color = self.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

		setShipCardFrame(self.shipFrameImg, var_3_0)
	end

	self.content:SetActive(tobool(self.shipGroup))
	self.imageUnknown.gameObject:SetActive(not self.shipGroup)

	if self.shipGroup then
		self.btn.targetGraphic = self.imageFrame or self.imageUnknown
	end

	setActive(self.ringTF, self.propose)

	return
end

function SnapshotShipCard:clear()
	ClearTweenItemAlphaAndWhite(self.go)

	self.shipGroup = nil
	self.showTrans = nil
	self.propose = nil
	self.code = nil

	return
end

return SnapshotShipCard
