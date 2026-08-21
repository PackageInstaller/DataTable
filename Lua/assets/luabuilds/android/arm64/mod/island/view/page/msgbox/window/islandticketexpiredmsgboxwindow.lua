local var_0_0 = class("IslandTicketExpiredMsgBoxWindow", import(".IslandCommonMsgboxWindow"))

var_0_0.TYPES = {
	EXPIRED = 1,
	REMIND = 2
}

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForTicketExpired"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.contentText = arg_2_0._tf:Find("Text")
	arg_2_0.scrollRect = arg_2_0._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	arg_2_0.cards = {}

	return
end

function var_0_0.OnShow(arg_5_0)
	var_0_0.super.OnShow(arg_5_0)
	arg_5_0:FlushInfo()

	return
end

function var_0_0.FlushBtn(arg_6_0, arg_6_1)
	setActive(arg_6_0.cancelBtn, false)
	setActive(arg_6_0.confirmBtn, true)

	arg_6_0.confirmTxt.text = i18n("word_ok")

	return
end

function var_0_0.OnInitItem(arg_7_0, arg_7_1)
	arg_7_0.cards[arg_7_1] = IslandTicketCard.New(arg_7_1)

	return
end

function var_0_0.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.cards[arg_8_2] then
		arg_8_0:OnInitItem(arg_8_2)
	end

	arg_8_0.cards[arg_8_2]:Update(arg_8_0.displays[arg_8_1 + 1])

	return
end

function var_0_0.FlushInfo(arg_9_0)
	local var_9_0 = arg_9_0.settings.body

	if arg_9_0.settings.body.type == var_0_0.TYPES.EXPIRED then
		setText(arg_9_0.contentText, i18n("island_ticket_expiration_tip2"))
	elseif var_9_0.type == var_0_0.TYPES.REMIND then
		setText(arg_9_0.contentText, i18n("island_ticket_expiration_tip1"))
	end

	arg_9_0.displays = var_9_0.tickets

	arg_9_0.scrollRect:SetTotalCount(#arg_9_0.displays, -1)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	ClearLScrollrect(arg_10_0.scrollRect)

	if arg_10_0.cards then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.cards) do
			iter_10_1:Dispose()
		end

		arg_10_0.cards = nil
	end

	return
end

return var_0_0
