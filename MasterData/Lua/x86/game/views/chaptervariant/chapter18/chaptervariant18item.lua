ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")

local ChapterVariant18Item = class("ChapterVariant18Item", ChapterVariantBaseItem)

function ChapterVariant18Item:BindRedPoint()
	manager.redPoint:bindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

function ChapterVariant18Item:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

return ChapterVariant18Item
