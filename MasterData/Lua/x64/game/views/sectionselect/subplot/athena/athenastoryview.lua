SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local AthenaStoryView = class("AthenaStoryView", SubPlotBaseView)

function AthenaStoryView:UIName()
	return "Widget/System/Operation/ChapterSectionUI/VolumeIIIDownSubPlotUI"
end

function AthenaStoryView:OnEnter()
	AthenaStoryView.super.OnEnter(self)

	if not getData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. self.params_.chapterClientID) then
		saveData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. self.params_.chapterClientID, 1)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_POLT_NEW_TAG, self.params_.chapterClientID), 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function AthenaStoryView:GetItemClass()
	return AthenaStoryItem
end

return AthenaStoryView
