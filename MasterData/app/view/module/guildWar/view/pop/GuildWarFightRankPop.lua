local var_0_0 = g.core.config.guild_war_info
local var_0_1 = g.core.model.User.guildWarData
local var_0_2 = g.core.const.ConstMgr.GuildWarConst
local var_0_3 = 0
local GuildWarFightRankPop = class("GuildWarFightRankPop", require("app.fairyGUI.guildWar.UI_GuildWarFightRankPop"), function()
	return fgui.GComponent:create({
		resName = "GuildWarFightRankPop",
		pkgPath = "ui/guildWar/guildWar",
		isFullScreen = true,
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarFightRankPop:ctor(arg_2_1)
	self._rankList = arg_2_1 or {}
	self._rewardList = {}
	self._curShowListIndex = 0
	self._myGroup = var_0_1:getCurFightingGroup()
	self._myRank = 0

	self:_initData()
	self:_initView()
end

function GuildWarFightRankPop:_initData()
	local var_3_0 = var_0_0.get(101)
	local var_3_1 = "king_"

	if self._myGroup == var_0_2.GROUP_INDEX.MASTER then
		var_3_1 = "master_"
	elseif self._myGroup == var_0_2.GROUP_INDEX.ELITE then
		var_3_1 = "elite_"
	end

	self._rewardList[1] = g.core.common.Drops:getGoodsArray(var_3_0[var_3_1 .. "first_reward"])
	self._rewardList[2] = g.core.common.Drops:getGoodsArray(var_3_0[var_3_1 .. "second_reward"])
	self._rewardList[3] = g.core.common.Drops:getGoodsArray(var_3_0[var_3_1 .. "third_reward"])
end

function GuildWarFightRankPop:onLoad()
	self:updateView()
end

function GuildWarFightRankPop:_initView()
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
	self.m_topBar:setResInfoById(var_0_2.HELP_ID)
	self.m_rankList:setVirtual()
	self.m_rankList:doFairyBatching(false)
	self.m_rankList:setItemRenderer(handler(self, self._onRendererRankList))
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardList))
	self.m_rewardTip:setText(g.core.lang:get(308667, {
		num = var_0_1:getBattleAward()
	}))
end

function GuildWarFightRankPop:_onShowListChanged()
	local var_6_0 = self.m_showListController:getSelectedIndex()

	if var_6_0 == self._curShowListIndex then
		return
	end

	self._curShowListIndex = var_6_0

	self:updateView()
end

function GuildWarFightRankPop:updateView()
	if self._curShowListIndex == var_0_3 then
		self:updateRankView()
	else
		self:updateRewardView()
	end
end

function GuildWarFightRankPop:updateRankView()
	local var_8_0 = var_0_1:getAllGuildStructArr()

	table.sort(var_8_0, var_0_1:getGuildStructSortFunc())

	self._rankList = var_8_0

	self.m_rankList:setNumItems(#self._rankList)
	self.m_rankList:transitionShowCells("enter_left", 0.03)
	self.m_isEmptyController:setSelectedIndex(#self._rankList == 0 and 0 or 1)

	local var_8_1 = var_0_1:getMyFightRank()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1:isMyGuild() then
			var_8_1 = 1

			break
		end
	end

	if var_8_1 > 0 then
		self.m_rankValue:setText(g.core.lang:get(308658, {
			rank = var_8_1
		}))
		self.m_hasRankController:setSelectedIndex(1)
	else
		self.m_hasRankController:setSelectedIndex(0)
	end
end

function GuildWarFightRankPop:updateRewardView()
	self.m_rewardList:setNumItems(#self._rewardList)
	self.m_rewardList:transitionShowCells("enter_left", 0.03)
end

function GuildWarFightRankPop:_onRendererRankList(arg_10_1, arg_10_2)
	arg_10_2:update({
		rankData = self._rankList[arg_10_1 + 1],
		rewardData = self._rewardList[arg_10_1 + 1]
	}, arg_10_1)
	arg_10_2:setCtrlState("isShowBg", {
		index = arg_10_1 % 2 ~= 0 and 1 or 0
	})
end

function GuildWarFightRankPop:_onRendererRewardList(arg_11_1, arg_11_2)
	arg_11_2:update({
		rewardData = self._rewardList[arg_11_1 + 1],
		index = arg_11_1
	})
	arg_11_2:setCtrlState("isShowBg", {
		index = arg_11_1 % 2 ~= 0 and 1 or 0
	})
end

return GuildWarFightRankPop
