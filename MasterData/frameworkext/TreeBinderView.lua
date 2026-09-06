-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/databinder/TreeBinderView.lua

module("frameworkext.lmvc.view.databinder.TreeBinderView", package.seeall)

local TreeBinderView = class("TreeBinderView", DataBinderView)

DefaultTransitionSeconds = 0.3

function TreeBinderView:ctor(treeModel, treeGoPath, prefabUrls, cellBehaviorClass, scrollDir)
	TreeBinderView.super.ctor(self, treeModel:getTreeDataProvider())

	self._treeModel = treeModel
	self._treeGoPath = treeGoPath
	self._prefabUrls = prefabUrls
	self._cellBehaviorClass = cellBehaviorClass
	self._scrollDir = scrollDir
	self._selectedItems = {}
end

function TreeBinderView:buildUI()
	TreeBinderView.super.buildUI(self)

	local treeGo = goutil.findChild(self.mainGO, self._treeGoPath)

	self._tree = Framework.TreeLoop.Get(treeGo)

	self._tree:Init(self._scrollDir, self._onCellUpdate, self, self._onCellSelect, self)
end

function TreeBinderView:destroyUI()
	TreeBinderView.super.destroyUI(self)
	self._tree:Clear()

	self._tree = nil
	self._treeModel = nil
end

function TreeBinderView:refreshView()
	TreeBinderView.super.refreshView(self)

	local treeInfo = {}
	local l = self._treeModel:getRootCount()

	for i = 1, l do
		local style = {}
		local s = self._treeModel:getStyle(i)

		style.rootType = s.rootType or 0
		style.rootIndex = i - 1
		style.rootLength = s.rootLength or 0
		style.childNodeType = s.childNodeType or 0
		style.childNodeLength = s.childNodeLength or 0
		style.childNodeCountEachLine = s.childNodeCountEachLine or 0
		style.isExpanded = s.isExpanded or false
		style.childNodeCount = self._treeModel:getNodeCount(i)

		if style.childNodeCountEachLine <= 0 then
			style.childNodeCountEachLine = 1
		end

		treeInfo[i] = style
	end

	self._tree:UpdateTreeInfoList(treeInfo)
end

function TreeBinderView:_onCellUpdate(cellRect, iconType, rootIndex, subIndex)
	local itemGo = goutil.findChild(cellRect.gameObject, "item")
	local cellBehavior

	if not itemGo then
		itemGo = self:getResInstance(self._prefabUrls[iconType + 1])

		goutil.addChildToParent(itemGo, cellRect.gameObject)

		itemGo.name = "item"
		cellBehavior = Framework.LuaComponentContainer.Add(itemGo, self._cellBehaviorClass)

		cellBehavior:setTreeView(self)
	end

	cellBehavior = cellBehavior or Framework.LuaComponentContainer.Get(itemGo, self._cellBehaviorClass)

	local mo = self._treeModel:getMoByIndex(rootIndex + 1, subIndex + 1)

	cellBehavior:setIndex(rootIndex + 1, subIndex + 1)
	cellBehavior:onSetMo(mo, iconType)

	if table.indexof(self._selectedItems, mo) then
		cellBehavior:showSelect(true)
	else
		cellBehavior:showSelect(false)
	end
end

function TreeBinderView:_onCellSelect(cellRect, isSelected)
	local itemGo, cellBehavior

	if cellRect then
		cellBehavior = Framework.LuaComponentContainer.Get(goutil.findChild(cellRect.gameObject, "item"), self._cellBehaviorClass)

		if cellBehavior then
			cellBehavior:showSelect(isSelected)
		end
	end
end

function TreeBinderView:selectCell(rootIndex, subIndex, isSelected)
	local mo = self._treeModel:getMoByIndex(rootIndex, subIndex)

	if mo then
		local i = table.indexof(self._selectedItems, mo)

		if i and not isSelected then
			table.remove(self._selectedItems, i)
		elseif isSelected and not i then
			table.insert(self._selectedItems, mo)
		end

		self._tree:SelectCell(rootIndex - 1, subIndex - 1, isSelected)
	end
end

function TreeBinderView:getSelectItems()
	return self._selectedItems
end

function TreeBinderView:setSelectItems(items)
	self._selectedItems = items

	self._tree:UpdateCells(true, false)
end

function TreeBinderView:expand(rootIndex, hasTransition, transitionSeconds, callBack)
	if hasTransition == nil then
		hasTransition = true
	end

	self._tree:Expand(rootIndex - 1, hasTransition, transitionSeconds or DefaultTransitionSeconds, callBack)
end

function TreeBinderView:shrink(rootIndex, hasTransition, transitionSeconds, callBack)
	if hasTransition == nil then
		hasTransition = true
	end

	self._tree:Shrink(rootIndex - 1, hasTransition, transitionSeconds or DefaultTransitionSeconds, callBack)
end

return TreeBinderView
