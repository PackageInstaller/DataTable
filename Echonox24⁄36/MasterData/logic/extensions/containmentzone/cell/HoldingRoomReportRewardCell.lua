-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomReportRewardCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomReportRewardCell", package.seeall)

local M = class("HoldingRoomReportRewardCell", UIReusableLuaBehavior)

function M:buildUI()
	self._cellItem = {}
	self._goNewInfoRoot = goutil.findChild(self.mainGO, "newInformation").gameObject
	self._rectTrNewInfoParent = goutil.findChildComponent(self.mainGO, "newInformation/scr/view/content", UIComponentType.RectTransform)
	self._goNewInfoItem = goutil.findChild(self.mainGO, "newInformation/scr/view/content/information_item").gameObject
	self._goRewardsRoot = goutil.findChild(self.mainGO, "rewards").gameObject
	self._scroll = LoopGridViewHelper.New(goutil.findChild(self.mainGO, "rewards/scroll").gameObject)

	self._scroll:InitGridView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._scroll:Dispose()

	self._scroll = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	return
end

function M:onExit()
	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._scroll:ClearCells()
end

function M:setCellData(itemData, curIndex)
	self._rewardsData = {}

	for key, value in pairs(itemData.rewardsData or {}) do
		local theItemData = ItemUtil.createItemData({
			itemId = value.itemCode
		})

		theItemData:setCount(value.itemCount)
		table.insert(self._rewardsData, theItemData)
	end

	table.sort(self._rewardsData, ItemUtil.sortItemsCompare)
	self:_showToastIntelligenceUnLock(itemData.protomerId, itemData.intelligenceData)
	self:_refreshScrollViewShow()
end

function M:setShow(show)
	goutil.setActive(self.mainGO, show)
end

function M:playFirstOpenAni()
	return
end

function M:_showToastIntelligenceUnLock(protomerId, unLockIntelligenceTable)
	local count = unLockIntelligenceTable and #unLockIntelligenceTable or 0

	self._showTable = {}

	if protomerId > 0 then
		local cfgInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)

		for theId, _ in pairs(unLockIntelligenceTable) do
			local infoUnlockCo = ContainmentConfig.instance:getInfoUnlockCo(cfgInfo.unlock, theId)

			table.insert(self._showTable, {
				id = theId,
				name = infoUnlockCo.name
			})
		end
	end

	local count = #self._showTable

	if count > 0 then
		while count > self._rectTrNewInfoParent.childCount do
			goutil.cloneAndSetParent(self._goNewInfoItem, self._rectTrNewInfoParent)
		end

		for i = 0, self._rectTrNewInfoParent.childCount - 1 do
			local tmpGo = self._rectTrNewInfoParent:GetChild(i).gameObject
			local show = i < count

			if show then
				local data = self._showTable[i + 1]
				local txtInfoName = goutil.findChildTextComponent(tmpGo, "txtInformation")

				txtInfoName.text = data.name
			end

			goutil.setActive(tmpGo, show)
		end
	end

	goutil.setActive(self._goNewInfoRoot, count > 0)
end

function M:_refreshScrollViewShow()
	local len = self._rewardsData and #self._rewardsData or 0

	if len > 0 then
		self._scroll:SetListItemCount(len, true)
		self._scroll:RefreshAllShownItem()
	else
		self._scroll:ClearCells()
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local itemData = self._rewardsData[curIndex]
	local item = self._scroll:NewListViewItem("backpack_item")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, HoldRewardItemCell)
	local itemCount = itemData:getCount()

	shower:setCellData(itemData, curIndex)
	shower:setNumShow(true, string.format("<color=white>%d</color>", itemCount))
	shower:setHandler(self)
	shower:setSignShow(CommEnum.BackPackItemSignTyp.None)
	shower:setIsShowTips(true)
	shower:setShowSelectedEffect(false)
	shower:setIsShowTipsPassEvent(false)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

return M
