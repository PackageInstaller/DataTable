local var_0_0 = class("PuzzlaItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.img = arg_1_1:GetComponent(typeof(Image))
	arg_1_0.btn = arg_1_1:AddComponent(typeof(Button))
	arg_1_0._go = arg_1_1
	arg_1_0._tr = rtf(arg_1_0._go)
	arg_1_0._tr.pivot = Vector2(0, 1)
	arg_1_0.width = 0
	arg_1_0.height = 0
	arg_1_0.position = nil
	arg_1_0.index = arg_1_2
	arg_1_0.isWhite = false
	arg_1_0.currIndex = nil
	arg_1_0.isOpen = arg_1_3
	arg_1_0.desc = arg_1_4
	arg_1_0.mask = GameObject("mask")
	arg_1_0.maskImg = arg_1_0.mask:AddComponent(typeof(Image))

	setParent(arg_1_0.mask, arg_1_0._go)

	tf(arg_1_0.mask).pivot = Vector2(0, 1)
	arg_1_0.maskImg.color = Color.New(0, 0, 0, 0.85)
	arg_1_0.textTF = GameObject("Text")
	arg_1_0.textTFText = arg_1_0.textTF:AddComponent(typeof(Text))

	setParent(arg_1_0.textTF, arg_1_0.mask)

	tf(arg_1_0.textTF).pivot = Vector2(0, 1)
	arg_1_0.textTFText.font = LoadAny("font/zhunyuan", "", nil)
	arg_1_0.textTFText.fontSize = 18
	arg_1_0.textTFText.alignment = TextAnchor.MiddleCenter

	return
end

function var_0_0.activeMask(arg_2_0, arg_2_1)
	setActive(arg_2_0.mask, arg_2_1)

	return
end

function var_0_0.activeDesc(arg_3_0, arg_3_1)
	setActive(arg_3_0.textTF, arg_3_1)

	return
end

function var_0_0.setDesc(arg_4_0, arg_4_1)
	arg_4_0.textTFText.text = arg_4_1

	return
end

function var_0_0.setCurrIndex(arg_5_0, arg_5_1)
	arg_5_0.currIndex = arg_5_1

	return
end

function var_0_0.isBlock(arg_6_0)
	return arg_6_0.isWhite
end

function var_0_0.isRestoration(arg_7_0)
	return arg_7_0.currIndex == arg_7_0.index and arg_7_0.isOpen
end

function var_0_0.update(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:setSprite(arg_8_1)
	arg_8_0:setPosition(arg_8_2, arg_8_0.index)

	if arg_8_3 then
		arg_8_0:setBlock()

		arg_8_0.isWhite = true
		arg_8_0.isOpen = true
	end

	arg_8_0:activeMask(not arg_8_0.isOpen)
	arg_8_0:activeDesc(arg_8_0.desc)

	if arg_8_0.desc then
		arg_8_0:setDesc(arg_8_0.desc)
	end

	return
end

function var_0_0.setHightLight(arg_9_0)
	arg_9_0.img.color = Color.New(1, 1, 1, 1)

	return
end

function var_0_0.setBlock(arg_10_0)
	arg_10_0.img.color = Color.New(1, 1, 1, 0)

	return
end

function var_0_0.setSprite(arg_11_0, arg_11_1)
	arg_11_0.img.sprite = arg_11_1

	arg_11_0.img:SetNativeSize()

	arg_11_0.width = arg_11_1.rect.width
	arg_11_0.height = arg_11_1.rect.height
	tf(arg_11_0.mask).sizeDelta = Vector2(arg_11_0.width, arg_11_0.height)
	tf(arg_11_0.mask).localPosition = Vector2(0, 0)
	tf(arg_11_0.textTF).sizeDelta = Vector2(arg_11_0.width, arg_11_0.height)
	tf(arg_11_0.textTF).localPosition = Vector2(0, 0)

	return
end

function var_0_0.setPosition(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.position = arg_12_1
	arg_12_0.currIndex = arg_12_2

	return
end

function var_0_0.getPosition(arg_13_0)
	return arg_13_0.position
end

function var_0_0.getCurrIndex(arg_14_0)
	return arg_14_0.currIndex
end

function var_0_0.setLocalPosition(arg_15_0, arg_15_1)
	arg_15_0._tr.localPosition = arg_15_1

	return
end

function var_0_0.getLocalPosition(arg_16_0)
	return arg_16_0._tr.localPosition
end

function var_0_0.getSurroundPosition(arg_17_0)
	table.insert({}, Vector2(arg_17_0.position.x, arg_17_0.position.y + 1))
	table.insert({}, Vector2(arg_17_0.position.x, arg_17_0.position.y - 1))
	table.insert({}, Vector2(arg_17_0.position.x - 1, arg_17_0.position.y))
	table.insert({}, Vector2(arg_17_0.position.x + 1, arg_17_0.position.y))

	return {}
end

return var_0_0
