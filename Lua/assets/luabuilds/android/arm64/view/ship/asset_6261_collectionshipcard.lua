local CollectionShipCard = class("CollectionShipCard")

CollectionShipCard.TypeCard = 1
CollectionShipCard.TypeTrans = 2

local var_0_1 = pg.ship_data_group

function CollectionShipCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.btn = GetOrAddComponent(arg_1_1, "Button")
	self.content = findTF(self.tr, "content").gameObject

	setActive(findTF(self.content, "dockyard"), false)
	setActive(findTF(self.content, "collection"), true)
	setActive(findTF(self.content, "expbuff"), false)

	self.shipFrameImg = findTF(self.content, "front/frame")
	self.iconShip = findTF(self.content, "ship_icon"):GetComponent(typeof(Image))
	self.imageBg = findTF(self.content, "bg"):GetComponent(typeof(Image))
	self.labelName = findTF(self.content, "info/name_mask/name")
	self.mask2D = GetOrAddComponent(findTF(self.content, "info/name_mask"), typeof(RectMask2D))
	self.iconType = findTF(self.content, "info/top/type"):GetComponent(typeof(Image))
	self.ringTF = findTF(self.content, "front/ring")
	self.ringMetaTF = findTF(self.content, "front/ring_meta")
	self.maskTF = findTF(self.content, "collection/mask")
	self.heart = findTF(self.content, "collection/heart")
	self.labelHeart = findTF(self.heart, "heart"):GetComponent(typeof(Text))
	self.labelHeartIcon = findTF(self.heart, "icon"):GetComponent(typeof(Image))
	self.labelHeartPlus = findTF(self.heart, "heart+"):GetComponent(typeof(Text))
	self.imageUnknown = findTF(self.tr, "unknown"):GetComponent(typeof(Image))

	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function CollectionShipCard:getIsInited()
	return self.shipGroup ~= nil
end

function CollectionShipCard:update(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = ShipGroup.getState(arg_3_5, arg_3_2, arg_3_3)

	if self.code ~= arg_3_1 or self.shipGroup ~= arg_3_2 or self.showTrans ~= arg_3_3 or self.propose ~= arg_3_4 or self.state ~= var_3_0 then
		self.code = arg_3_1
		self.shipGroup = arg_3_2
		self.showTrans = arg_3_3
		self.propose = arg_3_4
		self.state = var_3_0
		self.config = var_0_1[arg_3_5]

		self:flush()
	end

	TweenItemAlphaAndWhite(self.go)

	return
end

function CollectionShipCard:flush()
	setActive(self.heart, self.state == ShipGroup.STATE_UNLOCK)

	if self.state == ShipGroup.STATE_UNLOCK then
		self.labelHeart.text = self.shipGroup.hearts > 999 and "999" or tostring(self.shipGroup.hearts)

		setActive(self.labelHeartPlus, self.shipGroup.hearts > 999)

		self.labelHeart.color = self.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)
		self.labelHeartIcon.color = self.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)
		self.labelHeartPlus.color = self.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

		self:loadImage(self.shipGroup, true)
	elseif self.state == ShipGroup.STATE_NOTGET then
		self.shipGroup = ShipGroup.New({
			id = self.config.group_type
		})
		self.shipGroup.trans = true

		if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
			self:loadImage(self.shipGroup, false)
		else
			self:loadImage(self.shipGroup, true)
		end
	elseif self.state == ShipGroup.STATE_LOCK then
		-- block empty
	end

	setActive(self.content, self.state == ShipGroup.STATE_NOTGET or self.state == ShipGroup.STATE_UNLOCK)
	setActive(self.imageUnknown, self.state == ShipGroup.STATE_LOCK)
	setActive(self.maskTF, self.state == ShipGroup.STATE_NOTGET)

	if self.shipGroup then
		local var_4_3 = self.shipGroup:isMetaGroup()

		setActive(self.ringTF, self.propose and not var_4_3)
		setActive(self.ringMetaTF, self.propose and var_4_3)
	else
		setActive(self.ringTF, false)
		setActive(self.ringMetaTF, false)
	end

	self.mask2D.enabled = self.mask2D.enabled or true

	setActive(self.labelName, false)
	setActive(self.labelName, true)

	return
end

function CollectionShipCard:loadImage(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:rarity2bgPrint(self.showTrans)
	local var_5_1 = arg_5_2 and arg_5_1:getPainting(self.showTrans) or "unknown"

	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_5_0, "", self.imageBg)

	self.loadingPaintingName = var_5_1

	GetSpriteFromAtlasAsync("shipYardIcon/" .. var_5_1, "", function(arg_6_0)
		if not IsNil(self.go) and self.loadingPaintingName == var_5_1 then
			self.iconShip.sprite = arg_6_0
		end

		return
	end)

	self.iconType.sprite = GetSpriteFromAtlas("shiptype", shipType2print(arg_5_1:getShipType(self.showTrans)))

	setScrollText(self.labelName, arg_5_1:getName(self.showTrans))
	setShipCardFrame(self.shipFrameImg, var_5_0)

	return
end

function CollectionShipCard:clear()
	self.shipGroup = nil
	self.showTrans = nil
	self.propose = nil
	self.code = nil

	ClearTweenItemAlphaAndWhite(self.go)

	return
end

return CollectionShipCard
