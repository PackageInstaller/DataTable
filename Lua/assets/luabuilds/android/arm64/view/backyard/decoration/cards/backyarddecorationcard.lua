local var_0_0 = class("BackYardDecorationCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0._bg = findTF(arg_1_0._tf, "bg")
	arg_1_0.maskTF = findTF(arg_1_0._tf, "bg/mask")
	arg_1_0.iconImg = findTF(arg_1_0._tf, "bg/icon"):GetComponent(typeof(Image))
	arg_1_0.comfortableTF = findTF(arg_1_0._tf, "bg/comfortable")
	arg_1_0.newTF = findTF(arg_1_0._tf, "bg/new_bg")
	arg_1_0.countTxt = findTF(arg_1_0._tf, "bg/count")
	arg_1_0.mark = findTF(arg_1_0._tf, "bg/mark")
	arg_1_0.animation = arg_1_0._tf:GetComponent(typeof(Animation))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.furniture = arg_2_1

	LoadSpriteAtlasAsync("furnitureicon/" .. arg_2_1:getConfig("icon"), "", function(arg_3_0)
		if IsNil(arg_2_0.iconImg) then
			return
		end

		arg_2_0.iconImg.sprite = arg_3_0

		return
	end)
	setText(arg_2_0.comfortableTF, shortenString(HXSet.hxLan(arg_2_1:getConfig("name")), 4))

	local var_2_0 = arg_2_1:getConfig("count")
	local var_2_1 = arg_2_1:GetOwnCnt()

	arg_2_0.showMask = var_2_1 <= arg_2_2

	SetActive(arg_2_0.maskTF, arg_2_0.showMask)
	setText(arg_2_0.maskTF:Find("Text"), i18n("courtyard_label_using", arg_2_3))
	arg_2_0:UpdateMark(arg_2_4)

	if var_2_0 > 1 then
		setText(arg_2_0.countTxt, arg_2_2 .. "/" .. var_2_1)
		SetActive(arg_2_0.maskTF, arg_2_2 == var_2_1)
	else
		setText(arg_2_0.countTxt, "")
	end

	SetActive(arg_2_0.newTF, arg_2_1.newFlag)

	return
end

function var_0_0.PlayEnterAnimation(arg_4_0)
	arg_4_0.animation:Play("anim_backyard_furniture_itemin")

	return
end

function var_0_0.UpdateMark(arg_5_0, arg_5_1)
	if not arg_5_0.furniture then
		setActive(arg_5_0.mark, false)

		return
	end

	setActive(arg_5_0.mark, arg_5_1 and arg_5_1 == arg_5_0.furniture.id)

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
