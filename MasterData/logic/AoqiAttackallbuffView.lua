-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoqiAttackallbuffView.lua

module("logic.extensions.aoqiattackforce.view.AoqiAttackallbuffView", package.seeall)

local AoqiAttackallbuffView = class("AoqiAttackallbuffView", ViewComponent)

function AoqiAttackallbuffView:ctor()
	AoqiAttackallbuffView.super.ctor(self)
end

function AoqiAttackallbuffView:unbindEvents()
	AoqiAttackallbuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function AoqiAttackallbuffView:bindEvents()
	AoqiAttackallbuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function AoqiAttackallbuffView:buildUI()
	AoqiAttackallbuffView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("empty")
	self._btnClose = self:getBtn("btnClose")
end

function AoqiAttackallbuffView:onExit()
	AoqiAttackallbuffView.super.onExit(self)
	self._scrollerList:dispose()
end

function AoqiAttackallbuffView:onEnter()
	AoqiAttackallbuffView.super.onEnter(self)

	self._gianBuffIds = AoQiAttackForceModel.instance:getCurGainBuffs()

	self:_updateUI()
end

function AoqiAttackallbuffView:_updateCell(view, cell, buffId, tag)
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local buffIcon = Framework.ImageBigBG.Get(goBuffIcon)
	local imgChangeLevel = goutil.findChild(cell.gameObject, "level"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local cfg = AoQiAttackForceConfig.instance:getBuffCfgInGameCfg(buffId)

	txtDesc.text = cfg.desc
	txtName.text = cfg.name

	local picPath = string.format("%s.png", cfg.icon)

	buffIcon:SetImage(picPath)
end

function AoqiAttackallbuffView:_clearCell(cell)
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local buffIcon = Framework.ImageBigBG.Get(goBuffIcon)

	buffIcon:ClearImage()
end

function AoqiAttackallbuffView:_updateUI()
	self._scrollerList:reloadData(self._gianBuffIds)

	if self._gianBuffIds then
		local hasData = #self._gianBuffIds > 0

		goutil.setActive(self._emptyGo, not hasData)
	end
end

function AoqiAttackallbuffView:_onClickbtnClose()
	self:close()
end

return AoqiAttackallbuffView
