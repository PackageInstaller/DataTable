ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local ChapterVariantThothView = class("ChapterVariantThothView", ChapterVariantBaseView)

function ChapterVariantThothView:UIName()
	return "Widget/System/ChaptePlot/NorseUI_3_0_Plot01UI"
end

function ChapterVariantThothView:GetItemClass()
	return ChapterVariantThothItem
end

return ChapterVariantThothView
