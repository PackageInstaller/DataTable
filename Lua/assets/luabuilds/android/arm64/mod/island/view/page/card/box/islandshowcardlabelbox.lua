local var_0_0 = class("IslandShowCardLabelBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShowCardLabelBox"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("frame/title"), i18n("island_card_label_list"))

	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.emptyTF = arg_2_0._tf:Find("empty")

	setText(arg_2_0.emptyTF, i18n("island_card_no_label_tip"))

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

	arg_5_0.cards = {}

	return
end

function var_0_0.OnInitItem(arg_7_0, arg_7_1)
	arg_7_0.cards[arg_7_1] = IslandCardShowLabelCard.New(arg_7_1)

	return
end

function var_0_0.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.cards[arg_8_2]

	if not arg_8_0.cards[arg_8_2] then
		arg_8_0:OnInitItem(arg_8_2)

		var_8_0 = arg_8_0.cards[arg_8_2]
	end

	local var_8_1 = arg_8_0.labelList[arg_8_1 + 1]

	if arg_8_0.labelList[arg_8_1 + 1] then
		var_8_0:Update(var_8_1.id, var_8_1.num)
	end

	return
end

function var_0_0.Show(arg_9_0, arg_9_1)
	var_0_0.super.Show(arg_9_0)

	arg_9_0.labelList = arg_9_1

	arg_9_0.scrollRect:SetTotalCount(#arg_9_0.labelList, -1)
	setActive(arg_9_0.emptyTF, #arg_9_0.labelList == 0)
	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)

	return
end

function var_0_0.Hide(arg_10_0)
	var_0_0.super.Hide(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	ClearLScrollrect(arg_11_0.scrollRect)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.cards) do
		iter_11_1:Dispose()
	end

	arg_11_0.cards = {}

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, arg_11_0._parentTf)

	return
end

return var_0_0
