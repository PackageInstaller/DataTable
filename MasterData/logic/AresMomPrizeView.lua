-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomPrizeView.lua

module("logic.extensions.aresmom.view.AresMomPrizeView", package.seeall)

local AresMomPrizeView = class("AresMomPrizeView", ViewComponent)

function AresMomPrizeView:buildUI()
	AresMomPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("tablecell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AresMomPrizeView:bindEvents()
	AresMomPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AresMomPrizeView:unbindEvents()
	AresMomPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AresMomPrizeView:onEnter()
	AresMomPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._challengeId = checknumber(params[1])
	self._curType = checknumber(params[2])

	GlobalDispatcher:addListener(GlobalNotify.AresMomGainPrize, self._refreshPrizeList, self)
	self:_refreshPrizeList()
end

function AresMomPrizeView:onExit()
	AresMomPrizeView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.AresMomGainPrize, self._refreshPrizeList, self)
end

function AresMomPrizeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtTitle.text = data.taskDesc
	cell.txtPrize.text = data.prizeDesc

	if self._curProgress >= data.progress then
		if table.keyof(self._hasGainPrizeIds, data.id) then
			goutil.setActive(cell.markGained, true)
		else
			goutil.setActive(cell.btnReceive, true)
			GameUtil.addClickHandler(cell.btnReceive, GameUtil.handler(self._gainPrize, self, data.id))
		end
	else
		goutil.setActive(cell.markNotFinish, true)
	end
end

function AresMomPrizeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.markGained = goutil.findChild(cell.go, "markGained")
	cell.markNotFinish = goutil.findChild(cell.go, "markNotFinish")
	cell.btnReceive = goutil.findChild(cell.go, "btnReceive")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtPrize = goutil.findChildTextComponent(cell.go, "txtPrize")

	GameUtil.rmClickHandler(cell.btnReceive)
	goutil.setActive(cell.btnReceive, false)
	goutil.setActive(cell.markGained, false)
	goutil.setActive(cell.markNotFinish, false)

	return cell
end

function AresMomPrizeView:_refreshPrizeList()
	self._curInfo = AresMomModel.instance:getChallengeInfo(self._curType)
	self._typeCfg = AresMomConfig.instance:getTypeCfg(self._challengeId, self._curType)
	self._curProgress = 0

	for k, v in pairs(self._curInfo.stageInfoList) do
		self._curProgress = self._curProgress + checkint(v)
	end

	self._hasGainPrizeIds = self._curInfo.gainPrizeIds or {}

	local dataList = self:_getCurDataList()

	self._tableView:reloadData(dataList)
end

function AresMomPrizeView:_getCurDataList()
	local dataList = {}
	local cfgs = AresMomConfig.instance:getPrizeCfgs(self._curType) or {}

	for k, data in ipairs(cfgs) do
		if not table.keyof(self._hasGainPrizeIds, data.id) and self._curProgress >= data.progress then
			table.insert(dataList, data)
		end
	end

	for k, data in ipairs(cfgs) do
		if not table.keyof(self._hasGainPrizeIds, data.id) and self._curProgress < data.progress then
			table.insert(dataList, data)
		end
	end

	for k, data in ipairs(cfgs) do
		if table.keyof(self._hasGainPrizeIds, data.id) then
			table.insert(dataList, data)
		end
	end

	return dataList
end

function AresMomPrizeView:_gainPrize(id)
	AresMomController.instance:gainPrize(self._challengeId, self._curType, id)
end

return AresMomPrizeView
