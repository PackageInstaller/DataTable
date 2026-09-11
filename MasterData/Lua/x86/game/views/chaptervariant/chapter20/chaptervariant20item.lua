ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")

local ChapterVariant20Item = class("ChapterVariant20Item", ChapterVariantBaseItem)

function ChapterVariant20Item:BindRedPoint()
	manager.redPoint:bindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

function ChapterVariant20Item:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

return ChapterVariant20Item
