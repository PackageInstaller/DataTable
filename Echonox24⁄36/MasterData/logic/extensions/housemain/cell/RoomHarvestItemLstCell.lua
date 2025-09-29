-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomHarvestItemLstCell.lua

module("logic.extensions.housemain.cell.RoomHarvestItemLstCell", package.seeall)

local M = class("RoomHarvestItemLstCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:buildUI()
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._itemRoot = goutil.findChild(self.mainGO, "layout").gameObject
	self._itemPrefab = goutil.findChild(self.mainGO, "layout/backpack_item").gameObject

	goutil.setActive(self._itemPrefab, false)
end

function M:destroyUI()
	self.mainGO = nil
	self._txtTitle = nil
	self._itemRoot = nil
	self._itemPrefab = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._cellItem = {}
end

function M:onExit()
	for _, value in pairs(self._cellItem or {}) do
		value:onExit()
		value:destroyUI()
	end

	for i = 1, self._itemRoot.transform.childCount - 1 do
		local itemGo = self._itemRoot.transform:GetChild(i).gameObject

		goutil.destroy(itemGo)
	end

	self._typ = nil
	self._rewards = nil
end

function M:getMainGo()
	return self.mainGO
end

function M:setTitle(contentStr)
	self._txtTitle.text = contentStr
end

function M:setData(typ, rewards)
	self._typ = typ
	self._rewards = {}

	for id, count in pairs(rewards or {}) do
		local itemData = ItemUtil.createItemData({
			itemId = id
		})

		itemData:setCount(count)
		table.insert(self._rewards, itemData)
	end

	if #self._rewards > 0 then
		table.sort(self._rewards, ItemUtil.sortItemsCompare)
	end

	self:_updateRewardsShow()
end

function M:_updateRewardsShow()
	local rootTrans = self._itemRoot.transform
	local count = self._rewards and #self._rewards or 0

	while count > rootTrans.childCount - 1 do
		goutil.cloneAndSetParent(self._itemPrefab, rootTrans)
	end

	for i = 1, rootTrans.childCount - 1 do
		local show = i <= count
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local curIndex = i
			local itemData = self._rewards[curIndex]
			local shower = Astral.SimpleLuaComponentContainer.Add(tempGo, HoldRewardItemCell)

			shower:setCellData(itemData, curIndex)
			shower:setNumBgNodeVisible(false)
			shower:getComponent("num"):setTextColor(parsecolor("#FFFFFF"))
			shower:setHandler(self)
			shower:setIsShowTips(true)
			shower:setShowSelectedEffect(false)
			shower:setItemSelect(false)
			shower:setIsShowTipsPassEvent(false)

			self._cellItem[tempGo:GetInstanceID()] = shower
		end

		goutil.setActive(tempGo, show)
	end
end

function M:onRewardItemSelect(cellRewardItem)
	local instanceId = cellRewardItem:getMainGo():GetInstanceID()

	for key, value in pairs(self._cellItem or {}) do
		if key ~= instanceId then
			value:setItemSelect(false)
		end
	end
end

return M
