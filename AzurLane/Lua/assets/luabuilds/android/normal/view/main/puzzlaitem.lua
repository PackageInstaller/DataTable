class = var_0_10000

local var_0_0 = var_0_10000("PuzzlaItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetComponent

	typeof = var_1_10007
	Image = var_1_10008
	arg_1_0.img = var_1_1(var_1_0, var_1_10007(var_1_10008))

	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.AddComponent

	typeof = var_7
	Button = var_1_10008
	arg_1_0.btn = var_1_3(var_1_2, var_7(var_1_10008))
	arg_1_0._go = arg_1_1
	rtf = var_5
	arg_1_0._tr = var_5(arg_1_0._go)

	local var_1_4 = arg_1_0._tr

	Vector2 = var_6
	var_1_4.pivot = var_6(0, 1)
	arg_1_0.width = 0
	arg_1_0.height = 0
	arg_1_0.position = nil
	arg_1_0.index = arg_1_2
	arg_1_0.isWhite = false
	arg_1_0.currIndex = nil
	arg_1_0.isOpen = arg_1_3
	arg_1_0.desc = arg_1_4
	GameObject = var_5
	arg_1_0.mask = var_5("mask")

	local var_1_5 = arg_1_0.mask
	local var_1_6 = var_5.AddComponent

	typeof = var_7
	Image = var_8
	arg_1_0.maskImg = var_1_6(var_1_5, var_7(var_8))
	setParent = var_5

	var_5(arg_1_0.mask, arg_1_0._go)

	tf = var_5

	local var_1_7 = var_5(arg_1_0.mask)

	Vector2 = var_6
	var_1_7.pivot = var_6(0, 1)

	local var_1_8 = arg_1_0.maskImg

	Color = var_6
	var_1_8.color = var_6.New(0, 0, 0, 0.85)
	GameObject = var_1_8
	arg_1_0.textTF = var_1_8("Text")

	local var_1_9 = arg_1_0.textTF
	local var_1_10 = var_5.AddComponent

	typeof = var_7
	Text = var_8
	arg_1_0.textTFText = var_1_10(var_1_9, var_7(var_8))
	setParent = var_5

	var_5(arg_1_0.textTF, arg_1_0.mask)

	tf = var_5

	local var_1_11 = var_5(arg_1_0.textTF)

	Vector2 = var_6
	var_1_11.pivot = var_6(0, 1)

	local var_1_12 = arg_1_0.textTFText

	LoadAny = var_6
	var_1_12.font = var_6("font/zhunyuan", "", nil)
	arg_1_0.textTFText.fontSize = 18

	local var_1_13 = arg_1_0.textTFText

	TextAnchor = var_6
	var_1_13.alignment = var_6.MiddleCenter

	return
end

function var_0_0.activeMask(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0.mask, arg_2_1)

	return
end

function var_0_0.activeDesc(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.textTF, arg_3_1)

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
	local var_9_0 = arg_9_0.img

	Color = var_1_10002
	var_9_0.color = var_1_10002.New(1, 1, 1, 1)

	return
end

function var_0_0.setBlock(arg_10_0)
	local var_10_0 = arg_10_0.img

	Color = var_1_10002
	var_10_0.color = var_1_10002.New(1, 1, 1, 0)

	return
end

function var_0_0.setSprite(arg_11_0, arg_11_1)
	arg_11_0.img.sprite = arg_11_1

	local var_11_0 = arg_11_0.img

	var_2.SetNativeSize(var_11_0)

	arg_11_0.width = arg_11_1.rect.width
	arg_11_0.height = arg_11_1.rect.height
	tf = var_2

	local var_11_1 = var_2(arg_11_0.mask)

	Vector2 = var_3
	var_11_1.sizeDelta = var_3(arg_11_0.width, arg_11_0.height)
	tf = var_11_1

	local var_11_2 = var_11_1(arg_11_0.mask)

	Vector2 = var_3
	var_11_2.localPosition = var_3(0, 0)
	tf = var_11_2

	local var_11_3 = var_11_2(arg_11_0.textTF)

	Vector2 = var_3
	var_11_3.sizeDelta = var_3(arg_11_0.width, arg_11_0.height)
	tf = var_11_3

	local var_11_4 = var_11_3(arg_11_0.textTF)

	Vector2 = var_3
	var_11_4.localPosition = var_3(0, 0)

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
	local var_17_0 = {}

	table = var_1_10002

	local var_17_1 = var_1_10002.insert
	local var_17_2 = var_17_0

	Vector2 = var_1_10004

	var_17_1(var_17_2, var_1_10004(arg_17_0.position.x, arg_17_0.position.y + 1))

	table = var_17_1

	local var_17_3 = var_17_1.insert
	local var_17_4 = var_17_0

	Vector2 = var_4

	var_17_3(var_17_4, var_4(arg_17_0.position.x, arg_17_0.position.y - 1))

	table = var_17_3

	local var_17_5 = var_17_3.insert
	local var_17_6 = var_17_0

	Vector2 = var_4

	var_17_5(var_17_6, var_4(arg_17_0.position.x - 1, arg_17_0.position.y))

	table = var_17_5

	local var_17_7 = var_17_5.insert
	local var_17_8 = var_17_0

	Vector2 = var_4

	var_17_7(var_17_8, var_4(arg_17_0.position.x + 1, arg_17_0.position.y))

	return var_17_0
end

return var_0_0
