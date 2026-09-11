local ChapterPlot19MapLocationTitileItem = class("ChapterPlot19MapLocationTitileItem", ReduxView)

function ChapterPlot19MapLocationTitileItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
end

function ChapterPlot19MapLocationTitileItem:Show(arg_2_1)
	SetActive(self.gameObject_, arg_2_1)

	if arg_2_1 then
		self.transform_:SetAsLastSibling()
	end
end

function ChapterPlot19MapLocationTitileItem:Dispose()
	ChapterPlot19MapLocationTitileItem.super.Dispose(self)
end

return ChapterPlot19MapLocationTitileItem
