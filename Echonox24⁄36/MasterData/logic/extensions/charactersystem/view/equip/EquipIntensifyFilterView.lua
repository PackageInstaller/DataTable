-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipIntensifyFilterView.lua

module("logic.extensions.charactersystem.view.equip.EquipIntensifyFilterView", package.seeall)

local M = class("EquipIntensifyFilterView", EquipFilterView)
local index2SortType = {
	CommEnum.MainBackpackSortType.Experience,
	CommEnum.MainBackpackSortType.Quality,
	CommEnum.MainBackpackSortType.Level
}

function M:buildUI()
	self._filterRoot = self:getGo("2&common_filter_-55329758")
	self._btnMask = Astral.ButtonAdapter.Get(goutil.findChild(self._filterRoot, "click"))

	goutil.setActive(self._btnMask.gameObject, false)

	self._btnFilter = self:getBtn("11&com_btn_2_-31477526")
	self._suitCanvas = self._btnFilter.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._goFilterView = self:getGo("12&d6_filter_tips_470721785")
	self._equipFilterComponent = Astral.LuaComponentContainer.Add(self._goFilterView, EquipFilterComponent)
	self._txtFilter = goutil.findChildTextComponent(self._btnFilter.gameObject, "Text")
	self._btnSort = Astral.ButtonAdapter.Get(goutil.findChild(self._filterRoot, "btnFilter_2"))
	self._sortCanvas = self._btnSort.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._sortText = goutil.findChildComponent(self._btnSort.gameObject, "content/Label", UIComponentType.Text)
	self._sortItemsParent = goutil.findChild(self._btnSort.gameObject, "Template")
	self._sortUpGo = goutil.findChild(self._btnSort.gameObject, "content/up")
	self._sortDownGo = goutil.findChild(self._btnSort.gameObject, "content/down")
	self._sortItems = {}
	self._sortItemTemp = goutil.findChild(self._sortItemsParent, "Content/Item1")

	goutil.setActive(self._sortItemTemp, false)

	local itemsParent = goutil.findChild(self._sortItemsParent, "Content")

	for i = 1, 3 do
		local sortItem = goutil.clone(self._sortItemTemp)

		goutil.setActive(sortItem, true)
		goutil.addChildToParent(sortItem, itemsParent)

		local itemView = Astral.LuaComponentContainer.Add(sortItem, BackpackSortItemNew)
		local sortType = index2SortType[i]

		itemView:setData(BackpackItemSortData.New(sortType, false))
		itemView:setEvent(EventType.EQUIP_WEARING_SORT_ITEM_CLICK)
		table.insert(self._sortItems, itemView)

		if i == self.defaultSortType then
			itemView:setSelect(true)

			self._sortMo = itemView:getData()
		else
			itemView:setSelect(false)
		end
	end

	goutil.setActive(self._sortItemsParent, false)
end

return M
