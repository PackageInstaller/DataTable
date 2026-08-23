local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.GuildFightData
local GuildFightRankPop = class("GuildFightRankPop", require("app.fairyGUI.guildFight.UI_GuildFightRankPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guildFight/guildFight",
		resName = "GuildFightRankPop",
		pkgName = "guildFight",
		isFullScreen = true
	}, ...)
end)

function GuildFightRankPop:ctor(arg_2_1)
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self:showAtCenter()

	self._curTabIndex = 0
	self._rankListData = {}
	self._rankAwardsData = var_0_3:getRankAwardInfo()
	self._selfRank = 0

	self.m_guildRankList:setVirtual()
	self.m_guildRankList:doFairyBatching(false)
	self.m_guildRankList:setItemRendererAsync(handler(self, self._onRankListRenderer))
	self.m_awardRankList:setVirtual()
	self.m_awardRankList:doFairyBatching(false)
	self.m_awardRankList:setItemRendererAsync(handler(self, self._onAwardListRenderer))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_topBar:setResInfoById(28)
end

function GuildFightRankPop:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvGetRank, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onRcvGetRank, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 50,
		id = g.core.network.proto.GUILD_BATTLE_SCORE_CROSS
	})
end

function GuildFightRankPop:_onRcvGetRank()
	self._rankListData = var_0_3:getRankList()
	self._selfRank = var_0_3:getSelfRank()

	self:_updateCurView()
end

function GuildFightRankPop:_onChangeTabCtrl()
	self._curTabIndex = self.m_tabController:getSelectedIndex()

	self:_updateCurView()
end

function GuildFightRankPop:_updateCurView()
	local var_6_0 = self._selfRank == 0 and g.core.lang:get(109809) or self._selfRank

	if self._curTabIndex == 0 then
		self.m_guildRankList:setNumItems(#self._rankListData)
	else
		self.m_awardRankList:setNumItems(#self._rankAwardsData)
	end

	self.m_myRankTxt:setText(var_6_0)
end

function GuildFightRankPop:_onRankListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell({
		data = self._rankListData[arg_7_1 + 1],
		index = arg_7_1 + 1
	})
end

function GuildFightRankPop:_onAwardListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell({
		index = arg_8_1 + 1
	})
end

return GuildFightRankPop
