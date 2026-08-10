ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")

local var_0_0 = class("ChapterVariant20Item", ChapterVariantBaseItem)

function var_0_0.BindRedPoint(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, arg_1_0.chapterID_))
end

function var_0_0.UnBindRedPoint(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, arg_2_0.chapterID_))
end

return var_0_0
