local var_0_0 = class("IslandSetCardPhotoBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSetCardPhotoBox"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("frame/title"), i18n("island_card_choose_photo"))

	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("cancel")

	setText(arg_2_0.cancelBtn:Find("Text"), i18n("word_cancel"))

	arg_2_0.confirmBtn = arg_2_0._tf:Find("confirm")

	setText(arg_2_0.confirmBtn:Find("Text"), i18n("word_ok"))

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
		arg_5_0:emit(IslandSelfCardMediator.SET_CARD_PHOTO, arg_5_0.selectedId)

		return
	end, SFX_PANEL)

	arg_5_0.cards = {}

	return
end

function var_0_0.OnInitItem(arg_9_0, arg_9_1)
	arg_9_0.cards[arg_9_1] = IslandCardPhotoCard.New(arg_9_1)

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
		var_10_0:Update(var_10_1, arg_10_0.selectedId)
	end

	onButton(arg_10_0, var_10_0._go, function()
		for iter_11_0, iter_11_1 in pairs(arg_10_0.cards) do
			iter_11_1:UpdateSelected(nil)
		end

		arg_10_0.selectedId = var_10_1

		var_10_0:UpdateSelected(arg_10_0.selectedId)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_12_0, arg_12_1, arg_12_2)
	var_0_0.super.Show(arg_12_0)

	arg_12_0.ids = arg_12_1

	table.sort(arg_12_0.ids)

	arg_12_0.selectedId = arg_12_2

	arg_12_0.scrollRect:SetTotalCount(#arg_12_0.ids, -1)
	pg.UIMgr.GetInstance():BlurPanel(arg_12_0._tf)

	return
end

function var_0_0.Hide(arg_13_0)
	var_0_0.super.Hide(arg_13_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf, arg_13_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_14_0)
	ClearLScrollrect(arg_14_0.scrollRect)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.cards) do
		iter_14_1:Dispose()
	end

	arg_14_0.cards = {}

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf, arg_14_0._parentTf)

	return
end

return var_0_0
