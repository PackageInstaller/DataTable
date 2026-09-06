-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/databinder/ListBinderCell.lua

module("frameworkext.lmvc.view.databinder.ListBinderCell", package.seeall)

local ListBinderCell = class("ListBinderCell")

function ListBinderCell:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._cellIndex = 0
	self._listView = nil
end

function ListBinderCell:setCellIndex(cellIndex)
	self._cellIndex = cellIndex
end

function ListBinderCell:setListView(listView)
	self._listView = listView
	self._localDispatcher = self._listView._viewPresentor.localDispatcher
end

function ListBinderCell:showSelect(isSelected)
	if self.isSelected == isSelected then
		return
	end

	self.isSelected = isSelected

	self:onSelect(self.isSelected)
end

function ListBinderCell:setSelect(isSelect)
	self._listView:selectCell(self._cellIndex, isSelect)
end

function ListBinderCell:registerNotify(name, handler, handlerObj, priority)
	GlobalDispatcher:addListener(name, handler, handlerObj)
end

function ListBinderCell:unregisterNotify(name, handler, handlerObj)
	GlobalDispatcher:removeListener(name, handler, handlerObj)
end

function ListBinderCell:notify(name, message)
	GlobalDispatcher:dispatch(name, message)
end

function ListBinderCell:registerLocalNotify(name, handler, handlerObj, priority)
	self._localDispatcher:addListener(name, handler, handlerObj)
end

function ListBinderCell:unregisterLocalNotify(name, handler, handlerObj)
	self._localDispatcher:removeListener(name, handler, handlerObj)
end

function ListBinderCell:localNotify(name, message)
	self._localDispatcher:dispatch(name, message)
end

function ListBinderCell:Awake()
	return
end

function ListBinderCell:onSetMo(mo)
	return
end

function ListBinderCell:onSelect(isSelected)
	return
end

function ListBinderCell:OnDestroy()
	return
end

return ListBinderCell
