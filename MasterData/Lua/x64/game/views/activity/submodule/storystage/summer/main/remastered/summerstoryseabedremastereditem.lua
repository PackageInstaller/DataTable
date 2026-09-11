local SummerStorySeabedRemasterdItem = class("SummerStorySeabedRemasterdItem", ReduxView)

function SummerStorySeabedRemasterdItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function SummerStorySeabedRemasterdItem:OnEnter()
	self.unLockState_ = BattleStageData:GetStageData()[ChapterCfg[self.chapterID_].section_id_list[1]] ~= nil

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
	self:RefreshState()
end

function SummerStorySeabedRemasterdItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function SummerStorySeabedRemasterdItem:Dispose()
	SummerStorySeabedRemasterdItem.super.Dispose(self)
end

function SummerStorySeabedRemasterdItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if not self.unLockState_ then
			ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")

			return
		end

		local var_6_0 = getChapterClientCfgByChapterID(self.chapterID_)

		BattleFieldData:SetCacheChapterClient(getChapterToggle(var_6_0.id), var_6_0.id)
		BattleFieldData:SetCacheChapter(var_6_0.id, self.chapterID_)
		BattleStageAction.ClickSubPlot(self.chapterID_)
		self:Go("/summerSeabedStoryRemastered", {
			chapterID = self.chapterID_
		})
	end)
end

function SummerStorySeabedRemasterdItem:RefreshState()
	self.timeText_.text = ""

	if self.unLockState_ then
		self.controller_:SetSelectedState("on")
	else
		self.controller_:SetSelectedState("off")
	end
end

return SummerStorySeabedRemasterdItem
