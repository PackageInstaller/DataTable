local var_0_0 = g.core.model.User.guildWorshipData
local var_0_1 = g.core.model.User.guildData
local GuildContributePop = class("GuildContributePop", require("app.fairyGUI.guild.UI_GuildContributePop"), function()
	return fgui.GComponent:create({
		resName = "GuildContributePop",
		pkgPath = "ui/guild/guild",
		pkgName = "guild"
	}, ...)
end)

function GuildContributePop:ctor(arg_2_1)
	self._memberData = {}

	self:showAtCenter()
	self.m_memberList:setVirtual()
	self.m_memberList:setItemRendererAsync1(handler(self, self._onMemberItemRenderer), 0.1)
	var_0_0:resetGuildPlayerSendGiftRecord()
end

function GuildContributePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_SENDGIFT, self._onRcvSendGift, self)
	self:_updateView()
end

function GuildContributePop:_updateView()
	self.m_countNumTxt:setText(g.core.model.User:getSendCount() .. "/" .. (var_0_1:getCfg().gift_send_num or 0))
	self:_updateGuildMemberList()
end

function GuildContributePop:_updateGuildMemberList()
	local var_5_0 = var_0_0:getSendGiftMemberData()

	self._memberData = var_5_0

	self.m_memberList:setNumItems(#var_5_0)
end

function GuildContributePop:_onMemberItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateInfo(arg_6_1, self._memberData[arg_6_1 + 1], (var_0_1:canSendGift()))
end

function GuildContributePop:_onRcvSendGift(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_3.awards
	local var_7_1

	if not arg_7_3.awards then
		var_7_0 = {}
		var_7_1 = require("app.view.base.show.BaseFeedBackPopNew").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		data = {
			id = arg_7_3.member_id,
			awardData = var_7_0
		},
		title = g.core.lang:get(109611),
		showComp = fgui.UIPackage:createObject("guild", "GuildSendGiftSuccessComp")
	}), {
		touchDisappear = true,
		hideContinue = false
	})
	var_0_0:setCurGuildPlayerSendGiftRecord(g.core.model.User.guildData:getGuildMemberByPlayerId(arg_7_3.member_id).user.guild_id, arg_7_3.member_id)
	self:_updateView()
	self:dispatchCompEvent("send_gift_award_receive", {})
end

return GuildContributePop
