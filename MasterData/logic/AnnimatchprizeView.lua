-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchprizeView.lua

module("logic.extensions.annimatch.view.AnnimatchprizeView", package.seeall)

local AnnimatchprizeView = class("AnnimatchprizeView", ViewComponent)

function AnnimatchprizeView:ctor()
	AnnimatchprizeView.super.ctor(self)
end

function AnnimatchprizeView:unbindEvents()
	AnnimatchprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.closeBtn)
end

function AnnimatchprizeView:bindEvents()
	AnnimatchprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self.closeBtn, self.close, self)
end

function AnnimatchprizeView:buildUI()
	AnnimatchprizeView.super.buildUI(self)

	self.closeBtn = self:getGo("closeBtn")
	self.priceIitem = self:getGo("priceIitem")
	self.itemCell = self:getGo("itemCell")
	self.tableView = self:getGo("tableView")
	self.scrollList = ScrollerList.create(self.tableView, self.itemCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AnnimatchprizeView:onExit()
	AnnimatchprizeView.super.onExit(self)
	self.scrollList:dispose()
end

function AnnimatchprizeView:onEnter()
	AnnimatchprizeView.super.onEnter(self)

	self.scrollListPool = {}

	local activityId = AnnimatchController.instance:getCurrActId()
	local actCfg = AnnimatchConfig.instance:getCfgById(activityId)
	local prizePlanId = actCfg.prizePlanId
	local cfgList = AnnimatchConfig.instance:getCompetitionPrizeCfg(prizePlanId)
	local list = {}

	for k, v in pairs(cfgList) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, "winTimes")
	self.scrollList:reloadData(list)
end

function AnnimatchprizeView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local tableView = goutil.findChild(cell, "tableView")
	local scrollList = self.scrollListPool[tableView]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableView, self.priceIitem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self.clearItemCell, self))
		self.scrollListPool[tableView] = scrollList

		scrollList:dragNotifyParent()
	end

	local prizeList = MaterialMgr.changeItemStrArr(data.prize)

	scrollList:reloadData(prizeList)

	txtDesc.text = langPara("%s胜", data.winTimes)
end

function AnnimatchprizeView:clearCell(cell)
	local tableView = goutil.findChild(cell, "tableView")
	local scrollList = self.scrollListPool[tableView]

	if scrollList then
		scrollList:dispose()
	end
end

function AnnimatchprizeView:_updateItemCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function AnnimatchprizeView:clearItemCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

return AnnimatchprizeView
