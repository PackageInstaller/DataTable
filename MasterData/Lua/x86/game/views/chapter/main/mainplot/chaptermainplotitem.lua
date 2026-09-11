local ChapterMainPlotItem = class("ChapterMainPlotItem", ReduxView)

function ChapterMainPlotItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
end

function ChapterMainPlotItem:Dispose()
	ChapterMainPlotItem.super.Dispose(self)
end

function ChapterMainPlotItem:AddListeners()
	return
end

return ChapterMainPlotItem
