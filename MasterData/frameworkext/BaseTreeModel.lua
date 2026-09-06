-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/model/BaseTreeModel.lua

module("frameworkext.lmvc.model.BaseTreeModel", package.seeall)

local BaseTreeModel = class("BaseTreeModel", BaseModel)

function BaseTreeModel:ctor()
	BaseTreeModel.super.ctor(self)

	self._moList = {}
	self._treeDataProvider = DataProvider.New()
end

function BaseTreeModel:onInit()
	return
end

function BaseTreeModel:onReset()
	self:clear()
end

function BaseTreeModel:setDataBinder(binder)
	self._binder = binder
end

function BaseTreeModel:getTreeDataProvider()
	return self._treeDataProvider
end

function BaseTreeModel:addRoot(mo, style, index)
	local count = #self._moList

	if not index or index > count + 1 then
		index = count + 1
	elseif index < 1 then
		index = 1
	end

	table.insert(self._moList, index, {
		mo = mo,
		style = style,
		children = {}
	})
	self:notifyUpdate()
end

function BaseTreeModel:addSub(mo, rootIndex, subIndex)
	local subList = self._moList[rootIndex].children
	local count = #subList

	if not subIndex or subIndex > count + 1 then
		subIndex = count + 1
	elseif subIndex < 1 then
		subIndex = 1
	end

	table.insert(subList, subIndex, mo)
	self:notifyUpdate()
end

function BaseTreeModel:setSubList(moList, rootIndex)
	self._moList[rootIndex].children = moList

	self:notifyUpdate()
end

function BaseTreeModel:removeRoot(index)
	if not index or index < 1 then
		return nil
	end

	if index > #self._moList then
		return nil
	end

	local rootNode = table.remove(self._moList, index)

	self:notifyUpdate()

	return rootNode.mo
end

function BaseTreeModel:removeSub(rootIndex, subIndex)
	if not rootIndex or rootIndex < 1 then
		return nil
	end

	if rootIndex > #self._moList then
		return nil
	end

	local mo = table.remove(self._moList[rootIndex].children, subIndex)

	self:notifyUpdate()

	return mo
end

function BaseTreeModel:getMoByIndex(rootIndex, subIndex)
	if subIndex == 0 then
		return self._moList[rootIndex].mo
	else
		return self._moList[rootIndex].children[subIndex]
	end
end

function BaseTreeModel:getIndexByMo(mo)
	for i = 1, #self._moList do
		if self._moList[i].mo == mo then
			return i, 0
		else
			local sub = self._moList[i].children

			for j = 1, #sub do
				if sub[j] == mo then
					return i, j
				end
			end
		end
	end

	return nil
end

function BaseTreeModel:getStyle(rootIndex)
	return self._moList[rootIndex].style
end

function BaseTreeModel:clear()
	self._moList = {}

	self:notifyUpdate()
end

function BaseTreeModel:getRootCount()
	return #self._moList
end

function BaseTreeModel:getNodeCount(RootIndex)
	return #self._moList[RootIndex].children
end

function BaseTreeModel:notifyUpdate()
	if not self._pauseNotify then
		self._treeDataProvider:onUpdateData()
	end
end

function BaseTreeModel:beginBatch()
	self._pauseNotify = true
end

function BaseTreeModel:endBatch()
	self._pauseNotify = false

	self._treeDataProvider:onUpdateData()
end

return BaseTreeModel
