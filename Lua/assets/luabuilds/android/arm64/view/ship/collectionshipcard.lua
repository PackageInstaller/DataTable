local var_0_0 = class("CollectionShipCard")

var_0_0.TypeCard = 1
var_0_0.TypeTrans = 2

local var_0_1 = pg.ship_data_group

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.btn = GetOrAddComponent(arg_1_1, "Button")
	arg_1_0.content = findTF(arg_1_0.tr, "content").gameObject

	setActive(findTF(arg_1_0.content, "dockyard"), false)
	setActive(findTF(arg_1_0.content, "collection"), true)
	setActive(findTF(arg_1_0.content, "expbuff"), false)

	arg_1_0.shipFrameImg = findTF(arg_1_0.content, "front/frame")
	arg_1_0.iconShip = findTF(arg_1_0.content, "ship_icon"):GetComponent(typeof(Image))
	arg_1_0.imageBg = findTF(arg_1_0.content, "bg"):GetComponent(typeof(Image))
	arg_1_0.labelName = findTF(arg_1_0.content, "info/name_mask/name")
	arg_1_0.mask2D = GetOrAddComponent(findTF(arg_1_0.content, "info/name_mask"), typeof(RectMask2D))
	arg_1_0.iconType = findTF(arg_1_0.content, "info/top/type"):GetComponent(typeof(Image))
	arg_1_0.ringTF = findTF(arg_1_0.content, "front/ring")
	arg_1_0.ringMetaTF = findTF(arg_1_0.content, "front/ring_meta")
	arg_1_0.maskTF = findTF(arg_1_0.content, "collection/mask")
	arg_1_0.heart = findTF(arg_1_0.content, "collection/heart")
	arg_1_0.labelHeart = findTF(arg_1_0.heart, "heart"):GetComponent(typeof(Text))
	arg_1_0.labelHeartIcon = findTF(arg_1_0.heart, "icon"):GetComponent(typeof(Image))
	arg_1_0.labelHeartPlus = findTF(arg_1_0.heart, "heart+"):GetComponent(typeof(Text))
	arg_1_0.imageUnknown = findTF(arg_1_0.tr, "unknown"):GetComponent(typeof(Image))

	ClearTweenItemAlphaAndWhite(arg_1_0.go)

	return
end

function var_0_0.getIsInited(arg_2_0)
	return arg_2_0.shipGroup ~= nil
end

function var_0_0.update(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = ShipGroup.getState(arg_3_5, arg_3_2, arg_3_3)

	if arg_3_0.code ~= arg_3_1 or arg_3_0.shipGroup ~= arg_3_2 or arg_3_0.showTrans ~= arg_3_3 or arg_3_0.propose ~= arg_3_4 or arg_3_0.state ~= var_3_0 then
		arg_3_0.code = arg_3_1
		arg_3_0.shipGroup = arg_3_2
		arg_3_0.showTrans = arg_3_3
		arg_3_0.propose = arg_3_4
		arg_3_0.state = var_3_0
		arg_3_0.config = var_0_1[arg_3_5]

		arg_3_0:flush()
	end

	TweenItemAlphaAndWhite(arg_3_0.go)

	return
end

function var_0_0.flush(arg_4_0)
	setActive(arg_4_0.heart, arg_4_0.state == ShipGroup.STATE_UNLOCK)

	if arg_4_0.state == ShipGroup.STATE_UNLOCK then
		arg_4_0.labelHeart.text = arg_4_0.shipGroup.hearts > 999 and "999" or tostring(arg_4_0.shipGroup.hearts)

		setActive(arg_4_0.labelHeartPlus, arg_4_0.shipGroup.hearts > 999)

		local var_4_0 = arg_4_0.labelHeart

		var_4_0.color = arg_4_0.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

		local var_4_1 = arg_4_0.labelHeartIcon

		var_4_1.color = arg_4_0.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

		local var_4_2 = arg_4_0.labelHeartPlus

		var_4_2.color = arg_4_0.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

		arg_4_0:loadImage(arg_4_0.shipGroup, true)
	elseif arg_4_0.state == ShipGroup.STATE_NOTGET then
		arg_4_0.shipGroup = ShipGroup.New({
			id = arg_4_0.config.group_type
		})
		arg_4_0.shipGroup.trans = true

		if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
			arg_4_0:loadImage(arg_4_0.shipGroup, false)
		else
			arg_4_0:loadImage(arg_4_0.shipGroup, true)
		end
	elseif arg_4_0.state == ShipGroup.STATE_LOCK then
		-- block empty
	end

	setActive(arg_4_0.content, arg_4_0.state == ShipGroup.STATE_NOTGET or arg_4_0.state == ShipGroup.STATE_UNLOCK)
	setActive(arg_4_0.imageUnknown, arg_4_0.state == ShipGroup.STATE_LOCK)
	setActive(arg_4_0.maskTF, arg_4_0.state == ShipGroup.STATE_NOTGET)

	if arg_4_0.shipGroup then
		local var_4_3 = arg_4_0.shipGroup:isMetaGroup()
		local var_4_4 = arg_4_0.propose and not var_4_3

		setActive(arg_4_0.ringTF, var_4_4)

		local var_4_5 = arg_4_0.propose and var_4_3

		setActive(arg_4_0.ringMetaTF, var_4_5)
	else
		setActive(arg_4_0.ringTF, false)
		setActive(arg_4_0.ringMetaTF, false)
	end

	arg_4_0.mask2D.enabled = arg_4_0.mask2D.enabled or true

	setActive(arg_4_0.labelName, false)
	setActive(arg_4_0.labelName, true)

	return
end

function var_0_0.loadImage(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:rarity2bgPrint(arg_5_0.showTrans)
	local var_5_1 = arg_5_2 and arg_5_1:getPainting(arg_5_0.showTrans) or "unknown"

	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_5_0, "", arg_5_0.imageBg)

	arg_5_0.loadingPaintingName = var_5_1

	GetSpriteFromAtlasAsync("shipYardIcon/" .. var_5_1, "", function(arg_6_0)
		if not IsNil(arg_5_0.go) and arg_5_0.loadingPaintingName == var_5_1 then
			arg_5_0.iconShip.sprite = arg_6_0
		end

		return
	end)

	arg_5_0.iconType.sprite = GetSpriteFromAtlas("shiptype", shipType2print(arg_5_1:getShipType(arg_5_0.showTrans)))

	setScrollText(arg_5_0.labelName, arg_5_1:getName(arg_5_0.showTrans))
	setShipCardFrame(arg_5_0.shipFrameImg, var_5_0)

	return
end

function var_0_0.clear(arg_7_0)
	arg_7_0.shipGroup = nil
	arg_7_0.showTrans = nil
	arg_7_0.propose = nil
	arg_7_0.code = nil

	ClearTweenItemAlphaAndWhite(arg_7_0.go)

	return
end

return var_0_0
