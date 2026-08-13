class = var_0_10000

local var_0_0 = "CryptolaliaResDeleteWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CryptolaliaResDeleteWindowui"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "window/content/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.contentTxt = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "window/content/cover/icon")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.icon = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "window/content/cover/signature")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.signature = var_2_9(var_2_8, var_4(var_1_10006))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "window/content/cover/name")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.name = var_2_12(var_2_11, var_4(var_1_10006))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "window/content/cover/shipname")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.shipname = var_2_15(var_2_14, var_4(var_1_10006))

	local var_2_16 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_16, "window/button_container/cancel")

	local var_2_17 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_17, "window/button_container/confirm")
	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "window/top/title")

	i18n = var_4

	var_1(var_2_19, var_4("cryptolalia_delete_res_title"))

	setText = var_1

	local var_2_20 = arg_2_0.cancelBtn
	local var_2_21 = var_3.Find(var_2_20, "Text")

	i18n = var_4

	var_1(var_2_21, var_4("text_cancel"))

	setText = var_1

	local var_2_22 = arg_2_0.confirmBtn
	local var_2_23 = var_3.Find(var_2_22, "Text")

	i18n = var_4

	var_1(var_2_23, var_4("text_confirm"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.cancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.super.Show(arg_7_0)

	pg = var_3

	local var_7_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_7_0, arg_7_0._tf)

	local var_7_1 = arg_7_0.contentTxt

	i18n = var_1_10004

	local var_7_2 = "cryptolalia_delete_res_tip"
	local var_7_3 = arg_7_1

	var_7_1.text = var_1_10004(var_7_2, arg_7_1.GetResSize(var_7_3, arg_7_2))
	arg_7_0.name.text = arg_7_1:GetName()
	arg_7_0.shipname.text = arg_7_1:GetShipName()

	local var_7_4 = arg_7_1:GetShipGroupId()

	LoadSpriteAtlasAsync = var_4

	var_4("CryptolaliaShip/" .. var_7_4, "cd", function(arg_8_0)
		if arg_7_0.exited then
			return
		end

		arg_7_0.icon.sprite = arg_8_0

		local var_8_0 = arg_7_0.icon

		var_1.SetNativeSize(var_8_0)

		return
	end)

	onButton = var_4

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.confirmBtn

	local function var_7_7()
		IsUnityEditor = var_2_10000

		if var_2_10000 then
			pg = var_2_10000

			local var_9_0 = var_2_10000.TipsMgr.GetInstance()
			local var_9_1 = var_0.ShowTips

			i18n = var_2_10003

			var_9_1(var_9_0, var_2_10003("common_no_open"))

			return
		end

		local var_9_2 = arg_7_0

		var_0.Delete(var_9_2, arg_7_1, arg_7_2)

		local var_9_3 = arg_7_0

		var_0.Hide(var_9_3)

		return
	end

	SFX_PANEL = var_7_3

	var_4(var_7_5, var_7_6, var_7_7, var_7_3)

	return
end

function var_0_1.Delete(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 and arg_10_1:IsPlayableState(arg_10_2) then
		local var_10_0 = arg_10_1
		local var_10_1 = arg_10_1.GetCpkName(var_10_0, arg_10_2)

		Cryptolalia = var_1_10004

		local var_10_2 = var_1_10004.BuildCpkPath(var_10_1)

		Cryptolalia = var_10_0

		local var_10_3 = var_10_0.BuildSubtitlePath(var_10_1)

		pg = var_6

		local var_10_4 = var_6.CipherGroupMgr.GetInstance()

		var_6.DelFile(var_10_4, {
			var_10_2,
			var_10_3
		})

		local var_10_5 = arg_10_0
		local var_10_6 = arg_10_0.emit

		CryptolaliaScene = var_9

		var_10_6(var_10_5, var_9.ON_DELETE)
	end

	return
end

function var_0_1.Hide(arg_11_0)
	var_0_1.super.Hide(arg_11_0)

	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf, arg_11_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0.exited = true

	return
end

return var_0_1
