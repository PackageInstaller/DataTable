-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenStagePrizeView.lua

module("logic.extensions.annualfuben.view.AnnualFubenStagePrizeView", package.seeall)

local AnnualFubenStagePrizeView = class("AnnualFubenStagePrizeView", ViewComponent)

AnnualFubenStagePrizeView.STAGE_TYPE_HOLD = 1
AnnualFubenStagePrizeView.STAGE_TYPE_BROKEN = 2

function AnnualFubenStagePrizeView:ctor()
	AnnualFubenStagePrizeView.super.ctor(self)
end

function AnnualFubenStagePrizeView:unbindEvents()
	AnnualFubenStagePrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AnnualFubenStagePrizeView:bindEvents()
	AnnualFubenStagePrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AnnualFubenStagePrizeView:buildUI()
	AnnualFubenStagePrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._itemTablecell = self:getGo("itemTablecell")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AnnualFubenStagePrizeView:onExit()
	AnnualFubenStagePrizeView.super.onExit(self)

	for k, v in pairs(self._itemTableListMap) do
		v:dispose()
	end

	table.clear(self._itemTableListMap)
end

function AnnualFubenStagePrizeView:onEnter()
	AnnualFubenStagePrizeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageType = checknumber(params[2])
	self._itemTableListMap = {}

	self:_refreshView()
end

function AnnualFubenStagePrizeView:_refreshView()
	local stageCfgs

	self._passStageId = 0

	if self._stageType == AnnualFubenStagePrizeView.STAGE_TYPE_HOLD then
		stageCfgs = AnnualFubenConfig.instance:getHoldStageCfgs(self._activityId)
		self._passStageId = AnnualFubenModel.instance:getHoldStageId(self._activityId)
	else
		stageCfgs = AnnualFubenConfig.instance:getBrokenStageCfgs(self._activityId)
		self._passStageId = AnnualFubenModel.instance:getBrokenStageId(self._activityId)
	end

	self._tableList:reloadData(stageCfgs)
end

function AnnualFubenStagePrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local gainGo = goutil.findChild(go, "gain")
	local noReachGo = goutil.findChild(go, "noReach")
	local itemTableview = goutil.findChild(go, "itemTableview")

	itemTableList = self._itemTableListMap[go]

	if not itemTableList and itemTableview and self._itemTablecell then
		itemTableList = ScrollerList.create(itemTableview, self._itemTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		itemTableList:dragNotifyParent()

		self._itemTableListMap[go] = itemTableList
	end

	local prizeArray = string.split(data.prize, "#")

	itemTableList:reloadData(prizeArray)

	txtName.text = langPara("第%d关", data.stageId)

	GameUtil.SetActive(gainGo, data.stageId <= self._passStageId)
	GameUtil.SetActive(noReachGo, data.stageId > self._passStageId)
end

function AnnualFubenStagePrizeView:_clearCell(cell)
	local go = cell.gameObject

	if self._itemTableListMap[go] then
		self._itemTableListMap[go]:dispose()

		self._itemTableListMap[go] = nil
	end
end

function AnnualFubenStagePrizeView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function AnnualFubenStagePrizeView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return AnnualFubenStagePrizeView
