-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/manual/ManualMainView.lua

module("logic.extensions.controlaction.view.manual.ManualMainView", package.seeall)

local M = class("ManualMainView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("regulatory_manual_panel_-1906116467")
	self._btnSmall = self:getBtn("regulatory_manual_panel_-1009459979")
	self._panelMainGo = self:getGo("regulatory_manual_panel_-2122824068")
	self._panelDetailGo = self:getGo("regulatory_manual_panel_404169966")
	self._scrollRectGo = self:getGo("regulatory_manual_panel_-2122824068")
	self._loopGridView = LoopGridViewHelper.New(self._scrollRectGo)

	self._loopGridView:InitGridView(0, self._updateCell, self)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSmall:AddClickListener(self._onClickSmall, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MANUAL_DATA_DONE, self._refresh, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSmall:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MANUAL_DATA_DONE, self._refresh, self)
end

function M:onEnter()
	ControlActionAgent.instance:sendGetUnlockedProtomersRequest()
	goutil.setActive(self._panelMainGo, true)
	goutil.setActive(self._panelDetailGo, false)

	self._openId = self:getFirstParam() or 0
	self._moList = ControlActionModel.instance:getProtomerMoList()

	self:_setData()
end

function M:onExitFinished()
	return
end

function M:destroyUI()
	return
end

function M:_setData()
	printWarn("====#self._moList====", #self._moList)

	local itemCount = #self._moList

	self._loopGridView:SetListItemCount(itemCount)
	self._loopGridView:RefreshAllShownItem()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("manuaItem")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, ManualMainItem)
	local mo = self._moList[curIndex]

	itemView:refresh(mo)
	itemView:clickItem(self._openId)

	return item
end

function M:_refresh(e, mo)
	self._moList = ControlActionModel.instance:getProtomerMoList()

	self:_setData()
end

function M:_onClickClose()
	ViewMgr.instance:close(ViewName.ControlActionManual)
	GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_CLOSE, 3)
end

function M:_onClickSmall()
	ViewMgr.instance:close(ViewName.ControlActionManual)
end

return M
