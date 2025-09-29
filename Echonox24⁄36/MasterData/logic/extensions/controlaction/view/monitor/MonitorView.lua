-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/MonitorView.lua

module("logic.extensions.controlaction.view.monitor.MonitorView", package.seeall)

local M = class("MonitorView", ViewComponent)
local coinId = CommEnum.CurrencyCodeEnum.TlCode

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._unlockTipsGo = self:getGo("regulatory_monitor_panel_407257707")
	self._txtLastTime = self:getText("regulatory_monitor_panel_-820921777")
	self._btnClose = self:getBtn("regulatory_monitor_panel_-768102186")
	self._btnSmall = self:getBtn("regulatory_monitor_panel_-982855845")
	self._btnUse = self:getBtn("regulatory_monitor_panel_519353851")

	local listGo = self:getGo("regulatory_monitor_panel_-610746882")

	self._btn_clickCost = self:getBtn("regulatory_monitor_panel_-114854124")
	self._itemViewList = {}

	for i = 1, listGo.transform.childCount do
		local monitorGo = goutil.findChild(listGo, "monitor_" .. i)
		local itemView = Astral.LuaComponentContainer.Add(monitorGo, MonitorViewItem)

		itemView:initViewID(i)

		if i == 4 then
			itemView:setValid(false)
		end

		table.insert(self._itemViewList, itemView)
	end

	self._detailPanelGo = self:getGo("regulatory_monitor_panel_-243727352")
	self._rewardPanelGo = self:getGo("regulatory_monitor_panel_1671263342")
	self._heroPanelGo = self:getGo("regulatory_monitor_panel_319086299")
	self._lastTimeImage1Go = goutil.findChild(self._unlockTipsGo, "Image2")
	self._lastTimeImage2Go = goutil.findChild(self._unlockTipsGo, "Image3")
	self._winPanelParentGo = goutil.findChild(self.mainGO, "objGo")
	self._winLayoutGroup = self._winPanelParentGo:GetComponent(UIComponentType.HorizontalOrVerticalLayoutGroup)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	removetimer(self._timeCounter, self)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSmall:AddClickListener(self._onClickSmall, self)
	self._btnUse:AddClickListener(self._onClickUse, self)
	self._btn_clickCost:AddClickListener(self._onClickCost, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MONITORDATA_FINISH, self._onMonitorDataUpdate, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MONITOR_REWARD, self._previewReward, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MONITOR_INVALID, self._clickInvalidItem, self)
	GlobalDispatcher:addEventListener(EventType.ARITIGHT_OPEN_USEITEM, self._handleOpenUseItem, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSmall:RemoveClickListener()
	self._btnUse:RemoveClickListener()
	self._btn_clickCost:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MONITORDATA_FINISH, self._onMonitorDataUpdate, self)
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MONITOR_REWARD, self._previewReward, self)
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MONITOR_INVALID, self._clickInvalidItem, self)
	GlobalDispatcher:removeEventListener(EventType.ARITIGHT_OPEN_USEITEM, self._handleOpenUseItem, self)
end

function M:onEnter()
	self._guiAnimation:PlayAniByName("open")
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MONITOR_TAB, self._changeTab, self)

	self._itemData = ItemUtil.createItemData({
		itemId = coinId
	})

	self:_refreshView()
end

function M:onEnterFinished()
	local isIn = AirtightRoomController.instance:getIsInAirtightTime()
	local battleInfo = ControlActionModel.instance:getBattleInfo()

	if (battleInfo and isIn or ControlActionUtil.getGuideBattle()) and battleInfo then
		local viewId = battleInfo.viewId or self:_findViewId(battleInfo.dungeonGroupCode)

		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MONITOR_SELECT, viewId, battleInfo.difficultIndex)
	end

	settimer(1, function()
		ControlActionModel.instance:resetBattleInfo()
	end, self, false)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MONITOR_TAB, self._changeTab, self)
	goutil.setActive(self._detailPanelGo.transform.parent.gameObject, false)
	goutil.setActive(self._rewardPanelGo, false)

	self._winLayoutGroup.childAlignment = UnityEngine.TextAnchor.UpperCenter

	for i = 1, #self._itemViewList do
		self._itemViewList[i]:setStatus(nil, 0)
		self._itemViewList[i]:onExit()
	end

	removetimer(self._timeCounter, self)
	ViewMgr.instance:close(ViewName.ControlActionMonitorUseItem)
