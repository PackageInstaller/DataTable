-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolDiceMockView.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolDiceMockView", package.seeall)

local M = class("RogueHackToolDiceMockView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("0&title_view_-878360263")

	local oneDicePanel = self:getGo("dice_mock_view_-992129325")

	self._oneDicePanel = Astral.LuaComponentContainer.Add(oneDicePanel, RogueHackToolDiceOnceTestView)
end

function M:onEnter()
	self._oneDicePanel:onEnter()
	self._multipleDicePanel:onEnter()
end

function M:onExit()
	self._oneDicePanel:onExit()
	self._multipleDicePanel:onExit()
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._oneDicePanel:bindEvents()
	self._multipleDicePanel:bindEvents()
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._oneDicePanel:unbindEvents()
	self._multipleDicePanel:unbindEvents()
end

function M:destroyUI()
	self._oneDicePanel:destroyUI()
	self._multipleDicePanel:destroyUI()

	self._btnClose = nil
	self._oneDicePanel = nil
	self._multipleDicePanel = nil
end

function M:_onClickClose()
	self:close()
end

return M
