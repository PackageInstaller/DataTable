-- chunkname: @framework/mvc/view/scroll/LuaTreeScrollView.lua

module("framework.mvc.view.scroll.LuaTreeScrollView", package.seeall)

local LuaTreeScrollView = class("LuaTreeScrollView", BaseScrollView)

LuaTreeScrollView.PrefabInstName = "prefabInst"
LuaTreeScrollView.DefaultTransitionSeconds = 0.3

function LuaTreeScrollView:ctor(scrollModel, treeScrollParam)
	LuaTreeScrollView.super.ctor(self, scrollModel, treeScrollParam.emptyScrollParam)

	self._csTreeScroll = nil
	self._model = scrollModel
	self._param = treeScrollParam
	self._prefabInViewList = nil
	self._nodePrefab = nil
	self._cellCompDict = {}
	self._selectMOs = {}
end

function LuaTreeScrollView:onInitView()
	LuaTreeScrollView.super.onInitView(self)

	if self._param.prefabType == ScrollEnum.ScrollPrefabFromView then
		self._prefabInViewList = {}

		for _, path in ipairs(self._param.prefabUrls) do
			local onePrefabInView = gohelper.findChild(self.viewGO, path)

			table.insert(self._prefabInViewList, onePrefabInView)
			gohelper.setActive(onePrefabInView, false)
		end
	end

	local scrollGO = gohelper.findChild(self.viewGO, self._param.scrollGOPath)

	self._csTreeScroll = SLFramework.UGUI.TreeScrollView.Get(scrollGO)

	self._csTreeScroll:Init(self._param.scrollDir, self._onUpdateCell, self._onSelectCell, self)
end

function LuaTreeScrollView:getCsScroll()
	return self._csTreeScroll
end

function LuaTreeScrollView:refreshScroll()
	LuaTreeScrollView.super.refreshScroll(self)
	self._csTreeScroll:UpdateTreeInfoList(self._model:getInfoList())
	self:updateEmptyGO(self._model:getRootCount())
end

function LuaTreeScrollView:_onUpdateCell(cellGO, cellType, rootIndex, nodeIndex)
	local prefabInstGO = gohelper.findChild(cellGO, LuaTreeScrollView.PrefabInstName)
	local luaCellComp

	if prefabInstGO then
		luaCellComp = MonoHelper.getLuaComFromGo(prefabInstGO, self._param.cellClass)
	else
		if self._param.prefabType == ScrollEnum.ScrollPrefabFromRes then
			prefabInstGO = self:getResInst(self._param.prefabUrls[cellType], cellGO, LuaTreeScrollView.PrefabInstName)
		elseif self._param.prefabType == ScrollEnum.ScrollPrefabFromView then
			prefabInstGO = gohelper.clone(self._prefabInViewList[cellType], cellGO, LuaTreeScrollView.PrefabInstName)

			gohelper.setActive(prefabInstGO, true)
		else
			logError("TreeScrollView prefabType not support: " .. self._param.prefabType)
		end

		luaCellComp = MonoHelper.addNoUpdateLuaComOnceToGo(prefabInstGO, self._param.cellClass)

		luaCellComp:initInternal(prefabInstGO, self)

		self._cellCompDict[luaCellComp] = true
	end

	local mo = self._model:getByIndex(rootIndex + 1, nodeIndex + 1)

	luaCellComp._rootIndex = rootIndex + 1
	luaCellComp._nodeIndex = nodeIndex + 1

	if nodeIndex == -1 then
		luaCellComp:onUpdateRootMOInternal(mo)
	else
		luaCellComp:onUpdateNodeMOInternal(mo)
	end

	if tabletool.indexOf(self._selectMOs, mo) then
		luaCellComp:onSelect(true)
	else
		luaCellComp:onSelect(false)
	end
end

function LuaTreeScrollView:_onSelectCell(cellGO, isSelect)
	local prefabInstGO = gohelper.findChild(cellGO, LuaTreeScrollView.PrefabInstName)
	local luaCellComp = MonoHelper.getLuaComFromGo(prefabInstGO, self._param.cellClass)

	luaCellComp:onSelect(isSelect)
end

function LuaTreeScrollView:selectCell(rootIndex, nodeIndex, isSelected)
	local mo = self._model:getByIndex(rootIndex, nodeIndex)

	if mo then
		local index = tabletool.indexOf(self._selectMOs, mo)

		if index and not isSelected then
			table.remove(self._selectMOs, index)
		elseif isSelected and not index then
			table.insert(self._selectMOs, mo)
		end

		self._csTreeScroll:SelectCell(rootIndex - 1, nodeIndex - 1, isSelected)
	end
end

function LuaTreeScrollView:getSelectItems()
	return self._selectMOs
end

function LuaTreeScrollView:setSelectItems(items)
	self._selectMOs = items

	self._csTreeScroll:UpdateCells(true, false)
end

function LuaTreeScrollView:expand(rootIndex, hasTransition, duration, callBack, callbackObj)
	if self:isInTransition(rootIndex) then
		return
	end

	if hasTransition == nil then
		hasTransition = true
	end

	duration = duration or LuaTreeScrollView.DefaultTransitionSeconds

	self._csTreeScroll:Expand(rootIndex - 1, hasTransition, duration, callBack, callbackObj)
end

function LuaTreeScrollView:shrink(rootIndex, hasTransition, duration, callBack, callbackObj)
	if self:isInTransition(rootIndex) then
		return
	end

	if hasTransition == nil then
		hasTransition = true
	end

	duration = duration or LuaTreeScrollView.DefaultTransitionSeconds

	self._csTreeScroll:Shrink(rootIndex - 1, hasTransition, duration, callBack, callbackObj)
end

function LuaTreeScrollView:isInTransition(rootIndex)
	return self._csTreeScroll:IsInTransition(rootIndex - 1)
end

function LuaTreeScrollView:isExpand(rootIndex)
	return self._csTreeScroll:IsExpand(rootIndex - 1)
end

function LuaTreeScrollView:reverseRootOp(rootIndex, hasTransition, duration, callBack, callbackObj)
	if self:isExpand(rootIndex) then
		self:shrink(rootIndex, hasTransition, duration, callBack, callbackObj)
	else
		self:expand(rootIndex, hasTransition, duration, callBack, callbackObj)
	end
end

function LuaTreeScrollView:clear()
	if self._csTreeScroll then
		self._csTreeScroll:Clear()
	end
end

function LuaTreeScrollView:onDestroyView()
	LuaTreeScrollView.super.onDestroyView(self)

	if self._csTreeScroll then
		self._csTreeScroll:Clear()
	end
end

return LuaTreeScrollView
