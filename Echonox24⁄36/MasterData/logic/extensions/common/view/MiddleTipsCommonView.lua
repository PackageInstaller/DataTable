-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/MiddleTipsCommonView.lua

module("logic.extensions.common.view.MiddleTipsCommonView", package.seeall)

local M = class("MiddleTipsCommonView", ViewComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnExit = ButtonAdapter.Get(goutil.findChild(self.mainGO, "middle_tips_common_bg/clickExit"))
	self._btnClose = ButtonAdapter.Get(goutil.findChild(self.mainGO, "middle_tips_common_bg/btnClose"))
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnExit:AddClickListener(self._onClickExit, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnExit:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:onExitFinished()
	return
end

function M:_onClickClose()
	self:close()
end

function M:_onClickExit()
	self:close()
end

function M:destroyUI()
	self._btnExit = nil
	self._btnClose = nil
end

return M
