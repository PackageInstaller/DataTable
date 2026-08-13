class = var_0_10000

local var_0_0 = "IslandTicketGroupCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandTicketCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	setActive = var_2

	var_2(arg_1_0.validTimeTF, false)

	setActive = var_2

	var_2(arg_1_0.expiredTF, false)

	local var_1_0 = arg_1_0._tf

	arg_1_0.selectedPanel = var_2.Find(var_1_0, "icon_bg/selected_panel")

	local var_1_1 = arg_1_0.selectedPanel

	arg_1_0.countInput = var_2.Find(var_1_1, "InputField")

	local var_1_2 = arg_1_0.selectedPanel

	arg_1_0.reduceBtn = var_2.Find(var_1_2, "reduce")

	local var_1_3 = arg_1_0._tf

	arg_1_0.emptyTF = var_2.Find(var_1_3, "empty")

	local var_1_4 = arg_1_0.emptyTF

	arg_1_0.shopBtn = var_2.Find(var_1_4, "Image")
	setText = var_2

	local var_1_5 = arg_1_0.shopBtn
	local var_1_6 = var_4.Find(var_1_5, "Text")

	i18n = var_5

	var_2(var_1_6, var_5("island_ticket_shop"))

	return
end

function var_0_1.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.group = arg_2_1
	arg_2_0.allCnt = arg_2_3
	setActive = var_1_10005

	var_1_10005(arg_2_0.emptyTF, arg_2_0.allCnt == 0)

	arg_2_0.tickets = arg_2_2
	underscore = var_1_10005

	local var_2_0 = var_1_10005.reduce(arg_2_0.tickets, 0, function(arg_3_0, arg_3_1)
		local var_3_0

		if not arg_3_1:WillExpire() or not arg_3_1:GetCount() then
			var_3_0 = 0
		end

		return arg_3_0 + var_3_0
	end)
	local var_2_1 = arg_2_0.willExpireTxt

	i18n = var_7
	var_2_1.text = var_7("island_ticket_nearing_expiration", var_2_0)
	setActive = var_2_1

	var_2_1(arg_2_0.willExpireTF, var_2_0 > 0)

	local var_2_2

	if not arg_2_0.tickets[1] then
		IslandTicket = var_2_2
		var_2_2 = var_2_2.New
		pg = var_8
		var_2_2 = var_2_2(var_8.island_speedup_ticket.get_id_list_by_speedup_time[arg_2_1][1], 0, 1)
	end

	arg_2_0.showTicket = var_2_2
	setText = var_2_2

	local var_2_3 = arg_2_0.nameTF
	local var_2_4 = arg_2_0.showTicket

	var_2_2(var_2_3, var_9.getConfig(var_2_4, "name"))

	GetImageSpriteFromAtlasAsync = var_2_2

	local var_2_5 = "island/islandframe"
	local var_2_6 = arg_2_0.showTicket

	var_2_2(var_2_5, var_9.GetFrameName(var_2_6), arg_2_0.frameTF, true)

	GetImageSpriteFromAtlasAsync = var_2_2

	local var_2_7 = "ui/islandticketui_atlas"
	local var_2_8 = arg_2_0.showTicket

	var_2_2(var_2_7, var_9.GetBgName(var_2_8), arg_2_0.bgTF, true)

	GetImageSpriteFromAtlasAsync = var_2_2

	local var_2_9 = arg_2_0.showTicket

	var_2_2(var_8.GetIconName(var_2_9), "", arg_2_0.iconTF, true)
	arg_2_0:UpdateSelCnt(arg_2_4)

	return
end

function var_0_1.UpdateSelCnt(arg_4_0, arg_4_1)
	arg_4_0.selCnt = arg_4_1
	setInputText = var_1_10002

	var_1_10002(arg_4_0.countInput, arg_4_0.selCnt)

	setText = var_1_10002

	var_1_10002(arg_4_0.countTF, arg_4_0.allCnt - arg_4_0.selCnt)

	setActive = var_1_10002

	var_1_10002(arg_4_0.selectedPanel, arg_4_0.selCnt > 0)

	return
end

return var_0_1
