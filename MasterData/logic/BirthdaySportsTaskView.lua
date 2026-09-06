-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/BirthdaySportsTaskView.lua

module("logic.extensions.birthdaysportswish.view.BirthdaySportsTaskView", package.seeall)

local BirthdaySportsTaskView = class("BirthdaySportsTaskView", ViewComponent)

function BirthdaySportsTaskView:ctor()
	BirthdaySportsTaskView.super.ctor(self)
end

function BirthdaySportsTaskView:buildUI()
	BirthdaySportsTaskView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnsSwitch = {}

	for i = 1, 2 do
		local btn = {}

		btn.go = self:getGo("btn_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		btn.redpoint = goutil.findChild(btn.go, "redpoint")
		self._btnsSwitch[i] = btn
	end

	self._switchId = 1
end

function BirthdaySportsTaskView:bindEvents()
	BirthdaySportsTaskView.super.bindEvents(self)

	for k, btn in ipairs(self._btnsSwitch) do
		GameUtil.addClickHandler(btn.go, GameUtil.handler(self._onClickSwitch, self, k))
	end
end

function BirthdaySportsTaskView:unbindEvents()
	BirthdaySportsTaskView.super.unbindEvents(self)

	for k, btn in ipairs(self._btnsSwitch) do
		GameUtil.rmClickHandler(btn.go)
	end
end

function BirthdaySportsTaskView:onEnter()
	BirthdaySportsTaskView.super.onEnter(self)
	self:_sendInfoReq()
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function BirthdaySportsTaskView:onExit()
	BirthdaySportsTaskView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function BirthdaySportsTaskView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.btnGoTo = goutil.findChild(cell.go, "btnGoTo")
	cell.goFinish = goutil.findChild(cell.go, "finishGo")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "descTxt")
	cell.txtName = goutil.findChildTextComponent(cell.go, "nameTxt")
	cell.txtProger = goutil.findChildTextComponent(cell.go, "progerTxt")
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)
	GameUtil.rmClickHandler(cell.btnGet)
	GameUtil.rmClickHandler(cell.btnGoTo)

	return cell
end

function BirthdaySportsTaskView:_updateCell(view, goCell, temData)
	local data = temData.data
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellListByCfg(data.prize, cell.item)

	cell.txtDesc.text = data.desc
	cell.txtName.text = data.title

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProger.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	GameUtil.SetActive(cell.btnGet, temData.state == 1)
	GameUtil.SetActive(cell.btnGoTo, temData.state == 2)
	GameUtil.SetActive(cell.goFinish, temData.state == 3)
	GameUtil.SetActive(cell.txtProger.gameObject, temData.state ~= 3)
	GameUtil.addClickHandler(cell.btnGoTo, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
end

function BirthdaySportsTaskView:_onClickBtnGo(data)
	if not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)
	end
end

function BirthdaySportsTaskView:_onClickBtnRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._curActId, taskId)
end

function BirthdaySportsTaskView:_onClickSwitch(id)
	if self._switchId ~= id then
		self._switchId = id

		self:_onUpdate()
	end
end

function BirthdaySportsTaskView:_sendInfoReq()
	local data = self:getFirstParam()

	self._curActId = checkint(data and data.openParam)

	if self._curActId ~= 0 then
		EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._curActId)
	end
end

function BirthdaySportsTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function BirthdaySportsTaskView:_onUpdateData()
	self._taskDataQueue = {}

	if self._curActId ~= 0 then
		local queue = EventTaskSummaryConfig.instance:getTaskQueue(self._curActId)

		for pageId, taskList in ipairs(queue) do
			local list = {}

			for idx, data in ipairs(taskList) do
				local timePeriod = GameUtil.getTimePeriod(data.startTime, data.endTime)

				if timePeriod == GameUtil.inTimePeriod then
					local tab = {}

					tab.data = data
					tab.state = EventTaskSummaryController.instance:calcTaskState(self._curActId, data.taskId)

					table.insert(list, tab)
				end
			end

			table.sort(list, function(a, b)
				if a.state == b.state then
					if a.data.taskId < b.data.taskId then
						return true
					end

					return false
				end

				return a.state < b.state
			end)

			self._taskDataQueue[pageId] = list
		end

		table.sort(self._taskDataQueue, function(listA, listB)
			local a = listA[1]
			local b = listB[1]

			if a.state == b.state then
				if a.data.taskId < b.data.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		end)
	end
end

function BirthdaySportsTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()

	for k, v in ipairs(self._btnsSwitch) do
		goutil.setActive(v.select, k == self._switchId)
	end
end

function BirthdaySportsTaskView:_updateTaskScrollerList()
	local list = {}
	local fitterList = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == 3 then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	goutil.setActive(self._btnsSwitch[1].redpoint, false)
	goutil.setActive(self._btnsSwitch[2].redpoint, false)

	for _, v in ipairs(list) do
		if v.data.periodType == "daily" then
			if self._switchId == 1 then
				table.insert(fitterList, v)
			end

			if v.state == 1 then
				goutil.setActive(self._btnsSwitch[1].redpoint, true)
			end
		else
			if self._switchId == 2 then
				table.insert(fitterList, v)
			end

			if v.state == 1 then
				goutil.setActive(self._btnsSwitch[2].redpoint, true)
			end
		end
	end

	self._tableView:reloadData(fitterList)
end

return BirthdaySportsTaskView
