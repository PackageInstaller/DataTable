-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/databinder/TreeBinderCell.lua

module("frameworkext.lmvc.view.databinder.TreeBinderCell", package.seeall)

local TreeBinderCell = class("TreeBinderCell")

function TreeBinderCell:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self.rootIndex = 0
	self.subIndex = 0
	self.treeView = nil
end

function TreeBinderCell:setIndex(rootIndex, subIndex)
	self.rootIndex = rootIndex
	self.subIndex = subIndex
end

function TreeBinderCell:setTreeView(treeView)
	self._treeView = treeView
	self._localDispatcher = self._treeView._viewPresentor.localDispatcher
end

function TreeBinderCell:showSelect(isSelected)
	self.isSelected = isSelected

	self:onSelect(self.isSelected)
end

function TreeBinderCell:setSelect(isSelect)
	self._treeView:selectCell(self._cellIndex, isSelect)
end

function TreeBinderCell:registerNotify(name, handler, handlerObj, priority)
	GlobalDispatcher:addListener(name, handler, handlerObj)
end

function TreeBinderCell:unregisterNotify(name, handler, handlerObj)
	GlobalDispatcher:removeListener(name, handler, handlerObj)
end

function TreeBinderCell:notify(name, message)
	GlobalDispatcher:dispatch(name, message)
end

function TreeBinderCell:registerLocalNotify(name, handler, handlerObj, priority)
	self._localDispatcher:addListener(name, handler, handlerObj)
end

function TreeBinderCell:unregisterLocalNotify(name, handler, handlerObj)
	self._localDispatcher:removeListener(name, handler, handlerObj)
end

function TreeBinderCell:localNotify(name, message)
	self._localDispatcher:dispatch(name, message)
end

function TreeBinderCell:Awake()
	return
end

function TreeBinderCell:onSetMo(mo)
	return
end

function TreeBinderCell:onSelect(isSelected)
	return
end

function TreeBinderCell:OnDestroy()
	return
end

return TreeBinderCell
