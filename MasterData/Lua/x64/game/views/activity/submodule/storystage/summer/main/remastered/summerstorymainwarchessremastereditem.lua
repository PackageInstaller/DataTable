SummerStoryMainWarchessItem = import("game.views.activity.Submodule.storyStage.summer.main.SummerStoryMainWarchessItem")

local SummerStoryMainWarchessRemasteredItem = class("SummerStoryMainWarchessRemasteredItem", SummerStoryMainWarchessItem)

function SummerStoryMainWarchessRemasteredItem:OnEnter()
	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ChessConst.SUBPLOT_TAG.ISLAND, self.chapterID_))
	self:RefreshState()
end

function SummerStoryMainWarchessRemasteredItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ChessConst.SUBPLOT_TAG.ISLAND, self.chapterID_))
end

function SummerStoryMainWarchessRemasteredItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self:IsPrestageLock() then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(GetTips("CHESS_NAME_" .. WarchessLevelCfg[self.chapterID_].tag)), WarchessLevelCfg[WarchessLevelCfg[self.chapterID_].unlock_level].name_level))

			return
		end

		if self:IsLock() then
			if WarchessLevelCfg[self.chapterID_].unlock_condition[1] == 1 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityStoryChapterCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][1]].name), BattleActivityStoryStageCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][2]].name))
			elseif WarchessLevelCfg[self.chapterID_].unlock_condition[1] == 2 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ChapterCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][1]].subhead), BattleActivityStoryStageCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][2]].name))
			end

			return
		end

		ChessTools.EnterChessMap(self.chapterID_, true)
	end)
end

function SummerStoryMainWarchessRemasteredItem:IsLock()
	if WarchessLevelCfg[self.chapterID_].unlock_condition ~= "" then
		if WarchessLevelCfg[self.chapterID_].unlock_condition[1] == 1 then
			local var_5_0 = StoryStageActivityData:GetStageData(WarchessLevelCfg[self.chapterID_].unlock_condition[2][1])[WarchessLevelCfg[self.chapterID_].unlock_condition[2][2]]

			if var_5_0 and var_5_0.clear_times >= 1 then
				-- block empty
			else
				return true
			end
		elseif WarchessLevelCfg[self.chapterID_].unlock_condition[1] == 2 then
			return not ChapterTools.IsClearStage(WarchessLevelCfg[self.chapterID_].unlock_condition[2][2])
		end
	end

	return false
end

function SummerStoryMainWarchessRemasteredItem:RefreshState()
	if self:IsPrestageLock() or self:IsLock() then
		self.controller_:SetSelectedState("open")

		return
	end

	if WarChessData:GetCurrentChapter(WarchessLevelCfg[self.chapterID_].type) == self.chapterID_ then
		self.controller_:SetSelectedState("challenge")
	else
		self.controller_:SetSelectedState("normal")
	end
end

return SummerStoryMainWarchessRemasteredItem
