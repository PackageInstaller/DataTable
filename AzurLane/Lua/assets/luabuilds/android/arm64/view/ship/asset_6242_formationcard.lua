class = var_0_10000

local var_0_0 = var_0_10000("FormationCard")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform

	local var_1_0 = arg_1_0.tr

	arg_1_0.content = var_2.Find(var_1_0, "content")

	local var_1_1 = arg_1_0.content
	local var_1_2 = var_2.Find(var_1_1, "bg")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.bgImage = var_1_3(var_1_2, var_5(var_1_10007))

	local var_1_4 = arg_1_0.content

	arg_1_0.paintingTr = var_2.Find(var_1_4, "ship_icon/painting")
	arg_1_0.paintingDefaultAngle = arg_1_0.paintingTr.localEulerAngles

	local var_1_5 = arg_1_0.content

	arg_1_0.detailTF = var_2.Find(var_1_5, "detail")

	local var_1_6 = arg_1_0.detailTF
	local var_1_7 = var_2.Find(var_1_6, "top/level")
	local var_1_8 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.lvTxt = var_1_8(var_1_7, var_5(var_1_10007))

	local var_1_9 = arg_1_0.detailTF

	arg_1_0.shipType = var_2.Find(var_1_9, "top/type")

	local var_1_10 = arg_1_0.detailTF

	arg_1_0.propsTr = var_2.Find(var_1_10, "info")

	local var_1_11 = arg_1_0.detailTF

	arg_1_0.nameTxt = var_2.Find(var_1_11, "name_mask/name")

	local var_1_12 = arg_1_0.content

	arg_1_0.frame = var_2.Find(var_1_12, "front/frame")
	UIItemList = var_2

	local var_1_13 = var_2.New
	local var_1_14 = arg_1_0.content
	local var_1_15 = var_4.Find(var_1_14, "front/stars")
	local var_1_16 = arg_1_0.content

	arg_1_0.UIlist = var_1_13(var_1_15, var_5.Find(var_1_16, "front/stars/star_tpl"))

	local var_1_17 = arg_1_0.content

	arg_1_0.shipState = var_2.Find(var_1_17, "front/flag")

	local var_1_18 = arg_1_0.content

	arg_1_0.proposeMark = var_2.Find(var_1_18, "front/propose")

	local var_1_19 = arg_1_0.content

	arg_1_0.otherBg = var_2.Find(var_1_19, "front/bg_other")
	setActive = var_2

	var_2(arg_1_0.shipState, false)

	AutoLoader = var_2
	arg_1_0.loader = var_2.New()

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_1 then
		setActive = var_1_10002

		var_1_10002(arg_2_0.content, true)

		arg_2_0.shipVO = arg_2_1

		arg_2_0:flush()
	else
		setActive = var_1_10002

		var_1_10002(arg_2_0.content, false)
	end

	return
end

function var_0_0.flush(arg_3_0)
	local var_3_0 = arg_3_0.shipVO

	arg_3_0.lvTxt.text = "Lv." .. var_3_0.level

	local var_3_1 = var_3_0:getMaxStar()
	local var_3_2 = var_3_0
	local var_3_3 = var_3_0.getStar(var_3_2)
	local var_3_4 = arg_3_0.UIlist

	var_4.make(var_3_4, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_4_2:Find("star"), arg_4_1 < var_3_3)
		end

		return
	end)

	local var_3_5 = arg_3_0.UIlist

	var_4.align(var_3_5, var_3_1)

	setScrollText = var_4

	var_4(arg_3_0.nameTxt, var_3_0:GetColorName())
	arg_3_0:updateProps({})

	setPaintingPrefabAsync = var_4

	var_4(arg_3_0.paintingTr, var_3_0:getPainting(), "biandui", nil, {
		skinID = var_3_0:getSkinId(),
		rotateZ = arg_3_0.paintingDefaultAngle.z
	})

	local var_3_6 = var_3_0:rarity2bgPrint()

	GetImageSpriteFromAtlasAsync = var_3_2

	var_3_2("bg/star_level_card_" .. var_3_6, "", arg_3_0.bgImage)

	local var_3_7 = var_3_0
	local var_3_8, var_3_9 = var_3_0.GetFrameAndEffect(var_3_7, true)

	setRectShipCardFrame = var_3_7

	var_3_7(arg_3_0.frame, var_3_6, var_3_8)

	setFrameEffect = var_3_7

	var_3_7(arg_3_0.otherBg, var_3_9)

	setProposeMarkIcon = var_3_7

	var_3_7(arg_3_0.proposeMark, var_3_0)

	local var_3_10 = arg_3_0.shipVO
	local var_3_11 = var_7.getShipType(var_3_10)

	setImageSprite = var_8

	local var_3_12 = arg_3_0.shipType

	GetSpriteFromAtlas = var_11

	local var_3_13 = "shiptype"

	shipType2print = var_1_10014

	var_8(var_3_12, var_11(var_3_13, var_1_10014(var_3_11)))

	return
end

function var_0_0.updateProps(arg_5_0, arg_5_1)
	for iter_5_0 = 0, 2 do
		local var_5_0 = arg_5_0.propsTr
		local var_5_1 = var_6.GetChild(var_5_0, iter_5_0)

		if iter_5_0 < #arg_5_1 then
			local var_5_2 = var_5_1.gameObject

			var_7.SetActive(var_5_2, true)

			local var_5_3 = var_5_1:GetChild(0)

			var_7.GetComponent(var_5_3, "Text").text = arg_5_1[iter_5_0 + 1][1]

			local var_5_4 = var_5_1:GetChild(1)

			var_7.GetComponent(var_5_4, "Text").text = arg_5_1[iter_5_0 + 1][2]
		else
			local var_5_5 = var_5_1.gameObject

			var_7.SetActive(var_5_5, false)
		end
	end

	return
end

function var_0_0.clear(arg_6_0)
	if arg_6_0.shipVO then
		retPaintingPrefab = var_1_10002

		var_1_10002(arg_6_0.paintingTr, var_1:getPainting())
	end

	local var_6_0 = arg_6_0.loader

	var_2.Clear(var_6_0)

	return
end

return var_0_0
