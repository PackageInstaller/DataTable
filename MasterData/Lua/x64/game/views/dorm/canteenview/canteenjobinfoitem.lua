local CanteenJobInfoItem = class("CanteenJobInfoItem", ReduxView)

function CanteenJobInfoItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = not isNil(arg_1_2) and Object.Instantiate(arg_1_1, arg_1_2) or arg_1_1

	SetActive(self.gameObject_, true)

	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function CanteenJobInfoItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "name")
	self.jobController = ControllerUtil.GetController(self.gameObject_.transform, "job")
	self.heroItem = CanteenHeroItem.New(self.heroitemGo_1)

	self.heroItem:SetFunction(true)
end

function CanteenJobInfoItem:RefreshUI(arg_3_1)
	self.jobText.text = CanteenTools:GetJobName(arg_3_1)

	if arg_3_1 == DormNpcTools.BackHomeNpcType.cook then
		self.jobController:SetSelectedState("cook")
	elseif arg_3_1 == DormNpcTools.BackHomeNpcType.waiter then
		self.jobController:SetSelectedState("waiter")
	elseif arg_3_1 == DormNpcTools.BackHomeNpcType.cashier then
		self.jobController:SetSelectedState("cashier")
	end

	local var_3_0 = CanteenHeroTools:GetCanteenJobList()[arg_3_1]

	if var_3_0 then
		if var_3_0.heroID then
			self.stateController:SetSelectedState("normal")
			self.heroItem:RefreshUI(var_3_0.heroID)
		else
			self.stateController:SetSelectedState("empty")
		end
	end
end

function CanteenJobInfoItem:Dispose()
	self.heroItem:Dispose()
	CanteenJobInfoItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CanteenJobInfoItem
