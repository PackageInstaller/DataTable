-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/databinder/ListBinderView.lua

module("frameworkext.lmvc.view.databinder.ListBinderView", package.seeall)

local ListBinderView = class("ListBinderView", DataBinderView)

function ListBinderView:ctor(listModel, scrollGoPath, prefabUrl, cellBehaviorClass, scrollParamters, isMultiSelect)
	ListBinderView.super.ctor(self, listModel:getListDataProvider())

	self._listModel = listModel
	self._scrollGoPath = scrollGoPath
	self._prefabUrl = prefabUrl
	self._cellBehaviorClass = cellBehaviorClass
	self._scrollParamters = scrollParamters
	self._isMultiSelect = isMultiSelect or false
	self._selectedItems = {}
end

function ListBinderView:buildUI()
	ListBinderView.super.buildUI(self)

	local scrollGo = goutil.findChild(self.mainGO, self._scrollGoPath)

	self._scroll = Framework.ScrollRectLoop.Get(scrollGo)

	local scrollDir = self._scrollParamters[1]
	local cellWidth = self._scrollParamters[2]
	local cellHeight = self._scrollParamters[3]
	local cellSpaceH = self._scrollParamters[4]
	local cellSpaceV = self._scrollParamters[5]
	local fixNumEachLine = self._scrollParamters[6]

	if fixNumEachLine == nil or fixNumEachLine == 0 then
		self._scroll:Init(scrollDir, cellWidth, cellHeight, cellSpaceH, cellSpaceV, self._onCellUpdate, self, self._onCellSelect, self)
	else
		self._scroll:InitFix(scrollDir, cellWidth, cellHeight, cellSpaceH, cellSpaceV, fixNumEachLine, self._onCellUpdate, self, self._onCellSelect, self)
	end
end

function ListBinderView:destroyUI()
	ListBinderView.super.destroyUI(self)
	self._scroll:Clear()

	self._scroll = nil
	self._listModel = nil
end

function ListBinderView:refreshView()
	ListBinderView.super.refreshView(self)

	self._scroll.TotalCellNum = self._listModel:getMoCount()
end

function ListBinderView:_onCellUpdate(cellRect, curIndex, prevIndex)
	local itemGo = goutil.findChild(cellRect.gameObject, "item")
	local cellBehavior

	if not itemGo then
		itemGo = self:getResInstance(self._prefabUrl)

		goutil.addChildToParent(itemGo, cellRect.gameObject)

		itemGo.name = "item"
		cellBehavior = Framework.LuaComponentContainer.Add(itemGo, self._cellBehaviorClass)

		cellBehavior:setListView(self)
	end

	cellBehavior = cellBehavior or Framework.LuaComponentContainer.Get(itemGo, self._cellBehaviorClass)

	local mo = self._listModel:getMoByIndex(curIndex + 1)

	cellBehavior:setCellIndex(curIndex + 1)
	cellBehavior:onSetMo(mo)

	if table.indexof(self._selectedItems, mo) then
		cellBehavior:showSelect(true)
	else
		cellBehavior:showSelect(false)
	end
end

function ListBinderView:_onCellSelect(cellRect, isSelected)
	local itemGo, cellBehavior

	if cellRect then
		cellBehavior = Framework.LuaComponentContainer.Get(goutil.findChild(cellRect.gameObject, "item"), self._cellBehaviorClass)

		if cellBehavior then
			cellBehavior:showSelect(isSelected)
		end
	end
end

function ListBinderView:selectCell(index, isSelected)
	local mo = self._listModel:getMoByIndex(index)

	if mo then
		if self._isMultiSelect then
			local i = table.indexof(self._selectedItems, mo)

			if i and not isSelected then
				table.remove(self._selectedItems, i)
			elseif isSelected and not i then
				table.insert(self._selectedItems, mo)
			end
		else
			if self._selectedItems[1] ~= nil then
				local i = self._listModel:getMoIndex(self._selectedItems[1])

				if i then
					self._scroll:SelectCell(i - 1, false)
				end
			end

			self._selectedItems = {
				mo
			}
		end

		self._scroll:SelectCell(index - 1, isSelected)
	end
end

function ListBinderView:getSelectItem()
	return self._selectedItems[1]
end

function ListBinderView:setSelectItem(item)
	self:setSelectItems({
		item
	})
end

function ListBinderView:getSelectItems()
	return self._selectedItems
end

function ListBinderView:setSelectItems(items)
	self._selectedItems = items

	self._scroll:UpdateVisualCells()
end

function ListBinderView:refreshVisible()
	self._scroll:UpdateVisualCells()
end

return ListBinderView
