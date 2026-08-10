ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local var_0_0 = class("ChapterVariantThothView", ChapterVariantBaseView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ChaptePlot/NorseUI_3_0_Plot01UI"
end

function var_0_0.GetItemClass(arg_2_0)
	return ChapterVariantThothItem
end

return var_0_0
