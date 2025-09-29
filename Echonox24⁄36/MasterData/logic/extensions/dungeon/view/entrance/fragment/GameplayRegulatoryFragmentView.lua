-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/fragment/GameplayRegulatoryFragmentView.lua

module("logic.extensions.dungeon.view.entrance.fragment.GameplayRegulatoryFragmentView", package.seeall)

local M = class("GameplayRegulatoryFragmentView", GameplaySubViewBase)

function M:buildUI()
	M.super.buildUI(self)

	self._goContent = self._registry:getGo("fight_entry_regulatory_panel_418876108")
	self._goItem = self._goContent.transform:GetChild(0).gameObject

	self:_initViewItems()
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	M.super.onEnter(self)
	self:_setEvent(true)
	self:_refreshView()
end

function M:onExit()
	M.super.onExit(self)
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:_initViewItems()
	local item = Astral.SimpleLuaComponentContainer.Add(self._goItem, GameplayRegulatoryItem)

	self._regulatoryItem = item
end

function M:_refreshView()
	local data = {}
	local systemEnum = GameEnum.SystemEnum.ControlAction

	function data.callback()
		if not self:_checkCanOpen(systemEnum) then
			return
		end

		if not ControlActionModel.instance:isShowLoginView() then
			ViewMgr.instance:open(ViewName.ControlAction)

			return
		end

		ViewMgr.instance:open(ViewName.ControlActionLogin)
	end

	data.unlock = self:_getCanOpen(systemEnum)

	local lockDesc

	if not data.unlock then
		local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(systemEnum)

		if systemOpenCO and not string.nilorempty(systemOpenCO:getUnlockText()) then
			lockDesc = systemOpenCO:getUnlockText()
		end
	end

	data.unlockText = lockDesc

	self._regulatoryItem:updateData(data)
	self:setDoubleHint(self._regulatoryItem)
end

function M:setDoubleHint(item)
	if MultipleDropController.instance:prisonIsOpen() then
		item:setDoubleHint(true)
	else
		item:setDoubleHint(false)
	end
end

return M
