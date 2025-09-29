-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsGetWaysComp.lua

module("logic.extensions.tooltips.component.ToolTipsGetWaysComp", package.seeall)

local M = class("ToolTipsGetWaysComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._getWayGo = nil
	self._wayViewList = {}
end

function M:buildUI()
	self._rootGo = self:getGo("item_detail_tips_827817151")
	self._getWayGo = self:getGo("item_detail_tips_-700021967")
	self._goNoneGetWay = self:getGo("item_detail_tips_copy_1212511792")
	self._goWayItem = goutil.findChild(self._getWayGo, "get_path_item")

	goutil.setActive(self._goWayItem, false)
end

function M:onEnter()
	self:_setEvent(true)

	local info = self:getFirstParam()
	local getWayView = false
	local itemGo = false
	local count = 0

	for k, v in pairs(self._wayViewList) do
		v:setActive(false)
	end

	for k, v in ipairs(info.getWaysInfo or {}) do
		getWayView = self._wayViewList[k]

		if not getWayView then
			itemGo = goutil.cloneAndSetParent(self._goWayItem, self._getWayGo.transform)
			getWayView = ToolTipsGetWayViewNew.New(itemGo)
			self._wayViewList[k] = getWayView
		end

		getWayView:updateData(v)
		getWayView:setJumpParamsTable(self:getJumpParams(info, v))

		count = count + 1
	end

	goutil.setActive(self._goNoneGetWay, count == 0)
	goutil.setActive(self._getWayGo, count ~= 0)
	self:hideGetWay(info.isHideGetWay)
end

function M:getJumpParams(itemData, waysInfo)
	if waysInfo.jumpInfo and waysInfo.jumpInfo.jumpId == 10200003 then
		return {
			itemData.baseData:getItemInfo().heroId,
			itemData.baseData:getItemId(),
			HeroSkinEnum.ShowType.AllSkin
		}
	end

	if itemData.needItemCount then
		return {
			itemData.baseData:getItemId(),
			itemData.needItemCount
		}
	end

	return {}
end

function M:onExit()
	self:_setEvent(false)
	UIFocusMgr.hideFocus()
end

function M:destroyUI()
	for k, v in pairs(self._wayViewList) do
		v:destroy()
	end

	self._wayViewList = nil
	self._getWayGo = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self, 10000)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	end
end

function M:hideGetWay(isHide)
	goutil.setActive(self._rootGo, not isHide)
end

function M:handleJumpViewEvent()
	self:close()
end

return M
