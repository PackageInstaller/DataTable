-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tips/impl/ItemTipsImpl.lua

module("logic.common.viewlib.tips.impl.ItemTipsImpl", package.seeall)

local M = class("ItemTipsImpl", BaseTips)

function M:buildUI()
	self._mask = false
	self._code = false
end

function M:onEnter()
	self._mask = ModalMask.addEmptyMask(self.mainGO)

	self._mask:setClickListener(self._onClickMask, self)

	local mousePosition = MainPlayerInputFacade.instance:getScreenPosition()

	TipsPositionUtils.alignScreenPosition(self.mainGO, mousePosition.x, mousePosition.y)
end

function M:onExit()
	ModalMask.releaseMask(self._mask)

	self._mask = false
end

function M:destroyUI()
	self._mask = false
	self._code = false
end

function M:setCode(code)
	self._code = code

	return self
end

function M:_onClickMask()
	self:close()
end

return M
