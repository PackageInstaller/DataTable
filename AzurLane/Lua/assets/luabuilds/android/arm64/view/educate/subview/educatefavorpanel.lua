local var_0_0 = class("EducateFavorPanel", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "EducateFavorPanel"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.favorPanelTF = arg_2_0._tf:Find("favor_panel")
	arg_2_0.favorPanelAnim = arg_2_0.favorPanelTF:GetComponent(typeof(Animation))
	arg_2_0.favorPanelAnimEvent = arg_2_0.favorPanelTF:GetComponent(typeof(DftAniEvent))

	arg_2_0.favorPanelAnimEvent:SetEndEvent(function()
		setActive(arg_2_0.favorPanelTF, false)

		return
	end)
	setActive(arg_2_0.favorPanelTF, false)

	arg_2_0.favorUIList = UIItemList.New(arg_2_0.favorPanelTF:Find("panel/bg/view/content"), arg_2_0.favorPanelTF:Find("panel/bg/view/content/tpl"))
	arg_2_0.favorCurTF = arg_2_0.favorPanelTF:Find("panel/bg/cur")

	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0.favorPanelTF:Find("panel/bg")
		}
	})
	arg_2_0:addListener()
	arg_2_0:Flush()

	return
end

function var_0_0.addListener(arg_4_0)
	onButton(arg_4_0, arg_4_0.favorPanelTF, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	arg_4_0.favorUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			arg_4_0:updateFavorItem(arg_6_1, arg_6_2)
		end

		return
	end)

	return
end

function var_0_0.updateFavorPanel(arg_7_0)
	arg_7_0.char = getProxy(EducateProxy):GetCharData()

	local var_7_0 = arg_7_0.char:GetFavor()

	setText(arg_7_0.favorCurTF:Find("lv"), var_7_0.lv)

	local var_7_1 = arg_7_0.char:GetFavorUpgradExp(var_7_0.lv)

	setText(arg_7_0.favorCurTF:Find("progress"), i18n("child_favor_progress", var_7_0.exp .. "/" .. var_7_1))
	setSlider(arg_7_0.favorCurTF:Find("slider"), 0, 1, var_7_0.exp / var_7_1)
	arg_7_0.favorUIList:align(arg_7_0.char:getConfig("favor_level") - 1)

	return
end

function var_0_0.updateFavorItem(arg_8_0, arg_8_1, arg_8_2)
	setText(arg_8_2:Find("lv"), arg_8_1 + 1 + 1)

	local var_8_0 = arg_8_1 + 1 < arg_8_0.char:GetFavor().lv

	setActive(arg_8_2:Find("lock"), not var_8_0)
	setActive(arg_8_2:Find("unlock"), var_8_0)

	if not var_8_0 then
		local var_8_1 = arg_8_0.char:GetFavorUpgradExp(arg_8_1 + 1)

		setText(arg_8_2:Find("Text"), i18n("child_favor_lock1", arg_8_1 + 1 + 1))
		setTextColor(arg_8_2:Find("Text"), Color.NewHex("F5F5F5"))
		setTextColor(arg_8_2:Find("lv"), Color.NewHex("F5F5F5"))
	else
		local var_8_2 = arg_8_0.char:GetPerformByReplace(arg_8_1 + 1)

		if var_8_2[1] then
			setText(arg_8_2:Find("Text"), (arg_8_0:getStoryTitle(pg.child_performance[var_8_2[1]].param)))
		end

		setTextColor(arg_8_2:Find("Text"), Color.NewHex("393A3C"))
		setTextColor(arg_8_2:Find("lv"), Color.NewHex("FFFFFF"))
		onButton(arg_8_0, arg_8_2:Find("unlock"), function()
			pg.PerformMgr.GetInstance():PlayOne(var_8_2[1])

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.getStoryTitle(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(pg.memory_template.all) do
		if table.contains(pg.memory_template[iter_10_1].unlock_pre, arg_10_1) then
			return pg.memory_template[iter_10_1].title
		end
	end

	return arg_10_1
end

function var_0_0.Show(arg_11_0)
	if not arg_11_0:GetLoaded() then
		return
	end

	setActive(arg_11_0.favorPanelTF, true)
	arg_11_0:updateFavorPanel()

	return
end

function var_0_0.Hide(arg_12_0)
	arg_12_0.favorPanelAnim:Play("anim_educate_educateUI_favor_out")

	return
end

function var_0_0.Flush(arg_13_0)
	if not arg_13_0:GetLoaded() then
		return
	end

	arg_13_0:updateFavorPanel()

	return
end

function var_0_0.OnDestroy(arg_14_0)
	arg_14_0.favorPanelAnimEvent:SetEndEvent(nil)
	arg_14_0:UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_0
