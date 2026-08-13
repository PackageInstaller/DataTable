class = var_0_10000

local var_0_0 = var_0_10000("Dorm3dInstagramCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.iconTF = var_2.Find(var_1_0, "head/icon")

	local var_1_1 = arg_1_0._tf

	arg_1_0.nameTxt = var_2.Find(var_1_1, "name")

	local var_1_2 = arg_1_0._tf

	arg_1_0.txt = var_2.Find(var_1_2, "Text")

	local var_1_3 = arg_1_0._tf

	arg_1_0.like = var_2.Find(var_1_3, "like/Text")

	local var_1_4 = arg_1_0._tf

	arg_1_0.likeMark = var_2.Find(var_1_4, "like/mark")

	local var_1_5 = arg_1_0._tf

	arg_1_0.tip = var_2.Find(var_1_5, "head/tip")

	local var_1_6 = arg_1_0._tf

	arg_1_0.image = var_2.Find(var_1_6, "image")

	local var_1_7 = arg_1_0._tf

	arg_1_0.mask = var_2.Find(var_1_7, "mask")

	local var_1_8 = arg_1_0._tf

	arg_1_0.maskTxt = var_2.Find(var_1_8, "mask/content/Text")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.instagram = arg_2_1
	setImageSprite = var_1_10002

	local var_2_0 = arg_2_0.iconTF

	LoadSprite = var_1_10004

	var_1_10002(var_2_0, var_1_10004("qicon/" .. arg_2_1:GetIcon()), false)

	setText = var_1_10002

	var_1_10002(arg_2_0.nameTxt, arg_2_1:GetName())

	LoadSpriteAsync = var_1_10002

	var_1_10002("Dorm3dIns/" .. arg_2_1:GetPicture(), function(arg_3_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_2_0.image, arg_3_0, false)

		return
	end)

	setActive = var_1_10002

	var_1_10002(arg_2_0.likeMark, arg_2_1:IsGood())

	setText = var_1_10002

	var_1_10002(arg_2_0.txt, arg_2_1:GetText())

	setActive = var_1_10002

	var_1_10002(arg_2_0.tip, arg_2_1:ShouldTip())

	setActive = var_1_10002

	var_1_10002(arg_2_0.mask, arg_2_1:IsLock())

	setText = var_1_10002

	var_1_10002(arg_2_0.maskTxt, arg_2_1:GetUnLockConditionDesc())

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
