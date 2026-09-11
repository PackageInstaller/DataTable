ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local ChapterVariant20View = class("ChapterVariant20View", ChapterVariantBaseView)

function ChapterVariant20View:UIName()
	return "UI/Stage/ChaptePlot/ShashwatUI_3_6_MainlineUI"
end

function ChapterVariant20View:GetItemClass()
	return ChapterVariant20Item
end

return ChapterVariant20View
