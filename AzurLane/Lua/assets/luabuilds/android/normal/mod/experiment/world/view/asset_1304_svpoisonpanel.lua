class = var_0_10000

local var_0_0 = "SVPoisonPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SVPoisonPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rtName = var_1.Find(var_3_0, "window/content/name_mask/name")

	local var_3_1 = arg_3_0._tf

	arg_3_0.rtDesc = var_1.Find(var_3_1, "window/content/intro_view/Viewport/Content/intro")

	local var_3_2 = arg_3_0._tf

	arg_3_0.rtPoisonRate = var_1.Find(var_3_2, "window/content/poison_rate")

	local var_3_3 = arg_3_0._tf

	arg_3_0.rtBg = var_1.Find(var_3_3, "bg")

	local var_3_4 = arg_3_0._tf

	arg_3_0.btnClose = var_1.Find(var_3_4, "window/top/btnBack")

	local var_3_5 = arg_3_0._tf

	arg_3_0.btnConfirm = var_1.Find(var_3_5, "window/button_container/confirm_btn")
	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.rtBg

	local function var_3_8()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.btnClose

	local function var_3_11()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.btnConfirm

	local function var_3_14()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_12, var_3_13, var_3_14, var_1_10005)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

function var_0_1.Show(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_8_0, arg_8_0._tf)

	setActive = var_1

	var_1(arg_8_0._tf, true)

	return
end

function var_0_1.Hide(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._parentTf)

	setActive = var_1

	var_1(arg_9_0._tf, false)

	return
end

function var_0_1.Setup(arg_10_0, arg_10_1)
	setText = var_1_10002

	local var_10_0 = arg_10_0.rtName

	i18n = var_1_10004

	var_1_10002(var_10_0, var_1_10004("world_sairen_title"))

	Clone = var_1_10002
	pg = var_10_0

	local var_10_1 = var_1_10002(var_10_0.gameset.world_sairen_infection.description)

	table = var_3

	var_3.insert(var_10_1, 1, 0)

	table = var_3

	var_3.insert(var_10_1, 999)

	eachChild = var_3

	local var_10_2 = arg_10_0.rtPoisonRate

	var_3(var_4.Find(var_10_2, "bg/ring"), function(arg_11_0)
		local var_11_0 = arg_11_0:GetSiblingIndex() + 1
		local var_11_2

		if arg_10_1 >= var_10_1[var_11_0] and arg_10_1 < var_10_1[var_11_0 + 1] then
			setActive = var_11_2

			var_11_2(arg_11_0, true)

			local var_11_1 = arg_11_0

			var_11_2 = arg_11_0.GetComponent
			typeof = var_4
			Image = var_2_10005
			var_11_2 = var_11_2(var_11_1, var_4(var_2_10005))
			var_11_2.fillAmount = arg_10_1 / 100
			setText = var_11_2

			local var_11_3 = arg_10_0.rtDesc

			i18n = var_4

			var_11_2(var_11_3, var_4("world_sairen_description" .. var_11_0, arg_10_1))
		else
			setActive = var_11_2

			var_11_2(arg_11_0, false)
		end

		setText = var_11_2

		local var_11_4 = arg_10_0.rtPoisonRate

		var_11_2(var_3.Find(var_11_4, "bg/Text"), arg_10_1 .. "%")

		return
	end)

	return
end

return var_0_1
