local ActivityNoobFirstRechargeView = class("ActivityNoobFirstRechargeView", ReduxView)

function ActivityNoobFirstRechargeView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1.gameObject
	self.transform_ = arg_1_1
	self.contentTrans_ = arg_1_1
	self.contentViewList_ = {}
	self.type_ = arg_1_2
	self.contentClasss_ = {
		ActivityNoobFirstRechargeView_1,
		ActivityNoobFirstRechargeView_2
	}
end

function ActivityNoobFirstRechargeView:Dispose()
	for iter_2_0, iter_2_1 in pairs(self.contentViewList_) do
		iter_2_1:Dispose()
	end

	self.contentViewList_ = nil

	ActivityNoobFirstRechargeView.super.Dispose(self)
end

function ActivityNoobFirstRechargeView:SetActive(arg_3_1)
	if self.curView_ then
		self.curView_:SetActive(arg_3_1)
	end
end

function ActivityNoobFirstRechargeView:SetType(arg_4_1)
	self.type_ = arg_4_1
end

function ActivityNoobFirstRechargeView:SetData(arg_5_1)
	if arg_5_1 == nil then
		return
	end

	if self.curView_ then
		self.curView_:SetActive(false)
	end

	self.contentViewList_[arg_5_1] = self.contentViewList_[arg_5_1] or self.contentClasss_[arg_5_1].New(self.contentTrans_, self.type_)
	self.curView_ = self.contentViewList_[arg_5_1]

	self.curView_:SetData(arg_5_1)
	self.curView_:SetActive(true)
end

return ActivityNoobFirstRechargeView
