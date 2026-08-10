ChapterVariantBaseView = import("game.views.chapterVariant.base.ChapterVariantBaseView")

local var_0_0 = class("ChapterVariant20View", ChapterVariantBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/ChaptePlot/ShashwatUI_3_6_MainlineUI"
end

function var_0_0.GetItemClass(arg_2_0)
	return ChapterVariant20Item
end

return var_0_0
