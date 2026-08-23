local var_0_0 = g.core.model.User.guildData
local GuildMergeApplyPop = class("GuildMergeApplyPop", require("app.fairyGUI.guild.UI_GuildMergeApplyPop"), function()
	return fgui.GComponent:create({
		resName = "GuildMergeApplyPop",
		pkgPath = "ui/guild/guild",
		pkgName = "guild"
	}, ...)
end)

function GuildMergeApplyPop:ctor()
	self._applyList = {}

	self:showAtCenter()
	self:initView()
end

function GuildMergeApplyPop:initView()
	self.m_applyList:setVirtual()
	self.m_applyList:setItemRenderer(handler(self, self._onApplyListRenderer))
	self:newSchedule(handler(self, self._onScheduleUpdateTime), 1)
	self:_onScheduleUpdateTime()
end

function GuildMergeApplyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_NOTIFY, self._onClickClose, self)
end

function GuildMergeApplyPop:_onClickClose()
	if not self._onClose then
		self._onClose = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function GuildMergeApplyPop:getListData()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(var_0_0:getReceiveMergeList()) do
		table.insert(var_6_0, iter_6_1)
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		if arg_7_0.is_confirm == arg_7_1.is_confirm then
			return arg_7_0.merge_time < arg_7_1.merge_time
		end

		return arg_7_0.is_confirm
	end)

	return var_6_0
end

function GuildMergeApplyPop:_onScheduleUpdateTime()
	self._applyList = self:getListData()

	if #self._applyList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_applyList:setNumItems(#self._applyList)
	end
end

function GuildMergeApplyPop:_onApplyListRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateApplyGuild(self._applyList[arg_9_1 + 1])
end

return GuildMergeApplyPop
