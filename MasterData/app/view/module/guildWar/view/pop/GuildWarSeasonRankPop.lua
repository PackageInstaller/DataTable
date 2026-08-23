local var_0_0 = g.core.const.ConstMgr.GuildWarConst
local var_0_1 = g.core.model.User.guildWarData
local var_0_2 = g.core.const.ConstMgr.RankAwardConst
local RankAward = require("app.core.common.RankAward")
local var_0_4 = 0
local GuildWarSeasonRankPop = class("GuildWarSeasonRankPop", require("app.fairyGUI.guildWar.UI_GuildWarSeasonRankPop"), function()
	return fgui.GComponent:create({
		resName = "GuildWarSeasonRankPop",
		pkgPath = "ui/guildWar/guildWar",
		isFullScreen = true,
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarSeasonRankPop:ctor()
	self._curGroupIndex = var_0_1:getCurFightingGroup()
	self._curShowListIndex = 0
	self._groupRankList = {}
	self._groupRewardList = {}
	self._myRank = 0

	self:_initView()
end

function GuildWarSeasonRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onS2CRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self.updateView, self)
	self:updateView()
end

function GuildWarSeasonRankPop:_initView()
	self:getView():center(true)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_4_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_4_1 = self.m_rankList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_4_0.x > 0 then
		var_4_1 = var_4_1 - var_4_0.x * 2
	end

	self.m_rankList:setWidth(var_4_1)
	self.m_rewardList:setWidth(var_4_1)
	self.m_topBg1:setWidth(var_4_1)
	self.m_topBg2:setWidth(var_4_1)
	self.m_downBg:setWidth(var_4_1)
	self.m_showListController:setSelectedIndex(self._curShowListIndex)
	self.m_showListController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowListChanged))
	self.m_showGroupTabController:setSelectedIndex(self._curGroupIndex - 1)
	self.m_showGroupTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowTabChanged))
	self.m_topBar:setResInfoById(var_0_0.HELP_ID)
	self.m_rankList:setVirtual()
	self.m_rankList:doFairyBatching(false)
	self.m_rankList:setItemRenderer(handler(self, self._onRendererRankList))
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardList))
	self.m_rewardTip:setText(g.core.lang:get(308668, {
		num = var_0_1:getSeasonAward()
	}))
end

function GuildWarSeasonRankPop:_onShowListChanged()
	local var_5_0 = self.m_showListController:getSelectedIndex()

	if var_5_0 == self._curShowListIndex then
		return
	end

	self._curShowListIndex = var_5_0

	self:updateView()
end

function GuildWarSeasonRankPop:_onShowTabChanged()
	local var_6_0 = self.m_showGroupTabController:getSelectedIndex() + 1

	if var_6_0 == self._curGroupIndex then
		return
	end

	self._curGroupIndex = var_6_0

	self:updateView()
end

function GuildWarSeasonRankPop:updateView()
	if self._curShowListIndex == var_0_4 then
		self:updateRankView()
	else
		self:updateRewardView()
	end
end

function GuildWarSeasonRankPop:_onS2CRankList(arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_3 then
		return
	end

	self:updateView()
end

function GuildWarSeasonRankPop:updateRankView()
	local var_9_0, var_9_1 = var_0_1:getFightRankList(self._curGroupIndex)

	if var_9_0 == nil then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = var_9_1
		})
	else
		if self._groupRewardList[self._curGroupIndex] == nil then
			self._groupRewardList[self._curGroupIndex] = RankAward:getRankAwardArray(var_0_2["GUILD_WAR_SEASON_" .. self._curGroupIndex])
		end

		self._groupRankList[self._curGroupIndex] = var_9_0

		self.m_rankList:setNumItems(#var_9_0)

		local var_9_2 = var_0_1:getMyFightRank()

		if var_9_2 > 0 then
			self.m_rankValue:setText(var_0_1:getRankStrByGroup(var_0_1:getCurFightingGroup(), var_9_2))
			self.m_hasRankController:setSelectedIndex(1)
		else
			self.m_hasRankController:setSelectedIndex(0)
		end

		if #var_9_0 > 0 then
			self.m_isEmptyController:setSelectedIndex(1)
			self.m_rankList:transitionShowCells("enter_left", 0.03)
		else
			self.m_isEmptyController:setSelectedIndex(0)
		end
	end
end

function GuildWarSeasonRankPop:updateRewardView()
	local var_10_0 = self._groupRewardList[self._curGroupIndex]

	if self._groupRewardList[self._curGroupIndex] == nil then
		var_10_0 = RankAward:getRankAwardArray(var_0_2["GUILD_WAR_SEASON_" .. self._curGroupIndex])
		self._groupRewardList[self._curGroupIndex] = var_10_0
	end

	self.m_rewardList:setNumItems(#var_10_0)
	self.m_rewardList:transitionShowCells("enter_left", 0.03)
end

function GuildWarSeasonRankPop:_onRendererRankList(arg_11_1, arg_11_2)
	if self._groupRankList[self._curGroupIndex][arg_11_1 + 1] then
		local var_11_0

		for iter_11_0, iter_11_1 in pairs(self._groupRewardList[self._curGroupIndex]) do
			if self._groupRankList[self._curGroupIndex][arg_11_1 + 1].rank >= iter_11_1.minRank and self._groupRankList[self._curGroupIndex][arg_11_1 + 1].rank <= iter_11_1.maxRank then
				var_11_0 = iter_11_1

				break
			end
		end

		arg_11_2:update({
			rankData = self._groupRankList[self._curGroupIndex][arg_11_1 + 1],
			rewardData = var_11_0
		})
		arg_11_2:setCtrlState("isShowBg", {
			index = arg_11_1 % 2 ~= 0 and 1 or 0
		})
	end
end

function GuildWarSeasonRankPop:_onRendererRewardList(arg_12_1, arg_12_2)
	if self._groupRewardList[self._curGroupIndex][arg_12_1 + 1] then
		arg_12_2:update({
			rewardData = self._groupRewardList[self._curGroupIndex][arg_12_1 + 1]
		})
		arg_12_2:setCtrlState("isShowBg", {
			index = arg_12_1 % 2 ~= 0 and 1 or 0
		})
	end
end

return GuildWarSeasonRankPop
