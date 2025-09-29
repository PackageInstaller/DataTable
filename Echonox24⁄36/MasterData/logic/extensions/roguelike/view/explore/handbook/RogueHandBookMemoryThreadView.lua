-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookMemoryThreadView.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookMemoryThreadView", package.seeall)

local M = class("RogueHandBookMemoryThreadView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._goCell = self:getGo("run_group_handbook_thread_tips_-1642169147")
	self._txtThreadName = self:getText("run_group_event_view_-851054734")
	self._txtThreadDesc = self:getText("run_group_event_view_-669862653")

	local backpackItem = goutil.findChild(self._goCell, "backpack_item")
	local item = Astral.LuaComponentContainer.Add(backpackItem, RogueThreadItem)

	self._propItem = item
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:updateData()
end

function M:onExit()
	return
end

function M:updateData()
	local threadCo = self:getFirstParam()

	self._txtThreadName.text = threadCo.name
	self._txtThreadDesc.text = StringUtil.replaceAllGraphicText2(threadCo.desc)

	local data = {}

	data.itemId = threadCo.id

	self._propItem:updateData(data)
end

return M
