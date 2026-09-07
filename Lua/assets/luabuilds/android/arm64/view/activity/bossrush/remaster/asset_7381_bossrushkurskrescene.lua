local BossRushKurskReScene = class("BossRushKurskReScene", import("..BossRushKurskScene"))
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

function BossRushKurskReScene:getUIName()
	return "BossRushKurskReUI"
end

function BossRushKurskReScene:init()
	BossRushKurskReScene.super.init(self)

	self.ticketText = self._tf:Find("tickets/Text")

	return
end

function BossRushKurskReScene:SetActivity(arg_3_1)
	BossRushKurskReScene.super.SetActivity(self, arg_3_1)
	self:SetPtActivity(self:CreateVirtualPtActivity(arg_3_1))

	return
end

function BossRushKurskReScene:UpdateBattle()
	BossRushKurskReScene.super.UpdateBattle(self)

	if self.ticketText then
		setText(self.ticketText, getProxy(ChapterProxy).remasterTickets .. " / " .. pg.gameset.reactivity_ticket_max.key_value)
	end

	return
end

function BossRushKurskReScene:CreateVirtualPtActivity(arg_5_1)
	local var_5_0 = arg_5_1:getConfig("config_client")

	var_5_0 = type(var_5_0) == "table" and var_5_0 or {}

	local var_5_1 = var_5_0.chapter_progress or {}
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_1:GetActiveSeriesIds()) do
		if arg_5_1:HasPassSeries(iter_5_1) then
			var_5_2 = math.max(var_5_2, var_5_1[iter_5_0] or 0)
		end
	end

	local var_5_4 = {
		data3 = 0,
		id = arg_5_1.id,
		data1 = var_5_2
	}

	var_5_4.data2 = pg.TimeMgr.GetInstance():GetServerTime()
	var_5_4.data1_list = {}
	var_5_4.data2_list = {}
	var_5_4.data3_list = {}

	function var_5_4.getDataConfig(arg_6_0, arg_6_1)
		return var_0_1[arg_6_1]
	end

	function var_5_4.isEnd()
		return false
	end

	return var_5_4
end

return BossRushKurskReScene
