-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/view/BirthdayCakeTaskView.lua

module("logic.extensions.birthdaycake.view.BirthdayCakeTaskView", package.seeall)

local BirthdayCakeTaskView = class("BirthdayCakeTaskView", ViewComponent)
local taskTabName = {
	activeTask = 1,
	dayTask = 0
}

function BirthdayCakeTaskView:ctor()
	BirthdayCakeTaskView.super.ctor(self)

	self._selectTab = taskTabName.dayTask
end

function BirthdayCakeTaskView:unbindEvents()
	BirthdayCakeTaskView.super.unbindEvents(self)
	self._btnDayTask:RemoveClickListener()
	self._btnActiveTask:RemoveClickListener()
	self._close:RemoveClickListener()
end

function BirthdayCakeTaskView:bindEvents()
	BirthdayCakeTaskView.super.bindEvents(self)
	self._btnDayTask:AddClickListener(self._onClickDayTask, self)
	self._btnActiveTask:AddClickListener(self._onClickActiveTask, self)
	self._close:AddClickListener(function()
		self:close()
	end)
end

function BirthdayCakeTaskView:onExit()
	BirthdayCakeTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BirthdayCakeTaskInfo, self._refreshTaskList, self)
	GlobalDispatcher:removeListener(GlobalNotify.BirthdayCakeTaskReq, self._getTaskInfo, self)
end

function BirthdayCakeTaskView:buildUI()
	BirthdayCakeTaskView.super.buildUI(self)

	self._close = self:getBtn("close")
	self._btnDayTask = self:getBtn("btnDayTask")
	self._btnActiveTask = self:getBtn("btnActiveTask")
	self._cell = self:getGo("cell")
	self._tableview = self:getGo("tableview")
	self._cellItem = self:getGo("item")
	self._cellList = self:getGo("cell/rewardview")
	self._dayRedpoint = self:getGo("btnDayTask/redpoint")
	self._activeRedpoint = self:getGo("btnActiveTask/redpoint")
	self._changeDayTask = self._btnDayTask:GetComponent(typeof(UIChangeGroup))
	self._changeActiveTask = self._btnActiveTask:GetComponent(typeof(UIChangeGroup))
	self._taskTabList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateTaskTabList, self), GameUtil.handler(self._clearTaskTabList, self))
end

function BirthdayCakeTaskView:onEnter()
	BirthdayCakeTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BirthdayCakeTaskInfo, self._refreshTaskList, self)
	GlobalDispatcher:addListener(GlobalNotify.BirthdayCakeTaskReq, self._getTaskInfo, self)

	self._curActId = BirthdayCakeModel.instance:getActivityId()
	self._cellTabList = {}

	BirthdayCakeAgent.instance:sendPM_BirthdayCakeTaskInfoReq(self._curActId)
end

function BirthdayCakeTaskView:_refreshTaskList()
	local taskList = BirthdayCakeModel.instance:getTaskList()

	self._dayTasks = {}
	self._activeTask = {}

	local dayList = {}
	local actList = {}

	for i, v in ipairs(taskList) do
		local cfg = BirthdayCakeConfig.instance:getTaskCfgById(self._curActId, v.taskId)

		cfg.state = v.reward and 3 or v.curProgress >= cfg.progress and 1 or 2
		cfg.curProgress = v.curProgress
		cfg.reward = v.reward

		if cfg.refreshType == "daily" then
			self:_screenTask(dayList, cfg)
		else
			self:_screenTask(actList, cfg)
		end
	end

	goutil.setActive(self._dayRedpoint, false)
	goutil.setActive(self._activeRedpoint, false)

	for k, v in pairs(dayList) do
		if v.state == 1 then
			goutil.setActive(self._dayRedpoint, true)
		end

		table.insert(self._dayTasks, v)
	end

	for k, v in pairs(actList) do
		if v.state == 1 then
			goutil.setActive(self._activeRedpoint, true)
		end

		table.insert(self._activeTask, v)
	end

	table.sort(self._dayTasks, function(a, b)
		if a.state == b.state then
			return a.taskId < b.taskId
		end

		return a.state < b.state
	end)
	table.sort(self._activeTask, function(a, b)
		if a.state == b.state then
			return a.taskId < b.taskId
		end

		return a.state < b.state
	end)

	if self._selectTab == taskTabName.dayTask then
		self:_onClickDayTask()
	elseif self._selectTab == taskTabName.activeTask then
		self:_onClickActiveTask()
	end
end

function BirthdayCakeTaskView:_onClickDayTask()
	self:_setBtnActive(true)
	self._taskTabList:reloadData(self._dayTasks)
end

function BirthdayCakeTaskView:_onClickActiveTask()
	self:_setBtnActive(false)
	self._taskTabList:reloadData(self._activeTask)
end

function BirthdayCakeTaskView:_setBtnActive(isDayTask)
	self._changeDayTask:SetState(isDayTask and 1 or 0)
	self._changeActiveTask:SetState(isDayTask and 0 or 1)

	if isDayTask then
		self._selectTab = taskTabName.dayTask or taskTabName.activeTask
	end
end

function BirthdayCakeTaskView:_getTaskInfo()
	BirthdayCakeAgent.instance:sendPM_BirthdayCakeTaskInfoReq(self._curActId)
end

function BirthdayCakeTaskView:_updateTaskTabList(view, cell, data)
	local btnGoto = goutil.findChild(cell, "btnGoto")
	local btnRecieve = goutil.findChild(cell, "btnRecieve")
	local receive = goutil.findChild(cell, "receive")
	local rewardview = goutil.findChild(cell, "rewardview")
	local titleTxt = goutil.findChildTextComponent(cell, "titleTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local progressTxt = goutil.findChildTextComponent(cell, "progressTxt")
	local prizes = string.split(data.prize, "#")

	titleTxt.text = data.title
	descTxt.text = data.desc
	progressTxt.text = string.format("%s/%s", data.curProgress, data.progress)

	goutil.setActive(btnRecieve, data.state == 1)
	goutil.setActive(btnGoto, data.state == 2)
	goutil.setActive(receive, data.state == 3)

	self._cellTabList[cell] = self._cellTabList[cell] or ScrollerList.create(rewardview, self._cellItem, GameUtil.handler(self._updateCellList, self), GameUtil.handler(self._clearCellList, self))

	self._cellTabList[cell]:reloadData(prizes)
	GameUtil.asBtn(btnGoto):RemoveClickListener()
	GameUtil.asBtn(btnGoto):AddClickListener(function()
		GotoMgr.gotoByString(data.jumpGoto)
	end)
	GameUtil.asBtn(btnRecieve):RemoveClickListener()
	GameUtil.asBtn(btnRecieve):AddClickListener(function()
		BirthdayCakeAgent.instance:sendPM_BirthdayCakeTaskGetRewardReq(self._curActId, data.taskId)
	end)
end

function BirthdayCakeTaskView:_clearTaskTabList(cell)
	return
end

function BirthdayCakeTaskView:_updateCellList(view, cell, data)
	MaterialMgr.resetAll(cell)
	MaterialMgr.setCellByCfg(data, cell)
end

function BirthdayCakeTaskView:_clearCellList(cell)
	MaterialMgr.resetAll(cell)
end

function BirthdayCakeTaskView:_screenTask(list, cfg)
	if not list[cfg.type] then
		list[cfg.type] = cfg
	elseif list[cfg.type].reward and cfg.taskId > list[cfg.type].taskId then
		list[cfg.type] = cfg
	elseif not list[cfg.type].reward and cfg.taskId < list[cfg.type].taskId then
		list[cfg.type] = cfg
	end
end

return BirthdayCakeTaskView
