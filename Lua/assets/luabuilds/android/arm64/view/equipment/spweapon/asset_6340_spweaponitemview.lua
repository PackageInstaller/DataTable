local SpWeaponItemView = class("SpWeaponItemView")

function SpWeaponItemView:Ctor(arg_1_1)
	self.go = arg_1_1
	self.bg = findTF(arg_1_1, "frame/bg")
	self.mask = findTF(arg_1_1, "frame/bg/mask")
	self.nameTF = findTF(arg_1_1, "frame/bg/name"):GetComponent(typeof(Text))
	self.newTF = findTF(arg_1_1, "frame/bg/icon_bg/new")
	self.unloadBtn = findTF(arg_1_1, "frame/unload")
	self.reduceBtn = findTF(arg_1_1, "frame/bg/selected/reduce")
	self.selectCount = findTF(arg_1_1, "frame/bg/selected/reduce/Text")
	self.specialFrame = findTF(arg_1_1, "frame/bg/icon_bg/frame/specialFrame")
	self.tr = arg_1_1.transform
	self.equiped = findTF(self.tr, "frame/bg/equip_flag")

	setActive(self.equiped, false)
	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function SpWeaponItemView:update(arg_2_1, arg_2_2)
	setActive(self.equiped, false)
	setActive(self.unloadBtn, not arg_2_1)
	setActive(self.bg, tobool(arg_2_1))
	TweenItemAlphaAndWhite(self.go)

	if not arg_2_1 then
		return
	end

	self.spWeaponVO = arg_2_1

	updateSpWeapon(self.bg, arg_2_1)

	if not IsNil(self.mask) then
		setActive(self.mask, false)
	end

	setActive(self.newTF, false)
	setActive(self.nameTF, not arg_2_2)

	self.nameTF.text = shortenString(self.spWeaponVO:GetName(), 5)

	local var_2_0 = self.spWeaponVO:GetShipId()

	setActive(self.equiped, tobool(var_2_0))

	if var_2_0 and var_2_0 > 0 then
		setImageSprite(findTF(self.equiped, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_2_0):getPainting()))
	end

	setActive(self.specialFrame, not arg_2_1:IsReal())
	GetImageSpriteFromAtlasAsync("weaponframes", arg_2_1.owned and "frame_design_owned" or "frame_design", self.specialFrame)

	return
end

function SpWeaponItemView:clear()
	ClearTweenItemAlphaAndWhite(self.go)

	return
end

return SpWeaponItemView
