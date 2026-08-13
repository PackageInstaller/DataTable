class = var_0_10000

local var_0_0 = var_0_10000("IslandSelectableDescPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.isShowItemCount = arg_1_2
	arg_1_0.tr = arg_1_1

	local var_1_0 = arg_1_0.tr

	arg_1_0.countBg = var_3.Find(var_1_0, "bg/item/icon_bg/count_bg")

	local var_1_1 = arg_1_0.tr
	local var_1_2 = var_3.Find(var_1_1, "bg/item/icon_bg/count_bg/count")
	local var_1_3 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.itemCntTxt = var_1_3(var_1_2, var_6(var_1_10008))

	local var_1_4 = arg_1_0.tr

	arg_1_0.iconTr = var_3.Find(var_1_4, "bg/item/icon_bg/icon")

	local var_1_5 = arg_1_0.tr
	local var_1_6 = var_3.Find(var_1_5, "bg/detaiView/Viewport/detaiViewText")
	local var_1_7 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.detaltipsTf = var_1_7(var_1_6, var_6(var_1_10008))

	local var_1_8 = arg_1_0.tr
	local var_1_9 = var_3.Find(var_1_8, "bg/seedName")
	local var_1_10 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.nameTxt = var_1_10(var_1_9, var_6(var_1_10008))

	return
end

function var_0_0.Show(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.tr.position = arg_2_1

	local var_2_0 = arg_2_0.itemCntTxt

	var_2_0.text = arg_2_2:GetCount()
	setActive = var_2_0

	var_2_0(arg_2_0.countBg, arg_2_0.isShowItemCount)

	local var_2_1 = arg_2_2:GetIcon()

	GetImageSpriteFromAtlasAsync = var_4

	var_4("island/" .. var_2_1, "", arg_2_0.iconTr)

	arg_2_0.detaltipsTf.text = arg_2_2:GetDesc()

	local var_2_2 = arg_2_0.nameTxt

	var_2_2.text = arg_2_2:GetName()
	setActive = var_2_2

	var_2_2(arg_2_0.tr, true)

	return
end

function var_0_0.IsShowing(arg_3_0)
	isActive = var_1_10001

	return var_1_10001(arg_3_0.tr)
end

function var_0_0.Hide(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0.tr, false)

	return
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0:IsShowing() then
		arg_5_0:Hide()
	end

	return
end

return var_0_0
