ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")

local ChapterVariant16Item = class("ChapterVariant16Item", ChapterVariantBaseItem)

function ChapterVariant16Item:BindRedPoint()
	manager.redPoint:bindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

function ChapterVariant16Item:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

return ChapterVariant16Item
