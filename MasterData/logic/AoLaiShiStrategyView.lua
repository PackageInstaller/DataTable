-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aolaishilink/view/AoLaiShiStrategyView.lua

module("logic.extensions.aolaishilink.view.AoLaiShiStrategyView", package.seeall)

local AoLaiShiStrategyView = class("AoLaiShiStrategyView", ViewComponent)

function AoLaiShiStrategyView:ctor()
	AoLaiShiStrategyView.super.ctor(self)
end

function AoLaiShiStrategyView:unbindEvents()
	AoLaiShiStrategyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoLaiShiStrategyView:bindEvents()
	AoLaiShiStrategyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoLaiShiStrategyView:buildUI()
	AoLaiShiStrategyView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._tableview = self:getGo("Tableview")
	self._txtTime = self:getTxt("openTime/txt")
	self._cell1 = self:getGo("cell1")
	self._tableList = ScrollerList.create(self._tableview, self._cell1, GameUtil.handler(self._updateTableCell, self), GameUtil.handler(self._clearTableCell, self))
end

function AoLaiShiStrategyView:onEnter()
	AoLaiShiStrategyView.super.onEnter(self)

	local activityType = GameEnum.ActivityType.Summary
	local activityId = AoLaiShiConfig.instance:getActivityCfg(ViewName.AoLaiShiMainView).activityId

	self._txtTime.text = GameUtil.getActTimeDesc(activityType, activityId)

	self:_refreshView()
end

function AoLaiShiStrategyView:_refreshView()
	self.cellCfgList = {}

	local strategycellid = 1
	local cellCfgs = AoLaiShiConfig.instance:getResRoad(strategycellid)

	for i, v in ipairs(cellCfgs) do
		table.insert(self.cellCfgList, v)
	end

	self._tableList:reloadData(self.cellCfgList)
end

function AoLaiShiStrategyView:_updateTableCell(view, cell, data, tag)
	local go = cell.gameObject
	local cellImg = goutil.findChild(go, "img")
	local cellTxt = goutil.findChildTextComponent(go, "txtimg/txt")
	local cellTxtTip = goutil.findChildTextComponent(go, "txtimg/txtTip")

	uGuiUtil.setSpriteToImage(cellImg, nil, data.res)

	cellTxt.text = data.desc
	cellTxtTip.text = data.title .. ":"
end

function AoLaiShiStrategyView:_clearTableCell(cell)
	local go = cell.gameObject
	local cellImg = goutil.findChild(go, "img")

	uGuiUtil.clearImage(cellImg)
end

function AoLaiShiStrategyView:onExit()
	AoLaiShiStrategyView.super.onExit(self)
	self._tableList:dispose()
end

return AoLaiShiStrategyView
