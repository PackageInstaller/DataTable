class = var_0_10000

local var_0_0 = "BossRushKurskReScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BossRushKurskScene"))
local var_0_2 = {
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

function var_0_1.getUIName(arg_1_0)
	return "BossRushKurskReUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.ticketText = var_1.Find(var_2_0, "tickets/Text")

	return
end

function var_0_1.SetActivity(arg_3_0, arg_3_1)
	var_0_1.super.SetActivity(arg_3_0, arg_3_1)
	arg_3_0:SetPtActivity(arg_3_0:CreateVirtualPtActivity(arg_3_1))

	return
end

function var_0_1.UpdateBattle(arg_4_0)
	var_0_1.super.UpdateBattle(arg_4_0)

	if arg_4_0.ticketText then
		setText = var_1

		local var_4_0 = arg_4_0.ticketText

		getProxy = var_1_10003
		ChapterProxy = var_1_10004

		local var_4_1 = var_1_10003(var_1_10004).remasterTickets
		local var_4_2 = " / "

		pg = var_1_10005

		var_1(var_4_0, var_4_1 .. var_4_2 .. var_1_10005.gameset.reactivity_ticket_max.key_value)
	end

	return
end

function var_0_1.CreateVirtualPtActivity(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getConfig(var_5_0, "config_client")

	type = var_5_0
	var_5_1 = var_5_0(var_5_1) == "table" and var_5_1 or {}

	local var_5_2

	if not var_5_1.chapter_progress then
		var_5_2 = {}
	end

	local var_5_3 = 0

	ipairs = var_1_10005

	for iter_5_0, iter_5_1 in var_1_10005(arg_5_1:GetActiveSeriesIds()) do
		if arg_5_1:HasPassSeries(iter_5_1) then
			math = var_10

			local var_5_4 = var_10.max
			local var_5_5 = var_5_3
			local var_5_6

			if not var_5_2[iter_5_0] then
				var_5_6 = 0
			end

			var_5_3 = var_5_4(var_5_5, var_5_6)
		end
	end

	local var_5_7 = {
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_3
	}

	pg = var_6

	local var_5_8 = var_6.TimeMgr.GetInstance()

	var_5_7.data2 = var_6.GetServerTime(var_5_8)
	var_5_7.data1_list = {}
	var_5_7.data2_list = {}
	var_5_7.data3_list = {}

	function var_5_7.getDataConfig(arg_6_0, arg_6_1)
		return var_0_2[arg_6_1]
	end

	function var_5_7.isEnd()
		return false
	end

	return var_5_7
end

return var_0_1
