-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/BackpackPropOperateView.lua

module("logic.extensions.backpack.view.filterview.BackpackPropOperateView", package.seeall)

local M = class("BackpackPropOperateView", ViewComponent)
local dropDown2type = {
	CommEnum.PropFilterType.AllFilterType,
	CommEnum.PropFilterType.BaseFilterType,
	CommEnum.PropFilterType.CultivateFilterType,
	CommEnum.PropFilterType.TacitFilterType
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._rootGo = self:getGo("backpack_view_copy_1732289744")
	self._dropDown = self:getUIComponent("backpack_view_copy_-1108801006", UIComponentType.SpaceXDropDown)
	self._goUpFilterCareer = self:getGo("backpack_view_copy_1301823066")
	self._goDownFilterCareer = self:getGo("backpack_view_copy_-1032399899")
end

function M:bindEvents()
	self._dropDown:AddOnValueChange(self._onDropDownChanged, self)
	self._dropDown:AddOnDropDownListShow(self._onDropDownListShow, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchShowType, self)
end

function M:unbindEvents()
	self._dropDown:RemoveAllListener()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchShowType, self)
end

function M:_onSwitchShowType(e, showType)
	local isShow = showType == CommEnum.MainBackpackShowType.PropShowType

	goutil.setActive(self._rootGo, isShow)
end

function M:_onBackpackPageDataChanged(e, changeType)
	local curShowType = MainBackpackModel.instance:getCurShowType()
	local isShow = curShowType == CommEnum.MainBackpackShowType.PropShowType and not MainBackpackModel.instance:isEmpty()

	if changeType == CommEnum.MainBackpackRefreshType.SwitchPage then
		goutil.setActive(self._rootGo, isShow)
	end
end

function M:_onDropDownChanged(index)
	self._dropDownIndex = index

	local filter = MainBackpackModel.instance:getCurFilterCfg()

	if filter then
		filter:setFilterType(dropDown2type[index + 1])
		GlobalDispatcher:dispatchEvent(EventType.BACKPACK_FILTER_EVENT)
	end
end

function M:_onDropDownListShow(show)
	if show then
		goutil.setActive(self._goUpFilterCareer, false)
		goutil.setActive(self._goDownFilterCareer, true)
	else
		goutil.setActive(self._goUpFilterCareer, true)
		goutil.setActive(self._goDownFilterCareer, false)
	end
end

return M
