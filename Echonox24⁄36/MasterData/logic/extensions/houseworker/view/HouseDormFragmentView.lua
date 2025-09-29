-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseDormFragmentView.lua

module("logic.extensions.houseworker.view.HouseDormFragmentView", package.seeall)

local M = class("HouseDormFragmentView", DynamicFragmentView)

function M:buildUI()
	self._txtRoleNum = self._registry:findUIElement("dorm_settled_panel_-1573762440", UIComponentType.Text)
	self._btnPreview = Astral.ButtonAdapter.Get(self._registry:findUIElement("dorm_settled_panel_-285438270"))
	self._roleScrollGo = self._registry:findUIElement("dorm_settled_panel_-1160798730")
	self._roleLoopList = LoopListHelper.New(self._roleScrollGo)

	self._roleLoopList:InitListView(0, self._updateRoleCell, self)

	self._dormScrollGo = self._registry:findUIElement("dorm_settled_panel_-1333481474")
	self._dormLoopList = LoopListHelper.New(self._dormScrollGo)

	self._dormLoopList:InitListView(0, self._updateDormCell, self)

	self._dormNoneGo = self._registry:findUIElement("dorm_settled_panel_816816367")
end

function M:onEnter()
	self:refreshAllView()
	self:_setEvent(true)
end

function M:bindEvents()
	self._btnPreview:AddClickListener(self._clickPreview, self)
end

function M:unbindEvents()
	self._btnPreview:RemoveClickListener()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self.refreshAllView, self)
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self.refreshAllView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self.refreshAllView, self)
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self.refreshAllView, self)
	end
end

function M:refreshAllView()
	self:refreshView()
	self:refreshDormView()
	self:refreshRoleView()
end

function M:refreshView()
	local totalMaxCount = 0
	local totalCount = 0

	self._zoneList = LivingFacilitiesZoneController.instance:getAllDorm()

	for i, zone in ipairs(self._zoneList) do
		local maxRoleCount = zone:getHeroCount()
		local currentCount = zone:getInRoomHeroCount()

		totalMaxCount = totalMaxCount + maxRoleCount
		totalCount = totalCount + currentCount
	end

	self._txtRoleNum.text = string.format(lang("tip_job_schedule_adjust_3"), totalCount, totalMaxCount)

	goutil.setActive(self._btnPreview.gameObject, totalMaxCount ~= 0)
end

function M:refreshDormView()
	self._dormLoopList:SetListItemCount(#self._zoneList, true)
	self._dormLoopList:RefreshAllShownItem()
	self._dormLoopList:MoveToItemIndex(0)
	goutil.setActive(self._dormNoneGo, #self._zoneList == 0)
	goutil.setActive(self._dormScrollGo, #self._zoneList ~= 0)
end

function M:refreshRoleView()
	self._roleList = HouseWorkerModel.instance:getAllWorkHeroWithoutBunk()

	self._roleLoopList:SetListItemCount(#self._roleList, true)
	self._roleLoopList:RefreshAllShownItem()
	self._roleLoopList:MoveToItemIndex(0)
end

function M:_updateRoleCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._roleLoopList:NewListViewItem("hero_adjust_item")
	local heroId = self._roleList[curIndex]
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, HouseWorkHeadCell)

	shower:setWorkTypeShowStatus(false)
	shower:refreshHero(heroId)

	return item
end

function M:_updateDormCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._dormLoopList:NewListViewItem("dorm_settled_item")
	local zoneInfo = self._zoneList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, HouseDormSettleItemView)

	shower:setClickListener(self._clickCallBack, self)
	shower:setCellData(zoneInfo, curIndex)

	return item
end

function M:_clickCallBack(zoneMo)
	ViewMgr.instance:open(ViewName.LivingFacilitiesAdjustSchedule, zoneMo)
end

function M:_clickPreview()
	ViewMgr.instance:open(ViewName.HouseDormAdjust)
end

function M:onExit()
	self:_setEvent(false)
	self._roleLoopList:ClearCells()
	self._dormLoopList:ClearCells()
end

function M:destroyUI()
	self._roleLoopList:Dispose()

	self._roleLoopList = nil

	self._dormLoopList:Dispose()

	self._dormLoopList = nil
end

function M:onClickHeroItem(itemView)
	return
end

return M
