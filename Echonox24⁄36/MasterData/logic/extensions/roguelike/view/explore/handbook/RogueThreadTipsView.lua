-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueThreadTipsView.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueThreadTipsView", package.seeall)

local M = class("RogueThreadTipsView", ViewComponent)

function M:buildUI()
	self._goCell = self:getGo("run_group_gain_thread_view_-787779165")
	self._txtPropName = self:getText("run_group_gain_thread_view_1734856286")
	self._txtPropDesc = self:getText("run_group_gain_thread_view_51287642")

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
	GainItemController.instance:clearRogueThreadData()
end

function M:updateData()
	local propMo = self:getFirstParam()

	if propMo == nil then
		print("获得线索为空")

		return
	end

	self._txtPropName.text = propMo:getName()
	self._txtPropDesc.text = StringUtil.replaceAllGraphicText2(propMo:getItemDesc())

	local data = {}

	data.itemId = propMo:getItemId()

	self._propItem:updateData(data)
end

return M
