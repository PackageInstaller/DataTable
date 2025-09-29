-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/BattleRecordView.lua

module("logic.extensions.battlerecord.view.BattleRecordView", package.seeall)

local BattleRecordView = class("BattleRecordView", ViewComponent)

function BattleRecordView:buildUI()
	self._btnStart = self:getBtnByPath("bottom/btnStart")
	self._btnClose = self:getBtnByPath("btnClose")
	self._btnLoadRecordList = self:getBtnByPath("bottom/btnLoadRecordList")
	self._inputUserId = self:getInputByPath("bottom/inputUserId")
	self._inputRecordId = self:getInputByPath("bottom/inputRecordId")
	self._goTemplate = goutil.findChild(self.mainGO, "ScrollView/Viewport/template")
	self._scrollRect = Astral.ScrollRectLoop.Get(goutil.findChild(self.mainGO, "ScrollView"))

	self._scrollRect:InitFix(kScrollDirV, 375, 150, 5, 5, 4, self._onCellUpdate, self)

	self._recordItemList = {}
	self._recordMOList = false

	self._inputUserId:SetText(PlayerModel.instance:getId())
	goutil.setActive(self._goTemplate, false)
end

function BattleRecordView:destroyUI()
	self._btnStart = nil
	self._btnLoadRecordList = nil
	self._inputUserId = nil
	self._inputRecordId = nil
	self._scrollRect = nil
end

function BattleRecordView:bindEvents()
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnLoadRecordList:AddClickListener(self._onClickLoadRecordList, self)
end

function BattleRecordView:unbindEvents()
	self._btnStart:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnLoadRecordList:RemoveClickListener()
end

function BattleRecordView:onEnter()
	self:_setEvent(true)
	self:_onRecordListUpdate()
	self:_updateBattleRecordList()
end

function BattleRecordView:onExit()
	self:_setEvent(false)
	self:_clearRecordItem()
end

function BattleRecordView:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.BATTLE_RECORD_LIST_UPDATE, self._onRecordListUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.BATTLE_RECORD_LIST_UPDATE, self._onRecordListUpdate, self)
	end
end

function BattleRecordView:_updateBattleRecordList()
	local userId = checkint(self._inputUserId:GetText())

	BattleRecordAgent.instance:sendGetBattleRecordListRequest(userId)
end

function BattleRecordView:_clearRecordItem()
	for _, recordItem in ipairs(self._recordItemList) do
		recordItem:destroy()
	end

	BattleTableUtil.clearTable(self._recordItemList)
end

function BattleRecordView:_onClickLoadRecordList()
	self:_updateBattleRecordList()
end

function BattleRecordView:_onRecordListUpdate()
	self._recordMOList = BattleRecordModel.instance:getRecordMOList()
	self._scrollRect.TotalCellNum = #self._recordMOList
end

function BattleRecordView:_onClickStart()
	local userId = checkint(self._inputUserId:GetText())
	local recordId = checkint(self._inputRecordId:GetText())

	if userId <= 0 or recordId <= 0 then
		FloatWordMgr.instance:show("Invalid recordId!!!")

		return
	end

	self:close()
	BattleRecordAgent.instance:sendGetBattleRecordRequest(userId, recordId)
end

function BattleRecordView:_onCellUpdate(cellTransform, cellIndex, prevIndex)
	if not self._scrollRect then
		return
	end

	cellIndex = cellIndex + 1

	local itemGO = goutil.findChild(cellTransform.gameObject, "BattleRecordViewItem")
	local cellBehavior

	if itemGO then
		cellBehavior = Astral.SimpleLuaComponentContainer.Get(itemGO, BattleRecordViewItem)
	else
		itemGO = goutil.clone(self._goTemplate)
		itemGO.name = "BattleRecordViewItem"

		goutil.addChildToParent(itemGO, cellTransform.gameObject)
		goutil.setActive(itemGO, true)

		cellBehavior = Astral.SimpleLuaComponentContainer.Add(itemGO, BattleRecordViewItem)

		cellBehavior:setHandler(self)
		table.insert(self._recordItemList, cellBehavior)
	end

	local recordMO = self._recordMOList[cellIndex]

	cellBehavior:setRecordMO(recordMO)
end

function BattleRecordView:onClickRecordItem(recordMO)
	self._inputRecordId:SetText(recordMO.recordId)
end

function BattleRecordView:_onClickClose()
	self:close()
end

return BattleRecordView
