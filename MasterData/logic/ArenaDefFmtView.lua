-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaDefFmtView.lua

module("logic.extensions.arena.view.ArenaDefFmtView", package.seeall)

local ArenaDefFmtView = class("ArenaDefFmtView", ViewComponent)

function ArenaDefFmtView:ctor()
	ArenaDefFmtView.super.ctor(self)
end

function ArenaDefFmtView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ArenaDefFmtView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function ArenaDefFmtView:buildUI()
	self._closeButton = self:getBtn("Close")
	self._nameTxt = self:getGo("TxtName"):GetComponent("Text")
end

function ArenaDefFmtView:destroyUI()
	return
end

function ArenaDefFmtView:onEnter()
	self._nameTxt.text = self._viewPresentor._openParam[2] .. "的阵型"
end

function ArenaDefFmtView:onEnterFinished()
	return
end

function ArenaDefFmtView:onExit()
	return
end

function ArenaDefFmtView:onExitFinished()
	return
end

function ArenaDefFmtView:_onClickClose()
	self:close()
end

return ArenaDefFmtView
