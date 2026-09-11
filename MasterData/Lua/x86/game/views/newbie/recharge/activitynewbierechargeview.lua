local ActivityNewbieRechargeView = class("ActivityNewbieRechargeView", ReduxView)

function ActivityNewbieRechargeView:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Activitynewbie/NewbieRechargeUI"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.rechargeItemList_ = {}

	for iter_1_0, iter_1_1 in pairs(ActivityNewbieData:GetRechargeTemplate()) do
		self.rechargeItemList_[iter_1_0] = ActivityNewbieRechargeItem.New(self[string.format("button%s_", iter_1_0)], iter_1_0)
	end
end

function ActivityNewbieRechargeView:Dispose()
	ActivityNewbieRechargeView.super.Dispose(self)

	for iter_2_0, iter_2_1 in pairs(self.rechargeItemList_) do
		iter_2_1:Dispose()
	end

	self.rechargeItemList_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityNewbieRechargeView:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)

	if arg_3_1 then
		for iter_3_0, iter_3_1 in pairs(self.rechargeItemList_) do
			iter_3_1:RefreshUI()
		end
	end
end

return ActivityNewbieRechargeView
