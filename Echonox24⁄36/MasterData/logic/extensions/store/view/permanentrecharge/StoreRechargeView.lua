-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/permanentrecharge/StoreRechargeView.lua

module("logic.extensions.store.view.permanentrecharge.StoreRechargeView", package.seeall)

local M = class("StoreRechargeView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("store_member_welfare_tips_-786098104")
	self._btnExplain = self:getBtn("store_member_welfare_tips_-1499926045")
	self._goShow = self:getGo("store_member_welfare_tips_41576580")
	self._goHide = self:getGo("store_member_welfare_tips_534138266")
	self._btnSee = self:getBtn("store_member_welfare_tips_699681358")
	self._txtCunRecharge = self:getText("store_member_welfare_tips_-1462248447")
	self._txtNextRecharge = self:getText("store_member_welfare_tips_-655419373")

	local goScroll = self:getGo("store_member_welfare_tips_-2015945923")

	self._scrollView = LoopListHelper.New(goScroll)

	self._scrollView:InitListView(0, self._updateCell, self)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._handleDataUpdate, self)
		GlobalDispatcher:addEventListener(EventType.STORE_RECHARGE_GET_REWARD, self._handleGetReward, self)
	else
		GlobalDispatcher:removeEventListener(EventType.STORE_RECHARGE_DATA_UPDATE, self._handleDataUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.STORE_RECHARGE_GET_REWARD, self._handleGetReward, self)
	end
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnSee:AddClickListener(self._onClickSee, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnSee:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)
	goutil.setActive(self._scrollView.gameObject, false)

	local key = StoreEnum.StoreRechargeKey

	self._canSee = PlayerModel.instance:getLocalStorageInt(key, 1) == 1

	StoreRechargeAgent.instance:sendGetRechargeInfoRequest()
	ViewMgr.instance:close(ViewName.StoreMainViewViewPresentor)
end

function M:onExit()
	self:_setEvent(false)
end

function M:destroyUI()
	self._scrollView:ClearCells()
	self._scrollView:Dispose()

	self._scrollView = nil
end

function M:_onClickClose()
	self:close()
	StoreMainFacade.instance:jumpToStore(StoreEnum.TabId.HotList, 110001)
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.StoreRechargeExplainView)
end

function M:_onClickSee()
	self._canSee = not self._canSee

	local key = StoreEnum.StoreRechargeKey

	PlayerModel.instance:setLocalStorageInt(key, self._canSee and 1 or 0)
	self:_refreshText()
end

function M:_refreshText()
	if self._canSee then
		self._txtCunRecharge.text = StoreRechargeModel.instance:getCurCredit()
		self._txtNextRecharge.text = StoreRechargeModel.instance:getNextCredit()
	else
		self._txtCunRecharge.text = "***"
		self._txtNextRecharge.text = "***"
	end

	goutil.setActive(self._goShow, not self._canSee)
	goutil.setActive(self._goHide, self._canSee)
end

function M:_handleDataUpdate()
	self:_refreshText()
	goutil.setActive(self._scrollView.gameObject, true)

	self._curShowList = StoreRechargeModel.instance:getRewardList()

	local count = #self._curShowList

	self._scrollView:SetListItemCount(count, true)
	self._scrollView:RefreshAllShownItem()

	local moveToIndex = 0

	for i = 1, #self._curShowList - 1 do
		local curStatus = self._curShowList[i]:getItemStatus()
		local nextStatus = self._curShowList[i + 1]:getItemStatus()
		local itemStatus = StoreEnum.StoreRechargeStatus

		if curStatus == itemStatus.canGet then
			moveToIndex = i - 1

			break
		end

		if curStatus == itemStatus.hasGet and nextStatus ~= itemStatus.hasGet then
			moveToIndex = i - 1

			break
		end
	end

	self._scrollView:MoveToItemIndex(moveToIndex)
end

function M:_handleGetReward()
	self._curShowList = StoreRechargeModel.instance:getRewardList()

	local count = #self._curShowList

	self._scrollView:SetListItemCount(count, true)
	self._scrollView:RefreshAllShownItem()
end

function M:_updateCell(curIndex, row, column)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("item")

	if self._curShowList then
		local storeRechargeMo = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoreRechargeViewItem)

		shower:setMo(storeRechargeMo)
	end

	return item
end

return M
