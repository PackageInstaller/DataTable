-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollExchangeView.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollExchangeView", package.seeall)

local M = class("ClawDollExchangeView", ViewComponent)

function M:buildUI()
	self._btnReturn = self:getBtn("1&universal_second_tips_common_bg_1201003252")
	self._clickExitPanel = self:getBtn("1&universal_second_tips_common_bg_-1467035629")
	self._loopList = LoopListHelper.New(self:getGo("reward_exchange_tips_-1140181510"))

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._btnReturn = nil
	self._clickExitPanel = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._clickExitPanel:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._clickExitPanel:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local cfgId = self:getFirstParam()

	ClawDollAgent.instance:sendGetClipDollInfoRequest(cfgId)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CLAW_DOLL_REFRESHEXCHANGE, self.refreshExchangeLst, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CLAW_DOLL_REFRESHEXCHANGE, self.refreshExchangeLst, self)
	end
end

function M:_onClickReturn()
	self:back()
end

function M:refreshExchangeLst(e, cfgId)
	self._exchangeMoLst = ClawDollController.instance:getClawDollExchangeLstByCfgId(cfgId)

	local count = self._exchangeMoLst and #self._exchangeMoLst or 0

	self._loopList:SetListItemCount(count, false)
	self._loopList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local class = ClawDollExchangeCellItem
	local item = self._loopList:NewListViewItem("exchange_item")
	local taskMo = self._exchangeMoLst[curIndex]
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

	shower:updateData(taskMo)

	return item
end

return M
