class = var_0_10000

local var_0_0 = var_0_10000("EquipmentItem")
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

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTF = var_1_1(var_1_0, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.newTF = var_2(arg_1_1, "frame/bg/icon_bg/new")
	findTF = var_2
	arg_1_0.unloadBtn = var_2(arg_1_1, "frame/unload")
	findTF = var_2
	arg_1_0.reduceBtn = var_2(arg_1_1, "frame/bg/selected/reduce")
	findTF = var_2
	arg_1_0.selectCount = var_2(arg_1_1, "frame/bg/selected/reduce/Text")
	arg_1_0.tr = arg_1_1.transform
	findTF = var_2
	arg_1_0.selectedGo = var_2(arg_1_0.tr, "frame/bg/selected").gameObject

	local var_1_2 = arg_1_0.selectedGo

	var_2.SetActive(var_1_2, false)

	findTF = var_2
	arg_1_0.equiped = var_2(arg_1_0.tr, "frame/bg/equip_flag")
	setActive = var_2

	var_2(arg_1_0.equiped, false)

	findTF = var_2
	arg_1_0.selectedMask = var_2(arg_1_0.tr, "frame/bg/selected_transform")

	if arg_1_0.selectedMask then
		setActive = var_2

		var_2(arg_1_0.selectedMask, false)
	end

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

	var_1_10003(arg_2_0.bg, arg_2_1)

	TweenItemAlphaAndWhite = var_1_10003

	var_1_10003(arg_2_0.go)

	if not arg_2_1 then
		return
	end

	arg_2_0.equipmentVO = arg_2_1
	isa = var_1_10003

	local var_2_0 = arg_2_1

	SpWeapon = var_6

	if var_1_10003(var_2_0, var_6) then
		arg_2_0:updateSpWeapon()
	elseif arg_2_1.isSkin then
		arg_2_0:updateSkin()
	else
		updateEquipment = var_3

		var_3(arg_2_0.bg, arg_2_1)

		IsNil = var_3

		if not var_3(arg_2_0.mask) then
			setActive = var_3

			var_3(arg_2_0.mask, arg_2_1.mask)
		end

		setActive = var_3

		var_3(arg_2_0.newTF, arg_2_1.new ~= 0 or arg_2_1.isSkin)

		setActive = var_3

		var_3(arg_2_0.nameTF, not arg_2_2)

		local var_2_1 = arg_2_0.nameTF

		shortenString = var_1_10004

		local var_2_2 = arg_2_0.equipmentVO

		var_2_1.text = var_1_10004(var_6.getConfig(var_2_2, "name"), 5)
		setActive = var_2_1

		var_2_1(arg_2_0.equiped, arg_2_1.shipId)

		if arg_2_1.shipId then
			getProxy = var_3
			BayProxy = var_5

			local var_2_3 = var_3(var_5)
			local var_2_4 = var_3.getShipById(var_2_3, arg_2_1.shipId)

			setImageSprite = var_4
			findTF = var_6

			local var_2_5 = var_6(arg_2_0.equiped, "Image")

			LoadSprite = var_7

			var_4(var_2_5, var_7("qicon/" .. var_2_4:getPainting()))
		end
	end

	return
end

function var_0_0.updateSkin(arg_3_0)
	local var_3_0 = arg_3_0.equipmentVO

	setActive = var_1_10002

	var_1_10002(arg_3_0.equiped, var_3_0.shipId)

	local var_3_2

	if var_3_0.shipId then
		getProxy = var_3_2
		BayProxy = var_4

		local var_3_1 = var_3_2(var_4)

		var_3_2 = var_3_2.getShipById(var_3_1, var_3_0.shipId)
		setImageSprite = var_1_10003
		findTF = var_5

		local var_3_3 = var_5(arg_3_0.equiped, "Image")

		LoadSprite = var_1_10006

		var_1_10003(var_3_3, var_1_10006("qicon/" .. var_3_2:getPainting()))
	end

	updateDrop = var_3_2

	local var_3_4 = arg_3_0.bg
	local var_3_5 = {
		id = var_3_0.id
	}

	DROP_TYPE_EQUIPMENT_SKIN = var_6
	var_3_5.type = var_6
	var_3_5.count = var_3_0.count

	var_3_2(var_3_4, var_3_5)

	local var_3_6 = arg_3_0.nameTF

	shortenString = var_1_10003
	getText = var_3_5
	var_3_6.text = var_1_10003(var_3_5(arg_3_0.nameTF), 5)

	return
end

function var_0_0.updateSpWeapon(arg_4_0)
	local var_4_0 = arg_4_0.equipmentVO

	updateSpWeapon = var_1_10002

	var_1_10002(arg_4_0.bg, var_4_0)

	setActive = var_1_10002

	var_1_10002(arg_4_0.newTF, false)

	setActive = var_1_10002

	var_1_10002(arg_4_0.nameTF, true)

	local var_4_1 = arg_4_0.nameTF

	shortenString = var_1_10003

	local var_4_2 = var_4_0

	var_4_1.text = var_1_10003(var_4_0.GetName(var_4_2), 5)

	local var_4_3 = var_4_0
	local var_4_4 = var_4_0.GetShipId(var_4_3)

	setActive = var_3

	var_3(arg_4_0.equiped, var_4_4)

	if var_4_4 then
		getProxy = var_3
		BayProxy = var_5

		local var_4_5 = var_3(var_5)
		local var_4_6 = var_3.getShipById(var_4_5, var_4_4)

		setImageSprite = var_4_3
		findTF = var_6

		local var_4_7 = var_6(arg_4_0.equiped, "Image")

		LoadSprite = var_4_2

		var_4_3(var_4_7, var_4_2("qicon/" .. var_4_6:getPainting()))
	end

	return
end

function var_0_0.clear(arg_5_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_5_0.go)

	return
end

function var_0_0.dispose(arg_6_0)
	return
end

function var_0_0.updateSelected(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.selected = arg_7_1

	local var_7_0 = arg_7_0.selected
	local var_7_1 = arg_7_0.selectedGo

	var_5.SetActive(var_7_1, var_7_0)

	if var_7_0 then
		setText = var_5

		var_5(arg_7_0.selectCount, arg_7_2)

		if not arg_7_0.selectedTwId then
			LeanTween = var_5

			local var_7_2 = var_5.alpha(arg_7_0.selectedGo.transform, 1, var_0_1)
			local var_7_3 = var_5.setFrom(var_7_2, 0)
			local var_7_4 = var_5.setEase

			LeanTweenType = var_8

			local var_7_5 = var_7_4(var_7_3, var_8.easeInOutSine)

			arg_7_0.selectedTwId = var_5.setLoopPingPong(var_7_5).uniqueId
		end
	elseif arg_7_0.selectedTwId then
		LeanTween = var_5

		var_5.cancel(arg_7_0.selectedTwId)

		arg_7_0.selectedTwId = nil
	end

	return
end

return var_0_0
