-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/view/ChapterOpenTipsView.lua

module("logic.extensions.systemopen.view.ChapterOpenTipsView", package.seeall)

local M = class("ChapterOpenTipsView", ViewComponent)

function M:ctor()
	self._exitHandler = Handler.New()
end

function M:buildUI()
	self._textTitle = self:getText("chapter_unlock_view_-588308488")
	self._textChapter = self:getText("chapter_unlock_view_-381237008")
	self._btnClose = self:getBtn("chapter_unlock_view_201824811")
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	local info = self:getFirstParam()

	self._cfg = info.cfg

	self._exitHandler:setListener(info.exitFunc, info.exitHandler)
	self:_refreshView()
end

function M:onExit()
	return
end

function M:destroyUI()
	self._exitHandler:clear()

	self._exitHandler = nil
end

function M:_refreshView()
	self._textTitle.text = self._cfg.title
	self._textChapter.text = self._cfg.name
end

function M:_onClickClose()
	self:close()
	self._exitHandler:call()
end

return M
