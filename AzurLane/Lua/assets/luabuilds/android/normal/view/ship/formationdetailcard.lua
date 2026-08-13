class = var_0_10000

local var_0_0 = var_0_10000("FormationDetailCard")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform

	local var_1_0 = arg_1_0.tr

	arg_1_0.lockTF = var_2.Find(var_1_0, "lock")

	local var_1_1 = arg_1_0.tr

	arg_1_0.addTF = var_2.Find(var_1_1, "add")

	local var_1_2 = arg_1_0.tr

	arg_1_0.content = var_2.Find(var_1_2, "content")

	local var_1_3 = arg_1_0.content
	local var_1_4 = var_2.Find(var_1_3, "bg")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.bgImage = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_0.content

	arg_1_0.paintingTr = var_2.Find(var_1_6, "ship_icon/painting")
	arg_1_0.paintingDefaultAngle = arg_1_0.paintingTr.localEulerAngles

	local var_1_7 = arg_1_0.content

	arg_1_0.detailTF = var_2.Find(var_1_7, "detail")

	local var_1_8 = arg_1_0.detailTF

	arg_1_0.lvTxtTF = var_2.Find(var_1_8, "top/level")

	local var_1_9 = arg_1_0.lvTxtTF
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.lvTxt = var_1_10(var_1_9, var_4(var_1_10005))

	local var_1_11 = arg_1_0.detailTF

	arg_1_0.shipType = var_2.Find(var_1_11, "top/type")

	local var_1_12 = arg_1_0.detailTF

	arg_1_0.propsTr = var_2.Find(var_1_12, "info")

	local var_1_13 = arg_1_0.detailTF

	arg_1_0.propsTr1 = var_2.Find(var_1_13, "info1")

	local var_1_14 = arg_1_0.detailTF

	arg_1_0.nameTxt = var_2.Find(var_1_14, "name_mask/name")

	local var_1_15 = arg_1_0.content

	arg_1_0.frame = var_2.Find(var_1_15, "front/frame")
	UIItemList = var_2

	local var_1_16 = var_2.New
	local var_1_17 = arg_1_0.content
	local var_1_18 = var_3.Find(var_1_17, "front/stars")
	local var_1_19 = arg_1_0.content

	arg_1_0.UIlist = var_1_16(var_1_18, var_4.Find(var_1_19, "front/stars/star_tpl"))

	local var_1_20 = arg_1_0.content

	arg_1_0.shipState = var_2.Find(var_1_20, "front/flag")

	local var_1_21 = arg_1_0.content

	arg_1_0.proposeMark = var_2.Find(var_1_21, "front/propose")

	local var_1_22 = arg_1_0.content

	arg_1_0.otherBg = var_2.Find(var_1_22, "front/bg_other")
	setActive = var_2

	var_2(arg_1_0.propsTr1, false)

	setActive = var_2

	var_2(arg_1_0.shipState, false)

	setText = var_2

	local var_1_23 = arg_1_0.tr
	local var_1_24 = var_3.Find(var_1_23, "add/Text")

	i18n = var_1_23

	var_2(var_1_24, var_1_23("rect_ship_card_tpl_add"))

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.shipVO = arg_2_1
	arg_2_0.isLocked = arg_2_2

	arg_2_0:flush()

	return
end

function var_0_0.getState(arg_3_0)
	if arg_3_0.isLocked then
		return var_0_1
	elseif arg_3_0.shipVO then
		return var_0_3
	elseif not arg_3_0.isLocked and not arg_3_0.shipVO then
		return var_0_2
	end

	return
end

