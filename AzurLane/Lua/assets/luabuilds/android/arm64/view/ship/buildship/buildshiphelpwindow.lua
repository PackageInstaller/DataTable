local var_0_0 = class("BuildShipHelpWindow", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BuildShipHelpWindowUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.shipListTF = arg_2_0._tf:Find("window/list/scrollview/list")
	arg_2_0.shipListTpl = arg_2_0._tf:Find("window/list/scrollview/item")

	setActive(arg_2_0.shipListTpl, false)

	arg_2_0.tipListTF = arg_2_0._tf:Find("window/rateList/scrollview/list")
	arg_2_0.tipListTpl = arg_2_0._tf:Find("window/rateList/scrollview/item")

	setText(arg_2_0._tf:Find("window/confirm_btn/Image/Image (1)"), i18n("text_confirm"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("window/close_btn"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("window/confirm_btn"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	arg_7_0.isSupport = arg_7_2 == "support"

	local var_7_0 = arg_7_0._tf:Find("window/rateList/title/Text")

	if arg_7_0.isSupport then
		setText(var_7_0, i18n("support_rate_title"))
	else
		setText(var_7_0, i18n("build_rate_title"))
	end

	setActive(var_7_0, false)
	setActive(var_7_0, true)
	arg_7_0:OnShow(arg_7_1, arg_7_3)
	setActiveViaLayer(arg_7_0._tf, true)
	arg_7_0:PlayOpenAnimation()

	return
end

function var_0_0.OnShow(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.showing = true

	for iter_8_0 = 1, arg_8_0.shipListTF.childCount do
		local var_8_0 = arg_8_0.shipListTF:GetChild(iter_8_0 - 1)

		if var_8_0 then
			setActive(var_8_0, false)
		end
	end

	local var_8_1 = arg_8_0.tipListTF.childCount

	for iter_8_1 = 1, arg_8_0.tipListTF.childCount do
		local var_8_2 = arg_8_0.tipListTF:GetChild(iter_8_1 - 1)

		if var_8_2 then
			setActive(var_8_2, false)
		end
	end

	local var_8_3 = getProxy(ActivityProxy)
	local var_8_4

	if not arg_8_0.isSupport then
		var_8_4 = arg_8_2 and var_8_3:getBuildActivityCfgByID(arg_8_1.id) or var_8_3:getNoneActBuildActivityCfgByID(arg_8_1.id)
	end

	if var_8_4 then
		local var_8_5 = var_8_4.rate_tip or arg_8_1.rate_tip

		for iter_8_2 = 1, #var_8_5 do
			local var_8_6 = iter_8_2 <= var_8_1 and arg_8_0.tipListTF:GetChild(iter_8_2 - 1) or cloneTplTo(arg_8_0.tipListTpl, arg_8_0.tipListTF)

			if var_8_6 then
				setActive(var_8_6, true)
				setText(var_8_6, HXSet.hxLan(var_8_5[iter_8_2]))
			end
		end

		return
	end
end

function var_0_0.Hide(arg_9_0)
	arg_9_0.showing = false

	setActiveViaLayer(arg_9_0._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._tf)

	return
end

function var_0_0.isShowing(arg_10_0)
	return arg_10_0.showing
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

function var_0_0.PlayOpenAnimation(arg_12_0)
	local var_12_0 = arg_12_0._tf:Find("window/bg_decorations"):GetComponent(typeof(Animation))

	var_12_0:Stop()
	var_12_0:Play("anim_window_bg")

	local var_12_1 = arg_12_0._tf:Find("window/title"):GetComponent(typeof(Animation))

	var_12_1:Stop()
	var_12_1:Play("anim_top")

	local var_12_2 = arg_12_0._tf:Find("window"):GetComponent(typeof(Animation))

	var_12_2:Stop()
	var_12_2:Play("anim_content")

	local var_12_3 = arg_12_0._tf:Find("print"):GetComponent(typeof(Animation))

	var_12_3:Stop()
	var_12_3:Play("anim_bg_plus")

	local var_12_4 = arg_12_0._tf:Find("window/confirm_btn"):GetComponent(typeof(Animation))

	var_12_4:Stop()
	var_12_4:Play("anim_button_container")

	return
end

return var_0_0
