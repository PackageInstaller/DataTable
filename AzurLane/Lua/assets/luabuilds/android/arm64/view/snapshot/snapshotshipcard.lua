local var_0_0 = class("SnapshotShipCard")

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

	arg_1_0.shipFrameImg = findTF(arg_1_0.content, "front/frame")
	arg_1_0.iconShip = findTF(arg_1_0.content, "ship_icon"):GetComponent(typeof(Image))
	arg_1_0.imageBg = findTF(arg_1_0.content, "bg"):GetComponent(typeof(Image))
	arg_1_0.labelName = findTF(arg_1_0.content, "info/name_mask/name")
	arg_1_0.iconType = findTF(arg_1_0.content, "info/top/type"):GetComponent(typeof(Image))
	arg_1_0.ringTF = findTF(arg_1_0.content, "front/ring")
	arg_1_0.maskTF = findTF(arg_1_0.content, "collection/mask")
	arg_1_0.heart = findTF(arg_1_0.content, "collection/heart")
	arg_1_0.labelHeart = findTF(arg_1_0.heart, "heart"):GetComponent(typeof(Text))
	arg_1_0.labelHeartIcon = findTF(arg_1_0.heart, "icon"):GetComponent(typeof(Image))
	arg_1_0.labelHeartPlus = findTF(arg_1_0.heart, "heart+"):GetComponent(typeof(Text))
	arg_1_0.imageUnknown = findTF(arg_1_0.tr, "unknown"):GetComponent(typeof(Image))

	ClearTweenItemAlphaAndWhite(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	TweenItemAlphaAndWhite(arg_2_0.go)

	local var_2_0 = ShipGroup.getState(arg_2_5, arg_2_2, arg_2_3)

	if arg_2_0.code ~= arg_2_1 or arg_2_0.shipGroup ~= arg_2_2 or arg_2_0.showTrans ~= arg_2_3 or arg_2_0.propose ~= arg_2_4 or arg_2_0.state ~= var_2_0 then
		arg_2_0.code = arg_2_1
		arg_2_0.shipGroup = arg_2_2
		arg_2_0.showTrans = arg_2_3
		arg_2_0.propose = arg_2_4
		arg_2_0.state = var_2_0
		arg_2_0.config = var_0_1[arg_2_5]

		arg_2_0:flush()
	end

	return
end

function var_0_0.flush(arg_3_0)
	if arg_3_0.shipGroup then
		local var_3_0 = arg_3_0.shipGroup:rarity2bgPrint(arg_3_0.showTrans)

		GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_3_0, "", arg_3_0.imageBg)

		arg_3_0.iconShip.sprite = GetSpriteFromAtlas("shipYardIcon/unknown", "")

		LoadSpriteAsync("shipYardIcon/" .. arg_3_0.shipGroup:getPainting(arg_3_0.showTrans), function(arg_4_0)
			if arg_3_0.go then
				arg_3_0.iconShip.sprite = arg_4_0
			end

			return
		end)

		arg_3_0.iconType.sprite = GetSpriteFromAtlas("shiptype", shipType2print(arg_3_0.shipGroup:getShipType(arg_3_0.showTrans)))

		setScrollText(arg_3_0.labelName, arg_3_0.shipGroup:getName(arg_3_0.showTrans))

		arg_3_0.labelHeart.text = arg_3_0.shipGroup.hearts > 999 and "999" or tostring(arg_3_0.shipGroup.hearts)

		setActive(arg_3_0.labelHeartPlus, arg_3_0.shipGroup.hearts > 999)

		local var_3_1 = arg_3_0.labelHeart

		var_3_1.color = arg_3_0.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

		local var_3_2 = arg_3_0.labelHeartIcon

		var_3_2.color = arg_3_0.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

		local var_3_3 = arg_3_0.labelHeartPlus

		var_3_3.color = arg_3_0.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

		setShipCardFrame(arg_3_0.shipFrameImg, var_3_0)
	end

	arg_3_0.content:SetActive(tobool(arg_3_0.shipGroup))
	arg_3_0.imageUnknown.gameObject:SetActive(not arg_3_0.shipGroup)

	local var_3_4 = arg_3_0.btn

	if arg_3_0.shipGroup then
		var_3_4.targetGraphic = arg_3_0.imageFrame or arg_3_0.imageUnknown

		setActive(arg_3_0.ringTF, arg_3_0.propose)

		return
	end
end

function var_0_0.clear(arg_5_0)
	ClearTweenItemAlphaAndWhite(arg_5_0.go)

	arg_5_0.shipGroup = nil
	arg_5_0.showTrans = nil
	arg_5_0.propose = nil
	arg_5_0.code = nil

	return
end

return var_0_0
