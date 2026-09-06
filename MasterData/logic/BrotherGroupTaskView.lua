-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupTaskView.lua

module("logic.extensions.brothergroup.view.BrotherGroupTaskView", package.seeall)

local BrotherGroupTaskView = class("BrotherGroupTaskView", ViewComponent)

function BrotherGroupTaskView:buildUI()
	BrotherGroupTaskView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableview = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnsSwitch = {}

	for i = 1, 2 do
		local btn = {}

		btn.go = self:getGo("btn_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		btn.redpoint = goutil.findChild(btn.go, "redpoint")
		self._btnsSwitch[i] = btn
	end

	self._btnTips = self:getGo("btnTips")
	self._goCon = self:getGo("con")
end

function BrotherGroupTaskView:bindEvents()
	BrotherGroupTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnsSwitch[1].go, GameUtil.handler(self._onClickSwitch, self, 1))
	GameUtil.addClickHandler(self._btnsSwitch[2].go, GameUtil.handler(self._onClickSwitch, self, 2))
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
end

function BrotherGroupTaskView:unbindEvents()
	BrotherGroupTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnsSwitch[1].go)
	GameUtil.rmClickHandler(self._btnsSwitch[2].go)
end

function BrotherGroupTaskView:onEnter()
	BrotherGroupTaskView.super.onEnter(self)

	self._taskCfgs = BrotherGroupConfig.instance:getTaskCfgs(BrotherGroupModel.instance:getCurActId())
	self._switchId = nil

	self:_onClickSwitch(1)
	BrotherGroupController.instance:getTaskInfo()
	GlobalDispatcher:addListener(GlobalNotify.BrotherGroupUpdateTaskInfo, self._updateTaskList, self)

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, BrotherGroupConfig.instance:getCommomValue("SHOW_PET_SKIN"), self._goCon, 1)
end

function BrotherGroupTaskView:onExit()
	BrotherGroupTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BrotherGroupUpdateTaskInfo, self._updateTaskList, self)
	self._tableview:dispose()

	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function BrotherGroupTaskView:_onClickTips()
	ViewMgr.instance:open(ViewName.RulesView, "brothergrouptaskview")
end

function BrotherGroupTaskView:_onClickSwitch(id)
	if self._switchId ~= id then
		self._switchId = id

		for k, v in ipairs(self._btnsSwitch) do
			goutil.setActive(v.select, k == self._switchId)
		end

		self:_updateTaskList()
	end
end

function BrotherGroupTaskView:_updateTaskList()
	goutil.setActive(self._btnsSwitch[1].redpoint, false)
	goutil.setActive(self._btnsSwitch[2].redpoint, false)

	local dataList = {}
	local queueList = {}
	local typeStr = "daily"

	if self._switchId ~= 1 then
		typeStr = "weekly"
	end

	for k, v in ipairs(self._taskCfgs) do
		local info = BrotherGroupModel.instance:getTaskInfo(v.taskId)

		if info then
			local data = {}

			data.info = info
			data.cfg = v

			if data.info.hasGain then
				data.state = 3
			elseif data.info.curProgress >= data.cfg.maxProgress then
				data.state = 1

				if data.cfg.periodType == "daily" then
					goutil.setActive(self._btnsSwitch[1].redpoint, true)
				else
					goutil.setActive(self._btnsSwitch[2].redpoint, true)
				end
			else
				data.state = 2
			end

			if not queueList[v.pageId] then
				local dataQueue = {}

				table.insert(dataQueue, data)

				queueList[v.pageId] = dataQueue
			end
		end
	end

	for k, dataQueue in pairs(queueList) do
		table.sort(dataQueue, function(a, b)
			if a.state == b.state then
				if a.cfg.taskId < b.cfg.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		end)
	end

	for k, dataQueue in pairs(queueList) do
		local data = dataQueue[1]

		if data.cfg.periodType == typeStr then
			table.insert(dataList, data)
		end
	end

	table.sort(dataList, function(a, b)
		if a.state == b.state then
			if a.cfg.taskId < b.cfg.taskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)
	self._tableview:reloadData(dataList)
end

function BrotherGroupTaskView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	goutil.setActive(cell.btnGet, data.state == 1)
	goutil.setActive(cell.btnGoTo, data.state == 2)
	goutil.setActive(cell.goFinish, data.state == 3)

	cell.txtProger.text = langPara("%s/%s", math.min(data.info.curProgress, data.cfg.maxProgress), data.cfg.maxProgress)
	cell.txtName.text = data.cfg.taskTitle
	cell.txtDesc.text = data.cfg.taskDesc

	MaterialMgr.setCellListByCfg(data.cfg.prize, cell.item)
	GameUtil.addClickHandler(cell.btnGoTo, GameUtil.handler(self._onClickGoTo, self, data.cfg))
	GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickFinish, self, data.cfg))
end

function BrotherGroupTaskView:_clearCell(goCell)
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

function BrotherGroupTaskView:_onClickGoTo(cfg)
	if string.nilorempty(cfg and cfg.jumpTo) then
		return
	end

	GotoMgr.gotoByString(cfg.jumpTo)
end

function BrotherGroupTaskView:_onClickFinish(cfg)
	BrotherGroupController.instance:gainTaskPrize(cfg.taskId)
end

return BrotherGroupTaskView
