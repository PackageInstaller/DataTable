class = var_0_10000

local var_0_0 = "IslandTicketExpiredMsgBoxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCommonMsgboxWindow"))

var_0_1.TYPES = {
	EXPIRED = 1,
	REMIND = 2
}

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForTicketExpired"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.contentText = var_1.Find(var_2_0, "Text")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "scrollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_2, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	arg_2_0.cards = {}

	return
end

function var_0_1.OnShow(arg_5_0)
	var_0_1.super.OnShow(arg_5_0)
	arg_5_0:FlushInfo()

	return
end

function var_0_1.FlushBtn(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0.cancelBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_6_0.confirmBtn, true)

	local var_6_0 = arg_6_0.confirmTxt

	i18n = var_1_10003
	var_6_0.text = var_1_10003("word_ok")

	return
end

function var_0_1.OnInitItem(arg_7_0, arg_7_1)
	IslandTicketCard = var_1_10002

	local var_7_0 = var_1_10002.New(arg_7_1)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_1.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if not arg_8_0.cards[arg_8_2] then
		arg_8_0:OnInitItem(arg_8_2)

		var_8_0 = arg_8_0.cards[arg_8_2]
	end

	local var_8_1 = arg_8_0.displays[arg_8_1 + 1]

	var_8_0:Update(var_8_1)

	return
end

function var_0_1.FlushInfo(arg_9_0)
	if arg_9_0.settings.body.type == var_0_1.TYPES.EXPIRED then
		setText = var_2

		local var_9_0 = arg_9_0.contentText

		i18n = var_1_10005

		var_2(var_9_0, var_1_10005("island_ticket_expiration_tip2"))
	elseif var_1.type == var_0_1.TYPES.REMIND then
		setText = var_2

		local var_9_1 = arg_9_0.contentText

		i18n = var_1_10005

		var_2(var_9_1, var_1_10005("island_ticket_expiration_tip1"))
	end

	arg_9_0.displays = var_1.tickets

	local var_9_2 = arg_9_0.scrollRect

	var_2.SetTotalCount(var_9_2, #arg_9_0.displays, -1)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_10_0.scrollRect)

	if arg_10_0.cards then
		pairs = var_1

		for iter_10_0, iter_10_1 in var_1(arg_10_0.cards) do
			iter_10_1:Dispose()
		end

		arg_10_0.cards = nil
	end

	return
end

return var_0_1
