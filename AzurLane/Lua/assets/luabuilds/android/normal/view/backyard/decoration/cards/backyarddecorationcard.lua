class = var_0_10000

local var_0_0 = var_0_10000("BackYardDecorationCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)
	findTF = var_2
	arg_1_0._bg = var_2(arg_1_0._tf, "bg")
	findTF = var_2
	arg_1_0.maskTF = var_2(arg_1_0._tf, "bg/mask")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0._tf, "bg/icon")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.iconImg = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.comfortableTF = var_2(arg_1_0._tf, "bg/comfortable")
	findTF = var_2
	arg_1_0.newTF = var_2(arg_1_0._tf, "bg/new_bg")
	findTF = var_2
	arg_1_0.countTxt = var_2(arg_1_0._tf, "bg/count")
	findTF = var_2
	arg_1_0.mark = var_2(arg_1_0._tf, "bg/mark")

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Animation = var_1_10005
	arg_1_0.animation = var_1_3(var_1_2, var_4(var_1_10005))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.furniture = arg_2_1
	LoadSpriteAtlasAsync = var_1_10005

	var_1_10005("furnitureicon/" .. arg_2_1:getConfig("icon"), "", function(arg_3_0)
		IsNil = var_2_10001

		if var_2_10001(arg_2_0.iconImg) then
			return
		end

		arg_2_0.iconImg.sprite = arg_3_0

		return
	end)

	HXSet = var_1_10005

	local var_2_0 = var_1_10005.hxLan(arg_2_1:getConfig("name"))

	setText = var_6

	local var_2_1 = arg_2_0.comfortableTF

	shortenString = var_8

	var_6(var_2_1, var_8(var_2_0, 4))

	local var_2_2 = arg_2_1:getConfig("count")

	arg_2_0.showMask = arg_2_1:GetOwnCnt() <= arg_2_2
	SetActive = var_8

	var_8(arg_2_0.maskTF, arg_2_0.showMask)

	setText = var_8

	local var_2_3 = arg_2_0.maskTF
	local var_2_4 = var_9.Find(var_2_3, "Text")

	i18n = var_2_3

	var_8(var_2_4, var_2_3("courtyard_label_using", arg_2_3))
	arg_2_0:UpdateMark(arg_2_4)

	if 1 < var_2_2 then
		setText = var_8

		var_8(arg_2_0.countTxt, arg_2_2 .. "/" .. var_7)

		SetActive = var_8

		var_8(arg_2_0.maskTF, arg_2_2 == var_7)
	else
		setText = var_8

		var_8(arg_2_0.countTxt, "")
	end

	SetActive = var_8

	var_8(arg_2_0.newTF, arg_2_1.newFlag)

	return
end

function var_0_0.PlayEnterAnimation(arg_4_0)
	local var_4_0 = arg_4_0.animation

	var_1.Play(var_4_0, "anim_backyard_furniture_itemin")

	return
end

function var_0_0.UpdateMark(arg_5_0, arg_5_1)
	if not arg_5_0.furniture then
		setActive = var_2

		var_2(arg_5_0.mark, false)

		return
	end

	setActive = var_2

	var_2(arg_5_0.mark, arg_5_1 and arg_5_1 == arg_5_0.furniture.id)

	return
end

function var_0_0.Flush(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1.id == arg_6_0.furniture.id then
		arg_6_0:Update(arg_6_1, arg_6_2, arg_6_3)
	else
		arg_6_0:Update(arg_6_0.furniture, arg_6_2, arg_6_3)
	end

	return
end

function var_0_0.HasMask(arg_7_0)
	return arg_7_0.showMask
end

function var_0_0.Dispose(arg_8_0)
	return
end

return var_0_0
