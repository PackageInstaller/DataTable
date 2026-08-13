class = var_0_10000

local var_0_0 = var_0_10000("BackYardThemeCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.content = var_2.Find(var_1_0, "content")

	local var_1_1 = arg_1_0.content
	local var_1_2 = var_2.Find(var_1_1, "icon_mask/icon")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.icon = var_1_3(var_1_2, var_5(var_1_10007))

	local var_1_4 = arg_1_0.content
	local var_1_5 = var_2.Find(var_1_4, "Text")
	local var_1_6 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTxt = var_1_6(var_1_5, var_5(var_1_10007))

	local var_1_7 = arg_1_0.content

	arg_1_0.discountTF = var_2.Find(var_1_7, "discount")

	local var_1_8 = arg_1_0.discountTF
	local var_1_9 = var_2.Find(var_1_8, "Text")
	local var_1_10 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.discountTxt = var_1_10(var_1_9, var_5(var_1_10007))

	local var_1_11 = arg_1_0.content

	arg_1_0.hotTF = var_2.Find(var_1_11, "hot")

	local var_1_12 = arg_1_0.content

	arg_1_0.newTF = var_2.Find(var_1_12, "new")

	local var_1_13 = arg_1_0.content

	arg_1_0.maskPurchased = var_2.Find(var_1_13, "mask1")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.themeVO = arg_2_1
	LoadSpriteAtlasAsync = var_1_10003

	var_1_10003("BackYardTheme/" .. arg_2_1.id, "", function(arg_3_0)
		arg_2_0.icon.sprite = arg_3_0

		return
	end)

	shortenString = var_1_10003

	local var_2_0 = var_1_10003(arg_2_1:GetName(), 7)

	string = var_1_10004

	local var_2_1 = var_1_10004.gsub(var_2_0, "<size=%d+>", "")
	local var_2_2 = arg_2_0.nameTxt

	string = var_6
	var_2_2.text = var_6.gsub(var_2_1, "</size>", "")

	local var_2_3 = arg_2_1
	local var_2_4 = arg_2_1.GetDiscount(var_2_3)
	local var_2_5 = arg_2_1:HasDiscount()

	setActive = var_2_3

	var_2_3(arg_2_0.discountTF, var_2_5)

	if var_2_5 then
		arg_2_0.discountTxt.text = var_2_4 .. "%"
	end

	local var_2_6 = false
	local var_2_7 = arg_2_1:getConfig("new")

	if not (0 < var_2_7) then
		var_2_6 = arg_2_1:getConfig("hot") > 0
	end

	setActive = var_9

	var_9(arg_2_0.hotTF, var_2_6 and not arg_2_2)

	setActive = var_9

	var_9(arg_2_0.newTF, var_8 and not arg_2_2)

	setActive = var_9

	var_9(arg_2_0.maskPurchased, arg_2_2)

	return
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 and arg_4_1.id == arg_4_0.themeVO.id

	IsNil = var_1_10003

	if var_1_10003(arg_4_0.content) then
		return
	end

	LeanTween = var_3

	if var_3.isTweening(arg_4_0.content.gameObject) then
		LeanTween = var_3

		var_3.cancel(arg_4_0.content.gameObject)
	end

	local var_4_1 = arg_4_0.content.anchoredPosition.y
	local var_4_2 = var_4_0 and 0 or -70

	LeanTween = var_5

	local var_4_3 = var_5.value(arg_4_0.content.gameObject, var_4_1, var_4_2, 0.264)
	local var_4_4 = var_5.setOnUpdate

	System = var_8

	var_4_4(var_4_3, var_8.Action_float(function(arg_5_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_4_0.content, {
			y = arg_5_0
		})

		return
	end))

	return
end

function var_0_0.Dispose(arg_6_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_6_0.content.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_6_0.content.gameObject)
	end

	return
end

return var_0_0
