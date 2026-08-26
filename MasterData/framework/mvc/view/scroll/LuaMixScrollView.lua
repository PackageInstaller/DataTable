-- chunkname: @framework/mvc/view/scroll/LuaMixScrollView.lua

module("framework.mvc.view.scroll.LuaMixScrollView", package.seeall)

local LuaMixScrollView = class("LuaMixScrollView", BaseScrollView)

function LuaMixScrollView:ctor(scrollModel, mixScrollParam)
	LuaMixScrollView.super.ctor(self, scrollModel, mixScrollParam.emptyScrollParam)

	self._csMixScroll = nil
	self._model = scrollModel
	self._param = mixScrollParam
	self._cellCompDict = {}
end

function LuaMixScrollView:onInitView()
	LuaMixScrollView.super.onInitView(self)

	if self._param.prefabType == ScrollEnum.ScrollPrefabFromView then
		self._cellSourceGO = gohelper.findChild(self.viewGO, self._param.prefabUrl)

		gohelper.setActive(self._cellSourceGO, false)
	end

	local scrollGO = gohelper.findChild(self.viewGO, self._param.scrollGOPath)

	self._csMixScroll = SLFramework.UGUI.MixScrollView.Get(scrollGO)

	self._csMixScroll:Init(self._param.scrollDir, self._param.startSpace or 0, self._param.endSpace or 0, self._model:getInfoList(), self._onUpdateCell, self)
end

function LuaMixScrollView:clear()
	if self._csMixScroll then
		self._csMixScroll:Clear()
	end
end

function LuaMixScrollView:onDestroyView()
	LuaMixScrollView.super.onDestroyView(self)
	self._csMixScroll:Clear()

	self._csMixScroll = nil
	self._model = nil
	self._param = nil
	self._cellCompDict = nil
end

function LuaMixScrollView:getCsScroll()
	return self._csMixScroll
end

function LuaMixScrollView:refreshScroll()
	LuaMixScrollView.super.refreshScroll(self)
	self._csMixScroll:UpdateInfo(self._model:getInfoList(self._csMixScroll.gameObject), true, false)
	self:updateEmptyGO(self._model:getCount())
end

function LuaMixScrollView:_onUpdateCell(cellGO, index, type, param)
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
			logError("LuaMixScrollView prefabType not support: " .. self._param.prefabType)
		end

		luaCellComp = MonoHelper.addNoUpdateLuaComOnceToGo(prefabInstGO, self._param.cellClass)

		luaCellComp:initInternal(prefabInstGO, self)

		self._cellCompDict[luaCellComp] = true
	end

	local mo = self._model:getByIndex(index + 1)

	luaCellComp._index = index + 1

	luaCellComp:onUpdateMO(mo, type, param)
end

return LuaMixScrollView
