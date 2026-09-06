-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActIntroduceDateView.lua

module("logic.extensions.actintroduce.view.ActIntroduceDateView", package.seeall)

local ActIntroduceDateView = class("ActIntroduceDateView", ViewComponent)
local GridWidth = 124
local GridHeight = 52
local ContentOffset = 0
local OneDaySec = 86400
local WeekDays = {
	"日",
	"一",
	"二",
	"三",
	"四",
	"五",
	"六"
}

function ActIntroduceDateView:ctor()
	ActIntroduceDateView.super.ctor(self)
end

function ActIntroduceDateView:unbindEvents()
	ActIntroduceDateView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ActIntroduceDateView:bindEvents()
	ActIntroduceDateView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ActIntroduceDateView:buildUI()
	ActIntroduceDateView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._dateTableview = self:getGo("dateTableview")
	self._dateCell = self:getGo("dateCell")
	self._contentCell = self:getGo("contentCell")
	self._contentTableview = self:getGo("contentTableview")
	self._content = self:getGo("contentTableview/Viewport/Content")
	self._dateScroller = Framework.ScrollRectAdapter.Get(self._dateTableview)
	self._contentScroller = Framework.ScrollRectAdapter.Get(self._contentTableview)

	goutil.setActive(self._dateCell, false)
	goutil.setActive(self._contentCell, false)
end

function ActIntroduceDateView:onExit()
	ActIntroduceDateView.super.onExit(self)

	if self._dragDateTableView then
		self._dragDateTableView:RemoveDragListener()
		self._dragDateTableView:RemoveBeginDragListener()
		self._dragDateTableView:RemoveEndDragListener()
	end

	if self._dragContentTableView then
		self._dragContentTableView:RemoveDragListener()
		self._dragContentTableView:RemoveBeginDragListener()
		self._dragContentTableView:RemoveEndDragListener()
	end

	self._dateScrollList:dispose()

	for i, info in ipairs(self._contentCells) do
		local imgGo = goutil.findChild(info.cell, "img")

		GameUtil.rmClickHandler(imgGo)
	end

	goutil.clearChildren(self._content)

	self._contentCells = {}
end

