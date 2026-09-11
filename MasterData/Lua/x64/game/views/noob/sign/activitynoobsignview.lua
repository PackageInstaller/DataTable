local ActivityNoobSignView = class("ActivityNoobSignView", ReduxView)

function ActivityNoobSignView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.contentTrans_ = arg_1_1
	self.contenViewList_ = {}
end

function ActivityNoobSignView:Dispose()
	for iter_2_0, iter_2_1 in pairs(self.contenViewList_) do
		iter_2_1:Dispose()
	end

	ActivityNoobSignView.super.Dispose(self)
end

function ActivityNoobSignView:SetActive(arg_3_1)
	if self.curView_ then
		self.curView_:SetActive(arg_3_1)
	end
end

function ActivityNoobSignView:SetData(arg_4_1)
	if arg_4_1 == nil then
		return
	end

	if self.curView_ then
		self.curView_:SetActive(false)
	end

	self.contenViewList_[arg_4_1] = self.contenViewList_[arg_4_1] or ActivityNoobSignContentView.New(self.contentTrans_, arg_4_1)
	self.curView_ = self.contenViewList_[arg_4_1]

	self.curView_:SetData(arg_4_1)
	self.curView_:SetActive(true)
end

return ActivityNoobSignView
