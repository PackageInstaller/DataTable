local var_0_0 = class("IslandBookAwardListBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandBookAwardListBox"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.titleTxt = arg_2_0._tf:Find("title"):GetComponent(typeof(Text))
	arg_2_0.titleTxt.text = i18n("island_book_award_title")
	arg_2_0.closeBtn = arg_2_0._tf:Find("close")

	setActive(arg_2_0._tf:Find("tpl"), false)

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

	return
end

function var_0_0.OnInitItem(arg_7_0, arg_7_1)
	return
end

function var_0_0.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	updateCustomDrop(arg_8_2.transform:Find("drop"), Drop.Create(pg.island_collection_reward[arg_8_0.ids[arg_8_1 + 1]].award_display), {
		style = "island"
	})
	onButton(arg_8_0, arg_8_2.transform, function()
		arg_8_0.contextData:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_0
		})

		return
	end)
	setText(arg_8_2.transform:Find("level"), string.format("%02d", pg.island_collection_reward[arg_8_0.ids[arg_8_1 + 1]].level))
	setText(arg_8_2.transform:Find("desc"), pg.island_collection_reward[arg_8_0.ids[arg_8_1 + 1]].describe)

	local var_8_0 = table.contains(arg_8_0.gotIds, arg_8_0.ids[arg_8_1 + 1])

	setActive(arg_8_2.transform:Find("drop/got"), var_8_0)
	setGray(arg_8_2.transform, not var_8_0, true)

	return
end

function var_0_0.Show(arg_10_0)
	var_0_0.super.Show(arg_10_0)

	local var_10_0 = getProxy(IslandProxy):GetIsland():GetBookAgency()

	arg_10_0.ids = var_10_0:GetPointAwardIds(arg_10_0.contextData.type)
	arg_10_0.gotIds = var_10_0:GetPointAwardGotIds(arg_10_0.contextData.type)

	arg_10_0.scrollRect:SetTotalCount(#arg_10_0.ids, -1)
	pg.UIMgr.GetInstance():BlurPanel(arg_10_0._tf)

	return
end

function var_0_0.Hide(arg_11_0)
	var_0_0.super.Hide(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, arg_11_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_12_0)
	arg_12_0:Hide()
	ClearLScrollrect(arg_12_0.scrollRect)

	return
end

return var_0_0
