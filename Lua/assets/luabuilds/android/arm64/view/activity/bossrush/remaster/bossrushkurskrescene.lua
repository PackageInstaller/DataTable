local var_0_0 = class("BossRushKurskReScene", import("..BossRushKurskScene"))
local var_0_1 = {
	unlock_story = "",
	type = 1,
	pic_list = "",
	pt_list = "",
	id_2 = 0,
	link_id = 0,
	convert_pay = "",
	buff_time = "stop",
	end_time = "",
	drop_display = "",
	drop_client = {
		{
			1,
			1,
			0
		}
	},
	target = {
		999999999
	},
	day_unlock = {
		0
	},
	allplayer = {},
	target_buff = {},
	buff_group = {}
}

function var_0_0.getUIName(arg_1_0)
	return "BossRushKurskReUI"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.ticketText = arg_2_0._tf:Find("tickets/Text")

	return
end

function var_0_0.SetActivity(arg_3_0, arg_3_1)
	var_0_0.super.SetActivity(arg_3_0, arg_3_1)
	arg_3_0:SetPtActivity(arg_3_0:CreateVirtualPtActivity(arg_3_1))

	return
end

function var_0_0.UpdateBattle(arg_4_0)
	var_0_0.super.UpdateBattle(arg_4_0)

	if arg_4_0.ticketText then
		setText(arg_4_0.ticketText, getProxy(ChapterProxy).remasterTickets .. " / " .. pg.gameset.reactivity_ticket_max.key_value)
	end

	return
end

function var_0_0.CreateVirtualPtActivity(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getConfig("config_client")

	var_5_0 = type(var_5_0) == "table" and var_5_0 or {}

	local var_5_1 = var_5_0.chapter_progress or {}
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_1:GetActiveSeriesIds()) do
		if arg_5_1:HasPassSeries(iter_5_1) then
			local var_5_4 = var_5_1[iter_5_0] or 0

			var_5_2 = math.max(var_5_2, var_5_4)
		end
	end

	;({
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_2
	}).data2 = pg.TimeMgr.GetInstance():GetServerTime()
	;({
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_2
	}).data1_list = {}
	;({
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_2
	}).data2_list = {}
	;({
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_2
	}).data3_list = {}
	;({
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_2
	}).getDataConfig = function(arg_6_0, arg_6_1)
		return var_0_1[arg_6_1]
	end
	;({
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_2
	}).isEnd = function()
		return false
	end

	return {
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_2
	}
end

return var_0_0
