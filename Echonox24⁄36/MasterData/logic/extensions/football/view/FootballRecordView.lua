-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballRecordView.lua

module("logic.extensions.football.view.FootballRecordView", package.seeall)

local M = class("FootballRecordView", ViewComponent)

function M:buildUI()
	self._loopListHelper = LoopListHelper.New(self:getGo("football_report_tips_1775044597"))

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._closeBtn = self:getBtn("1&middle_tips_common_bg_-1205189576")
end

function M:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.FOOTBALL_RECORD_UPDATE, self._onNotifyRecordUpdate, self)
end

function M:onEnter()
	self:_bindEvents()

	self._recordList = {}

	FootballAgent.instance:sendGetRecordListRequest()

	self._hasSendReq = true
end

function M:_onNotifyRecordUpdate(_, recordList)
	self._hasSendReq = false

	local fmt = "%Y/%m/%d"
	local lastDay = 0

	for i, v in ipairs(recordList) do
		local day = math.floor(v.timestamp / 3600 / 24 / 1000)

		if day ~= lastDay then
			local data = {}

			data.isTime = true
			data.time = ServerTime.formatTimeServerLook(math.floor(v.timestamp / 1000), fmt)

			table.insert(self._recordList, data)

			lastDay = day
		end

		table.insert(self._recordList, v)
	end

	self:_refreshView()
end

function M:_refreshView()
	self._loopListHelper:SetListItemCount(#self._recordList, true)
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._recordList[curIndex]

	if not itemData.isTime then
		local item = self._loopListHelper:NewListViewItem("football_report_item")
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, FootballRecordCell)

		shower:setData(itemData)

		return item
	else
		local item = self._loopListHelper:NewListViewItem("football_time_item")
		local timeTxt = goutil.findChildTextComponent(item, "txtTime")

		timeTxt.text = itemData.time

		return item
	end
end

function M:onExit()
	self:_unbindEvents()
	self._loopListHelper:ClearCells()
end

function M:unbindEvents()
	self._closeBtn:RemoveClickListener()
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.FOOTBALL_RECORD_UPDATE, self._onNotifyRecordUpdate, self)
end

function M:_onClickClose()
	self:close()
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

return M
