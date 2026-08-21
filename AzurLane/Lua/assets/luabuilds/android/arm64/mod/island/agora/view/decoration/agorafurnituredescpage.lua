local var_0_0 = class("AgoraFurnitureDescPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAgoraFurnitureDescUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.width = arg_2_0._tf.rect.width
	arg_2_0.height = arg_2_0._tf.rect.height
	arg_2_0.prantLeftBound = arg_2_0._tf.parent.rect.width / 2
	arg_2_0.nameTxt = arg_2_0._tf:Find("name"):GetComponent(typeof(Text))
	arg_2_0.themeNameTxt = arg_2_0._tf:Find("theme"):GetComponent(typeof(Text))
	arg_2_0.capacityTxt = arg_2_0._tf:Find("capacity/Text"):GetComponent(typeof(Text))
	arg_2_0.descTxt = arg_2_0._tf:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.icon = arg_2_0._tf:Find("icon"):GetComponent(typeof(Image))
	arg_2_0.cntTxt = arg_2_0._tf:Find("cnt/Text"):GetComponent(typeof(Text))

	setActive(arg_2_0._tf:Find("cnt"), false)

	return
end

function var_0_0.Show(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.Show(arg_3_0)

	arg_3_0._tf.position = arg_3_2

	if arg_3_0._tf.localPosition.x + arg_3_0.width > arg_3_0.prantLeftBound then
		arg_3_0._tf.localPosition = Vector3(arg_3_0._tf.localPosition.x - arg_3_0.width, arg_3_0._tf.localPosition.y, arg_3_0._tf.localPosition.z)
	end

	arg_3_0:FlushInfo(arg_3_1)

	return
end

function var_0_0.FlushInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetFirstItem()

	arg_4_0.nameTxt.text = var_4_0:GetName()
	arg_4_0.themeNameTxt.text = i18n("agora_belong_theme", arg_4_1:GetThemeName())
	arg_4_0.capacityTxt.text = var_4_0:GetCost()
	arg_4_0.descTxt.text = var_4_0:GetDesc()
	arg_4_0.cntTxt.text = arg_4_1:GetAvailableCnt()

	LoadSpriteAsync("island/IslandFurnitureIcon/" .. var_4_0:GetIcon(), function(arg_5_0)
		if not IsNil(arg_4_0.icon) then
			arg_4_0.icon.sprite = arg_5_0
		end

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0
