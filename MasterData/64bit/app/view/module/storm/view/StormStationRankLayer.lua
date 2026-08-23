local StormStationRankLayer = class("StormStationRankLayer", require("app.fairyGUI.storm.UI_StormStationRankLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/storm/storm",
		resName = "StormStationRankLayer",
		pkgName = "storm",
		isFullScreen = true
	}, ...)
end)

function StormStationRankLayer:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self._allCityRankMap = {}
	self._rankNumMap = {}
	self._awardRankList = {}
	self._officialList = {}
	self._allRankData = {}
	self._cityIdList = g.core.model.User.stormCityData:getCityIdList()
	self._allRankIndex = 0
	self._listScrollY = 0
	self._leftSelectedIndex = 0
	self._selectCityId = self:_getCityIdByTabIndex(0)
	self._topTabIndex = 0
	self._frontSaveIndex = nil
	self._scrollToTop = false
	self._needPlayAnim = true

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankRenderer))
	self.m_rankList:doFairyBatching(false)
	self.m_rankList:addEventListener(fgui.UIEventType.PullUpRelease, handler(self, self._onAllRankListPullUpRelease))
	self.m_rankRewardList:setVirtual()
	self.m_rankRewardList:setItemRenderer(handler(self, self._onRankRewardRenderer))
	self.m_rankRewardList:doFairyBatching(false)
	self.m_dailyRewardList:setVirtual()
	self.m_dailyRewardList:setItemRenderer(handler(self, self._onDailyRewardRenderer))
	self.m_dailyRewardList:doFairyBatching(false)
	self.m_leftTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabClick))
	self.m_leftTabList:setSelectedIndex(0)
	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
	self.m_typeController:setSelectedIndex(self._topTabIndex)
	self:initLeftTab()
end

function StormStationRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETRANKLIST, self._onRcvGetRankList, self)
	g.core.model.User.stormCityData:clearRankData()
	g.core.network.GameNetProxy:send_C2S_StormCity_GetRanklist({
		rank_tp = 1,
		index = 1,
		city = self._selectCityId
	})
	self:updateBaseInfo()
end

function StormStationRankLayer:initLeftTab()
	for iter_4_0 = 0, 3 do
		self.m_leftTabList:getChildAt(iter_4_0):setTitle(g.core.config.storm_info.get((self:_getCityIdByTabIndex(iter_4_0))).name)
	end
end

function StormStationRankLayer:updateBaseInfo()
	local var_5_0 = g.core.model.User.stormCityData:getOwnRank()

	if var_5_0 <= 0 then
		self.m_myRankController:setSelectedIndex(0)
		self.m_noRankTxt:setText(g.core.lang:get(304610))
	else
		self.m_myRankController:setSelectedIndex(1)
		self.m_rankTxt:setText(var_5_0)
	end

	local var_5_1 = g.core.model.User.stormCityData:getOwnCityId()

	if var_5_1 <= 0 then
		self.m_curPlaceNameTxt:setText(g.core.lang:get(304612))
	else
		self.m_curPlaceNameTxt:setText(g.core.config.storm_info.get(var_5_1).name)
	end
end

function StormStationRankLayer:_onTabClick()
	local var_6_0 = self.m_leftTabList:getSelectedIndex()

	if self._leftSelectedIndex ~= var_6_0 then
		self._leftSelectedIndex = var_6_0
		self._needPlayAnim = true
	end

	self.m_typeController:setSelectedIndex(0)

	if var_6_0 == 4 then
		self.m_fullRankController:setSelectedIndex(1)

		self._frontSaveIndex = self.m_typeController:getSelectedIndex()
		self._selectCityId = 0

		self:_updateAllRank()
		g.core.network.GameNetProxy:send_C2S_StormCity_GetRanklist({
			rank_tp = 2,
			index = 1,
			city = self._selectCityId
		})
	else
		self.m_fullRankController:setSelectedIndex(0)

		local var_6_1 = self:_getCityIdByTabIndex(var_6_0)

		if var_6_1 ~= self._selectCityId then
			self._selectCityId = var_6_1

			g.core.network.GameNetProxy:send_C2S_StormCity_GetRanklist({
				rank_tp = 1,
				index = 1,
				city = self._selectCityId
			})
		end

		if self.m_typeController:getSelectedIndex() ~= 0 then
			self:_onTabChanged()
		end

		if self._frontSaveIndex then
			self.m_typeController:setSelectedIndex(self._frontSaveIndex)

			self._frontSaveIndex = nil
		end
	end

	self._scrollToTop = true
end

function StormStationRankLayer:_onTabChanged()
	local var_7_0 = self.m_typeController:getSelectedIndex()

	if var_7_0 == 0 then
		-- block empty
	elseif var_7_0 == 1 then
		self:_updateAwardRank()
	else
		self:_updateDailyAward()
	end
end

