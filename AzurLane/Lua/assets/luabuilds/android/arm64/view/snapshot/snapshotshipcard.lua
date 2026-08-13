class = var_0_10000

local var_0_0 = var_0_10000("SnapshotShipCard")

var_0_0.TypeCard = 1
var_0_0.TypeTrans = 2
pg = var_1

local var_0_1 = var_1.ship_data_group

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	GetOrAddComponent = var_2
	arg_1_0.btn = var_2(arg_1_1, "Button")
	findTF = var_2
	arg_1_0.content = var_2(arg_1_0.tr, "content").gameObject
	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_1_0.content, "dockyard"), false)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_1_0.content, "collection"), true)

	findTF = var_2
	arg_1_0.shipFrameImg = var_2(arg_1_0.content, "front/frame")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0.content, "ship_icon")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Image = var_7
	arg_1_0.iconShip = var_1_1(var_1_0, var_5(var_7))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0.content, "bg")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Image = var_7
	arg_1_0.imageBg = var_1_3(var_1_2, var_5(var_7))
	findTF = var_2
	arg_1_0.labelName = var_2(arg_1_0.content, "info/name_mask/name")
	findTF = var_2

	local var_1_4 = var_2(arg_1_0.content, "info/top/type")
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	Image = var_7
	arg_1_0.iconType = var_1_5(var_1_4, var_5(var_7))
	findTF = var_2
	arg_1_0.ringTF = var_2(arg_1_0.content, "front/ring")
	findTF = var_2
	arg_1_0.maskTF = var_2(arg_1_0.content, "collection/mask")
	findTF = var_2
	arg_1_0.heart = var_2(arg_1_0.content, "collection/heart")
	findTF = var_2

	local var_1_6 = var_2(arg_1_0.heart, "heart")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_1_0.labelHeart = var_1_7(var_1_6, var_5(var_7))
	findTF = var_2

	local var_1_8 = var_2(arg_1_0.heart, "icon")
	local var_1_9 = var_2.GetComponent

	typeof = var_5
	Image = var_7
	arg_1_0.labelHeartIcon = var_1_9(var_1_8, var_5(var_7))
	findTF = var_2

	local var_1_10 = var_2(arg_1_0.heart, "heart+")
	local var_1_11 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_1_0.labelHeartPlus = var_1_11(var_1_10, var_5(var_7))
	findTF = var_2

	local var_1_12 = var_2(arg_1_0.tr, "unknown")
	local var_1_13 = var_2.GetComponent

	typeof = var_5
	Image = var_7
	arg_1_0.imageUnknown = var_1_13(var_1_12, var_5(var_7))
	ClearTweenItemAlphaAndWhite = var_2

	var_2(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	TweenItemAlphaAndWhite = var_1_10006

	var_1_10006(arg_2_0.go)

	ShipGroup = var_1_10006

	local var_2_0 = var_1_10006.getState(arg_2_5, arg_2_2, arg_2_3)

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
		local var_3_0 = var_1
		local var_3_1 = var_1.rarity2bgPrint(var_3_0, arg_3_0.showTrans)

		var_1_10005 = var_1

		local var_3_2 = var_1.getPainting(var_1_10005, arg_3_0.showTrans)

		GetImageSpriteFromAtlasAsync = var_3_0

		var_3_0("bg/star_level_card_" .. var_3_1, "", arg_3_0.imageBg)

		local var_3_3 = arg_3_0.iconShip

		GetSpriteFromAtlas = var_1_10005
		var_3_3.sprite = var_1_10005("shipYardIcon/unknown", "")
		LoadSpriteAsync = var_3_3

		var_3_3("shipYardIcon/" .. var_3_2, function(arg_4_0)
			if arg_3_0.go then
				arg_3_0.iconShip.sprite = arg_4_0
			end

			return
		end)

		local var_3_4 = arg_3_0.iconType

		GetSpriteFromAtlas = var_1_10005

		local var_3_5 = "shiptype"

		shipType2print = var_8
		var_3_4.sprite = var_1_10005(var_3_5, var_8(var_1:getShipType(arg_3_0.showTrans)))
		setScrollText = var_3_4

		var_3_4(arg_3_0.labelName, var_1:getName(arg_3_0.showTrans))

		local var_3_6 = arg_3_0.labelHeart

		if var_1.hearts > 999 then
			var_1_10005 = "999"
		else
			tostring = var_1_10005
			var_1_10005 = var_1_10005(var_1.hearts)
		end

		var_3_6.text = var_1_10005
		setActive = var_3_6

		var_3_6(arg_3_0.labelHeartPlus, var_1.hearts > 999)

		local var_3_7 = arg_3_0.labelHeart

		if var_1.iheart then
			Color = var_1_10005

			if not var_1_10005.New(1, 0.6, 0.6) then
				Color = var_1_10005
				var_1_10005 = var_1_10005.New(1, 1, 1)
			end

			var_3_7.color = var_1_10005

			local var_3_8 = arg_3_0.labelHeartIcon

			if var_1.iheart then
				Color = var_1_10005

				if not var_1_10005.New(1, 0.6, 0.6) then
					Color = var_1_10005
					var_1_10005 = var_1_10005.New(1, 1, 1)
				end

				var_3_8.color = var_1_10005

				local var_3_9 = arg_3_0.labelHeartPlus

				if var_1.iheart then
					Color = var_1_10005

					if not var_1_10005.New(1, 0.6, 0.6) then
						Color = var_1_10005
						var_1_10005 = var_1_10005.New(1, 1, 1)
					end

					var_3_9.color = var_1_10005
					setShipCardFrame = var_3_9

					var_3_9(arg_3_0.shipFrameImg, var_3_1)

					local var_3_10 = arg_3_0.content
					local var_3_11 = var_2.SetActive

					tobool = var_1_10005

					var_3_11(var_3_10, var_1_10005(var_1))

					local var_3_12 = arg_3_0.imageUnknown.gameObject

					var_2.SetActive(var_3_12, not var_1)

					local var_3_13 = arg_3_0.btn
					local var_3_14

					if not var_1 or not arg_3_0.imageFrame then
						var_3_14 = arg_3_0.imageUnknown
					end

					var_3_13.targetGraphic = var_3_14
					setActive = var_3_13

					var_3_13(arg_3_0.ringTF, arg_3_0.propose)

					return
				end
			end
		end
	end
end

function var_0_0.clear(arg_5_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_5_0.go)

	arg_5_0.shipGroup = nil
	arg_5_0.showTrans = nil
	arg_5_0.propose = nil
	arg_5_0.code = nil

	return
end

return var_0_0