function ActIntroduceDateView:onEnter()
	ActIntroduceDateView.super.onEnter(self)

	self._dragDateTableView = Framework.UIDragTrigger.Get(self._dateTableview)

	self._dragDateTableView:AddDragListener(self._onDragDateTableView, self)
	self._dragDateTableView:AddBeginDragListener(self._onBeginDragDateTableView, self)
	self._dragDateTableView:AddEndDragListener(self._onEndDragDateTableView, self)

	self._dragContentTableView = Framework.UIDragTrigger.Get(self._contentTableview)

	self._dragContentTableView:AddDragListener(self._onDragContentTableView, self)
	self._dragContentTableView:AddBeginDragListener(self._onBeginDragContentTableView, self)
	self._dragContentTableView:AddEndDragListener(self._onEndDragContentTableView, self)
	goutil.clearChildren(self._content)

	self._contentCells = {}
	self._configs = ActIntroduceConfig.instance:getCurActDateConfigs()

	if not self._configs then
		self:close()
		printError("配置有误，不能正确获取日程配置，请配置版本时间")

		return
	end

	self._dateScrollList = ScrollerList.create(self._dateTableview, self._dateCell, GameUtil.handler(self._updateDateCell, self), GameUtil.handler(self._clearDateCell, self))

	self._dateScrollList:regGetCellSize(function(...)
		return 154, 600
	end)

	local dateStartTime, dateEndTime = ActIntroduceConfig.instance:getCurActTime()
	local currentDateTime = GameUtil.string2time(dateStartTime)
	local endDateTime = GameUtil.string2time(dateEndTime)
	local dateTimeArray = {}

	while currentDateTime <= endDateTime do
		table.insert(dateTimeArray, GameUtil.time2date(currentDateTime))

		currentDateTime = currentDateTime + OneDaySec
	end

	local dateLength = #dateTimeArray

	self._beginTime = GameUtil.string2time(dateStartTime)

	local configs = {}

	for i = 1, #self._configs do
		local config = self._configs[i]
		local startTime, endTime = ActIntroduceConfig.instance:getConfigBeginAndEndTime(config)

		table.insert(configs, {
			config = config,
			startTime = startTime,
			endTime = endTime
		})
		self:_addOneContent(i, configs[i])
	end

	self._contendWidth = dateLength * GridWidth

	GameUtil.setWidth(self._content, self._contendWidth)
	GameUtil.setHeight(self._content, #configs * GridHeight + ContentOffset)
	self._dateScrollList:regReloadFinish(function()
		self._dateScrollList:regReloadFinish(nil)

		local idx = 0

		for i, v in ipairs(dateTimeArray) do
			if self:_isToday(v) then
				idx = i - 1

				break
			end
		end

		self._dateScrollList:MoveCellToCenter(idx)
		self:_onDateScrollerValueChanged()
	end)
	self._dateScrollList:reloadData(dateTimeArray)
end

function ActIntroduceDateView:_updateDateCell(view, cell, data, tag)
	local changeGroup = cell.gameObject:GetComponent("UIChangeGroup")
	local txtDate = goutil.findChildTextComponent(cell, "txtDate")
	local date = data
	local weekDay = date.wday

	txtDate.text = langPara("星期%s\n%d.%d", WeekDays[weekDay], date.month, date.day)

	if self:_isToday(date) then
		changeGroup:SetState(1)
	else
		changeGroup:SetState(0)
	end
end

function ActIntroduceDateView:_isToday(date)
	local nowDate = ServerTime.nowDateServerLook()

	return nowDate.year == date.year and nowDate.month == date.month and nowDate.day == date.day
end

function ActIntroduceDateView:_clearDateCell(cell)
	return
end

function ActIntroduceDateView:_addOneContent(index, data)
	local cell = goutil.cloneAndSetParent(self._contentCell, self._content.transform)

	goutil.setActive(cell, true)
	GameUtil.setLocalPos(cell, 0, -((index - 1) * GridHeight + ContentOffset) - 32, 0)

	local txtContent = goutil.findChildTextComponent(cell, "txtContent")
	local contentSizeImmediate = txtContent:GetComponent("ContentSizeImmediate")
	local imgGo = goutil.findChild(cell, "img")
	local imgChange = imgGo:GetComponent("UIImageSpriteChange")

	txtContent.text = data.config.title

	local dDay = math.ceil((data.endTime - data.startTime) / OneDaySec)
	local width = (dDay + 1) * GridWidth

	GameUtil.setWidth(imgGo, width)

	local dStartDay = math.ceil((data.startTime - self._beginTime) / OneDaySec)
	local beginX = dStartDay * GridWidth
	local endX = beginX + width

	GameUtil.setLocalPos(imgGo, beginX, 0, 0)

	local localPos = GameUtil.getLocalPos(txtContent.gameObject)

	GameUtil.setLocalPos(txtContent.gameObject, beginX, localPos.y, localPos.z)

	local info = {
		cell = cell,
		data = data,
		beginX = beginX,
		endX = endX,
		moveGo = txtContent.gameObject,
		moveGoWidth = contentSizeImmediate:GetPreferredSize().x
	}

	table.insert(self._contentCells, info)
	GameUtil.addClickHandler(imgGo, function()
		self:_showActTips(data.config)
	end)
end

function ActIntroduceDateView:_updateTxtContentPos(info)
	if self._contentBeginX ~= nil and self._contentEndX ~= nil then
		local bInRange = info.beginX >= self._contentBeginX and info.beginX <= self._contentEndX or info.endX >= self._contentBeginX and info.endX <= self._contentEndX or info.beginX <= self._contentBeginX and info.endX >= self._contentEndX

		if bInRange then
			local moveGo = info.moveGo
			local moveGoWidth = info.moveGoWidth
			local localPos = GameUtil.getLocalPos(moveGo)
			local x = self._contentBeginX + 50

			x = Mathf.Clamp(x, info.beginX + 42, info.endX - moveGoWidth)

			GameUtil.setLocalPos(moveGo, x, localPos.y, localPos.z)
		end
	end
end

function ActIntroduceDateView:_onContentScrollerValueChanged()
	self._dateScroller.scrollRect.horizontalNormalizedPosition = self._contentScroller.scrollRect.horizontalNormalizedPosition
	self._contentBeginX = -GameUtil.getLocalPos(self._content).x
	self._contentEndX = self._contentBeginX + 1136

	for _, info in ipairs(self._contentCells) do
		self:_updateTxtContentPos(info)
	end
end

function ActIntroduceDateView:_onDateScrollerValueChanged()
	self._contentScroller.scrollRect.horizontalNormalizedPosition = self._dateScroller.scrollRect.horizontalNormalizedPosition
	self._contentBeginX = -GameUtil.getLocalPos(self._content).x
	self._contentEndX = self._contentBeginX + 1136

	for _, info in ipairs(self._contentCells) do
		self:_updateTxtContentPos(info)
	end
end

function ActIntroduceDateView:_onDragDateTableView()
	printInfo("..............ActIntroduceDateView:_onDragDateTableView")
	self:_onDateScrollerValueChanged()
end

function ActIntroduceDateView:_onBeginDragDateTableView()
	printInfo("..............ActIntroduceDateView:_onBeginDragDateTableView")
	self:_onDateScrollerValueChanged()
end

function ActIntroduceDateView:_onEndDragDateTableView()
	printInfo("..............ActIntroduceDateView:_onEndDragDateTableView")
	self:_onDateScrollerValueChanged()
end

function ActIntroduceDateView:_onDragContentTableView()
	printInfo("..............ActIntroduceDateView:_onDragContentTableView")
	self:_onContentScrollerValueChanged()
end

function ActIntroduceDateView:_onBeginDragContentTableView()
	printInfo("..............ActIntroduceDateView:_onBeginDragContentTableView")
	self:_onContentScrollerValueChanged()
end

function ActIntroduceDateView:_onEndDragContentTableView()
	printInfo("..............ActIntroduceDateView:_onEndDragContentTableView")
	self:_onContentScrollerValueChanged()
end

function ActIntroduceDateView:_showActTips(config)
	UIStateManager.instance:push(ViewName.ActIntroduceDateInfoView, config)
end

return ActIntroduceDateView
