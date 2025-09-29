-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreShoppingItem.lua

module("logic.extensions.store.view.StoreShoppingItem", package.seeall)

local M = class("StoreShoppingItem")

function M:ctor(compContainer)
	self.go = compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self.go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._itemGo = registry:findUIElement("rewards_detail_item_2141037416")
	self._itemCell = Astral.LuaComponentContainer.Add(self._itemGo, ItemCell)

	self._itemCell:getComponent("normal"):setClickListener(self._clickItemCell, self)
end

function M:_clickItemCell(cell)
	if self._itemData and ItemUtil.isCharacterById(self._itemData.itemId) and self._goodsMo then
		StoreMainFacade.instance:jumpToStore(self._goodsMo:getTabId(), self._goodsMo:getStoreId(), self._goodsMo:getGoodsId(), true)
	end

	cell:dealSelect()
end

function M:setCellData(itemData, index, goodsMo)
	self._goodsMo = goodsMo
	self._itemData = itemData

	self._itemCell:setShowSelectedEffect(false)

	local _itemData = ItemUtil.createItemData({
		count = itemData.num,
		itemId = itemData.itemId
	})

	self._itemCell:updateData(_itemData)
end

function M:OnDestroy()
	self.go = nil
	self._viewElementsRegistry = nil
	self._itemGo = nil
	self._itemCell = nil
end

return M
