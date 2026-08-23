local var_0_0 = g.core.config.resource_info
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst
local var_0_2 = g.core.const.ConstMgr.PeakArenaConst.BetListSortType
local var_0_3 = 0
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.common.Path
local var_0_6 = g.core.model.User.peakArenaData
local var_0_7 = g.core.common.ServerTime
local PeakArenaBettingListPop = class("PeakArenaBettingListPop", require("app.fairyGUI.peakArena.UI_PeakArenaBettingListPop"), function()
	return fgui.GComponent:create({
		pkgName = "peakArena",
		resName = "PeakArenaBettingListPop",
		pkgPath = "ui/peakArena/peakArena"
	}, ...)
end)

function PeakArenaBettingListPop:ctor()
	self._selectedTabIdxCpp = -1
	self._championUserId = var_0_6:getChampionUserId()
	self._allUserIdArr = {}
	self._userId2DArr = {}

	for iter_2_0 = 1, var_0_1.GROUP_NUM do
		local var_2_0 = var_0_6:getGroupStruct(iter_2_0):getValidUserIdArr()

		self._userId2DArr[iter_2_0] = var_2_0

		table.insertto(self._allUserIdArr, var_2_0)
	end

	self._showUserIdArr = {}

	self.m_baseResItemComp:updateResBtn({
		type = var_0_4.TYPE_RESOURCE,
		value = var_0_4.RESOURCE.TYPE_PA_STARLIGHT_STAMP,
		clickFunc = function()
			return
		end
	})
	self.m_helpBtn:addClickListener(handler(self, self._onClickHelpBtn))
	self.m_tabList:setIniter(self)
	self.m_tabList:doFairyBatching(true)
	self.m_tabList:setItemRenderer(handler(self, self._onTabListRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabListItem))
	self.m_bettingList:setVirtual()
	self.m_bettingList:doFairyBatching(false)
	self.m_bettingList:setItemRenderer(handler(self, self._onBettingListRenderer))
	self.m_myBetCheckBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onBetCheckBtnChanged))
	self:showAtCenter()
end

function PeakArenaBettingListPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_PLAYBETS, self._onS2CPlayBets, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CUserSnapshot), self)

	self._selectedTabIdxCpp = var_0_3

	self.m_sortDropDownBox:updateComp(var_0_2.POWER)
	self.m_tabList:setNumItems(var_0_1.GROUP_NUM + 1)
	self.m_tabList:setSelectedIndex(self._selectedTabIdxCpp)
	self.m_resIconLoader:setURL((var_0_5:getResourceIconById(var_0_0.get(var_0_4.RESOURCE.TYPE_PA_STARLIGHT_STAMP).icon, true)))
	self.m_remainBetNumTxt:setText((var_0_6:getRemainBetNum()))
	self.m_myBetCheckBtn:setSelected(false)

	local var_4_0 = var_0_6:getBetStarTime()
	local var_4_1 = var_0_7:getWeekDayByTimeTamp(var_4_0)
	local var_4_2

	if var_4_1 == 0 then
		var_4_1 = 7
		var_4_2 = {}
	end

	var_4_2.week = g.core.lang:get(130 + var_4_1)
	var_4_2.startTime = var_0_7:getDateObject(var_4_0).hour
	var_4_2.endTime = var_0_7:getDateObject(var_0_6:getBetEndTime()).hour

	self.m_betTimeTxt:setText(g.core.lang:get(307036, var_4_2))
	self:_updateShowIdArr(self._selectedTabIdxCpp, (self.m_myBetCheckBtn:isSelected()))
	self:_sortShowUserIdArr((self.m_sortDropDownBox:getSortType()))
	self.m_bettingList:setNumItems(#self._showUserIdArr)
	self.m_bettingList:scrollToView(0, true)
end

function PeakArenaBettingListPop:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "CHANGE_SORT_TYPE" then
		self:_sortShowUserIdArr((self.m_sortDropDownBox:getSortType()))
		self.m_bettingList:setNumItems(#self._showUserIdArr)
	end
end

function PeakArenaBettingListPop:_onS2CPlayBets()
	self.m_baseResItemComp:updateResNum(false)
	self.m_bettingList:setNumItems(#self._showUserIdArr)
	self.m_remainBetNumTxt:setText((var_0_6:getRemainBetNum()))
end

function PeakArenaBettingListPop:_onS2CUserSnapshot()
	self.m_bettingList:setNumItems(#self._showUserIdArr)
end

function PeakArenaBettingListPop:_onClickHelpBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = var_0_1.BET_HELP_ID
	}), {
		touchDisappear = true
	})
end

function PeakArenaBettingListPop:_onTabListRenderer(arg_9_1, arg_9_2)
	arg_9_2:setTitle(arg_9_1 == var_0_3 and g.core.lang:get(307032) or var_0_6:getGroupStruct(arg_9_1):getName())
end

function PeakArenaBettingListPop:_onClickTabListItem(arg_10_1)
	local var_10_0 = arg_10_1:getDataValue()

	if self._selectedTabIdxCpp == var_10_0 then
		return
	end

	self._selectedTabIdxCpp = var_10_0

	self:_updateShowIdArr(var_10_0, (self.m_myBetCheckBtn:isSelected()))
	self:_sortShowUserIdArr((self.m_sortDropDownBox:getSortType()))
	self.m_bettingList:setNumItems(#self._showUserIdArr)
end

function PeakArenaBettingListPop:_onBettingListRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateCell(self._showUserIdArr[arg_11_1 + 1], self._championUserId)
end

function PeakArenaBettingListPop:_onBetCheckBtnChanged()
	self:_updateShowIdArr(self._selectedTabIdxCpp, (self.m_myBetCheckBtn:isSelected()))
	self:_sortShowUserIdArr((self.m_sortDropDownBox:getSortType()))
	self.m_bettingList:setNumItems(#self._showUserIdArr)
end

function PeakArenaBettingListPop:_sortRulePower()
	return function(arg_14_0, arg_14_1)
		return var_0_6:getPeakStageUserStructWithId(arg_14_0):getFightValue() > var_0_6:getPeakStageUserStructWithId(arg_14_1):getFightValue()
	end
end

function PeakArenaBettingListPop:_sortRuleSupportNum()
	return function(arg_16_0, arg_16_1)
		return var_0_6:getPeakStageUserStructWithId(arg_16_0):getSupportNum() > var_0_6:getPeakStageUserStructWithId(arg_16_1):getSupportNum()
	end
end

function PeakArenaBettingListPop:_sortRuleOdds()
	return function(arg_18_0, arg_18_1)
		return var_0_6:getPeakStageUserStructWithId(arg_18_0):getChampionOdds() > var_0_6:getPeakStageUserStructWithId(arg_18_1):getChampionOdds()
	end
end

function PeakArenaBettingListPop:_updateShowIdArr(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1 == var_0_3 and self._allUserIdArr or self._userId2DArr[arg_19_1]

	if arg_19_2 then
		local var_19_1 = {}

		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			if var_0_6:isIBetOnHim(iter_19_1) then
				table.insert(var_19_1, iter_19_1)
			end
		end

		self._showUserIdArr = var_19_1
	else
		self._showUserIdArr = clone(var_19_0)
	end
end

function PeakArenaBettingListPop:_sortShowUserIdArr(arg_20_1)
	table.sort(self._showUserIdArr, arg_20_1 == var_0_2.SUPPORT_NUM and self:_sortRuleSupportNum() or arg_20_1 == var_0_2.ODDS and self:_sortRuleOdds() or self:_sortRulePower())
end

return PeakArenaBettingListPop
