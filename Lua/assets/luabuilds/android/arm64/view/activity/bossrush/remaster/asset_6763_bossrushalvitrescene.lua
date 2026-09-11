local BossRushAlvitReScene = class("BossRushAlvitReScene", import("view.activity.BossRush.Alvit.BossRushAlvitScene"))
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

function BossRushAlvitReScene:getUIName()
	return "BossRushAlvitReUI"
end

function BossRushAlvitReScene:init()
	BossRushAlvitReScene.super.init(self)

	self.ticketText = self._tf:Find("tickets/Text")

	return
end

function BossRushAlvitReScene:SetActivity(arg_3_1)
	BossRushAlvitReScene.super.SetActivity(self, arg_3_1)
	self:SetPtActivity(self:CreateVirtualPtActivity(arg_3_1))

	return
end

function BossRushAlvitReScene:UpdateBattle()
	BossRushAlvitReScene.super.UpdateBattle(self)

	if self.ticketText then
		setText(self.ticketText, getProxy(ChapterProxy).remasterTickets .. " / " .. pg.gameset.reactivity_ticket_max.key_value)
	end

	return
end

function BossRushAlvitReScene:UpdateStoryTask()
	return
end

function BossRushAlvitReScene:UpdateTpTip()
	setActive(self.ptTip, false)

	return
end

function BossRushAlvitReScene:onBackPressed()
	self:emit(BaseUI.ON_BACK)

	return
end

function BossRushAlvitReScene:CreateVirtualPtActivity(arg_8_1)
	local var_8_0 = arg_8_1:getConfig("config_client")

	var_8_0 = type(var_8_0) == "table" and var_8_0 or {}

	local var_8_1 = var_8_0.chapter_progress or {}
	local var_8_2 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1:GetActiveSeriesIds()) do
		if arg_8_1:HasPassSeries(iter_8_1) then
			var_8_2 = math.max(var_8_2, var_8_1[iter_8_0] or 0)
		end
	end

	local var_8_4 = {
		data3 = 0,
		id = arg_8_1.id,
		data1 = var_8_2
	}

	var_8_4.data2 = pg.TimeMgr.GetInstance():GetServerTime()
	var_8_4.data1_list = {}
	var_8_4.data2_list = {}
	var_8_4.data3_list = {}

	function var_8_4.getDataConfig(arg_9_0, arg_9_1)
		return var_0_1[arg_9_1]
	end

	function var_8_4.isEnd()
		return false
	end

	return var_8_4
end

return BossRushAlvitReScene
