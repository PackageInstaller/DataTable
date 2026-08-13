class = var_0_10000

local var_0_0 = "BuildShipHelpWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BuildShipHelpWindowUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.shipListTF = var_1.Find(var_2_0, "window/list/scrollview/list")

	local var_2_1 = arg_2_0._tf

	arg_2_0.shipListTpl = var_1.Find(var_2_1, "window/list/scrollview/item")
	setActive = var_1

	var_1(arg_2_0.shipListTpl, false)

	local var_2_2 = arg_2_0._tf

	arg_2_0.tipListTF = var_1.Find(var_2_2, "window/rateList/scrollview/list")

	local var_2_3 = arg_2_0._tf

	arg_2_0.tipListTpl = var_1.Find(var_2_3, "window/rateList/scrollview/item")
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "window/confirm_btn/Image/Image (1)")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("text_confirm"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "window/close_btn")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "window/confirm_btn")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf

	local function var_3_10()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_8, var_3_9, var_3_10, var_5)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	pg = var_1_10004

	local var_7_0 = var_1_10004.UIMgr.GetInstance()

	var_4.BlurPanel(var_7_0, arg_7_0._tf)

	arg_7_0.isSupport = arg_7_2 == "support"

	local var_7_1 = arg_7_0._tf
	local var_7_2 = var_4.Find(var_7_1, "window/rateList/title/Text")

	if arg_7_0.isSupport then
		setText = var_5

		local var_7_3 = var_7_2

		i18n = var_1_10007

		var_5(var_7_3, var_1_10007("support_rate_title"))
	else
		setText = var_5

		local var_7_4 = var_7_2

		i18n = var_1_10007

		var_5(var_7_4, var_1_10007("build_rate_title"))
	end

	setActive = var_5

	var_5(var_7_2, false)

	setActive = var_5

	var_5(var_7_2, true)
	arg_7_0:OnShow(arg_7_1, arg_7_3)

	setActiveViaLayer = var_5

	var_5(arg_7_0._tf, true)
	arg_7_0:PlayOpenAnimation()

	return
end

function var_0_1.OnShow(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.showing = true

	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_0.shipListTF.childCount

	for iter_8_0 = 1, var_8_1 do
		local var_8_2 = arg_8_0.shipListTF

		if var_9.GetChild(var_8_2, iter_8_0 - 1) then
			setActive = var_8_2

			var_8_2(var_9, false)
		end
	end

	local var_8_3 = arg_8_0.tipListTF.childCount

	for iter_8_1 = 1, var_8_3 do
		local var_8_4 = arg_8_0.tipListTF

		if var_10.GetChild(var_8_4, iter_8_1 - 1) then
			setActive = var_8_4

			var_8_4(var_10, false)
		end
	end

	getProxy = var_6
	ActivityProxy = var_7

	local var_8_5 = var_6(var_7)
	local var_8_6

	if not arg_8_0.isSupport then
		if arg_8_2 then
			var_8_6 = var_8_5:getBuildActivityCfgByID(var_8_0.id)
		else
			var_8_6 = var_8_5:getNoneActBuildActivityCfgByID(var_8_0.id)
		end
	end

	local var_8_7

	if not var_8_6 or not var_8_6.rate_tip then
		var_8_7 = var_8_0.rate_tip
	end

	for iter_8_2 = 1, #var_8_7 do
		local var_8_8

		if iter_8_2 <= var_8_3 then
			local var_8_9 = arg_8_0.tipListTF

			var_8_8 = var_1_10014.GetChild(var_8_9, iter_8_2 - 1)
		else
			cloneTplTo = var_1_10014
			var_8_8 = var_1_10014(arg_8_0.tipListTpl, arg_8_0.tipListTF)
		end

		if var_8_8 then
			setActive = var_1_10014

			var_1_10014(var_8_8, true)

			setText = var_1_10014

			local var_8_10 = var_8_8

			HXSet = var_16

			var_1_10014(var_8_10, var_16.hxLan(var_8_7[iter_8_2]))
		end
	end

	return
end

function var_0_1.Hide(arg_9_0)
	arg_9_0.showing = false
	setActiveViaLayer = var_1

	var_1(arg_9_0._tf, false)

	pg = var_1

	local var_9_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._tf)

	return
end

function var_0_1.isShowing(arg_10_0)
	return arg_10_0.showing
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

function var_0_1.PlayOpenAnimation(arg_12_0)
	local var_12_0 = arg_12_0._tf
	local var_12_1 = var_1.Find(var_12_0, "window/bg_decorations")
	local var_12_2 = var_1.GetComponent

	typeof = var_1_10004
	Animation = var_1_10005

	local var_12_3 = var_12_2(var_12_1, var_1_10004(var_1_10005))

	var_2.Stop(var_12_3)
	var_2:Play("anim_window_bg")

	local var_12_4 = arg_12_0._tf
	local var_12_5 = var_3.Find(var_12_4, "window/title")
	local var_12_6 = var_3.GetComponent

	typeof = var_1_10006
	Animation = var_1_10007

	local var_12_7 = var_12_6(var_12_5, var_1_10006(var_1_10007))

	var_4.Stop(var_12_7)
	var_4:Play("anim_top")

	local var_12_8 = arg_12_0._tf
	local var_12_9 = var_5.Find(var_12_8, "window")
	local var_12_10 = var_5.GetComponent

	typeof = var_1_10008
	Animation = var_1_10009

	local var_12_11 = var_12_10(var_12_9, var_1_10008(var_1_10009))

	var_6.Stop(var_12_11)
	var_6:Play("anim_content")

	local var_12_12 = arg_12_0._tf
	local var_12_13 = var_7.Find(var_12_12, "print")
	local var_12_14 = var_7.GetComponent

	typeof = var_1_10010
	Animation = var_1_10011

	local var_12_15 = var_12_14(var_12_13, var_1_10010(var_1_10011))

	var_8.Stop(var_12_15)
	var_8:Play("anim_bg_plus")

	local var_12_16 = arg_12_0._tf
	local var_12_17 = var_9.Find(var_12_16, "window/confirm_btn")
	local var_12_18 = var_9.GetComponent

	typeof = var_1_10012
	Animation = var_1_10013

	local var_12_19 = var_12_18(var_12_17, var_1_10012(var_1_10013))

	var_10.Stop(var_12_19)
	var_10:Play("anim_button_container")

	return
end

return var_0_1
