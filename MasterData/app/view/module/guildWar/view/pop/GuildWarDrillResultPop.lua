local var_0_0 = g.core.model.User.guildWarData
local GuildWarDrillResultPop = class("GuildWarDrillResultPop", require("app.fairyGUI.guildWar.UI_GuildWarDrillResultPop"), function()
	return fgui.GComponent:create({
		resName = "GuildWarDrillResultPop",
		pkgPath = "ui/guildWar/guildWar",
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarDrillResultPop:ctor()
	self._groupRankList = {}

	self:_initView()
end

function GuildWarDrillResultPop:_initView()
	self:showAtCenter()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRendererResultList))
end

function GuildWarDrillResultPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onS2CRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onS2CRankList, self)

	if var_0_0:getDrillRankList() == nil then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = g.core.network.proto.GUILD_WAR_PRACTICE_SCORE_CROSS
		})
	else
		self:updateView()
	end
end

function GuildWarDrillResultPop:_onS2CRankList()
	self:updateView()
end

function GuildWarDrillResultPop:updateView()
	self._groupRankList = {}

	for iter_6_0, iter_6_1 in pairs(var_0_0:getDrillRankList() or {}) do
		local var_6_1 = var_0_0:getDrillRankGroup(iter_6_1.rank or 0)

		if self._groupRankList[var_6_1] == nil then
			self._groupRankList[var_6_1] = {}
		end

		table.insert(self._groupRankList[var_6_1], iter_6_1)
	end

	self.m_rankList:setNumItems(#self._groupRankList)
end

function GuildWarDrillResultPop:_onS2CRankList(arg_7_1, arg_7_2, arg_7_3)
	self:updateView()
end

function GuildWarDrillResultPop:_onRendererResultList(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._groupRankList[arg_8_1 + 1], arg_8_1)
end

return GuildWarDrillResultPop
