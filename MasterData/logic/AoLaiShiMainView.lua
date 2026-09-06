-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/AoLaiShiMainView.lua

module("logic.extensions.operationsummary.view.AoLaiShiMainView", package.seeall)

local AoLaiShiMainView = class("AoLaiShiMainView", ViewComponent)

function AoLaiShiMainView:ctor()
	AoLaiShiMainView.super.ctor(self)
end

function AoLaiShiMainView:unbindEvents()
	AoLaiShiMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoLaiShiMainView:bindEvents()
	AoLaiShiMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoLaiShiMainView:buildUI()
	AoLaiShiMainView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._cell1 = self:getGo("cell1")
	self._cell2 = self:getGo("cell2")
	self._cell3 = self:getGo("cell3")
	self.container = self:getGo("objs")
	self._txtTime = self:getTxt("openTime/txt")
	self._effect = self:getGo("effect")
end

function AoLaiShiMainView:onEnter()
	AoLaiShiMainView.super.onEnter(self)

	local activityType = GameEnum.ActivityType.Summary
	local activityId = AoLaiShiConfig.instance:getActivityCfg(ViewName.AoLaiShiMainView).activityId

	self._txtTime.text = GameUtil.getActTimeDesc(activityType, activityId)
	self.items = {}
	self._cfg = {}

	local _cfgList = OperationSummaryConfig.instance:getTaskItemsCfg(activityId)

	for k, v in pairs(_cfgList) do
		table.insert(self._cfg, v)
	end

	goutil.clearChildren(self.container)

	for k, v in pairs(self._cfg) do
		local cell = self:createCell(v)

		table.insert(self.items, cell)
	end

	self.tabActTimePeriod = ActivityDefineController:getActTimePeriod(activityType, activityId)

	self:_loadEffect()
end

function AoLaiShiMainView:onExit()
	AoLaiShiMainView.super.onExit(self)
	self:_removeEffect()

	for i, v in ipairs(self.items) do
		local redPoint = goutil.findChild(v, "imgRed")

		RedPointController.instance:unregRedPoint(redPoint)
	end
end

function AoLaiShiMainView:_loadEffect()
	self:_removeEffect()

	local bgEffectPath = "20240119/liandonghuizong/fx_ui_liandonghuizong_fw.prefab"
	local bgUIEffect = UIEffectManager.instance:playEffect(self, bgEffectPath, self._effect.transform, 0, 0, true, false)

	bgUIEffect:setParent(self._effect.transform)
	bgUIEffect:setScale(1)
	bgUIEffect:setLocalPos(0, 0, 0)

	self._bgUIEffect = bgUIEffect
end

function AoLaiShiMainView:_removeEffect()
	if self._bgUIEffect then
		UIEffectManager.instance:stopEffect(self._bgUIEffect)

		self._bgUIEffect = nil
	end
end

function AoLaiShiMainView:createCell(data)
	local cellName = data.cellName
	local cell
	local cellGo = goutil.clone(cellName == "cell1" and self._cell1 or cellName == "cell2" and self._cell2 or self._cell3, "cell_" .. data.id)

	GameUtil.SetActive(cellGo, true)
	goutil.addChildToParent(cellGo, self.container)

	if not data.pos then
		GameUtil.setAnchoredPos(cellGo, data.pos[1], data.pos[2])
		GameUtil.addClickHandler(cellGo, GameUtil.handler(self._onClickCell, self, data.gotoStr))

		local redPoint = goutil.findChild(cellGo, "imgRed")

		if not string.nilorempty(data.redpointId) then
			GameUtil.SetActive(redPoint, false)

			local isNeedToRegRed = redPoint and not string.nilorempty(data.redpointId) and self.tabActTimePeriod == GameUtil.inTimePeriod

			if isNeedToRegRed then
				RedPointController.instance:unregRedPoint(redPoint)
				RedPointController.instance:regRedPoint(redPoint, unpack(string.split(data.redpointId or "", "#")))
			end
		else
			GameUtil.SetActive(redPoint, false)
		end

		return cellGo
	end
end

function AoLaiShiMainView:_onClickCell(gotoStr)
	GotoMgr.gotoByString(gotoStr)
end

return AoLaiShiMainView
