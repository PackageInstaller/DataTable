class = var_0_10000

local var_0_0 = var_0_10000("CardPairsCard")

var_0_0.CARD_STATE_BACK = 0
var_0_0.CARD_STATE_FRONT = 1
var_0_0.CARD_STATE_HIDE = 2
var_0_0.ANI_TIME = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	pg = var_1_10007

	var_1_10007.DelegateInfo.New(arg_1_0)

	arg_1_0.cardTf = arg_1_1
	arg_1_0.pics = arg_1_2
	findTF = var_7
	arg_1_0.img = var_7(arg_1_0.cardTf, "img")
	findTF = var_7
	arg_1_0.back = var_7(arg_1_0.cardTf, "back")
	findTF = var_7
	arg_1_0.front = var_7(arg_1_0.cardTf, "front")
	findTF = var_7
	arg_1_0.clearSign = var_7(arg_1_0.cardTf, "gray")
	GetComponent = var_7

	local var_1_0 = arg_1_0.front

	typeof = var_10
	Outline = var_1_10012
	arg_1_0.outline = var_7(var_1_0, var_10(var_1_10012))

	arg_1_0:setOutline(false)

	arg_1_0.cardState = arg_1_0.CARD_STATE_BACK
	arg_1_0.canClick = true
	arg_1_0.enable = true
	arg_1_0.aniCallBack = arg_1_6
	arg_1_0.aniStartCallBak = arg_1_5

	arg_1_0:initCard(arg_1_3)

	onButton = var_7

	var_7(arg_1_0, arg_1_0.cardTf, function()
		arg_1_4(arg_1_0)

		return
	end)

	return
end

function var_0_0.getCardIndex(arg_3_0)
	return arg_3_0.cardIndex
end

function var_0_0.setEnable(arg_4_0, arg_4_1)
	arg_4_0.enable = arg_4_1

	return
end

function var_0_0.setClear(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.clearSign, true)
	arg_5_0:setOutline(false)

	arg_5_0.canClick = false

	return
end

function var_0_0.setOutline(arg_6_0, arg_6_1)
	arg_6_0.outline.enabled = arg_6_1

	return
end

function var_0_0.initCard(arg_7_0, arg_7_1)
	arg_7_0.cardIndex = arg_7_1

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.setSpriteTo

	findTF = var_1_10005

	var_7_1(var_7_0, var_1_10005(arg_7_0.pics, "pic" .. arg_7_1), arg_7_0.img, false)

	setActive = var_7_1

	var_7_1(arg_7_0.clearSign, false)
	arg_7_0:showBack()

	arg_7_0.canClick = true

	return
end

function var_0_0.showBack(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.back, true)

	setActive = var_1_10001

	var_1_10001(arg_8_0.front, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.img, false)

	arg_8_0.cardState = arg_8_0.CARD_STATE_BACK

	arg_8_0:setOutline(false)

	return
end

function var_0_0.showFront(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.back, false)

	setActive = var_1_10001

	var_1_10001(arg_9_0.front, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.img, true)

	arg_9_0.cardState = arg_9_0.CARD_STATE_FRONT

	return
end

function var_0_0.aniShowBack(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.canClick = false

	if arg_10_1 then
		var_1_10006 = arg_10_0

		arg_10_0.showBack(var_1_10006)
	else
		var_1_10006 = arg_10_0

		arg_10_0.showFront(var_1_10006)
	end

	if not arg_10_2 then
		arg_10_0.aniStartCallBak(arg_10_0, arg_10_1)
	end

	local var_10_0 = arg_10_0.cardTf

	Vector3 = var_1_10005
	var_10_0.localScale = var_1_10005(1, 1, 1)
	LeanTween = var_10_0

	local var_10_1 = var_10_0.scale

	go = var_1_10006

	local var_10_2 = var_1_10006(arg_10_0.cardTf)

	Vector3 = var_7

	local var_10_3 = var_10_1(var_10_2, var_7(0, 1, 1), arg_10_0.ANI_TIME)
	local var_10_4 = var_4.setDelay

	defaultValue = var_7

	local var_10_5 = var_10_4(var_10_3, var_7(arg_10_3, 0))
	local var_10_6 = var_4.setOnComplete

	System = var_7

	var_10_6(var_10_5, var_7.Action(function()
		if arg_10_1 then
			var_2_10002 = arg_10_0

			var_0.showFront(var_2_10002)
		else
			var_2_10002 = arg_10_0

			var_0.showBack(var_2_10002)
		end

		LeanTween = var_0

		local var_11_0 = var_0.scale

		go = var_2_10002

		local var_11_1 = var_2_10002(arg_10_0.cardTf)

		Vector3 = var_2_10003

		local var_11_2 = var_11_0(var_11_1, var_2_10003(1, 1, 1), arg_10_0.ANI_TIME)
		local var_11_3 = var_0.setOnComplete

		System = var_3

		var_11_3(var_11_2, var_3.Action(function()
			arg_10_0.canClick = true

			if not arg_10_2 then
				arg_10_0.aniCallBack(arg_10_0, arg_10_1)
			end

			return
		end))

		return
	end))

	return
end

function var_0_0.setSpriteTo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_2
	local var_13_1 = arg_13_2.GetComponent

	typeof = var_1_10007
	Image = var_1_10009

	local var_13_2 = var_13_1(var_13_0, var_1_10007(var_1_10009))
	local var_13_3 = arg_13_1
	local var_13_4 = arg_13_1.GetComponent

	typeof = var_1_10008
	Image = var_1_10010
	var_13_2.sprite = var_13_4(var_13_3, var_1_10008(var_1_10010)).sprite

	if arg_13_3 then
		var_13_2:SetNativeSize()
	end

	return
end

function var_0_0.clear(arg_14_0)
	LeanTween = var_1_10001

	local var_14_0 = var_1_10001.cancel

	go = var_1_10003

	var_14_0(var_1_10003(arg_14_0.cardTf))

	return
end

function var_0_0.destroy(arg_15_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_15_0)

	LeanTween = var_1

	local var_15_0 = var_1.cancel

	go = var_3

	var_15_0(var_3(arg_15_0.cardTf))

	return
end

return var_0_0
