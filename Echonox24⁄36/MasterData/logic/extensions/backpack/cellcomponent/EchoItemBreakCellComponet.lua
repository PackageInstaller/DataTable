-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/EchoItemBreakCellComponet.lua

module("logic.extensions.backpack.cellcomponent.EchoItemBreakCellComponet", package.seeall)

local M = class("EchoItemBreakCellComponet", EchoItemCellComponet)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	M.super.onInit(self)

	self._cutBtn = Astral.ButtonAdapter.Get(self._btnCutGo)

	self._cutBtn:AddClickListener(self._onClickCutBtn, self)
end

function M:setCutGoVisible(visible)
	self._btnCutGo:SetActive(visible)
end

function M:_onClickCutBtn()
	self._cell:unSelect()
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._cutBtn:RemoveClickListener()
end

return M
