ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local ChapterVariant18View = class("ChapterVariant18View", ChapterVariantBaseView)

function ChapterVariant18View:UIName()
	return "UI/Stage/ChaptePlot/JapanRegionMain_2_10UI"
end

function ChapterVariant18View:GetItemClass()
	return ChapterVariant18Item
end

return ChapterVariant18View
