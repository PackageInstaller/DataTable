-- chunkname: @framework/mvc/view/scroll/LuaCircleScrollView.lua

module("framework.mvc.view.scroll.LuaCircleScrollView", package.seeall)

local LuaCircleScrollView = class("LuaCircleScrollView", BaseScrollView)

function LuaCircleScrollView:ctor(scrollModel, circleScrollParam)
	LuaCircleScrollView.super.ctor(self, scrollModel, circleScrollParam.emptyScrollParam)

	self._csCircleScroll = nil
	self._model = scrollModel
	self._param = circleScrollParam
	self._cellCompDict = {}
end

function LuaCircleScrollView:onInitView()
	LuaCircleScrollView.super.onInitView(self)

	if self._param.prefabType == ScrollEnum.ScrollPrefabFromView then
		self._cellSourceGO = gohelper.findChild(self.viewGO, self._param.prefabUrl)

		gohelper.setActive(self._cellSourceGO, false)
	end

	local scrollGO = gohelper.findChild(self.viewGO, self._param.scrollGOPath)

	self._csCircleScroll = SLFramework.UGUI.CircleScrollView.Get(scrollGO)

	self._csCircleScroll:Init(self._param.scrollDir, self._param.rotateDir, self._param.circleCellCount, self._param.scrollRadius, self._param.cellRadius, self._param.firstDegree, self._param.isLoop, self._onUpdateCell, self._onSelectCell, self)
end

function LuaCircleScrollView:getCsScroll()
	return self._csCircleScroll
end

function LuaCircleScrollView:_onUpdateCell(cellGO, listIndex, cellIndex)
	return
end

function LuaCircleScrollView:_onSelectCell(cellGO, isSelect)
	return
end

return LuaCircleScrollView