function StormStationRankLayer:_updateAwardRank()
	self._awardRankList = {}

	for iter_8_0 = 1, g.core.config.storm_city_rank_info.getLength() do
		local var_8_0 = g.core.config.storm_city_rank_info.indexOf(iter_8_0)

		if var_8_0.rank_type == self._selectCityId then
			table.insert(self._awardRankList, var_8_0)
		end
	end

	self.m_rankRewardList:setNumItems(#self._awardRankList)
	self:_checkPlayAnim(self.m_rankRewardList)
end

function StormStationRankLayer:_getOfficialList()
	self._officialList = {}

	for iter_9_0 = 1, g.core.config.storm_city_lord_info.getLength() do
		self._officialList[#self._officialList + 1] = g.core.config.storm_city_lord_info.indexOf(iter_9_0)
	end

	table.sort(self._officialList, function(arg_10_0, arg_10_1)
		return arg_10_0.order < arg_10_1.order
	end)
end

function StormStationRankLayer:_updateDailyAward()
	self:_getOfficialList()
	self.m_dailyRewardList:setNumItems(#self._officialList)
	self:_checkPlayAnim(self.m_dailyRewardList)

	local var_11_0 = g.core.model.User.stormCityData:getOfficialInfoByRank()

	if var_11_0 then
		self.m_myRankController:setSelectedIndex(1)
		self.m_titleTxt:setText(var_11_0.name)
	else
		self.m_myRankController:setSelectedIndex(0)
		self.m_noTitleTxt:setText(g.core.lang:get(304626))
	end
end

function StormStationRankLayer:_getCityIdByTabIndex(arg_12_1)
	return self._cityIdList[arg_12_1 + 1] or self._cityIdList[4]
end

function StormStationRankLayer:_onRcvGetRankList(arg_13_1, arg_13_2, arg_13_3)
	self._allCityRankMap = g.core.model.User.stormCityData:getRankData()
	self._rankNumMap[arg_13_3.city] = arg_13_3.index * 25

	if arg_13_3.rank_tp == 2 then
		if arg_13_3.index > self._allRankIndex then
			table.insertto(self._allRankData, arg_13_3.units or {})
		end

		self._allRankIndex = arg_13_3.index

		self:_updateAllRank()
	else
		self:_updateCityRank()
	end

	self._listScrollY = 0
end

function StormStationRankLayer:_updateAllRank()
	table.sort(self._allRankData, function(arg_15_0, arg_15_1)
		if arg_15_0.rank ~= arg_15_1.rank then
			return arg_15_0.rank < arg_15_1.rank
		end

		if arg_15_0.city ~= arg_15_1.city then
			return arg_15_0.city > arg_15_1.city
		end
	end)

	if #self._allRankData == 0 then
		self.m_rankEmptyController:setSelectedIndex(1)
	else
		self.m_rankEmptyController:setSelectedIndex(0)
		self.m_rankList:setNumItems(#self._allRankData)

		if self._scrollToTop then
			self._scrollToTop = false

			self.m_rankList:scrollToView(0)
		end

		self:_checkPlayAnim(self.m_rankList)
	end
end

function StormStationRankLayer:_updateCityRank()
	self._cityRankList = self._allCityRankMap[self._selectCityId]

	if not self._cityRankList then
		return
	end

	if self._rankNumMap[self._selectCityId] == 0 then
		self.m_rankEmptyController:setSelectedIndex(1)
	else
		self.m_rankEmptyController:setSelectedIndex(0)
		self.m_rankList:setNumItems(self._rankNumMap[self._selectCityId])
		self:_checkPlayAnim(self.m_rankList)

		if self._scrollToTop then
			self._scrollToTop = false

			self.m_rankList:scrollToView(0)
		end
	end
end

function StormStationRankLayer:_onRankRenderer(arg_17_1, arg_17_2)
	if self.m_leftTabList:getSelectedIndex() == 4 then
		arg_17_2:updateCell(self._allRankData[arg_17_1 + 1], arg_17_1 + 1, true)
	else
		arg_17_2:updateCell(self._cityRankList[arg_17_1 + 1], arg_17_1 + 1)
	end
end

function StormStationRankLayer:_onRankRewardRenderer(arg_18_1, arg_18_2)
	arg_18_2:updateView(self._awardRankList[arg_18_1 + 1], arg_18_1)
end

function StormStationRankLayer:_onDailyRewardRenderer(arg_19_1, arg_19_2)
	arg_19_2:updateView(self._officialList[arg_19_1 + 1], arg_19_1)
end

function StormStationRankLayer:_checkPlayAnim(arg_20_1)
	if self._needPlayAnim then
		self._needPlayAnim = false

		arg_20_1:transitionShowCells("enter_left", 0.03, 1)
	end
end

function StormStationRankLayer:_checkSendRankMsg()
	local var_21_0 = 1

	if self._rankNumMap[self._selectCityId] then
		var_21_0 = math.floor(self._rankNumMap[self._selectCityId] / 25) + 1

		if var_21_0 > 4 then
			return
		end
	end

	g.core.network.GameNetProxy:send_C2S_StormCity_GetRanklist({
		rank_tp = 1,
		city = self._selectCityId,
		index = var_21_0
	})
end

function StormStationRankLayer:_onAllRankListPullUpRelease()
	if self.m_leftTabList:getSelectedIndex() < 4 then
		local var_22_0 = self.m_rankList:getScrollPane():getPercY()

		if self._listScrollY < 1 and var_22_0 == 1 then
			self:_checkSendRankMsg()
		end

		self._listScrollY = var_22_0
	else
		if self._allRankIndex >= 4 then
			return
		end

		local var_22_1 = self.m_rankList:getScrollPane():getPercY()

		if self._listScrollY < 1 and var_22_1 == 1 then
			g.core.network.GameNetProxy:send_C2S_StormCity_GetRanklist({
				rank_tp = 2,
				city = self:_getCityIdByTabIndex(0),
				index = math.min(4, self._allRankIndex + 1)
			})
		end

		self._listScrollY = var_22_1
	end
end

return StormStationRankLayer
