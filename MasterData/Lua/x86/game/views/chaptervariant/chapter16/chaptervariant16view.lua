ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local ChapterVariant16View = class("ChapterVariant16View", ChapterVariantBaseView)

function ChapterVariant16View:UIName()
	return "UI/Stage/ChaptePlot/JapanRegionMainUI"
end

function ChapterVariant16View:GetItemClass()
	return ChapterVariant16Item
end

return ChapterVariant16View