end

function M:_findViewId(dungeonGroupCode)
	for index, itemView in ipairs(self._itemViewList) do
		local monitorMO = itemView:getMonitorMO()

		if monitorMO and monitorMO:getDungeonGroupCode() == dungeonGroupCode then
			return index
		end
	end

	return false
end

function M:_timeCounter()
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local nextTimeStamp = AirtightRoomController.instance:getNextAirtightBeginTimeStamp()
	local timeStr = TimeUtil.instance:numberToTime(nextTimeStamp - nowTime, "h:m:s")

	self._txtLastTime.text = string.format(lang("tip_controlaction_monitor_time2"), timeStr)

	goutil.setActive(self._txtLastTime.gameObject, not inSpTime)
	goutil.setActive(self._lastTimeImage1Go, not inSpTime)
	goutil.setActive(self._lastTimeImage2Go, not inSpTime)
end

function M:_refreshView()
	if ControlActionUtil.isInGuideSecond() then
		goutil.setActive(self._unlockTipsGo, false)
		goutil.setActive(self._btnUse.gameObject, false)

		for i = 1, #self._itemViewList do
			if i == 1 then
				self._itemViewList[i]:setAirRoom(true)
			else
				self._itemViewList[i]:setAirRoom(false)
				self._itemViewList[i]:setValid(false)
			end
		end

		self:_refresh()
	else
		local isIn = AirtightRoomController.instance:getIsInAirtightTime()
		local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

		goutil.setActive(self._unlockTipsGo, not isIn)
		goutil.setActive(self._btnUse.gameObject, not isIn and not inSpTime)
		self:_timeCounter()
		removetimer(self._timeCounter, self)
		settimer(1, self._timeCounter, self, true)

		for i = 1, #self._itemViewList do
			self._itemViewList[i]:setAirRoom(isIn)
		end

		self:_refresh()
	end
end

function M:_refresh()
	local dataList = ControlActionModel.instance:getMonitorMoList()

	if ControlActionUtil.isInGuideSecond() then
		dataList = ControlActionModel.instance:getGuideMonitorMoList()
	end

	for i = 1, #self._itemViewList do
		if i <= #dataList then
			self._itemViewList[i]:refresh(dataList[i])
		else
			self._itemViewList[i]:setAirRoom(false)
			self._itemViewList[i]:setValid(false)
		end
	end
end

function M:_onMonitorDataUpdate()
	self:_refreshView()
end

function M:_handleOpenUseItem()
	self:onEnter()
end

function M:_changeTab(e, info)
	local dungeonCode = info.dungeonCode
	local preDungeonCode = info.preDungeonCode

	self._winLayoutGroup.childAlignment = UnityEngine.TextAnchor.UpperRight

	local dungeonMo = DungeonModel.instance:getDungeonMoById(dungeonCode)

	printWarn("=====_changeTab======", dungeonCode)

	local preDungeonMo

	if preDungeonCode then
		preDungeonMo = DungeonModel.instance:getDungeonMoById(preDungeonCode)
	end

	goutil.setActive(self._detailPanelGo.transform.parent.gameObject, true)

	self._detailView = Astral.LuaComponentContainer.Add(self._detailPanelGo, MonitorDetailView)

	self._detailView:refresh(dungeonMo, preDungeonMo, info)
end

function M:_clickInvalidItem(e, ...)
	goutil.setActive(self._detailPanelGo.transform.parent.gameObject, false)

	self._winLayoutGroup.childAlignment = UnityEngine.TextAnchor.UpperCenter
end

function M:_previewReward(e, rewardCode)
	goutil.setActive(self._rewardPanelGo, true)

	self._preView = Astral.LuaComponentContainer.Add(self._rewardPanelGo, MonitorRewardPreview)

	self._preView:refresh(rewardCode)
end

function M:_onClickUse()
	ViewMgr.instance:open(ViewName.ControlActionMonitorUseItem)
end

function M:_onClickCost()
	GlobalDispatcher:dispatchEvent(EventType.ITEM_NORMAL_MARK_TYPE, self._itemData, self._btn_clickCost.gameObject, 0, true, false)
end

function M:_onClickClose()
	ViewMgr.instance:close(ViewName.ControlActionMonitor)
	GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_CLOSE, 1)
end

function M:_onClickSmall()
	ViewMgr.instance:close(ViewName.ControlActionMonitor)
end

return M
