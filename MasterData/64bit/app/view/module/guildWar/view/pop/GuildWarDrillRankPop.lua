local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.const.ConstMgr.GuildWarConst
local var_0_2 = g.core.const.ConstMgr.RankAwardConst
local RankAward = require("app.core.common.RankAward")
local var_0_4 = g.core.network.proto
local var_0_5 = 0
local GuildWarDrillRankPop = class("GuildWarDrillRankPop", require("app.fairyGUI.guildWar.UI_GuildWarDrillRankPop"), function()
	return fgui.GComponent:create({
		pkgName = "guildWar",
		isFullScreen = true,
		pkgPath = "ui/guildWar/guildWar",
		resName = "GuildWarDrillRankPop"
	}, ...)
end)

function GuildWarDrillRankPop:ctor()
	self._rankList = {}
	self._rewardList = {}
	self._curShowListIndex = 0
	self._myGroup = 0
	self._myRank = 0

	self:_initData()
	self:_initView()
end

function GuildWarDrillRankPop:_initData()
	self._rewardList = RankAward:getRankAwardArray(var_0_2.GUILD_WAR_DRILL)
end

function GuildWarDrillRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onS2CRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onS2CRankList, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 100,
		id = var_0_4.GUILD_WAR_PRACTICE_SCORE_CROSS
	})
end

function GuildWarDrillRankPop:_initView()
	self:getView():center(true)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_5_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_5_1 = self.m_rankList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_5_0.x > 0 then
		var_5_1 = var_5_1 - var_5_0.x * 2
	end

	self.m_rankList:setWidth(var_5_1)
	self.m_rewardList:setWidth(var_5_1)
	self.m_topBg1:setWidth(var_5_1)
	self.m_topBg2:setWidth(var_5_1)
	self.m_downBg:setWidth(var_5_1)
	self.m_showListController:setSelectedIndex(self._curShowListIndex)
	self.m_showListController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowListChanged))
	self.m_topBar:setResInfoById(var_0_1.HELP_ID)
	self.m_rankList:setVirtual()
	self.m_rankList:doFairyBatching(false)
	self.m_rankList:setItemRenderer(handler(self, self._onRendererRankList))
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardList))
	self.m_rewardTip:setText(g.core.lang:get(308666, {
		num = var_0_0:getTestAward()
	}))
end

function GuildWarDrillRankPop:_onShowListChanged()
	local var_6_0 = self.m_showListController:getSelectedIndex()

	if var_6_0 == self._curShowListIndex then
		return
	end

	self._curShowListIndex = var_6_0

	self:updateView()
end

function GuildWarDrillRankPop:updateView()
	if self._curShowListIndex == var_0_5 then
		self:updateRankView()
	else
		self:updateRewardView()
	end

	local var_7_0 = var_0_0:getDrillRank()

	if var_7_0 > 0 then
		self.m_hasRankController:setSelectedIndex(1)
		self.m_rankValueText:setText(var_7_0)
	else
		self.m_hasRankController:setSelectedIndex(0)
	end
end

function GuildWarDrillRankPop:_onS2CRankList(arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_3 then
		return
	end

	self._rankList = arg_8_3.rank_units or {}

	if self._curShowListIndex == var_0_5 then
		self:updateView()
	end
end

function GuildWarDrillRankPop:updateRankView()
	self.m_rankList:setNumItems(#self._rankList)

	if #self._rankList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_rankList:transitionShowCells("enter_left", 0.03)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function GuildWarDrillRankPop:updateRewardView()
	self.m_rewardList:setNumItems(#self._rewardList)
	self.m_rewardList:transitionShowCells("enter_left", 0.03)
end

function GuildWarDrillRankPop:_onRendererRankList(arg_11_1, arg_11_2)
	local var_11_0

	for iter_11_0, iter_11_1 in pairs(self._rewardList) do
		if self._rankList[arg_11_1 + 1].rank >= iter_11_1.minRank and self._rankList[arg_11_1 + 1].rank <= iter_11_1.maxRank then
			var_11_0 = iter_11_1

			break
		end
	end

	arg_11_2:update({
		rankData = self._rankList[arg_11_1 + 1],
		rewardData = var_11_0
	})
	arg_11_2:setCtrlState("isShowBg", {
		index = arg_11_1 % 2 ~= 0 and 1 or 0
	})
end

function GuildWarDrillRankPop:_onRendererRewardList(arg_12_1, arg_12_2)
	arg_12_2:update({
		rewardData = self._rewardList[arg_12_1 + 1],
		index = arg_12_1
	})
	arg_12_2:setCtrlState("isShowBg", {
		index = arg_12_1 % 2 ~= 0 and 1 or 0
	})
end

return GuildWarDrillRankPop
