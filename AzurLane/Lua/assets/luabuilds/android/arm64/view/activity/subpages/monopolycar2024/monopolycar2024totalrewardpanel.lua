local var_0_0 = class("MonopolyCar2024TotalRewardPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "TotalRewardPanelForMonopoly"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("Window/Layout/Box/ScrollView/Content/ItemGrid2"), arg_2_0._tf:Find("Window/Layout/Box/ScrollView/Content/ItemGrid2/GridItem"))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("Window/Fixed/ButtonGO")
	arg_2_0.closeBtn = arg_2_0._tf:Find("BG")

	setText(arg_2_0._tf:Find("Window/Fixed/top/bg/obtain/title"), i18n("MonopolyCar2024Game_total_award_title"))
	setText(arg_2_0._tf:Find("Window/Fixed/ButtonGO/pic"), i18n("text_confirm"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	var_0_0.super.Show(arg_6_0)
	arg_6_0.uiItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_6_0:UpdateItem(arg_7_2, arg_6_1[arg_7_1 + 1])
		end

		return
	end)
	arg_6_0.uiItemList:align(#arg_6_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.Hide(arg_8_0)
	var_0_0.super.Hide(arg_8_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf, arg_8_0.parentTF)

	return
end

function var_0_0.UpdateItem(arg_9_0, arg_9_1, arg_9_2)
	updateDrop(arg_9_1:Find("Icon"), arg_9_2)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_0
