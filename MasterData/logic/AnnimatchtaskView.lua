-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchtaskView.lua

module("logic.extensions.annimatch.view.AnnimatchtaskView", package.seeall)

local AnnimatchtaskView = class("AnnimatchtaskView", ViewComponent)

function AnnimatchtaskView:ctor()
	AnnimatchtaskView.super.ctor(self)
end

function AnnimatchtaskView:unbindEvents()
	AnnimatchtaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.closeBtn)
end

function AnnimatchtaskView:bindEvents()
	AnnimatchtaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self.closeBtn, self.close, self)
end

function AnnimatchtaskView:buildUI()
	AnnimatchtaskView.super.buildUI(self)

	self.closeBtn = self:getGo("closeBtn")
	self.tableView = self:getGo("tableView")
	self.itemCell = self:getGo("itemCell")
	self.item = self:getGo("item")
	self.scrollList = ScrollerList.create(self.tableView, self.itemCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AnnimatchtaskView:onExit()
	AnnimatchtaskView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.OnAnnimatchGetTaskInfo, self.refreshUI, self)
end

function AnnimatchtaskView:onEnter()
	AnnimatchtaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnAnnimatchGetTaskInfo, self.refreshUI, self)

	local activityId = AnnimatchController.instance:getCurrActId()

	AnnimatchController.instance:sendGetTaskInfo(activityId)
	self:refreshUI()
end

function AnnimatchtaskView:refreshUI()
	local activityId = AnnimatchController.instance:getCurrActId()
	local actCfg = AnnimatchConfig.instance:getCfgById(activityId)
	local prizePlanId = actCfg.prizePlanId
	local cfgList = AnnimatchConfig.instance:getCompetitionTaskCfg(prizePlanId)
	local list = {}

	for k, v in pairs(cfgList) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, "taskId")
	self.scrollList:reloadData(list)
end

function AnnimatchtaskView:_updateCell(view, cell, data, tag)
	local txtTask = goutil.findChildTextComponent(cell, "txtTask")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local priceItem = goutil.findChild(cell, "priceItem")
	local btnGo = goutil.findChild(cell, "btnGo")
	local btnReceive = goutil.findChild(cell, "btnReceive")
	local receivedGo = goutil.findChild(cell, "receivedGo")

	GameUtil.SetActive(btnGo, false)

	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getTaskInfo(activityId, data.taskId) or {}

	GameUtil.updateCellsList(priceItem, self.item, string.split(data.prize, "#"), function(go, str, idx)
		MaterialMgr.setCellByCfg(str, go)
	end)

	local curProgress = math.min(checknumber(info.curProgress), data.maxProgress)

	txtTask.text = data.title

	local desc = AnnimatchConfig.instance:getCommonByKey("TASK_VIWE_PROGRESS")

	txtDesc.text = data.desc .. " " .. langPara(desc, curProgress, data.maxProgress)

	GameUtil.SetActive(btnReceive, not info.hasGainedPrize)
	GameUtil.SetActive(receivedGo, info.hasGainedPrize)
	GameUtil.SetGray(btnReceive, curProgress < data.maxProgress)
	GameUtil.addClickHandler(btnReceive, function()
		if curProgress >= data.maxProgress then
			AnnimatchController.instance:sendGetTaskPrize(activityId, data.taskId)
		else
			local desc = AnnimatchConfig.instance:getCommonByKey("TASK_VIWE_NOT_ENOUTH")

			TipsFacade.instance:openCommonTips(desc)
		end
	end)
end

function AnnimatchtaskView:clearCell(cell)
	local priceItem = goutil.findChild(cell, "priceItem")

	GameUtil.clearCells(priceItem, function(cell, idx)
		MaterialMgr.resetAll(cell)
	end)
end

return AnnimatchtaskView
