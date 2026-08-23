local var_0_0 = g.core.const.ConstMgr.PeakArenaConst
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst.RankLayerTabIdx
local var_0_2 = g.core.network.proto
local var_0_3 = g.core.model.User
local var_0_4 = g.core.model.User.peakArenaData
local var_0_5 = g.core.model.User.guildData
local var_0_6 = g.core.common.Path
local RankAward = require("app.core.common.RankAward")
local PeakArenaRankLayer = class("PeakArenaRankLayer", require("app.fairyGUI.peakArena.UI_PeakArenaRankLayer"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaRankLayer",
		pkgName = "peakArena",
		isFullScreen = true,
		pkgPath = "ui/peakArena/peakArena"
	}, ...)
end)

function PeakArenaRankLayer:ctor(arg_2_1)
	self._curTabIndex = arg_2_1 or var_0_1.RANKING
	self._danGradingAwardArr = var_0_4:getLevelInfoList()
	self._rankingAwardArr = RankAward:getRankAwardArray((var_0_4:isShowAlliance() or nil) and var_0_0.RANK_TYPE2)

	if #self._rankingAwardArr > 1 then
		table.sort(self._rankingAwardArr, function(arg_3_0, arg_3_1)
			return arg_3_0.minRank > arg_3_1.minRank
		end)
	end

	self._myAwardArr = self:_getMyAwardArr()

	self:_initView()
end

function PeakArenaRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRcvRankList, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 100,
		id = var_0_2.PEAK_ARENA_SCORE_CROSS
	})
	self:_updateBottom()
	self:_updateView()
end

function PeakArenaRankLayer:_onRankingListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self:_isShowItemBg(arg_5_1), self._rankingArr[arg_5_1 + 1])
end

function PeakArenaRankLayer:_onDanGradingAwardListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self:_isShowItemBg(arg_6_1), self._danGradingAwardArr[arg_6_1 + 1])
end

function PeakArenaRankLayer:_onRankingAwardListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self:_isShowItemBg(arg_7_1), self._rankingAwardArr[arg_7_1 + 1])
end

function PeakArenaRankLayer:_onMyAwardListRenderer(arg_8_1, arg_8_2)
	self._myAwardArr[arg_8_1 + 1].scaleIndex = 6

	arg_8_2:updateIcon(self._myAwardArr[arg_8_1 + 1])
end

function PeakArenaRankLayer:_onPageChanged()
	local var_9_0 = self.m_pageTypeController:getSelectedIndex()

	if var_9_0 == self._curTabIndex then
		return
	end

	self._curTabIndex = var_9_0

	self:_updateView()
end

function PeakArenaRankLayer:_initView()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(var_0_0.TOP_BAR_ID)
	self.m_pageTypeController:setSelectedIndex(self._curTabIndex, false)
	self.m_pageTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onPageChanged))
	self.m_rankingList:setVirtual()
	self.m_rankingList:setItemRenderer(handler(self, self._onRankingListRenderer))
	self.m_rankingList:doFairyBatching(false)
	self.m_danGradingAwardList:setVirtual()
	self.m_danGradingAwardList:setItemRenderer(handler(self, self._onDanGradingAwardListRenderer))
	self.m_rankingAwardList:setVirtual()
	self.m_rankingAwardList:doFairyBatching(false)
	self.m_rankingAwardList:setItemRenderer(handler(self, self._onRankingAwardListRenderer))
	self.m_myAwardList:setVirtual()
	self.m_myAwardList:setItemRenderer(handler(self, self._onMyAwardListRenderer))
	self.m_belong:setText((var_0_4:isShowAlliance() or nil) and (g.core.lang:get(109643) or g.core.lang:get(100507)))
	self:showAtCenter()
end

function PeakArenaRankLayer:_updateView()
	if self._curTabIndex == var_0_1.RANKING then
		self.m_userInfoGroup:setVisible(true)

		self._rankingArr = var_0_4:getRankList(var_0_2.PEAK_ARENA_SCORE_CROSS)

		self.m_rankingList:setNumItems(#self._rankingArr)
		self.m_rankingList:transitionShowCells("enter_left", 0.03)
		self.m_isEmptyController:setSelectedIndex(#self._rankingArr == 0 and 1 or 0)
	elseif self._curTabIndex == var_0_1.DAN_GRADING_AWARD then
		self.m_userInfoGroup:setVisible(true)
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_danGradingAwardList:setNumItems(#self._danGradingAwardArr)
		self.m_danGradingAwardList:transitionShowCells("enter_left", 0.03)
	elseif self._curTabIndex == var_0_1.RANKING_AWARD then
		self.m_userInfoGroup:setVisible(var_0_4:getMyselfInfo().final_lv ~= var_0_0.HonorTitleType.NONE)
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_rankingAwardList:setNumItems(#self._rankingAwardArr)
		self.m_rankingAwardList:transitionShowCells("enter_left", 0.03)
	end
end

function PeakArenaRankLayer:_updateBottom()
	local var_12_0 = var_0_4:getMyselfInfo()

	self:_updateMyRankingAndScore()
	self.m_IconComp:updateAsSelf()
	self.m_userName:setText(var_0_3:getName())
	self.m_guildName:setText(var_0_4:isShowAlliance() and (var_0_3:getAllianceId() > 0 and var_0_3:getAllianceName() or g.core.lang:get(109642)) or var_0_5:hasGuild() and var_0_3:getGuildName() or g.core.lang:get(302055))
	self.m_serverName:setText((g.core.platform.ServerListProxy:getCurServer() or {}).name or "")
	self.m_fightValueTxt:setText(var_0_3:getFightValue())

	if var_12_0.final_lv == var_0_0.HonorTitleType.NONE then
		self.m_haveHonorTitleController:setSelectedIndex(0)
	else
		self.m_haveHonorTitleController:setSelectedIndex(1)
		self.m_rankingAliasComp:updateComp(var_12_0.final_lv)
		self.m_myAwardList:setNumItems(#self._myAwardArr)
	end
end

function PeakArenaRankLayer:_onRcvRankList()
	if self.m_pageTypeController:getSelectedIndex() == var_0_1.RANKING then
		self:_updateView()
	end

	self:_updateMyRankingAndScore()
end

function PeakArenaRankLayer:_isShowItemBg(arg_14_1)
	return arg_14_1 % 2 ~= 0
end

function PeakArenaRankLayer:_updateMyRankingAndScore()
	local var_15_0 = var_0_4:getMyRankingForRankingList(var_0_2.PEAK_ARENA_SCORE_CROSS)

	self.m_rankTxt:setText(tostring(var_15_0))
	self.m_haveRankingController:setSelectedIndex(var_15_0 > 0 and 1 or 0)

	local var_15_1 = var_0_4:getMyselfInfo()
	local var_15_2 = var_0_4:getPALevelInfo(var_15_1.score)

	self.m_rankIcon:setURL(var_0_6:getPeakArenaDanGradingPic(var_15_2.pic))
	self.m_scoreTxt:setText(var_15_1.score)
	self.m_myDanGradingTxt:setText(var_15_2.name)
end

function PeakArenaRankLayer:_getMyAwardArr()
	local var_16_0 = var_0_4:getMyselfInfo().final_lv

	if var_16_0 == var_0_0.HonorTitleType.NONE then
		return {}
	else
		for iter_16_0, iter_16_1 in ipairs(self._rankingAwardArr) do
			if iter_16_1.minRank == var_16_0 then
				return iter_16_1.data
			end
		end
	end
end

return PeakArenaRankLayer
