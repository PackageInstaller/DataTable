local ChapterPlot19StoryCollectStoryItem = class("ChapterPlot19StoryCollectStoryItem", ReduxView)

function ChapterPlot19StoryCollectStoryItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChapterPlot19StoryCollectStoryItem:Dispose()
	ChapterPlot19StoryCollectStoryItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
end

function ChapterPlot19StoryCollectStoryItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		JumpTools.OpenPageByJump("gameHelpLong", {
			title = StageArchiveCfg[self.storyID_].name,
			content = formatText(StageArchiveCfg[self.storyID_].desc)
		})
	end)
end

function ChapterPlot19StoryCollectStoryItem:SetData(arg_5_1)
	self.storyID_ = arg_5_1
	self.nameText_.text = StageArchiveCfg[arg_5_1].name

	self:Show(true)
end

function ChapterPlot19StoryCollectStoryItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

return ChapterPlot19StoryCollectStoryItem
