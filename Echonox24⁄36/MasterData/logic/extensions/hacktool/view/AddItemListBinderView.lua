-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/AddItemListBinderView.lua

module("logic.extensions.hacktool.view.AddItemListBinderView", package.seeall)

local M = class("AddItemListBinderView", DataBinderView)

function M:ctor(listModel, scrollGo, cellPrefabGo, cellBehaviorClass, isMultiSelect, cellSort, blankPrefabUrl, blankRootPath, blankParams)
	M.super.ctor(self, listModel:getListDataProvider(), blankPrefabUrl, blankRootPath, blankParams)

	self._listModel = listModel
	self._scrollGo = scrollGo

	if not goutil.isNil(self._scrollGo) then
		self._scrollGoWidth = goutil.getWidth(self._scrollGo.transform)
		self._scrollGoHeight = goutil.getHeight(self._scrollGo.transform)
	end

	self._scrollRect = scrollGo:GetComponent(UIComponentType.ScrollRect)

	if not goutil.isNil(self._scrollRect) then
		self._scrollContent = self._scrollRect.content
	end

	if not goutil.isNil(self._scrollContent) then
		self._gridLayoutGroup = self._scrollContent:GetComponent(UIComponentType.GridLayoutGroup)
	end

	self._cellPrefabGo = cellPrefabGo

	goutil.setActive(self._cellPrefabGo, false)

	self._scrollParamters = {}

	if not goutil.isNil(self._gridLayoutGroup) then
		self._gridLayoutGroup.enabled = false

		if self._scrollRect.horizontal == true then
			self._scrollParamters[1] = kScrollDirH
		end

		if self._scrollRect.vertical == true then
			self._scrollParamters[1] = kScrollDirV
		end

		self._scrollParamters[2] = self._gridLayoutGroup.cellSize.x
		self._scrollParamters[3] = self._gridLayoutGroup.cellSize.y
		self._scrollParamters[4] = self._gridLayoutGroup.spacing.x
		self._scrollParamters[5] = self._gridLayoutGroup.spacing.y
		self._childAlignment = self._gridLayoutGroup.childAlignment
		self._cellPrefabGo.transform.anchorMin = Vector2(0.5, 0.5)
		self._cellPrefabGo.transform.anchorMax = Vector2(0.5, 0.5)

		Astral.TransformUtil.SetAnchoredPos(self._cellPrefabGo.transform, 0, 0)
		goutil.setWidth(self._cellPrefabGo.transform, self._gridLayoutGroup.cellSize.x)
		goutil.setHeight(self._cellPrefabGo.transform, self._gridLayoutGroup.cellSize.y)

		if self._scrollParamters[1] == kScrollDirH then
			self._scrollParamters[7] = self._gridLayoutGroup.padding.left
			self._scrollParamters[8] = self._gridLayoutGroup.padding.right

			if self._gridLayoutGroup.constraint == UnityEngine.UI.GridLayoutGroup.Constraint.FixedRowCount then
				self._scrollParamters[6] = self._gridLayoutGroup.constraintCount
			end
		elseif self._scrollParamters[1] == kScrollDirV then
			self._scrollParamters[7] = self._gridLayoutGroup.padding.top
			self._scrollParamters[8] = self._gridLayoutGroup.padding.bottom

			if self._gridLayoutGroup.constraint == UnityEngine.UI.GridLayoutGroup.Constraint.FixedColumnCount then
				self._scrollParamters[6] = self._gridLayoutGroup.constraintCount
			end
		end
	end

	self._cellBehaviorClass = cellBehaviorClass
	self._isMultiSelect = isMultiSelect or false
	self._selectedItems = {}
	self._cellSort = cellSort or 0
end

function M:setViewPresentor(presentor)
	M.super.setViewPresentor(self, presentor)
end

function M:buildUI()
	M.super.buildUI(self)

	local scrollDir = self._scrollParamters[1] or kScrollDirH

	if scrollDir == kScrollDirH or scrollDir == kScrollDirV then
		local cellWidth = self._scrollParamters[2]
		local cellHeight = self._scrollParamters[3]
		local cellSpaceH = self._scrollParamters[4]
		local cellSpaceV = self._scrollParamters[5]
		local fixNumEachLine = self._scrollParamters[6]
		local startSpacing = self._scrollParamters[7] or 0
		local endSpacing = self._scrollParamters[8] or 0

		self._scroll = Astral.ScrollRectLoop.Get(self._scrollGo)

		if fixNumEachLine == nil or fixNumEachLine == 0 then
			self._scroll:Init(scrollDir, cellWidth, cellHeight, cellSpaceH, cellSpaceV, self._onCellUpdate, self, self._onCellSelect, self, self._cellSort, startSpacing, endSpacing)
		else
			self._scroll:InitFix(scrollDir, cellWidth, cellHeight, cellSpaceH, cellSpaceV, fixNumEachLine, self._onCellUpdate, self, self._onCellSelect, self, self._cellSort, startSpacing, endSpacing)
		end

		self._scroll:SetCellsUpdateFinishHandler(self._cellUpdateFinishHandler, self)
	elseif scrollDir == kScrollDirCircleH or scrollDir == kScrollDirCircleV then
		local rotateDir = self._scrollParamters[2]
		local showCount = self._scrollParamters[3]
		local radius = self._scrollParamters[4]
		local cellRadius = self._scrollParamters[5] or 0
		local firstDegree = self._scrollParamters[6] or 0
		local isLoop = self._scrollParamters[7] or false

		self._scroll = Framework.CircleLoop.Get(self._scrollGo)

		self._scroll:Init(scrollDir - 2, rotateDir, showCount, radius, cellRadius, firstDegree, isLoop, self._onCircleCellUpdate, self._onCellSelect, self)
	end
