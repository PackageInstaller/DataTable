local ChapterChallengeLnkView = class("ChapterChallengeLnkView", ReduxView)

function ChapterChallengeLnkView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.lnkItemList_ = {}

	for iter_1_0 = 1, 4 do
		self.lnkItemList_[iter_1_0] = ChapterChallengeLnkItem.New(self[string.format("item%s_", iter_1_0)])
	end
end

function ChapterChallengeLnkView:OnEnter(arg_2_1)
	for iter_2_0 = 1, #arg_2_1 do
		self.lnkItemList_[iter_2_0 + #self.lnkItemList_ - #arg_2_1]:SetData(arg_2_1[iter_2_0])
	end

	for iter_2_1 = 1, #self.lnkItemList_ - #arg_2_1 do
		self.lnkItemList_[iter_2_1]:Show(false)
	end
end

function ChapterChallengeLnkView:OnExit()
	for iter_3_0, iter_3_1 in ipairs(self.lnkItemList_) do
		iter_3_1:OnExit()
	end
end

function ChapterChallengeLnkView:RefresLock()
	for iter_4_0, iter_4_1 in ipairs(self.lnkItemList_) do
		iter_4_1:RefreshLockState()
	end
end

function ChapterChallengeLnkView:Dispose()
	ChapterChallengeLnkView.super.Dispose(self)

	for iter_5_0, iter_5_1 in ipairs(self.lnkItemList_) do
		iter_5_1:Dispose()
	end

	self.lnkItemList_ = nil
	self.gameObject_ = nil
	self.transform_ = nil
end

return ChapterChallengeLnkView
