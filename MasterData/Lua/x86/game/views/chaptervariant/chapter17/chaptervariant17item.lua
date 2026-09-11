ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")

local ChapterVariant17Item = class("ChapterVariant17Item", ChapterVariantBaseItem)

function ChapterVariant17Item:BindRedPoint()
	manager.redPoint:bindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

function ChapterVariant17Item:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

return ChapterVariant17Item
