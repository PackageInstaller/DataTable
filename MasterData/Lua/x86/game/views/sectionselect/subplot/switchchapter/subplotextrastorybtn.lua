local SubPlotExtraStoryBtn = class("SubPlotExtraStoryBtn", ReduxView)

function SubPlotExtraStoryBtn:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function SubPlotExtraStoryBtn:OnEnter()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, getChapterClientCfgByChapterID(self.chapterID_).id))
end

function SubPlotExtraStoryBtn:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, getChapterClientCfgByChapterID(self.chapterID_).id))
end

function SubPlotExtraStoryBtn:Dispose()
	SubPlotExtraStoryBtn.super.Dispose(self)
end

function SubPlotExtraStoryBtn:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		local var_6_0 = getChapterClientCfgByChapterID(self.chapterID_)

		if var_6_0.extra_story_unlock_condition ~= "" then
			for iter_6_0, iter_6_1 in ipairs(var_6_0.extra_story_unlock_condition) do
				if not isMeetCondition(iter_6_1) then
					ShowTips(getConditionText(iter_6_1))

					return
				end
			end
		end

		BattleStageAction.ClickSubPlotExtraStory(var_6_0.id)

		if type(var_6_0.extra_strory_system) == "table" then
			JumpTools.JumpToPage2(var_6_0.extra_strory_system)
		end
	end)
end

function SubPlotExtraStoryBtn:SetData(arg_7_1)
	self.chapterID_ = arg_7_1

	self:RefreshUI()
end

function SubPlotExtraStoryBtn:RefreshUI()
	if type(getChapterClientCfgByChapterID(self.chapterID_).extra_strory_system) == "table" then
		SetActive(self.gameObject_, true)
	else
		SetActive(self.gameObject_, false)
	end
end

return SubPlotExtraStoryBtn
