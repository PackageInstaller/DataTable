-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessselectfullstarbuffView.lua

module("logic.extensions.autochess.view.AutochessselectfullstarbuffView", package.seeall)

local AutochessselectfullstarbuffView = class("AutochessselectfullstarbuffView", ViewComponent)

function AutochessselectfullstarbuffView:bindEvents()
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function AutochessselectfullstarbuffView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function AutochessselectfullstarbuffView:buildUI()
	AutochessselectfullstarbuffView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._btnClose = self:getBtn("viewnode/btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._txtBtnSure = self:getTxt("btnSure/txt")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AutochessselectfullstarbuffView:onExit()
	AutochessselectfullstarbuffView.super.onExit(self)
	self._scrollerList:dispose()
	removetimer(self._tick, self)
end

function AutochessselectfullstarbuffView:onEnter()
	AutochessselectfullstarbuffView.super.onEnter(self)
	self.addGEvent(self, AutoChessAgent.ACSelectFullStarBuffRes, self._onACSelectFullStarBuffRes, self)

	self._hasBuffIds = AutochessModel.instance:getEquipBuffIds()
	self._buffCfgs = self:_getBuffCfgs()
	self._currBuffId = self._buffCfgs[1].buffId

	self._scrollerList:reloadData(self._buffCfgs)

	self._activityId = AutochessModel.instance:getActivityId()
	self._tickTime = AutochessConfig.instance:getInitBuffTimeSec(self._activityId)
	self._targetTickTime = ServerTime.now() + self._tickTime - 1

	settimer(1, self._tick, self, true)
	self:_tick()
end

function AutochessselectfullstarbuffView:_onClickbtnClose()
	self:close()
end

function AutochessselectfullstarbuffView:_onClickbtnSure()
	if self._currBuffId > 0 then
		AutochessController.instance:sendPM_ACSelectFullStarBuffReq(self._currBuffId)
	end
end

function AutochessselectfullstarbuffView:_updateCell(view, cell, buffCfg)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local goHasTag = goutil.findChild(cell.gameObject, "hasTag")

	goutil.setActive(goHasTag, self:_hasBuffId(buffCfg.buffId))

	txtName.text = buffCfg.name
	txtDesc.text = buffCfg.buffDesc

	local spriteName = string.format("ui/icon/%s.png", buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(goBuffIcon, nil, spriteName)
	goutil.setActive(goSelect, self._currBuffId == buffCfg.buffId)
	btn:AddClickListener(function()
		if self._currBuffId == buffCfg.buffId then
			return
		end

		self._currBuffId = buffCfg.buffId

		self._scrollerList:refresh()
	end)
end

function AutochessselectfullstarbuffView:_clearCell(cell)
	return
end

function AutochessselectfullstarbuffView:_getBuffCfg(buffId)
	return AutochessConfig.instance:getEquipBuffCfg(buffId)
end

function AutochessselectfullstarbuffView:_getBuffIds()
	return AutochessModel.instance:getFullStarBuffIds()
end

function AutochessselectfullstarbuffView:_getBuffCfgs()
	local buffIds = self:_getBuffIds()
	local cfgs = {}

	for i, buffId in ipairs(buffIds) do
		if buffId > 0 then
			local cfg = self:_getBuffCfg(buffId)

			table.insert(cfgs, cfg)
		end
	end

	return cfgs
end

function AutochessselectfullstarbuffView:_hasBuffId(buffId)
	return self._hasBuffIds[buffId]
end

function AutochessselectfullstarbuffView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._txtBtnSure.text = string.format("领取(%ss)", leftTime)

	if leftTime <= 0 then
		self._txtBtnSure.text = "领取"

		self:_onClickbtnSure()
		self:close()
	end
end

function AutochessselectfullstarbuffView:_onACSelectFullStarBuffRes()
	self:close()
end

return AutochessselectfullstarbuffView
