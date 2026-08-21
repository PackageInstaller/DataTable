local var_0_0 = class("DreamlandSwitcherPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "DreamlandSwitcherUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.confirmBtn = arg_2_0._tf:Find("bg/confirm")
	arg_2_0.times = {
		arg_2_0._tf:Find("bg/conent/1"),
		arg_2_0._tf:Find("bg/conent/2"),
		arg_2_0._tf:Find("bg/conent/3")
	}

	setText(arg_2_0.times[1]:Find("title"), i18n("dreamland_label_day"))
	setText(arg_2_0.times[2]:Find("title"), i18n("dreamland_label_dusk"))
	setText(arg_2_0.times[3]:Find("title"), i18n("dreamland_label_night"))

	return
end

function var_0_0.OnInit(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.times) do
		onToggle(arg_3_0, iter_3_1, function(arg_4_0)
			if arg_4_0 then
				arg_3_0.selected = iter_3_0
			end

			arg_3_0:UpdateToggleStyle(iter_3_1, arg_4_0)

			return
		end, SFX_PANEL)
	end

	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if not arg_3_0.selected then
			return
		end

		arg_3_0:emit(DreamlandScene.EVENT_SWITCH_TIME, arg_3_0.selected)
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)
	triggerToggle(arg_7_0.times[arg_7_1], true)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)
	arg_7_0:InitTogglesStyle(arg_7_1)

	return
end

function var_0_0.InitTogglesStyle(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.times) do
		if iter_8_0 ~= arg_8_1 then
			arg_8_0:UpdateToggleStyle(iter_8_1, false)
		end
	end

	return
end

function var_0_0.UpdateToggleStyle(arg_9_0, arg_9_1, arg_9_2)
	local var_9_9000
	local var_9_0 = arg_9_1:Find("icon")
	local var_9_1 = var_9_0.GetComponent(var_9_9000, typeof(Image))
	local var_9_2 = arg_9_1:Find("title_icon"):GetComponent(typeof(Image))
	local var_9_3 = arg_9_1:Find("title").GetComponent(var_9_0, typeof(Text))
	local var_9_4 = Color.New(1, 1, 1, 1)
	local var_9_5 = Color.New(0.4235294, 0.4313726, 0.5137255, 1)

	var_9_1.color = arg_9_2 and var_9_4 or var_9_5
	var_9_2.color = arg_9_2 and var_9_4 or var_9_5
	var_9_3.color = arg_9_2 and var_9_4 or var_9_5

	return
end

function var_0_0.Hide(arg_10_0)
	var_0_0.super.Hide(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	if arg_11_0:isShowing() then
		arg_11_0:Hide()
	end

	return
end

return var_0_0
