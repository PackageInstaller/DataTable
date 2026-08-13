class = var_0_10000

local var_0_0 = var_0_10000("SpWeaponItemView")
local var_0_1 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	findTF = var_1_10002
	arg_1_0.bg = var_1_10002(arg_1_1, "frame/bg")
	findTF = var_2
	arg_1_0.mask = var_2(arg_1_1, "frame/bg/mask")
	findTF = var_2

	local var_1_0 = var_2(arg_1_1, "frame/bg/name")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTF = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.newTF = var_2(arg_1_1, "frame/bg/icon_bg/new")
	findTF = var_2
	arg_1_0.unloadBtn = var_2(arg_1_1, "frame/unload")
	findTF = var_2
	arg_1_0.reduceBtn = var_2(arg_1_1, "frame/bg/selected/reduce")
	findTF = var_2
	arg_1_0.selectCount = var_2(arg_1_1, "frame/bg/selected/reduce/Text")
	findTF = var_2
	arg_1_0.specialFrame = var_2(arg_1_1, "frame/bg/icon_bg/frame/specialFrame")
	arg_1_0.tr = arg_1_1.transform
	findTF = var_2
	arg_1_0.equiped = var_2(arg_1_0.tr, "frame/bg/equip_flag")
	setActive = var_2

	var_2(arg_1_0.equiped, false)

	ClearTweenItemAlphaAndWhite = var_2

	var_2(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	setActive = var_1_10003

	var_1_10003(arg_2_0.equiped, false)

	setActive = var_1_10003

	var_1_10003(arg_2_0.unloadBtn, not arg_2_1)

	setActive = var_1_10003

	local var_2_0 = arg_2_0.bg

	tobool = var_5

	var_1_10003(var_2_0, var_5(arg_2_1))

	TweenItemAlphaAndWhite = var_1_10003

	var_1_10003(arg_2_0.go)

	if not arg_2_1 then
		return
	end

	arg_2_0.spWeaponVO = arg_2_1
	updateSpWeapon = var_1_10003

	var_1_10003(arg_2_0.bg, arg_2_1)

	IsNil = var_1_10003

	if not var_1_10003(arg_2_0.mask) then
		setActive = var_3

		var_3(arg_2_0.mask, false)
	end

	setActive = var_3

	var_3(arg_2_0.newTF, false)

	setActive = var_3

	var_3(arg_2_0.nameTF, not arg_2_2)

	local var_2_1 = arg_2_0.nameTF

	shortenString = var_4

	local var_2_2 = arg_2_0.spWeaponVO

	var_2_1.text = var_4(var_5.GetName(var_2_2), 5)

	local var_2_3 = arg_2_0.spWeaponVO
	local var_2_4 = var_3.GetShipId(var_2_3)

	setActive = var_2_3

	local var_2_5 = arg_2_0.equiped

	tobool = var_6

	var_2_3(var_2_5, var_6(var_2_4))

	if var_2_4 and 0 < var_2_4 then
		getProxy = var_2_3
		BayProxy = var_2_5

		local var_2_6 = var_2_3(var_2_5)

		var_2_3 = var_2_3.getShipById(var_2_6, var_2_4)
		setImageSprite = var_2_6
		findTF = var_6

		local var_2_7 = var_6(arg_2_0.equiped, "Image")

		LoadSprite = var_7

		var_2_6(var_2_7, var_7("qicon/" .. var_2_3:getPainting()))
	end

	setActive = var_2_3

	var_2_3(arg_2_0.specialFrame, not arg_2_1:IsReal())

	local var_2_8 = arg_2_1.owned and "frame_design_owned" or "frame_design"

	GetImageSpriteFromAtlasAsync = var_6

	var_6("weaponframes", var_2_8, arg_2_0.specialFrame)

	return
end

function var_0_0.clear(arg_3_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_3_0.go)

	return
end

return var_0_0
