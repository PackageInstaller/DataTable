local var_0_0 = class("ActivityBossPtAwardSubPanel", import("view.base.BaseSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "ActivitybonusWindow_btnVer"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.scrollPanel = arg_2_0._tf:Find("window/panel")
	arg_2_0.UIlist = UIItemList.New(arg_2_0._tf:Find("window/panel/list"), arg_2_0._tf:Find("window/panel/list/item"))
	arg_2_0.totalTxt = arg_2_0._tf:Find("window/pt/Text"):GetComponent(typeof(Text))
	arg_2_0.totalTitleTxt = arg_2_0._tf:Find("window/pt/title"):GetComponent(typeof(Text))
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.btn_banned = arg_2_0._tf:Find("window/btn_banned")
	arg_2_0.btn_get = arg_2_0._tf:Find("window/btn_get")
	arg_2_0.btn_got = arg_2_0._tf:Find("window/btn_got")

	onButton(arg_2_0, arg_2_0._tf:Find("bg_dark"), function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.closeBtn, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btn_get, function()
		local var_5_0, var_5_1 = arg_2_0.ptData:GetResProgress()

		arg_2_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.ptData:GetId(),
			arg1 = var_5_1
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateView(arg_6_0, arg_6_1)
	arg_6_0.ptData = arg_6_1

	local var_6_0 = arg_6_1.dropList
	local var_6_1 = arg_6_1.targets
	local var_6_2 = arg_6_1.level
	local var_6_4 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_6_1.resId
	}):getName()

	if arg_6_1.type == 2 then
		arg_6_0.resTitle, arg_6_0.cntTitle = i18n("pt_count", i18n("pt_cosume", var_6_4)), i18n("pt_total_count", i18n("pt_cosume", var_6_4))
	else
		arg_6_0.resTitle, arg_6_0.cntTitle = i18n("pt_count", var_6_4), i18n("pt_total_count", var_6_4)
	end

	local var_6_5 = arg_6_0.ptData:CanGetAward()

	setActive(arg_6_0.btn_get, var_6_5)
	setActive(arg_6_0.btn_banned, not var_6_5)
	arg_6_0:UpdateList(var_6_0, var_6_1, var_6_2, (arg_6_0.ptData:GetBossProgress()))
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.UpdateList(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	assert(#arg_7_1 == #arg_7_2)
	arg_7_0.UIlist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_8_0 = arg_7_1[arg_8_1 + 1]

		setText(arg_8_2:Find("title/Text"), "PHASE " .. arg_8_1 + 1)
		setText(arg_8_2:Find("target/Text"), arg_7_2[arg_8_1 + 1])
		setText(arg_8_2:Find("target/title"), arg_7_0.resTitle)
		updateDrop(arg_8_2:Find("award"), {
			type = var_8_0[1],
			id = var_8_0[2],
			count = var_8_0[3]
		}, {
			hideName = true
		})
		onButton(arg_7_0, arg_8_2:Find("award"), function()
			arg_7_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		setActive(arg_8_2:Find("award/mask"), arg_8_1 + 1 <= arg_7_3)

		local var_8_1 = arg_7_0.ptData.progress_target[arg_8_1 + 1] < arg_7_4

		setActive(arg_8_2:Find("mask"), arg_7_0.ptData.progress_target[arg_8_1 + 1] < arg_7_4)

		if var_8_1 then
			setText(arg_8_2:Find("mask/Text"), i18n("world_boss_award_limit", math.round(arg_7_0.ptData.progress_target[arg_8_1 + 1] / 100)))
		end

		setActive(arg_8_2:Find("award/mask/Image"), arg_8_1 + 1 <= arg_7_3)

		return
	end)
	arg_7_0.UIlist:align(#arg_7_1)
	scrollTo(arg_7_0.scrollPanel, 0, 1 - arg_7_3 * 166 / (#arg_7_2 * 166 + 20 - 570))

	return
end

function var_0_0.OnShow(arg_10_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_10_0._tf)

	return
end

function var_0_0.OnHide(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, arg_11_0.viewParent._tf)

	return
end

return var_0_0
