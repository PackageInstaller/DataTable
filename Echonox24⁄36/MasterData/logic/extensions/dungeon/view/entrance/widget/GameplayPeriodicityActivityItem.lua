-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/widget/GameplayPeriodicityActivityItem.lua

module("logic.extensions.dungeon.view.entrance.widget.GameplayPeriodicityActivityItem", package.seeall)

local M = class("GameplayPeriodicityActivityItem", SimpleCellComponent)

function M:buildUI()
	local go = self._go

	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._imgIcon = goutil.findChildImageComponent(go, "click/imgBg")
	self._goLimitTime = goutil.findChild(go, "click/limitTimeSign")
	self._txtName = goutil.findChildTextComponent(go, "click/txtName")
	self._txtTitle = goutil.findChildTextComponent(go, "click/layout/txtTitle")
	self._txtProgress = goutil.findChildTextComponent(go, "click/layout/txtTitle/txtProgress")
	self._txtLimitTime = goutil.findChildTextComponent(go, "click/limitTimeSign/txtLimitTime")
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:bindDispatcherEvent()
	return
end

function M:unbindDispatcherEvent()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_onClick()
	if self._callback ~= nil then
		self._callback()
	end
end

function M:updateData(data)
	self._callback = data.callback
	self._txtTitle.text = data.task
	self._txtName.text = data.name

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Fight, data.icon)
	self:setActive(true)
end

return M
