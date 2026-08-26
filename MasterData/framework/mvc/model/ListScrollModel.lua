-- chunkname: @framework/mvc/model/ListScrollModel.lua

module("framework.mvc.model.ListScrollModel", package.seeall)

local ListScrollModel = class("ListScrollModel", BaseModel)

function ListScrollModel:ctor()
	ListScrollModel.super.ctor(self)

	self._scrollViews = {}
end

function ListScrollModel:reInitInternal()
	ListScrollModel.super.reInitInternal(self)

	for _, scrollView in ipairs(self._scrollViews) do
		if scrollView.clear then
			scrollView:clear()
		end
	end
end

function ListScrollModel:addScrollView(scrollView)
	table.insert(self._scrollViews, scrollView)
end

function ListScrollModel:removeScrollView(scrollView)
	tabletool.removeValue(self._scrollViews, scrollView)
end

function ListScrollModel:onModelUpdate()
	for _, scrollView in ipairs(self._scrollViews) do
		scrollView:onModelUpdate()
	end
end

function ListScrollModel:selectCell(index, isSelect)
	for _, scrollView in ipairs(self._scrollViews) do
		scrollView:selectCell(index, isSelect)
	end
end

function ListScrollModel:sort(sortFunction)
	ListScrollModel.super.sort(self, sortFunction)
	self:onModelUpdate()
end

function ListScrollModel:addList(list)
	ListScrollModel.super.addList(self, list)
	self:onModelUpdate()
end

function ListScrollModel:addAt(mo, index)
	ListScrollModel.super.addAt(self, mo, index)
	self:onModelUpdate()
end

function ListScrollModel:removeAt(index)
	local mo = ListScrollModel.super.removeAt(self, index)

	self:onModelUpdate()

	return mo
end

function ListScrollModel:clear()
	ListScrollModel.super.clear(self)
	self:onModelUpdate()
end

return ListScrollModel
