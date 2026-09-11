ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local ChapterVariant17View = class("ChapterVariant17View", ChapterVariantBaseView)

function ChapterVariant17View:UIName()
	return "UI/Stage/ChaptePlot/JapanRegionMainlineUI"
end

function ChapterVariant17View:GetItemClass()
	return ChapterVariant17Item
end

return ChapterVariant17View
