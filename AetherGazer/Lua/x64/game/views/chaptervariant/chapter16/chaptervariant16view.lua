ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local var_0_0 = class("ChapterVariant16View", ChapterVariantBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/ChaptePlot/JapanRegionMainUI"
end

function var_0_0.GetItemClass(arg_2_0)
	return ChapterVariant16Item
end

return var_0_0
