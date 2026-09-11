local StoryChapterView = class("StoryChapterView", ReduxView)

function StoryChapterView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityID_ = arg_1_2

	self:BindCfgUI()

	self.btnList_ = {}

	for iter_1_0, iter_1_1 in pairs(ActivityStoryChapterCfg.get_id_list_by_activity_id[arg_1_2]) do
		self.btnList_[iter_1_0] = StoryChapterBtnView.New(self[string.format("btnChapter%s_", iter_1_0)], iter_1_1)
	end
end

function StoryChapterView:OnEnter(arg_2_1)
	for iter_2_0, iter_2_1 in pairs(self.btnList_) do
		iter_2_1:OnEnter(arg_2_1)
	end

	self:RefreshUI(arg_2_1)
end

function StoryChapterView:OnExit()
	for iter_3_0, iter_3_1 in pairs(self.btnList_) do
		iter_3_1:OnExit()
	end
end

function StoryChapterView:OnUpdate(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.btnList_) do
		iter_4_1:OnUpdate(arg_4_1)
	end

	self:RefreshUI(arg_4_1)
end

function StoryChapterView:Dispose()
	StoryChapterView.super.Dispose(self)

	for iter_5_0, iter_5_1 in pairs(self.btnList_) do
		iter_5_1:Dispose()
	end

	self.btnList_ = nil
end

function StoryChapterView:RefreshUI(arg_6_1)
	SetActive(self.gameObject_, ActivityStoryChapterCfg[arg_6_1].activity_id == self.activityID_)
end

return StoryChapterView
