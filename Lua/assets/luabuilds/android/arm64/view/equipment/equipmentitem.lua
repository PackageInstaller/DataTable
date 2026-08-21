local var_0_0 = class("EquipmentItem")
local var_0_1 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.bg = findTF(arg_1_1, "frame/bg")
	arg_1_0.mask = findTF(arg_1_1, "frame/bg/mask")
	arg_1_0.nameTF = findTF(arg_1_1, "frame/bg/name"):GetComponent(typeof(Text))
	arg_1_0.newTF = findTF(arg_1_1, "frame/bg/icon_bg/new")
	arg_1_0.unloadBtn = findTF(arg_1_1, "frame/unload")
	arg_1_0.reduceBtn = findTF(arg_1_1, "frame/bg/selected/reduce")
	arg_1_0.selectCount = findTF(arg_1_1, "frame/bg/selected/reduce/Text")
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.selectedGo = findTF(arg_1_0.tr, "frame/bg/selected").gameObject

	arg_1_0.selectedGo:SetActive(false)

	arg_1_0.equiped = findTF(arg_1_0.tr, "frame/bg/equip_flag")

	setActive(arg_1_0.equiped, false)

	arg_1_0.selectedMask = findTF(arg_1_0.tr, "frame/bg/selected_transform")

	if arg_1_0.selectedMask then
		setActive(arg_1_0.selectedMask, false)
	end

	ClearTweenItemAlphaAndWhite(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	setActive(arg_2_0.equiped, false)
	setActive(arg_2_0.unloadBtn, not arg_2_1)
	setActive(arg_2_0.bg, arg_2_1)
	TweenItemAlphaAndWhite(arg_2_0.go)

	if not arg_2_1 then
		return
	end

	arg_2_0.equipmentVO = arg_2_1

	if isa(arg_2_1, SpWeapon) then
		arg_2_0:updateSpWeapon()
	elseif arg_2_1.isSkin then
		arg_2_0:updateSkin()
	else
		updateEquipment(arg_2_0.bg, arg_2_1)

		if not IsNil(arg_2_0.mask) then
			setActive(arg_2_0.mask, arg_2_1.mask)
		end

		setActive(arg_2_0.newTF, arg_2_1.new ~= 0 or arg_2_1.isSkin)
		setActive(arg_2_0.nameTF, not arg_2_2)

		arg_2_0.nameTF.text = shortenString(arg_2_0.equipmentVO:getConfig("name"), 5)

		setActive(arg_2_0.equiped, arg_2_1.shipId)

		if arg_2_1.shipId then
			setImageSprite(findTF(arg_2_0.equiped, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(arg_2_1.shipId):getPainting()))
		end
	end

	return
end

function var_0_0.updateSkin(arg_3_0)
	setActive(arg_3_0.equiped, arg_3_0.equipmentVO.shipId)

	if arg_3_0.equipmentVO.shipId then
		setImageSprite(findTF(arg_3_0.equiped, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(arg_3_0.equipmentVO.shipId):getPainting()))
	end

	updateDrop(arg_3_0.bg, {
		id = arg_3_0.equipmentVO.id,
		type = DROP_TYPE_EQUIPMENT_SKIN,
		count = arg_3_0.equipmentVO.count
	})

	arg_3_0.nameTF.text = shortenString(getText(arg_3_0.nameTF), 5)

	return
end

function var_0_0.updateSpWeapon(arg_4_0)
	updateSpWeapon(arg_4_0.bg, arg_4_0.equipmentVO)
	setActive(arg_4_0.newTF, false)
	setActive(arg_4_0.nameTF, true)

	arg_4_0.nameTF.text = shortenString(arg_4_0.equipmentVO:GetName(), 5)

	local var_4_0 = arg_4_0.equipmentVO:GetShipId()

	setActive(arg_4_0.equiped, var_4_0)

	if var_4_0 then
		setImageSprite(findTF(arg_4_0.equiped, "Image"), LoadSprite("qicon/" .. getProxy(BayProxy):getShipById(var_4_0):getPainting()))
	end

	return
end

function var_0_0.clear(arg_5_0)
	ClearTweenItemAlphaAndWhite(arg_5_0.go)

	return
end

function var_0_0.dispose(arg_6_0)
	return
end

function var_0_0.updateSelected(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.selected = arg_7_1

	arg_7_0.selectedGo:SetActive(arg_7_0.selected)

	if arg_7_0.selected then
		setText(arg_7_0.selectCount, arg_7_2)

		arg_7_0.selectedTwId = arg_7_0.selectedTwId or LeanTween.alpha(arg_7_0.selectedGo.transform, 1, var_0_1):setFrom(0):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
	elseif arg_7_0.selectedTwId then
		LeanTween.cancel(arg_7_0.selectedTwId)

		arg_7_0.selectedTwId = nil
	end

	return
end

return var_0_0
