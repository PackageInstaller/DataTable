-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActIntroduceCommonView.lua

module("logic.extensions.actintroduce.view.ActIntroduceCommonView", package.seeall)

local ActIntroduceCommonView = class("ActIntroduceCommonView", ViewComponent)

function ActIntroduceCommonView:ctor()
	ActIntroduceCommonView.super.ctor(self)
end

function ActIntroduceCommonView:unbindEvents()
	ActIntroduceCommonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnDateView)
end

function ActIntroduceCommonView:bindEvents()
	ActIntroduceCommonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnDateView, self._onClickDateView, self)
end

function ActIntroduceCommonView:buildUI()
	ActIntroduceCommonView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._btnDateView = self:getBtn("btnDateView")
	self._petCon = self:getGo("petCon")
	self._txtBubble = self:getTxt("bubble/txtDesc")
	self._tabviewGo = self:getGo("prizeCol/tabView")
	self._tabCell = self:getGo("prizeCol/btnCell")
	self._prizeviewGo = self:getGo("prizeCol/prizeScrollView")
	self._prizeviewScroll = self:getScrollRect("prizeCol/prizeScrollView")
	self._prizeCell = self:getGo("prizeCol/prizeScrollCell")
	self._tabView = ScrollerList.create(self._tabviewGo, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._prizeView = ScrollerList.create(self._prizeviewGo, self._prizeCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._cell2PrizeList = {}
end

function ActIntroduceCommonView:onExit()
	ActIntroduceCommonView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._updateConfigData, self)
	self._tabView:dispose()
	self._prizeView:dispose()
end

function ActIntroduceCommonView:onEnter()
	ActIntroduceCommonView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateConfigData, self)

	self._cfg = ActIntroduceConfig.instance:getCurActVersion()
	self._curSelectId = 1

	self:_updateConfigData()
	self:_initActTime()
	self:_petShow()
end

function ActIntroduceCommonView:_updateConfigData()
	local tabCfg = ActIntroduceConfig.instance:getCurTabCfg()
	local idx = 0

	if tabCfg and #tabCfg > 0 then
		for _, data in ipairs(tabCfg) do
			local startTime, endTime = data.startTime, data.endTime
			local isInTime = GameUtil.checkIsInTimePeriod(startTime, endTime)

			idx = idx + 1

			if isInTime then
				self._curSelectId = data.id

				local actCfgs = ActIntroduceConfig.instance:getActConfigsByIds(data.actIds)

				self._prizeView:reloadData(actCfgs)

				break
			end
		end
	end

	self._tabView:reloadData(tabCfg)
	self._tabView:regReloadFinish(function()
		self._tabView:MoveCellToCenter(idx)
	end)
end

function ActIntroduceCommonView:_initActTime()
	local startDate = GameUtil.string2date(self._cfg.startTime)
	local endDate = GameUtil.string2date(self._cfg.endTime)

	self._txtTime.text = langPara("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function ActIntroduceCommonView:_petShow()
	self._txtBubble.text = self._cfg.desc

	local x, y, scale = 0, 0, 1

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._cfg.raceId, self._petCon, scale, nil, true, x, y)
end

function ActIntroduceCommonView:_updateTabCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell, "Text")
	local txtSelectTitle = goutil.findChildTextComponent(cell, "select/Text")
	local select = goutil.findChild(cell, "select")

	txtTitle.text = data.title
	txtSelectTitle.text = data.title

	GameUtil.SetActive(select, self._curSelectId == data.id)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickTab, self, data.id))
end

function ActIntroduceCommonView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell)
end

function ActIntroduceCommonView:_updateCell(view, cell, data)
	local btnGoto = goutil.findChild(cell, "btnGoto")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtOverDate = goutil.findChildTextComponent(cell, "txtOverDate")
	local prizeItemGo = goutil.findChild(cell, "item")
	local prizeItemListGo = goutil.findChild(cell, "itemview")
	local startTime, endTime = ActIntroduceConfig.instance:getConfigBeginAndEndTime(data)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)
	local periodType = GameUtil.getTimePeriodTypeBySec(startTime, endTime)

	txtTitle.text = data.title
	txtTime.text = langPara("%02d.%02d %d点 - %02d.%02d %d点", startDate.month, startDate.day, startDate.hour, endDate.month, endDate.day, endDate.hour)

	GameUtil.SetActive(btnGoto, periodType == GameUtil.inTimePeriod)
	GameUtil.SetActive(txtOverDate, periodType ~= GameUtil.inTimePeriod)

	if periodType == GameUtil.beforeTimePeriod then
		txtOverDate.text = lang("活动未开始")
	elseif periodType == GameUtil.afterTimePeriod then
		txtOverDate.text = lang("活动已结束")
	end

	GameUtil.addClickHandler(btnGoto, function()
		GotoMgr.gotoByString(data.jumpTo)
	end)

	local prizeArray = string.split(data.prize, "#") or {}

	self:_clearPrizeCells(cell)

	local list = ScrollerList.create(prizeItemListGo, prizeItemGo, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._cell2PrizeList[cell] = list

	list:reloadData(prizeArray)
	list:refresh()
end

function ActIntroduceCommonView:_clearCell(cell)
	return
end

function ActIntroduceCommonView:_clearTableview(cell)
	local btnGoto = goutil.findChildButtonComponent(cell, "btnGoto")

	GameUtil.rmClickHandler(btnGoto)
end

function ActIntroduceCommonView:_clearPrizeCells(cell)
	local list = self._cell2PrizeList[cell]

	if list then
		list:dispose()
	end

	self._cell2PrizeList[cell] = nil
end

function ActIntroduceCommonView:_updatePrizeCell(index, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function ActIntroduceCommonView:_clearPrizeCell(cell)
	MaterialMgr.resetAll(cell)
end

function ActIntroduceCommonView:_onClickDateView()
	UIStateManager.instance:push(ViewName.ActIntroduceDateView)
end

function ActIntroduceCommonView:_onClickTab(tabId)
	local tabCfg = ActIntroduceConfig.instance:getTabCfgById(tabId)
	local startTime, endTime = tabCfg.startTime, tabCfg.endTime
	local timeState = GameUtil.getTimePeriodType(startTime, endTime)

	if timeState == GameUtil.beforeTimePeriod then
		FloatWordMgr.instance:show("未到开启时间哦~")

		return
	end

	self._curSelectId = tabId

	local actCfgs = ActIntroduceConfig.instance:getActConfigsByIds(tabCfg.actIds)

	self._prizeviewScroll.scrollRect.verticalNormalizedPosition = 1

	self._prizeView:reloadData(actCfgs)
	self._tabView:refresh()
end

return ActIntroduceCommonView
