local var_0_0 = class("IslandTicketGroupCard", import(".IslandTicketCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
	setActive(arg_1_0.validTimeTF, false)
	setActive(arg_1_0.expiredTF, false)

	arg_1_0.selectedPanel = arg_1_0._tf:Find("icon_bg/selected_panel")
	arg_1_0.countInput = arg_1_0.selectedPanel:Find("InputField")
	arg_1_0.reduceBtn = arg_1_0.selectedPanel:Find("reduce")
	arg_1_0.emptyTF = arg_1_0._tf:Find("empty")
	arg_1_0.shopBtn = arg_1_0.emptyTF:Find("Image")

	setText(arg_1_0.shopBtn:Find("Text"), i18n("island_ticket_shop"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.group = arg_2_1
	arg_2_0.allCnt = arg_2_3

	setActive(arg_2_0.emptyTF, arg_2_0.allCnt == 0)

	arg_2_0.tickets = arg_2_2

	local var_2_0 = underscore.reduce(arg_2_0.tickets, 0, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_1:WillExpire() and arg_3_1:GetCount() or 0

		return arg_3_0 + var_3_0
	end)

	arg_2_0.willExpireTxt.text = i18n("island_ticket_nearing_expiration", var_2_0)

	setActive(arg_2_0.willExpireTF, var_2_0 > 0)

	arg_2_0.showTicket = arg_2_0.tickets[1] or IslandTicket.New(pg.island_speedup_ticket.get_id_list_by_speedup_time[arg_2_1][1], 0, 1)

	setText(arg_2_0.nameTF, arg_2_0.showTicket:getConfig("name"))
	GetImageSpriteFromAtlasAsync("island/islandframe", arg_2_0.showTicket:GetFrameName(), arg_2_0.frameTF, true)
	GetImageSpriteFromAtlasAsync("ui/islandticketui_atlas", arg_2_0.showTicket:GetBgName(), arg_2_0.bgTF, true)
	GetImageSpriteFromAtlasAsync(arg_2_0.showTicket:GetIconName(), "", arg_2_0.iconTF, true)
	arg_2_0:UpdateSelCnt(arg_2_4)

	return
end

function var_0_0.UpdateSelCnt(arg_4_0, arg_4_1)
	arg_4_0.selCnt = arg_4_1

	setInputText(arg_4_0.countInput, arg_4_0.selCnt)
	setText(arg_4_0.countTF, arg_4_0.allCnt - arg_4_0.selCnt)
	setActive(arg_4_0.selectedPanel, arg_4_0.selCnt > 0)

	return
end

return var_0_0
