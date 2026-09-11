SummerStoryMainItem = import("game.views.activity.Submodule.storyStage.summer.main.SummerStoryMainItem")

local SummerStoryMainRemasteredItem = class("SummerStoryMainRemasteredItem", SummerStoryMainItem)

function SummerStoryMainRemasteredItem:OnEnter()
	SummerStoryMainRemasteredItem.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function SummerStoryMainRemasteredItem:OnExit()
	SummerStoryMainRemasteredItem.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function SummerStoryMainRemasteredItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		local var_4_0 = getChapterClientCfgByChapterID(self.chapterID_)

		BattleFieldData:SetCacheChapterClient(var_4_0.id, var_4_0.id)
		BattleFieldData:SetCacheChapter(var_4_0.id, self.chapterID_)
		BattleStageAction.ClickSubPlot(self.chapterID_)
		self:Go("/summerStoryRemastered", {
			chapterID = self.chapterID_
		})
	end)
end

function SummerStoryMainRemasteredItem:RefreshUI()
	local var_5_0 = (#ChapterCfg[self.chapterID_].section_id_list - ChapterTools.GetUnclearStageCnt(self.chapterID_)) / #ChapterCfg[self.chapterID_].section_id_list

	self.progressText_.text = string.format("%d%%", var_5_0 * 100)
	self.slider_.fillAmount = var_5_0

	if var_5_0 < 1 then
		self.controller_:SetSelectedState("enter")
	else
		self.controller_:SetSelectedState("false")
	end
end

return SummerStoryMainRemasteredItem
