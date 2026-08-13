class = var_0_10000

local var_0_0 = "AgoraFurnitureDescPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAgoraFurnitureDescUI"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0.width = arg_2_0._tf.rect.width
	arg_2_0.height = arg_2_0._tf.rect.height
	arg_2_0.prantLeftBound = arg_2_0._tf.parent.rect.width / 2

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "name")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "theme")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.themeNameTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "capacity/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.capacityTxt = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTxt = var_2_11(var_2_10, var_4(var_1_10006))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "icon")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.icon = var_2_14(var_2_13, var_4(var_1_10006))

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "cnt/Text")
	local var_2_17 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.cntTxt = var_2_17(var_2_16, var_4(var_1_10006))
	setActive = var_1

	local var_2_18 = arg_2_0._tf

	var_1(var_3.Find(var_2_18, "cnt"), false)

	return
end

function var_0_1.Show(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.Show(arg_3_0)

	arg_3_0._tf.position = arg_3_2

	if arg_3_0._tf.localPosition.x + arg_3_0.width > arg_3_0.prantLeftBound then
		local var_3_0 = arg_3_0._tf.localPosition
		local var_3_1 = arg_3_0._tf

		Vector3 = var_5
		var_3_1.localPosition = var_5(var_3_0.x - arg_3_0.width, var_3_0.y, var_3_0.z)
	end

	arg_3_0:FlushInfo(arg_3_1)

	return
end

function var_0_1.FlushInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetFirstItem()

	arg_4_0.nameTxt.text = var_4_0:GetName()

	local var_4_1 = arg_4_0.themeNameTxt

	i18n = var_4
	var_4_1.text = var_4("agora_belong_theme", arg_4_1:GetThemeName())
	arg_4_0.capacityTxt.text = var_4_0:GetCost()
	arg_4_0.descTxt.text = var_4_0:GetDesc()

	local var_4_2 = arg_4_0.cntTxt

	var_4_2.text = arg_4_1:GetAvailableCnt()
	LoadSpriteAsync = var_4_2

	var_4_2("island/IslandFurnitureIcon/" .. var_4_0:GetIcon(), function(arg_5_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_4_0.icon) then
			arg_4_0.icon.sprite = arg_5_0
		end

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	return
end

return var_0_1
