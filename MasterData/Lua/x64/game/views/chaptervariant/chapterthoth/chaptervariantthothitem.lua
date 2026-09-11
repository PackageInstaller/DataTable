ChapterVariantSubPlotBaseItem = import("game.views.chapterVariant.base.ChapterVariantSubPlotBaseItem")

local ChapterVariantThothItem = class("ChapterVariantThothItem", ChapterVariantSubPlotBaseItem)

function ChapterVariantThothItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function ChapterVariantThothItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function ChapterVariantThothItem:RefreshControllerState()
	if self.isLock_ or self.timeLock_ then
		self.controller_:SetSelectedState("timeLock")

		if self.timeLock_ == false and self.isLock_ then
			self.timerText_.text = GetTips("NEED_FINISH_PRE_NORMAL_STAGE")
		end
	else
		self.controller_:SetSelectedState("normal")
	end
end

return ChapterVariantThothItem
