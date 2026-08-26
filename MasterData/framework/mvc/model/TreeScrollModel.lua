-- chunkname: @framework/mvc/model/TreeScrollModel.lua

module("framework.mvc.model.TreeScrollModel", package.seeall)

local TreeScrollModel = class("TreeScrollModel", BaseModel)

function TreeScrollModel:ctor()
	self._stopUpdate = false
	self._scrollViews = {}
	self._moList = {}
end

function TreeScrollModel:reInitInternal()
	TreeScrollModel.super.reInitInternal(self)

	for _, scrollView in ipairs(self._scrollViews) do
		if scrollView.clear then
			scrollView:clear()
		end
	end
end

function TreeScrollModel:clear()
	self._stopUpdate = false
	self._moList = {}

	self:onModelUpdate()
end

function TreeScrollModel:getInfoList()
	local treeInfoList = {}
	local rootCount = self:getRootCount()

	for i = 1, rootCount do
		local rootInfo4CSharp = {}
		local treeRootParam = self._moList[i].treeRootParam

		rootInfo4CSharp.rootType = treeRootParam.rootType or 0
		rootInfo4CSharp.rootIndex = i - 1
		rootInfo4CSharp.rootLength = treeRootParam.rootLength or 0
		rootInfo4CSharp.nodeType = treeRootParam.nodeType or 0
		rootInfo4CSharp.nodeLength = treeRootParam.nodeLength or 0
		rootInfo4CSharp.nodeStartSpace = treeRootParam.nodeStartSpace or 0
		rootInfo4CSharp.nodeEndSpace = treeRootParam.nodeEndSpace or 0
		rootInfo4CSharp.nodeCountEachLine = treeRootParam.nodeCountEachLine or 0
		rootInfo4CSharp.isExpanded = treeRootParam.isExpanded or false
		rootInfo4CSharp.nodeCount = self:getNodeCount(i)

		if rootInfo4CSharp.nodeCountEachLine <= 0 then
			rootInfo4CSharp.nodeCountEachLine = 1
		end

		treeInfoList[i] = rootInfo4CSharp
	end

	return treeInfoList
end

function TreeScrollModel:getRootCount()
	return #self._moList
end

function TreeScrollModel:getNodeCount(rootIndex)
	return #self._moList[rootIndex].children
end

function TreeScrollModel:getByIndex(rootIndex, nodeIndex)
	if nodeIndex == 0 then
		return self._moList[rootIndex].mo
	else
		return self._moList[rootIndex].children[nodeIndex]
	end
end

function TreeScrollModel:addRoot(mo, treeRootParam, rootIndex)
	local count = #self._moList

	if not rootIndex or rootIndex > count + 1 then
		rootIndex = count + 1
	elseif rootIndex < 1 then
		rootIndex = 1
	end

	table.insert(self._moList, rootIndex, {
		mo = mo,
		treeRootParam = treeRootParam,
		children = {}
	})
	self:onModelUpdate()
end

function TreeScrollModel:addNode(mo, rootIndex, nodeIndex)
	local subList = self._moList[rootIndex].children
	local count = #subList

	if not nodeIndex or nodeIndex > count + 1 then
		nodeIndex = count + 1
	elseif nodeIndex < 1 then
		nodeIndex = 1
	end

	table.insert(subList, nodeIndex, mo)

	self._moList[rootIndex].children = subList

	self:onModelUpdate()
end

function TreeScrollModel:removeRoot(rootIndex)
	if not rootIndex or rootIndex < 1 then
		return nil
	end

	if rootIndex > #self._moList then
		return nil
	end

	local root = table.remove(self._moList, rootIndex)

	self:onModelUpdate()

	return root.mo
end

function TreeScrollModel:removeNode(rootIndex, nodeIndex)
	if not rootIndex or rootIndex < 1 then
		return nil
	end

	if rootIndex > #self._moList then
		return nil
	end

	local mo = table.remove(self._moList[rootIndex].children, nodeIndex)

	self:onModelUpdate()

	return mo
end

function TreeScrollModel:stopUpdate()
	self._stopUpdate = true
end

function TreeScrollModel:resumeUpdate()
	self._stopUpdate = false

	self:onModelUpdate()
end

function TreeScrollModel:onModelUpdate()
	if self._stopUpdate then
		return
	end

	for _, scrollView in ipairs(self._scrollViews) do
		scrollView:onModelUpdate()
	end
end

function TreeScrollModel:addScrollView(scrollView)
	table.insert(self._scrollViews, scrollView)
end

function TreeScrollModel:removeScrollView(scrollView)
	tabletool.removeValue(self._scrollViews, scrollView)
end

return TreeScrollModel
