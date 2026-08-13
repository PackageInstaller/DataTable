class = var_0_10000

local var_0_0 = var_0_10000("LoveLetterShipCard")

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
	findTF = var_3

	var_2(var_3(arg_1_0.content, "dockyard"), false)

	findTF = var_2
	arg_1_0.shipFrameImg = var_2(arg_1_0.content, "front/frame")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0.content, "ship_icon")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.iconShip = var_1_1(var_1_0, var_4(var_5))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0.content, "bg")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.imageBg = var_1_3(var_1_2, var_4(var_5))
	findTF = var_2
	arg_1_0.labelName = var_2(arg_1_0.content, "info/name_mask/name")
	findTF = var_2

	local var_1_4 = var_2(arg_1_0.content, "info/top/type")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.iconType = var_1_5(var_1_4, var_4(var_5))
	findTF = var_2
	arg_1_0.ringTF = var_2(arg_1_0.content, "front/ring")
	findTF = var_2
	arg_1_0.maskTF = var_2(arg_1_0.content, "collection/mask")
	findTF = var_2

	local var_1_6 = var_2(arg_1_0.tr, "unknown")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_1_0.imageUnknown = var_1_7(var_1_6, var_4(var_5))
	ClearTweenItemAlphaAndWhite = var_2

	var_2(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	TweenItemAlphaAndWhite = var_1_10005

	var_1_10005(arg_2_0.go)

	ShipGroup = var_1_10005

	local var_2_0 = var_1_10005.getState(arg_2_4, arg_2_1, arg_2_2)

	if arg_2_0.shipGroup ~= arg_2_1 or arg_2_0.showTrans ~= arg_2_2 or arg_2_0.propose ~= arg_2_3 or arg_2_0.state ~= var_2_0 then
		arg_2_0.shipGroup = arg_2_1
		arg_2_0.showTrans = arg_2_2
		arg_2_0.propose = arg_2_3
		arg_2_0.state = var_2_0

		arg_2_0:flush()
	end

	return
end

function var_0_0.flush(arg_3_0)
	if arg_3_0.shipGroup then
		local var_3_0 = var_1:rarity2bgPrint(arg_3_0.showTrans)

		var_1_10004 = var_1

		local var_3_1 = var_1.getPainting(var_1_10004, arg_3_0.showTrans)

		GetImageSpriteFromAtlasAsync = var_1_10004

		var_1_10004("bg/star_level_card_" .. var_3_0, "", arg_3_0.imageBg)

		var_1_10004 = arg_3_0.iconShip
		GetSpriteFromAtlas = var_5
		var_1_10004.sprite = var_5("shipYardIcon/unknown", "")
		LoadSpriteAsync = var_1_10004

		var_1_10004("shipYardIcon/" .. var_3_1, function(arg_4_0)
			if arg_3_0.iconShip then
				arg_3_0.iconShip.sprite = arg_4_0
			end

			return
		end)

		var_1_10004 = arg_3_0.iconType
		GetSpriteFromAtlas = var_5

		local var_3_2 = "shiptype"

		shipType2print = var_7
		var_1_10004.sprite = var_5(var_3_2, var_7(var_1:getShipType(arg_3_0.showTrans)))
		setScrollText = var_1_10004

		var_1_10004(arg_3_0.labelName, var_1:getName(arg_3_0.showTrans))

		setShipCardFrame = var_1_10004

		var_1_10004(arg_3_0.shipFrameImg, var_3_0)

		local var_3_3 = arg_3_0.content.transform

		var_1_10004 = var_1_10004.Find(var_3_3, "love_letter")
		getProxy = var_3_3
		LoveLetterProxy = var_6

		local var_3_4 = var_3_3(var_6)
		local var_3_5 = var_5.GetGroupData(var_3_4, var_1.id)

		setActive = var_3_4

		var_3_4(var_1_10004, var_3_5.exp > 0)

		if var_3_5.exp > 0 then
			local var_3_6, var_3_7 = var_3_5:GetDisplayExp()

			if var_3_7 == 0 then
				setSlider = var_8

				var_8(var_1_10004, 0, 1, 1)
			else
				setSlider = var_8

				var_8(var_1_10004, 0, var_3_7, var_3_6)
			end

			setText = var_8

			var_8(var_1_10004:Find("mark/Text"), var_3_5:GetDisplayLevelMark())

			local var_3_8 = var_3_5
			local var_3_9 = var_3_5.GetDisplayRank(var_3_8)

			eachChild = var_3_8

			var_3_8(var_1_10004:Find("mark/bg"), function(arg_5_0, arg_5_1)
				setActive = var_2_10002

				var_2_10002(arg_5_0, arg_5_1 == var_3_9)

				return
			end)
		end
	end

	local var_3_10 = arg_3_0.content
	local var_3_11 = var_2.SetActive

	tobool = var_1_10004

	var_3_11(var_3_10, var_1_10004(var_1))

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

function var_0_0.clear(arg_6_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_6_0.go)

	arg_6_0.shipGroup = nil
	arg_6_0.showTrans = nil
	arg_6_0.propose = nil

	return
end

return var_0_0
