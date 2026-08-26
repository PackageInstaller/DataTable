-- chunkname: @framework/mvc/view/scroll/LuaListScrollView.lua

module("framework.mvc.view.scroll.LuaListScrollView", package.seeall)

local LuaListScrollView = class("LuaListScrollView", BaseScrollView)

LuaListScrollView.PrefabInstName = "prefabInst"

function LuaListScrollView:ctor(scrollModel, listScrollParam)
	LuaListScrollView.super.ctor(self, scrollModel, listScrollParam.emptyScrollParam)

	self._csListScroll = nil
	self._model = scrollModel
	self._param = listScrollParam
	self._selectMOs = {}
	self._cellCompDict = {}
end

function LuaListScrollView:onInitView()
	LuaListScrollView.super.onInitView(self)

	if self._param.prefabType == ScrollEnum.ScrollPrefabFromView then
		self._cellSourceGO = gohelper.findChild(self.viewGO, self._param.prefabUrl)

		gohelper.setActive(self._cellSourceGO, false)
	end

	local scrollGO = gohelper.findChild(self.viewGO, self._param.scrollGOPath)

	self._csListScroll = SLFramework.UGUI.ListScrollView.Get(scrollGO)

	self._csListScroll:Init(self._param.scrollDir, self._param.lineCount, self._param.cellWidth, self._param.cellHeight, self._param.cellSpaceH, self._param.cellSpaceV, self._param.startSpace, self._param.endSpace, self._param.sortMode, self._param.frameUpdateMs, self._param.minUpdateCountInFrame, self._onUpdateCell, self.onUpdateFinish, self._onSelectCell, self)
end

function LuaListScrollView:clear()
	if self._csListScroll then
		self._csListScroll:Clear()
	end
end

function LuaListScrollView:onDestroyView()
	LuaListScrollView.super.onDestroyView(self)
	self._csListScroll:Clear()

	self._csListScroll = nil
	self._model = nil
	self._param = nil
	self._selectMOs = nil
	self._cellCompDict = nil
end

function LuaListScrollView:getCsListScroll()
	return self._csListScroll
end

function LuaListScrollView:refreshScroll()
	LuaListScrollView.super.refreshScroll(self)

	local moCount = self._model:getCount()

	self._csListScroll:UpdateTotalCount(moCount)
	self:updateEmptyGO(moCount)
end

function LuaListScrollView:selectCell(index, isSelect)
	local mo = self._model:getByIndex(index)

	if not mo then
		return
	end

	if self._param.multiSelect then
		local i = tabletool.indexOf(self._selectMOs, mo)

		if i and not isSelect then
			table.remove(self._selectMOs, i)
		else
			table.insert(self._selectMOs, mo)
		end
	else
		local firstSelectMO = self._selectMOs[1]

		if firstSelectMO then
			local i = self._model:getIndex(firstSelectMO)

			if i then
				self._csListScroll:SelectCell(i - 1, false)
			end
		end

		self._selectMOs = isSelect and {
			mo
		} or {}
	end

	self._csListScroll:SelectCell(index - 1, isSelect)
end

function LuaListScrollView:getFirstSelect()
	return self._selectMOs[1]
end

function LuaListScrollView:getSelectList()
	return self._selectMOs
end

function LuaListScrollView:setSelect(mo)
	self:setSelectList({
		mo
	})
end

function LuaListScrollView:setSelectList(list)
	self._selectMOs = {}

	if list then
		for _, mo in ipairs(list) do
			table.insert(self._selectMOs, mo)
		end
	end

	if self._csListScroll then
		self._csListScroll:UpdateVisualCells()
	end
end

function LuaListScrollView:_onUpdateCell(cellGO, index)
	local prefabInstGO = gohelper.findChild(cellGO, LuaListScrollView.PrefabInstName)
	local luaCellComp

	if prefabInstGO then
		luaCellComp = MonoHelper.getLuaComFromGo(prefabInstGO, self._param.cellClass)
	else
		if self._param.prefabType == ScrollEnum.ScrollPrefabFromRes then
			prefabInstGO = self:getResInst(self._param.prefabUrl, cellGO, LuaListScrollView.PrefabInstName)
		elseif self._param.prefabType == ScrollEnum.ScrollPrefabFromView then
			prefabInstGO = gohelper.clone(self._cellSourceGO, cellGO, LuaListScrollView.PrefabInstName)

			gohelper.setActive(prefabInstGO, true)
		else
			logError("ListScrollView prefabType not support: " .. self._param.prefabType)
		end

		luaCellComp = MonoHelper.addNoUpdateLuaComOnceToGo(prefabInstGO, self._param.cellClass)

		luaCellComp:initInternal(prefabInstGO, self)

		self._cellCompDict[luaCellComp] = true
	end

	local mo = self._model:getByIndex(index + 1)

	luaCellComp._index = index + 1

	luaCellComp:onUpdateMO(mo)

	if tabletool.indexOf(self._selectMOs, mo) then
		luaCellComp:onSelect(true)
	else
		luaCellComp:onSelect(false)
	end
end

function LuaListScrollView:onUpdateFinish()
	return
end

function LuaListScrollView:_onSelectCell(cellGO, isSelect)
	local prefabInstGO = gohelper.findChild(cellGO, LuaListScrollView.PrefabInstName)

	if prefabInstGO then
		local luaCellComp = MonoHelper.getLuaComFromGo(prefabInstGO, self._param.cellClass)

		if luaCellComp then
			luaCellComp:onSelect(isSelect)
		end
	end
end

return LuaListScrollView
