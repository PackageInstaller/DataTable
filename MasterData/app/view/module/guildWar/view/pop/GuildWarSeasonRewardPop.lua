local var_0_0 = g.core.const.ConstMgr.GuildWarConst
local var_0_1 = g.core.model.User.guildWarData
local var_0_2 = g.core.const.ConstMgr.RankAwardConst
local RankAward = require("app.core.common.RankAward")
local GuildWarSeasonRewardPop = class("GuildWarSeasonRewardPop", require("app.fairyGUI.guildWar.UI_GuildWarSeasonRewardPop"), function()
	return fgui.GComponent:create({
		resName = "GuildWarSeasonRewardPop",
		pkgPath = "ui/guildWar/guildWar",
		isFullScreen = true,
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarSeasonRewardPop:ctor()
	self._curGroupIndex = var_0_1:getCurFightingGroup()
	self._groupRewardList = {}
	self._myRank = 0

	self:_initView()
end

function GuildWarSeasonRewardPop:onLoad()
	self:updateView()
end

function GuildWarSeasonRewardPop:_initView()
	self:getView():center(true)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_4_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_4_1 = self.m_rewardList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_4_0.x > 0 then
		var_4_1 = var_4_1 - var_4_0.x * 2
	end

	self.m_rewardList:setWidth(var_4_1)
	self.m_topBg1:setWidth(var_4_1)
	self.m_downBg:setWidth(var_4_1)
	self.m_showGroupTabController:setSelectedIndex(self._curGroupIndex - 1)
	self.m_showGroupTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowTabChanged))
	self.m_topBar:setResInfoById(var_0_0.HELP_ID)
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardList))
	self.m_rewardTip:setText(g.core.lang:get(308668, {
		num = var_0_1:getSeasonAward()
	}))
end

function GuildWarSeasonRewardPop:_onShowTabChanged()
	local var_5_0 = self.m_showGroupTabController:getSelectedIndex() + 1

	if var_5_0 == self._curGroupIndex then
		return
	end

	self._curGroupIndex = var_5_0

	self:updateView()
end

function GuildWarSeasonRewardPop:updateView()
	self:updateRewardView()
end

function GuildWarSeasonRewardPop:updateRewardView()
	local var_7_0 = self._groupRewardList[self._curGroupIndex]

	if self._groupRewardList[self._curGroupIndex] == nil then
		var_7_0 = RankAward:getRankAwardArray(var_0_2["GUILD_WAR_SEASON_" .. self._curGroupIndex])
		self._groupRewardList[self._curGroupIndex] = var_7_0
	end

	self.m_rewardList:setNumItems(#var_7_0)
	self.m_rewardList:transitionShowCells("enter_left", 0.03)
end

function GuildWarSeasonRewardPop:_onRendererRewardList(arg_8_1, arg_8_2)
	if self._groupRewardList[self._curGroupIndex][arg_8_1 + 1] then
		arg_8_2:update({
			rewardData = self._groupRewardList[self._curGroupIndex][arg_8_1 + 1]
		})
		arg_8_2:setCtrlState("isShowBg", {
			index = arg_8_1 % 2 ~= 0 and 1 or 0
		})
	end
end

return GuildWarSeasonRewardPop
