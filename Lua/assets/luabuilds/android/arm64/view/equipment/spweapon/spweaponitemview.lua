local var_0_0 = class("SpWeaponItemView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.bg = findTF(arg_1_1, "frame/bg")
	arg_1_0.mask = findTF(arg_1_1, "frame/bg/mask")
	arg_1_0.nameTF = findTF(arg_1_1, "frame/bg/name"):GetComponent(typeof(Text))
	arg_1_0.newTF = findTF(arg_1_1, "frame/bg/icon_bg/new")
	arg_1_0.unloadBtn = findTF(arg_1_1, "frame/unload")
	arg_1_0.reduceBtn = findTF(arg_1_1, "frame/bg/selected/reduce")
	arg_1_0.selectCount = findTF(arg_1_1, "frame/bg/selected/reduce/Text")
	arg_1_0.specialFrame = findTF(arg_1_1, "frame/bg/icon_bg/frame/specialFrame")
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.equiped = findTF(arg_1_0.tr, "frame/bg/equip_flag")

	setActive(arg_1_0.equiped, false)
	ClearTweenItemAlphaAndWhite(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	setActive(arg_2_0.equiped, false)
	setActive(arg_2_0.unloadBtn, not arg_2_1)
	setActive(arg_2_0.bg, tobool(arg_2_1))
	TweenItemAlphaAndWhite(arg_2_0.go)

	if not arg_2_1 then
		return
	end

	arg_2_0.spWeaponVO = arg_2_1

	updateSpWeapon(arg_2_0.bg, arg_2_1)

	if not IsNil(arg_2_0.mask) then
		setActive(arg_2_0.mask, false)
	end

	setActive(arg_2_0.newTF, false)
	setActive(arg_2_0.nameTF, not arg_2_2)

	arg_2_0.nameTF.text = shortenString(arg_2_0.spWeaponVO:GetName(), 5)

	local var_2_0 = arg_2_0.spWeaponVO:GetShipId()

	setActive(arg_2_0.equiped, tobool(var_2_0))

	if var_2_0 and var_2_0 > 0 then
		setImageSprite(findTF(arg_2_0.equiped, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_2_0):getPainting()))
	end

	setActive(arg_2_0.specialFrame, not arg_2_1:IsReal())
	GetImageSpriteFromAtlasAsync("weaponframes", arg_2_1.owned and "frame_design_owned" or "frame_design", arg_2_0.specialFrame)

	return
end

function var_0_0.clear(arg_3_0)
	ClearTweenItemAlphaAndWhite(arg_3_0.go)

	return
end

return var_0_0
