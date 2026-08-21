local var_0_0 = class("CardPairsCard")

var_0_0.CARD_STATE_BACK = 0
var_0_0.CARD_STATE_FRONT = 1
var_0_0.CARD_STATE_HIDE = 2
var_0_0.ANI_TIME = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.cardTf = arg_1_1
	arg_1_0.pics = arg_1_2
	arg_1_0.img = findTF(arg_1_0.cardTf, "img")
	arg_1_0.back = findTF(arg_1_0.cardTf, "back")
	arg_1_0.front = findTF(arg_1_0.cardTf, "front")
	arg_1_0.clearSign = findTF(arg_1_0.cardTf, "gray")
	arg_1_0.outline = GetComponent(arg_1_0.front, typeof(Outline))

	arg_1_0:setOutline(false)

	arg_1_0.cardState = arg_1_0.CARD_STATE_BACK
	arg_1_0.canClick = true
	arg_1_0.enable = true
	arg_1_0.aniCallBack = arg_1_6
	arg_1_0.aniStartCallBak = arg_1_5

	arg_1_0:initCard(arg_1_3)
	onButton(arg_1_0, arg_1_0.cardTf, function()
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
	setActive(arg_5_0.clearSign, true)
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

	arg_7_0:setSpriteTo(findTF(arg_7_0.pics, "pic" .. arg_7_1), arg_7_0.img, false)
	setActive(arg_7_0.clearSign, false)
	arg_7_0:showBack()

	arg_7_0.canClick = true

	return
end

function var_0_0.showBack(arg_8_0)
	setActive(arg_8_0.back, true)
	setActive(arg_8_0.front, false)
	setActive(arg_8_0.img, false)

	arg_8_0.cardState = arg_8_0.CARD_STATE_BACK

	arg_8_0:setOutline(false)

	return
end

function var_0_0.showFront(arg_9_0)
	setActive(arg_9_0.back, false)
	setActive(arg_9_0.front, true)
	setActive(arg_9_0.img, true)

	arg_9_0.cardState = arg_9_0.CARD_STATE_FRONT

	return
end

function var_0_0.aniShowBack(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.canClick = false

	if arg_10_1 then
		arg_10_0:showBack()
	else
		arg_10_0:showFront()
	end

	if not arg_10_2 then
		arg_10_0:aniStartCallBak(arg_10_1)
	end

	arg_10_0.cardTf.localScale = Vector3(1, 1, 1)

	LeanTween.scale(go(arg_10_0.cardTf), Vector3(0, 1, 1), arg_10_0.ANI_TIME):setDelay(defaultValue(arg_10_3, 0)):setOnComplete(System.Action(function()
		if arg_10_1 then
			arg_10_0:showFront()
		else
			arg_10_0:showBack()
		end

		LeanTween.scale(go(arg_10_0.cardTf), Vector3(1, 1, 1), arg_10_0.ANI_TIME):setOnComplete(System.Action(function()
			arg_10_0.canClick = true

			if not arg_10_2 then
				arg_10_0:aniCallBack(arg_10_1)
			end

			return
		end))

		return
	end))

	return
end

function var_0_0.setSpriteTo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_2:GetComponent(typeof(Image))

	var_13_0.sprite = arg_13_1:GetComponent(typeof(Image)).sprite

	if arg_13_3 then
		var_13_0:SetNativeSize()
	end

	return
end

function var_0_0.clear(arg_14_0)
	LeanTween.cancel(go(arg_14_0.cardTf))

	return
end

function var_0_0.destroy(arg_15_0)
	pg.DelegateInfo.Dispose(arg_15_0)
	LeanTween.cancel(go(arg_15_0.cardTf))

	return
end

return var_0_0
