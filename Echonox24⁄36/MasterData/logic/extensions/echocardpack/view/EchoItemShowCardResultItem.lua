-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoItemShowCardResultItem.lua

module("logic.extensions.echocardpack.view.EchoItemShowCardResultItem", package.seeall)

local M = class("EchoItemShowCardResultItem", EchoItemShowCardView)

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)
	self._gyros = Astral.LuaComponentContainer.Add(self._mainGo, EchoItemGyros)
	self._showGyros = false
	self._ignoreCheckEchoChange = false
	self._curX = 0
	self._startX = 0
	self._hasDragTrigger = false

	self:_buildUI()
end

return M
