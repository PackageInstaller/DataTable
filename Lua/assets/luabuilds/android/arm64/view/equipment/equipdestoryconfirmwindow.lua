local var_0_0 = class("EquipDestoryConfirmWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "DestoryConfirmWindow"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")

	setActive(arg_2_0._tf:Find("window/top/bg/infomation/title_en"), PLATFORM_CODE ~= PLATFORM_US)
	setText(arg_2_0._tf:Find("window/top/bg/infomation/title"), i18n("title_info"))

	arg_2_0.cancelBtn = arg_2_0._tf:Find("window/cancel_btn")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("window/confirm_btn")

	setText(findTF(arg_2_0.confirmBtn, "pic"), i18n("destroy_confirm_access"))
	setText(findTF(arg_2_0.cancelBtn, "pic"), i18n("destroy_confirm_cancel"))

	arg_2_0.title = arg_2_0._tf:Find("window/content/Text")
	arg_2_0.label = arg_2_0._tf:Find("window/content/desc/label")

	setText(arg_2_0.label, i18n("destory_ship_before_tip"))

	arg_2_0.urLabel = arg_2_0._tf:Find("window/content/desc/label1")
	arg_2_0.urInput = arg_2_0._tf:Find("window/content/desc/InputField")
	arg_2_0.urOverflowLabel = arg_2_0._tf:Find("window/content/desc/label2")

	setText(arg_2_0.urOverflowLabel, i18n("destory_ur_pt_overflowa"))
	setText(arg_2_0.urInput:Find("Placeholder"), i18n("box_ship_del_click"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:Confirm()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback = arg_8_1

	return
end

function var_0_0.Confirm(arg_9_0)
	if arg_9_0.key then
		if arg_9_0.key ~= tonumber((getInputText(arg_9_0.urInput))) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("destory_ship_input_erro"))

			return
		end

		local var_9_0 = arg_9_0.callback

		arg_9_0:Hide()
		existCall(var_9_0)
	else
		local var_9_1 = arg_9_0.callback

		arg_9_0:Hide()
		existCall(var_9_1)
	end

	return
end

function var_0_0.Show(arg_10_0, arg_10_1, arg_10_2)
	var_0_0.super.Show(arg_10_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_10_0._tf)

	arg_10_0.key = nil
	arg_10_0.equips = arg_10_1

	arg_10_0:SetCallBack(arg_10_2)
	arg_10_0:Updatelayout()
	arg_10_0:UpdateEquips()

	return
end

function var_0_0.Updatelayout(arg_11_0)
	if underscore.any(arg_11_0.equips, function(arg_12_0)
		return arg_12_0:getConfig("rarity") >= 4
	end) then
		table.insert({}, i18n("destroy_high_rarity_tip"))
	end

	if underscore.any(arg_11_0.equips, function(arg_13_0)
		return arg_13_0:getConfig("level") > 1
	end) then
		table.insert({}, i18n("destroy_high_intensify_tip", ""))
	end

	if #{} == 0 then
		table.insert({}, i18n("destroy_importantequipment_tip"))
	end

	setText(arg_11_0.title, i18n("destroy_eliteequipment_tip", table.concat({}, ",")))

	local var_11_0 = underscore.any(arg_11_0.equips, function(arg_14_0)
		return arg_14_0:isImportance()
	end)

	if var_11_0 and not arg_11_0.key then
		arg_11_0.key = math.random(100000, 999999)

		setText(arg_11_0.urLabel, i18n("destroy_equip_rarity_tip", arg_11_0.key))
	else
		setText(arg_11_0.urLabel, "")
	end

	setActive(arg_11_0.urOverflowLabel, false)
	setActive(arg_11_0.urLabel, var_11_0)
	setActive(arg_11_0.urInput, var_11_0)

	return
end

function var_0_0.UpdateEquips(arg_15_0)
	mergeSort(arg_15_0.equips, CompareFuncs({
		function(arg_16_0)
			return -arg_16_0:getConfig("rarity")
		end,
		function(arg_17_0)
			return -arg_17_0:getConfig("level")
		end
	}, true))

	if #arg_15_0.equips > 5 then
		setActive(arg_15_0._tf:Find("window/content/ships"), true)
		setActive(arg_15_0._tf:Find("window/content/ships_single"), false)

		local var_15_0 = arg_15_0._tf:Find("window/content/ships/content"):GetComponent("LScrollRect")

		arg_15_0._tf:Find("window/content/ships/content"):GetComponent("LScrollRect").onUpdateItem = function(arg_18_0, arg_18_1)
			updateEquipment(tf(arg_18_1), arg_15_0.equips[arg_18_0 + 1])

			return
		end

		onNextTick(function()
			var_15_0:SetTotalCount(#arg_15_0.equips)

			return
		end)
	else
		local var_15_1 = arg_15_0._tf:Find("window/content/ships_single")
		local var_15_2 = UIItemList.New(var_15_1, var_15_1:Find("IconTpl"))

		setActive(arg_15_0._tf:Find("window/content/ships"), false)
		setActive(arg_15_0._tf:Find("window/content/ships_single"), true)
		var_15_2:make(function(arg_20_0, arg_20_1, arg_20_2)
			if arg_20_0 == UIItemList.EventUpdate then
				updateEquipment(arg_20_2, arg_15_0.equips[arg_20_1 + 1])
			end

			return
		end)
		var_15_2:align(#arg_15_0.equips)
	end

	return
end

function var_0_0.Hide(arg_21_0)
	var_0_0.super.Hide(arg_21_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf, arg_21_0._parentTf)

	arg_21_0.key = nil
	arg_21_0.callback = nil

	setInputText(arg_21_0.urInput, "")

	return
end

function var_0_0.OnDestroy(arg_22_0)
	if arg_22_0:isShowing() then
		arg_22_0:Hide()
	end

	return
end

return var_0_0
