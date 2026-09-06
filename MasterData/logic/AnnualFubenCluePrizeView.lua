-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenCluePrizeView.lua

module("logic.extensions.annualfuben.view.AnnualFubenCluePrizeView", package.seeall)

local AnnualFubenCluePrizeView = class("AnnualFubenCluePrizeView", ViewComponent)

function AnnualFubenCluePrizeView:ctor()
	AnnualFubenCluePrizeView.super.ctor(self)
end

function AnnualFubenCluePrizeView:unbindEvents()
	AnnualFubenCluePrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AnnualFubenCluePrizeView:bindEvents()
	AnnualFubenCluePrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AnnualFubenCluePrizeView:buildUI()
	AnnualFubenCluePrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._itemTablecell = self:getGo("itemTablecell")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AnnualFubenCluePrizeView:onExit()
	AnnualFubenCluePrizeView.super.onExit(self)

	for k, v in pairs(self._itemTableListMap) do
		v:dispose()
	end

	table.clear(self._itemTableListMap)
end

function AnnualFubenCluePrizeView:onEnter()
	AnnualFubenCluePrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AnnualFubenInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._itemTableListMap = {}

	self:_refreshView()
end

function AnnualFubenCluePrizeView:_refreshView()
	local clueMaps = AnnualFubenController:getAllGainClueIds(self._activityId)

	self._curGainClueCount = table.nums(clueMaps)

	local prizeCfgs = AnnualFubenConfig.instance:getCluePrizeCfgs(self._activityId)

	self._tableList:reloadData(prizeCfgs)
end

function AnnualFubenCluePrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local gainGo = goutil.findChild(go, "gain")
	local notReachGo = goutil.findChild(go, "notReach")
	local itemTableview = goutil.findChild(go, "itemTableview")
	local btnGet = goutil.findChild(go, "btnGet")

	itemTableList = self._itemTableListMap[go]

	if not itemTableList and itemTableview and self._itemTablecell then
		itemTableList = ScrollerList.create(itemTableview, self._itemTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		itemTableList:dragNotifyParent()

		self._itemTableListMap[go] = itemTableList
	end

	local prizeArray = string.split(data.prize, "#")

	itemTableList:reloadData(prizeArray)

	txtName.text = langPara("累计解锁%d条线索", data.clueNum)

	local isGainPrize = AnnualFubenModel.instance:isGainCluePrize(self._activityId, data.prizeId)

	GameUtil.SetActive(gainGo, isGainPrize)
	GameUtil.SetActive(notReachGo, not isGainPrize and data.clueNum > self._curGainClueCount)
	GameUtil.SetActive(btnGet, not isGainPrize and data.clueNum <= self._curGainClueCount)
	GameUtil.rmClickHandler(btnGet)
	GameUtil.addClickHandler(btnGet, function()
		AnnualFubenAgent.instance:sendPM_AnnualFubenGainCluePrizeReq(self._activityId, data.prizeId)
	end)
end

function AnnualFubenCluePrizeView:_clearCell(cell)
	local go = cell.gameObject

	if self._itemTableListMap[go] then
		self._itemTableListMap[go]:dispose()

		self._itemTableListMap[go] = nil
	end
end

function AnnualFubenCluePrizeView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AnnualFubenCluePrizeView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return AnnualFubenCluePrizeView
