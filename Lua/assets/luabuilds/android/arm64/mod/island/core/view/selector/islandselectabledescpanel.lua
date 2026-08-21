local var_0_0 = class("IslandSelectableDescPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.isShowItemCount = arg_1_2
	arg_1_0.tr = arg_1_1
	arg_1_0.countBg = arg_1_0.tr:Find("bg/item/icon_bg/count_bg")
	arg_1_0.itemCntTxt = arg_1_0.tr:Find("bg/item/icon_bg/count_bg/count"):GetComponent(typeof(Text))
	arg_1_0.iconTr = arg_1_0.tr:Find("bg/item/icon_bg/icon")
	arg_1_0.detaltipsTf = arg_1_0.tr:Find("bg/detaiView/Viewport/detaiViewText"):GetComponent(typeof(Text))
	arg_1_0.nameTxt = arg_1_0.tr:Find("bg/seedName"):GetComponent(typeof(Text))

	return
end

function var_0_0.Show(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.tr.position = arg_2_1
	arg_2_0.itemCntTxt.text = arg_2_2:GetCount()

	setActive(arg_2_0.countBg, arg_2_0.isShowItemCount)
	GetImageSpriteFromAtlasAsync("island/" .. arg_2_2:GetIcon(), "", arg_2_0.iconTr)

	arg_2_0.detaltipsTf.text = arg_2_2:GetDesc()
	arg_2_0.nameTxt.text = arg_2_2:GetName()

	setActive(arg_2_0.tr, true)

	return
end

function var_0_0.IsShowing(arg_3_0)
	return isActive(arg_3_0.tr)
end

function var_0_0.Hide(arg_4_0)
	setActive(arg_4_0.tr, false)

	return
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0:IsShowing() then
		arg_5_0:Hide()
	end

	return
end

return var_0_0
