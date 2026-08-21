local var_0_0 = class("BuildShipMsgBox", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "BuildShipMsgBoxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.cancenlBtn = findTF(arg_2_0._go, "window/btns/cancel_btn")
	arg_2_0.confirmBtn = findTF(arg_2_0._go, "window/btns/confirm_btn")
	arg_2_0.closeBtn = findTF(arg_2_0._go, "window/close_btn")
	arg_2_0.count = 1
	arg_2_0.minusBtn = findTF(arg_2_0._go, "window/content/calc_panel/minus")
	arg_2_0.addBtn = findTF(arg_2_0._go, "window/content/calc_panel/add")
	arg_2_0.maxBtn = findTF(arg_2_0._go, "window/content/max")
	arg_2_0.valueTxt = findTF(arg_2_0._go, "window/content/calc_panel/Text"):GetComponent(typeof(Text))
	arg_2_0.text = findTF(arg_2_0._go, "window/content/Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("window/btns/cancel_btn/Image/Image (1)"), i18n("text_cancel"))
	setText(arg_2_0._tf:Find("window/btns/confirm_btn/Image/Image (1)"), i18n("text_confirm"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancenlBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if arg_3_0.onConfirm then
			arg_3_0.onConfirm(arg_3_0.count)
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.minusBtn, function()
		arg_3_0.count = math.max(arg_3_0.count - 1, 1)

		arg_3_0:updateTxt(arg_3_0.count)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.addBtn, function()
		if arg_3_0.buildType == "ticket" and arg_3_0.count >= arg_3_0.itemVO.count then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tip_build_ticket_not_enough", arg_3_0.itemVO:getConfig("name")))

			return
		end

		arg_3_0.count = math.clamp(arg_3_0.count + 1, 1, MAX_BUILD_WORK_COUNT)

		arg_3_0:updateTxt(arg_3_0.count)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.maxBtn, function()
		arg_3_0.count = MAX_BUILD_WORK_COUNT

		if arg_3_0.buildType == "ticket" then
			arg_3_0.count = math.clamp(arg_3_0.itemVO.count, 1, MAX_BUILD_WORK_COUNT)
		end

		arg_3_0:updateTxt(arg_3_0.count)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateTxt(arg_11_0, arg_11_1)
	arg_11_0.valueTxt.text = arg_11_1
	arg_11_0.text.text = arg_11_0:GetDesc(arg_11_1)

	return
end

function var_0_0.GetDesc(arg_12_0, arg_12_1)
	local var_12_0 = ""

	switch(arg_12_0.buildType, {
		base = function()
			var_12_0 = arg_12_1 <= arg_12_0.max and arg_12_0.player.gold >= arg_12_1 * arg_12_0.buildPool.use_gold and arg_12_0.itemVO.count >= arg_12_1 * arg_12_0.buildPool.number_1 and i18n("build_ship_tip", arg_12_1, arg_12_0.buildPool.name, arg_12_1 * arg_12_0.buildPool.use_gold, arg_12_1 * arg_12_0.buildPool.number_1, COLOR_GREEN) or i18n("build_ship_tip", arg_12_1, arg_12_0.buildPool.name, arg_12_1 * arg_12_0.buildPool.use_gold, arg_12_1 * arg_12_0.buildPool.number_1, COLOR_RED)

			return
		end,
		ticket = function()
			var_12_0 = arg_12_1 <= arg_12_0.max and arg_12_0.itemVO.count >= arg_12_1 and i18n("build_ship_tip_use_ticket", arg_12_1, arg_12_0.buildPool.name, arg_12_1, arg_12_0.itemVO:getConfig("name"), COLOR_GREEN) or i18n("build_ship_tip_use_ticket", arg_12_1, arg_12_0.buildPool.name, arg_12_1, arg_12_0.itemVO:getConfig("name"), COLOR_RED)

			return
		end,
		medal = function()
			var_12_0 = arg_12_1 <= arg_12_0.max and arg_12_0.itemVO.count >= arg_12_1 * arg_12_0.cost and i18n("honor_medal_support_tips_confirm", arg_12_1, arg_12_1 * arg_12_0.cost, COLOR_GREEN) or i18n("honor_medal_support_tips_confirm", arg_12_1, arg_12_1 * arg_12_0.cost, COLOR_RED)

			return
		end
	})

	return ""
end

function var_0_0.Show(arg_16_0, arg_16_1)
	arg_16_0.showing = true

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		arg_16_0[iter_16_0] = iter_16_1
	end

	arg_16_0.count = 1

	arg_16_0:updateTxt(arg_16_0.count)
	setText(arg_16_0._tf:Find("window/content/title"), i18n(arg_16_0.buildType == "medal" and "support_times_tip" or "build_times_tip"))
	setActiveViaLayer(arg_16_0._go, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_16_0._tf)

	return
end

function var_0_0.Hide(arg_17_0)
	arg_17_0.showing = false

	if arg_17_0._go then
		arg_17_0.onConfirm = nil
		arg_17_0.count = 1
		arg_17_0.max = 1

		setActiveViaLayer(arg_17_0._go, false)
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_17_0._tf, arg_17_0._parentTf)

	return
end

function var_0_0.isShowing(arg_18_0)
	return arg_18_0.showing
end

function var_0_0.OnDestroy(arg_19_0)
	arg_19_0:Hide()

	return
end

return var_0_0
