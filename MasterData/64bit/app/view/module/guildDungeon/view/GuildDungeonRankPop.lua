local GuildDungeonRankPop = class("GuildDungeonRankPop", require("app.fairyGUI.guildDungeon.UI_GuildDungeonRankPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guildDungeon/guildDungeon",
		resName = "GuildDungeonRankPop",
		pkgName = "guildDungeon",
		isFullScreen = true
	})
end)
local RankAward = require("app.core.common.RankAward")
local var_0_2 = g.core.model.User.guildDungeonData

function GuildDungeonRankPop:ctor()
	self._myRank = 0
	self._tab = 0
	self._rankData = {}
	self._awardArr = RankAward:getRankAwardArray(g.core.const.ConstMgr.RankAwardConst.GUILD_DUNGEON)

	self:_initUI()
end

function GuildDungeonRankPop:_initUI()
	self.m_topBar:setResInfoById(27)
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_rankList:setVirtual(self)
	self.m_rankList:setItemProvider(handler(self, self._onRankItemProvider))
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRenderer))
end

function GuildDungeonRankPop:_onRankItemProvider(arg_4_1)
	if self._tab == 0 then
		return "ui://guildDungeon/GuildDungeonRankCell"
	else
		return "ui://guildDungeon/GuildDungeonAwardCell"
	end
end

function GuildDungeonRankPop:_onRankItemRenderer(arg_5_1, arg_5_2)
	local var_5_0 = {}

	var_5_0 = self._tab == 0 and self._rankData[arg_5_1 + 1] or self._awardArr[arg_5_1 + 1]

	arg_5_2:updateCell({
		rank = arg_5_1 + 1,
		data = var_5_0
	})
end

function GuildDungeonRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._switchTab, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 30,
		id = g.core.network.proto.GUILD_DUNGEON_DAMAGE
	})
end

function GuildDungeonRankPop:_onRcvRank(arg_7_1, arg_7_2, arg_7_3)
	self._rankData = arg_7_3.rank_units or {}
	self._myRank = arg_7_3.self_rank or 0

	self.m_numTxt:setText(self._myRank)
	self.m_chapterTxt:setText(g.core.lang:get(306004, {
		rebirth = var_0_2:getRebirth(),
		chapter = var_0_2:getCurChapterId()
	}))
	self:_switchTab()
end

function GuildDungeonRankPop:_switchTab()
	self._tab = self.m_tabController:getSelectedIndex()

	if self._tab == 0 then
		self.m_rankList:setNumItems(#self._rankData)

		if #self._rankData > 0 then
			self.m_emptyComp:setVisible(false)
		else
			self.m_emptyComp:setVisible(true)
		end
	else
		self.m_emptyComp:setVisible(false)
		self.m_rankList:setNumItems(#self._awardArr)
	end
end

function GuildDungeonRankPop:_onChangeTabCtrl()
	self:_switchTab()
end

return GuildDungeonRankPop
