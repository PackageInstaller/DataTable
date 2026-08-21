local var_0_0 = class("Dorm3dInstagramCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.iconTF = arg_1_0._tf:Find("head/icon")
	arg_1_0.nameTxt = arg_1_0._tf:Find("name")
	arg_1_0.txt = arg_1_0._tf:Find("Text")
	arg_1_0.like = arg_1_0._tf:Find("like/Text")
	arg_1_0.likeMark = arg_1_0._tf:Find("like/mark")
	arg_1_0.tip = arg_1_0._tf:Find("head/tip")
	arg_1_0.image = arg_1_0._tf:Find("image")
	arg_1_0.mask = arg_1_0._tf:Find("mask")
	arg_1_0.maskTxt = arg_1_0._tf:Find("mask/content/Text")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.instagram = arg_2_1

	setImageSprite(arg_2_0.iconTF, LoadSprite("qicon/" .. arg_2_1:GetIcon()), false)
	setText(arg_2_0.nameTxt, arg_2_1:GetName())
	LoadSpriteAsync("Dorm3dIns/" .. arg_2_1:GetPicture(), function(arg_3_0)
		setImageSprite(arg_2_0.image, arg_3_0, false)

		return
	end)
	setActive(arg_2_0.likeMark, arg_2_1:IsGood())
	setText(arg_2_0.txt, arg_2_1:GetText())
	setActive(arg_2_0.tip, arg_2_1:ShouldTip())
	setActive(arg_2_0.mask, arg_2_1:IsLock())
	setText(arg_2_0.maskTxt, arg_2_1:GetUnLockConditionDesc())

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