end

function M:_cellUpdateFinishHandler()
	self:localNotify(EventType.FW_VIEW_ONCELLSUPDATEFINISH_EVENT)
end

function M:destroyUI()
	M.super.destroyUI(self)
	self._scroll:Clear()

	self._scroll = nil
	self._listModel = nil
end

function M:resetListMode(listModel)
	self._listModel = listModel

	self:refreshView()
end

function M:refreshView()
	M.super.refreshView(self)

	self._scroll.TotalCellNum = self._listModel:getMoCount()

	self:updateScrBlankView(self._listModel:getMoCount())

	if self._childAlignment and self._childAlignment == UnityEngine.TextAnchor.MiddleCenter then
		local cellWidth = self._scrollParamters[2] or 0
		local cellHeight = self._scrollParamters[3] or 0
		local cellSpaceH = self._scrollParamters[4]
		local cellSpaceV = self._scrollParamters[5]
		local startSpacing = self._scrollParamters[7] or 0
		local endSpacing = self._scrollParamters[8] or 0
		local curW = self._scroll.TotalCellNum * (cellWidth + cellSpaceH) + startSpacing + endSpacing

		if curW <= self._scrollGoWidth then
			goutil.setWidth(self._scrollGo.transform, curW)
			goutil.setHeight(self._scrollGo.transform, cellHeight)
		else
			goutil.setWidth(self._scrollGo.transform, self._scrollGoWidth)
			goutil.setHeight(self._scrollGo.transform, self._scrollGoHeight)
		end
	end
end

function M:_onCircleCellUpdate(cellRect, currIndex, cellIndex)
	self:_onCellUpdate(cellRect, currIndex, -1)
end

function M:_onCellUpdate(cellRect, curIndex, prevIndex)
	local itemGo = goutil.findChild(cellRect.gameObject, "item")
	local cellBehavior

	if not itemGo then
		itemGo = goutil.clone(self._cellPrefabGo)

		goutil.setActive(itemGo, true)
		goutil.addChildToParent(itemGo, cellRect.gameObject)

		itemGo.name = "item"

		local _tContainer = Astral.LuaComponentContainer.Get(itemGo)

		_tContainer.CanLuaAwakeInvoked = false
		cellBehavior = Astral.LuaComponentContainer.Add(itemGo, self._cellBehaviorClass)

		cellBehavior:setListView(self)

		if cellBehavior.Awake ~= nil then
			cellBehavior:Awake()
		end

		if itemGo.activeInHierarchy and _tContainer.enabled and cellBehavior.OnEnable then
			cellBehavior:OnEnable()
		end

		_tContainer.CanLuaAwakeInvoked = true
	end

	cellBehavior = cellBehavior or Astral.LuaComponentContainer.Get(itemGo, self._cellBehaviorClass)

	local mo = self._listModel:getMoByIndex(curIndex + 1)

	cellBehavior:setCellIndex(curIndex + 1)
	cellBehavior:updateData(mo)

	if table.indexof(self._selectedItems, mo) then
		cellBehavior:showSelect(true)
	else
		cellBehavior:showSelect(false)
	end
end

function M:_onCellSelect(cellRect, isSelected)
	local itemGo, cellBehavior

	if cellRect then
		itemGo = goutil.findChild(cellRect.gameObject, "item")
		cellBehavior = Astral.LuaComponentContainer.Get(itemGo, self._cellBehaviorClass)

		if cellBehavior then
			cellBehavior:showSelect(isSelected)
		end
	end
end

function M:selectCells(indexlist, isSelected)
	if indexlist then
		local index

		for i = 1, #indexlist do
			index = indexlist[i]

			self:selectCell(index, isSelected)
		end
	end
end

function M:selectCell(index, isSelected)
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
			end

			if not isSelected then
				self._selectedItems = {}
			else
				self._selectedItems = {
					mo
				}
			end
		end

		self._scroll:SelectCell(index - 1, isSelected)
	end
end

function M:getSelectItem()
	return self._selectedItems[1]
end

function M:setSelectItem(item)
	self:setSelectItems({
		item
	})
end

function M:getSelectItems()
	return self._selectedItems
end

function M:setSelectItems(items)
	table.clear(self._selectedItems)

	if items then
		for i = 1, #items do
			table.insert(self._selectedItems, items[i])
		end
	end

	self._scroll:UpdateVisualCells()
end

function M:refreshVisible()
	self._scroll:UpdateVisualCells()
end

return M
