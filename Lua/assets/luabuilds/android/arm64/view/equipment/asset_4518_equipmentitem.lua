local EquipmentItem = class("EquipmentItem")
local var_0_1 = 0.5

function EquipmentItem:Ctor(arg_1_1)
	self.go = arg_1_1
	self.bg = findTF(arg_1_1, "frame/bg")
	self.mask = findTF(arg_1_1, "frame/bg/mask")
	self.nameTF = findTF(arg_1_1, "frame/bg/name"):GetComponent(typeof(Text))
	self.newTF = findTF(arg_1_1, "frame/bg/icon_bg/new")
	self.unloadBtn = findTF(arg_1_1, "frame/unload")
	self.reduceBtn = findTF(arg_1_1, "frame/bg/selected/reduce")
	self.selectCount = findTF(arg_1_1, "frame/bg/selected/reduce/Text")
	self.tr = arg_1_1.transform
	self.selectedGo = findTF(self.tr, "frame/bg/selected").gameObject

	self.selectedGo:SetActive(false)

	self.equiped = findTF(self.tr, "frame/bg/equip_flag")

	setActive(self.equiped, false)

	self.selectedMask = findTF(self.tr, "frame/bg/selected_transform")

	if self.selectedMask then
		setActive(self.selectedMask, false)
	end

	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function EquipmentItem:update(arg_2_1, arg_2_2)
	setActive(self.equiped, false)
	setActive(self.unloadBtn, not arg_2_1)
	setActive(self.bg, arg_2_1)
	TweenItemAlphaAndWhite(self.go)

	if not arg_2_1 then
		return
	end

	self.equipmentVO = arg_2_1

	if isa(arg_2_1, SpWeapon) then
		self:updateSpWeapon()
	elseif arg_2_1.isSkin then
		self:updateSkin()
	else
		updateEquipment(self.bg, arg_2_1)

		if not IsNil(self.mask) then
			setActive(self.mask, arg_2_1.mask)
		end

		setActive(self.newTF, arg_2_1.new ~= 0 or arg_2_1.isSkin)
		setActive(self.nameTF, not arg_2_2)

		self.nameTF.text = shortenString(self.equipmentVO:getConfig("name"), 5)

		setActive(self.equiped, arg_2_1.shipId)

		if arg_2_1.shipId then
			setImageSprite(findTF(self.equiped, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(arg_2_1.shipId):getPainting()))
		end
	end

	return
end

function EquipmentItem:updateSkin()
	setActive(self.equiped, self.equipmentVO.shipId)

	if self.equipmentVO.shipId then
		setImageSprite(findTF(self.equiped, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(self.equipmentVO.shipId):getPainting()))
	end

	updateDrop(self.bg, {
		id = self.equipmentVO.id,
		type = DROP_TYPE_EQUIPMENT_SKIN,
		count = self.equipmentVO.count
	})

	self.nameTF.text = shortenString(getText(self.nameTF), 5)

	return
end

function EquipmentItem:updateSpWeapon()
	updateSpWeapon(self.bg, self.equipmentVO)
	setActive(self.newTF, false)
	setActive(self.nameTF, true)

	self.nameTF.text = shortenString(self.equipmentVO:GetName(), 5)

	local var_4_0 = self.equipmentVO:GetShipId()

	setActive(self.equiped, var_4_0)

	if var_4_0 then
		setImageSprite(findTF(self.equiped, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_4_0):getPainting()))
	end

	return
end

function EquipmentItem:clear()
	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function EquipmentItem:dispose()
	return
end

function EquipmentItem:updateSelected(arg_7_1, arg_7_2, arg_7_3)
	self.selected = arg_7_1

	self.selectedGo:SetActive(self.selected)

	if self.selected then
		setText(self.selectCount, arg_7_2)

		self.selectedTwId = self.selectedTwId or LeanTween.alpha(self.selectedGo.transform, 1, var_0_1):setFrom(0):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
	elseif self.selectedTwId then
		LeanTween.cancel(self.selectedTwId)

		self.selectedTwId = nil
	end

	return
end

return EquipmentItem