function var_0_0.flush(arg_4_0)
	local var_4_0 = arg_4_0:getState()

	if arg_4_0.otherBg then
		eachChild = var_2

		var_2(arg_4_0.otherBg, function(arg_5_0)
			setActive = var_2_10001

			var_2_10001(arg_5_0, false)

			return
		end)
	end

	local var_4_1

	if var_4_0 == var_0_1 then
		-- block empty
	elseif var_4_0 == var_0_3 then
		var_4_1 = arg_4_0.shipVO
		arg_4_0.lvTxt.text = "Lv." .. var_4_1.level

		local var_4_2 = var_4_1:getMaxStar()
		local var_4_3 = var_4_1:getStar()
		local var_4_4 = arg_4_0.UIlist

		var_5.make(var_4_4, function(arg_6_0, arg_6_1, arg_6_2)
			UIItemList = var_2_10003

			if arg_6_0 == var_2_10003.EventUpdate then
				setActive = var_3

				var_3(arg_6_2:Find("star"), arg_6_1 < var_4_3)
			end

			return
		end)

		local var_4_5 = arg_4_0.UIlist

		var_5.align(var_4_5, var_4_2)

		setScrollText = var_5

		var_5(arg_4_0.nameTxt, var_4_1:GetColorName())
		arg_4_0:updateProps({})

		setPaintingPrefabAsync = var_5

		var_5(arg_4_0.paintingTr, var_4_1:getPainting(), "biandui", nil, {
			skinID = var_4_1:getSkinId(),
			rotateZ = arg_4_0.paintingDefaultAngle.z
		})

		local var_4_6 = arg_4_0.shipVO
		local var_4_7 = var_5.rarity2bgPrint(var_4_6)

		GetImageSpriteFromAtlasAsync = var_4_6

		var_4_6("bg/star_level_card_" .. var_4_7, "", arg_4_0.bgImage)

		local var_4_8, var_4_9 = var_4_1:GetFrameAndEffect(true)

		setRectShipCardFrame = var_8

		var_8(arg_4_0.frame, var_4_7, var_4_8)

		setFrameEffect = var_8

		var_8(arg_4_0.otherBg, var_4_9)

		setProposeMarkIcon = var_8

		var_8(arg_4_0.proposeMark, var_4_1)

		local var_4_10 = arg_4_0.shipVO
		local var_4_11 = var_8.getShipType(var_4_10)

		setImageSprite = var_4_10

		local var_4_12 = arg_4_0.shipType

		GetSpriteFromAtlas = var_11

		local var_4_13 = "shiptype"

		shipType2print = var_1_10013

		var_4_10(var_4_12, var_11(var_4_13, var_1_10013(var_4_11)))
	elseif var_4_0 == var_0_2 then
		-- block empty
	end

	setActive = var_4_1

	var_4_1(arg_4_0.lockTF, var_4_0 == var_0_1)

	setActive = var_4_1

	var_4_1(arg_4_0.addTF, var_4_0 == var_0_2)

	setActive = var_4_1

	var_4_1(arg_4_0.content, var_4_0 == var_0_3)

	return
end

function var_0_0.updateProps(arg_7_0, arg_7_1)
	for iter_7_0 = 0, 2 do
		local var_7_0 = arg_7_0.propsTr
		local var_7_1 = var_6.GetChild(var_7_0, iter_7_0)

		if iter_7_0 < #arg_7_1 then
			local var_7_2 = var_7_1.gameObject

			var_7.SetActive(var_7_2, true)

			local var_7_3 = var_7_1:GetChild(0)

			var_7.GetComponent(var_7_3, "Text").text = arg_7_1[iter_7_0 + 1][1]

			local var_7_4 = var_7_1:GetChild(1)

			var_7.GetComponent(var_7_4, "Text").text = arg_7_1[iter_7_0 + 1][2]
		else
			local var_7_5 = var_7_1.gameObject

			var_7.SetActive(var_7_5, false)
		end
	end

	return
end

function var_0_0.clear(arg_8_0)
	if arg_8_0.shipVO then
		retPaintingPrefab = var_1_10002

		var_1_10002(arg_8_0.paintingTr, var_1:getPainting())
	end

	return
end

return var_0_0
