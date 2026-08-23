local WushRankPop = class("WushRankPop", require("app.fairyGUI.wush.UI_WushRankPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/wush/wush",
		resName = "WushRankPop",
		pkgName = "wush"
	})
end)

WushRankPop.WEEK_RANK_TAB = 0
WushRankPop.WEEK_AWARD_TAB = 1
WushRankPop.RECORD_RANK_ID = 3
WushRankPop.WEEK_RANK_ID = 4
WushRankPop.WUSH_WEEKLY = 3

function WushRankPop:ctor()
	self._weekRankData = {}
	self._weekAwardData = {}
	self._recordData = {}
	self._rankMeWeek = 0
	self._rankMeRecord = 0
	self._maxRank = 0

	self:getView():center(true)

	self._curTabIndex = 0

	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_topBarComp:setResInfoById(31)
end

function WushRankPop:onLoad()
	self._weekAwardData = g.core.common.RankAward:getRankAwardArray(WushRankPop.WUSH_WEEKLY)
	self._maxRank = self._weekAwardData[#self._weekAwardData].maxRank

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRecvRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._switchTab, self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 50,
		id = WushRankPop.RECORD_RANK_ID
	})
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 50,
		id = WushRankPop.WEEK_RANK_ID
	})
end

function WushRankPop:_onRecvRankList(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.id == WushRankPop.WEEK_RANK_ID then
		self._weekRankData = arg_4_3.rank_units or {}
		self._rankMeWeek = arg_4_3.self_rank or 0

		self:_updateMeRank()
		self:_switchTab()
	elseif arg_4_3.id == WushRankPop.RECORD_RANK_ID then
		self._recordData = arg_4_3.rank_units or {}
		self._rankMeRecord = arg_4_3.self_rank or 0
	end
end

function WushRankPop:_updateMeRank()
	if self._maxRank >= self._rankMeWeek and self._rankMeWeek > 0 then
		local var_5_0 = g.core.common.RankAward:getAwardByTypeAndRank(WushRankPop.WUSH_WEEKLY, self._rankMeWeek)

		self.m_rankTxt:setText(self._rankMeWeek)

		for iter_5_0 = 1, 4 do
			local var_5_1 = self:getChild("awardComp" .. iter_5_0)

			if var_5_0.data[iter_5_0] then
				var_5_1:updateByTVS({
					type = var_5_0.data[iter_5_0].type,
					value = var_5_0.data[iter_5_0].value,
					size = var_5_0.data[iter_5_0].size
				})
				var_5_1:setVisible(false)
			end
		end

		self:setCtrlState("isRank", {
			index = 1
		})
	else
		self:setCtrlState("isRank", {
			index = 0
		})
		self.m_rankTxt:setText(g.core.lang:get(300012))
		self.m_noteLabel:setText(g.core.lang:get(303020, {
			rank = self._maxRank
		}))
		self.m_noteLabel:setVisible(false)
	end
end

function WushRankPop:_updateWeekRankList()
	self.m_weekList:setVirtual()
	self.m_weekList:setItemRenderer(function(arg_7_0, arg_7_1)
		arg_7_1:update({
			isWeek = true,
			data = self._weekRankData[arg_7_0 + 1],
			rank = arg_7_0 + 1,
			selfRank = self._rankMeWeek
		})
		arg_7_1:setCtrlState("isEven", {
			index = arg_7_0 % 2 ~= 0 and 1 or 0
		})
	end)
	self.m_weekList:setNumItems(#self._weekRankData)
	self.m_weekList:transitionShowCells("listCrossbandAUiRightIn", 0.04)
end

function WushRankPop:_updateAwardList()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(function(arg_9_0, arg_9_1)
		arg_9_1:update({
			cellData = self._weekAwardData[arg_9_0 + 1]
		})
		arg_9_1:setCtrlState("isEven", {
			index = arg_9_0 % 2 ~= 0 and 1 or 0
		})
	end)
	self.m_awardList:setNumItems(#self._weekAwardData)
	self.m_awardList:transitionShowCells("listCrossbandAUiRightIn", 0.04)
end

function WushRankPop:_updateRecordList()
	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(function(arg_11_0, arg_11_1)
		arg_11_1:update({
			data = self._recordData[arg_11_0 + 1],
			rank = arg_11_0 + 1,
			selfRank = self._rankMeRecord
		})
		arg_11_1:setCtrlState("isEven", {
			index = arg_11_0 % 2 ~= 0 and 1 or 0
		})
	end)
	self.m_recordList:setNumItems(#self._recordData)
	self.m_recordList:transitionShowCells("listCrossbandAUiRightIn", 0.04)
end

function WushRankPop:_updateMeRecordCell()
	if self._maxRank >= self._rankMeRecord and self._rankMeRecord > 0 then
		self.m_meRecordComp:getChild("rankLabel"):setText(g.core.lang:get(302509, {
			rank = self._rankMeRecord
		}))
	else
		self.m_meRecordComp:getChild("rankLabel"):setText(g.core.lang:get(300012))
	end

	self.m_meRecordComp:setProperties("numLabel", {
		text = g.core.model.User.wushData:getRecordMaxStar()
	})
end

function WushRankPop:_onChangeTabCtrl(arg_13_1)
	self:_switchTab()
end

function WushRankPop:_switchTab()
	self._curTabIndex = self.m_tabController:getSelectedIndex()

	if self._curTabIndex == WushRankPop.WEEK_RANK_TAB then
		self:_updateWeekRankList()
		self:_updateMeRank()
	elseif self._curTabIndex == WushRankPop.WEEK_AWARD_TAB then
		self:_updateAwardList()
		self:_updateMeRank()
	else
		self:_updateRecordList()
		self:_updateMeRecordCell()
	end
end

return WushRankPop
