local var_0_0 = class("IslandSetCardAchvsBox", import("view.base.BaseSubView"))

var_0_0.MAX_CNT = 4

function var_0_0.getUIName(arg_1_0)
	return "IslandSetCardAchvsBox"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.titleTxt = arg_2_0._tf:Find("frame/title"):GetComponent(typeof(Text))
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("cancel")

	setText(arg_2_0.cancelBtn:Find("Text"), i18n("word_cancel"))

	arg_2_0.confirmBtn = arg_2_0._tf:Find("confirm")

	setText(arg_2_0.confirmBtn:Find("Text"), i18n("word_ok"))

	arg_2_0.emptyTF = arg_2_0._tf:Find("empty")

	setText(arg_2_0.emptyTF, i18n("island_card_no_achieve_tip"))

	arg_2_0.scrollRect = arg_2_0._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0.closeBtn, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.cancelBtn, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.confirmBtn, function()
		arg_5_0:emit(IslandSelfCardMediator.SET_CARD_ACHVS, (getProxy(IslandProxy):GetIsland():GetAchievementAgency():UpdataAchLv(arg_5_0.selectedIds)))

		return
	end, SFX_PANEL)

	arg_5_0.cards = {}

	return
end

function var_0_0.OnInitItem(arg_9_0, arg_9_1)
	arg_9_0.cards[arg_9_1] = IslandCardAchvCard.New(arg_9_1)

	return
end

function var_0_0.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.cards[arg_10_2]

	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)

		var_10_0 = arg_10_0.cards[arg_10_2]
	end

	local var_10_1 = arg_10_0.ids[arg_10_1 + 1]

	if arg_10_0.ids[arg_10_1 + 1] then
		var_10_0:Update(var_10_1, arg_10_0.selectedIds)
	end

	onButton(arg_10_0, var_10_0._go, function()
		local var_11_0 = table.contains(arg_10_0.selectedIds, var_10_1)

		if not var_11_0 and #arg_10_0.selectedIds == var_0_0.MAX_CNT then
			return
		end

		if var_11_0 then
			table.removebyvalue(arg_10_0.selectedIds, var_10_1)
		else
			table.insert(arg_10_0.selectedIds, var_10_1)
		end

		for iter_11_0, iter_11_1 in pairs(arg_10_0.cards) do
			iter_11_1:UpdateSelected(arg_10_0.selectedIds)
		end

		arg_10_0:UpdateTitle()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetNewSelectedIds(arg_12_0, arg_12_1)
	return
end

function var_0_0.Show(arg_13_0, arg_13_1, arg_13_2)
	var_0_0.super.Show(arg_13_0)

	arg_13_0.ids = arg_13_1
	arg_13_0.selectedIds = arg_13_2

	arg_13_0.scrollRect:SetTotalCount(#arg_13_0.ids, -1)
	setActive(arg_13_0.emptyTF, #arg_13_0.ids == 0)
	arg_13_0:UpdateTitle()
	pg.UIMgr.GetInstance():BlurPanel(arg_13_0._tf)

	return
end

function var_0_0.UpdateTitle(arg_14_0)
	arg_14_0.titleTxt.text = i18n("island_card_choose_achievement", #arg_14_0.selectedIds)

	return
end

function var_0_0.Hide(arg_15_0)
	var_0_0.super.Hide(arg_15_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf, arg_15_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	ClearLScrollrect(arg_16_0.scrollRect)

	for iter_16_0, iter_16_1 in pairs(arg_16_0.cards) do
		iter_16_1:Dispose()
	end

	arg_16_0.cards = {}

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf, arg_16_0._parentTf)

	return
end

return var_0_0
