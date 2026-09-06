-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessbuffshowView.lua

module("logic.extensions.autochess.view.AutochessbuffshowView", package.seeall)

local AutochessbuffshowView = class("AutochessbuffshowView", ViewComponent)

function AutochessbuffshowView:ctor()
	AutochessbuffshowView.super.ctor(self)
end

function AutochessbuffshowView:unbindEvents()
	AutochessbuffshowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function AutochessbuffshowView:bindEvents()
	AutochessbuffshowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function AutochessbuffshowView:buildUI()
	AutochessbuffshowView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("viewnode/btnClose")
	self._emptyGo = self:getGo("empty")
end

function AutochessbuffshowView:onExit()
	AutochessbuffshowView.super.onExit(self)
	self._scrollerList:dispose()
end

function AutochessbuffshowView:onEnter()
	AutochessbuffshowView.super.onEnter(self)

	self._activityId = AutochessModel.instance:getActivityId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._curViewDatas = self:_getBuffCfgs()

	self._scrollerList:reloadData(self._curViewDatas)
	goutil.setActive(self._emptyGo, #self._curViewDatas <= 0)
end

function AutochessbuffshowView:_getBuffCfgs()
	local buffIds = self:_getBuffIds()
	local cfgs = {}
	local isUseBuffIds = {}

	for i, buffId in ipairs(buffIds) do
		if buffId > 0 and not isUseBuffIds[buffId] then
			isUseBuffIds[buffId] = true

			local cfg = self:_getBuffCfg(buffId)

			table.insert(cfgs, cfg)
		end
	end

	return cfgs
end

function AutochessbuffshowView:_updateCell(view, cell, buffCfg)
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	txtName.text = buffCfg.name
	txtDesc.text = buffCfg.buffDesc

	local spriteName = string.format("ui/icon/%s.png", buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(goBuffIcon, nil, spriteName)
end

function AutochessbuffshowView:_clearCell(cell)
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")

	uGuiUtil.clearImage(goBuffIcon)
end

function AutochessbuffshowView:_getBuffIds()
	local buffIds = AutochessModel.instance:getEquipBuffIds()

	return table.values(buffIds)
end

function AutochessbuffshowView:_getBuffCfg(buffId)
	return AutochessConfig.instance:getEquipBuffCfg(buffId)
end

function AutochessbuffshowView:_onClickbtnClose()
	self:close()
end

return AutochessbuffshowView
