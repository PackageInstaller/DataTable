local var_0_0 = class("ActivityBossScoreAwardLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ActivitybonusWindow_nonPt"
end

function var_0_0.init(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("window/panel/list"), arg_2_0._tf:Find("window/panel/list/item"))

	arg_2_0.uiItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateItem(arg_3_1, arg_3_2)
		end

		return
	end)

	arg_2_0.currentTxt = arg_2_0._tf:Find("window/pt/Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("window/top/bg/infomation"), i18n("world_expedition_reward_display"))
	setText(arg_2_0._tf:Find("window/pt/title"), i18n("activityboss_sp_window_best_score"))
	setText(arg_2_0._tf:Find("window/panel/list/item/target/title"), i18n("activityboss_sp_score_target"))

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.closeBtn, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	arg_4_0:Flush()
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)

	return
end

function var_0_0.Flush(arg_7_0, arg_7_1)
	arg_7_0.awards = arg_7_0.contextData.awards
	arg_7_0.targets = arg_7_0.contextData.targets
	arg_7_0.score = arg_7_0.contextData.score

	arg_7_0.uiItemList:align(#arg_7_0.awards)

	arg_7_0.currentTxt.text = arg_7_0.score

	return
end

function var_0_0.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.targets[arg_8_1 + 1]
	local var_8_1 = arg_8_2:Find("award")

	updateDrop(var_8_1, {
		type = arg_8_0.awards[arg_8_1 + 1][1],
		id = arg_8_0.awards[arg_8_1 + 1][2],
		count = arg_8_0.awards[arg_8_1 + 1][3]
	})
	onButton(arg_8_0, var_8_1, function()
		arg_8_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setActive(arg_8_2:Find("award/mask"), var_8_0 <= arg_8_0.score)
	setText(arg_8_2:Find("target/Text"), var_8_0)
	setText(arg_8_2:Find("title/Text"), "PHASE  " .. arg_8_1 + 1)

	return
end

function var_0_0.Hide(arg_10_0)
	arg_10_0:closeView()

	return
end

function var_0_0.willExit(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf)

	return
end

return var_0_0
