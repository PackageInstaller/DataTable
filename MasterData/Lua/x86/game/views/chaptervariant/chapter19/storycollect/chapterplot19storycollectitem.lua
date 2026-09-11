local ChapterPlot19StoryCollectItem = class("ChapterPlot19StoryCollectItem", ReduxView)

function ChapterPlot19StoryCollectItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:BindCfgUI()

	self.itemList_ = {}
end

function ChapterPlot19StoryCollectItem:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.itemList_) do
		iter_2_1:Dispose()
	end

	self.itemList_ = nil

	ChapterPlot19StoryCollectItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
end

function ChapterPlot19StoryCollectItem:SetData(arg_3_1)
	self.titleText_.text = ChapterStoryCollectCfg[arg_3_1].title_name

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(ChapterStoryCollectCfg[arg_3_1].story_id_list) do
		if ChapterTools.HasReadEventID(iter_3_1) then
			table.insert(var_3_0, iter_3_1)
		end
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_0) do
		if self.itemList_[iter_3_2] == nil then
			self.itemList_[iter_3_2] = ChapterPlot19StoryCollectStoryItem.New(self.storyItem_, self.gameObject_)
		end

		self.itemList_[iter_3_2]:SetData(iter_3_3)
	end

	for iter_3_4 = #self.itemList_, #var_3_0 + 1, -1 do
		self.itemList_[iter_3_4]:Show(false)
	end
end

return ChapterPlot19StoryCollectItem
