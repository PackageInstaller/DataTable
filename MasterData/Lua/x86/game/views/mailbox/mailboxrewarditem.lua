local MailBoxRewardItem = class("MailBoxRewardItem", ReduxView)

function MailBoxRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MailBoxRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MailBoxRewardItem:InitUI()
	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.commonItemGo_)
end

function MailBoxRewardItem:AddUIListener()
	return
end

function MailBoxRewardItem:SetRewardData(arg_5_1, arg_5_2)
	self.rewardData_ = arg_5_1
	self.haveGet_ = arg_5_2

	self:UpdateView()
end

function MailBoxRewardItem:UpdateView()
	local var_6_0 = formatReward(self.rewardData_)
	local var_6_1 = clone(ItemTemplateData)

	var_6_1.id = var_6_0.id
	var_6_1.number = var_6_0.num or var_6_0.number
	var_6_1.timeValid = var_6_0.timeValid or 0
	var_6_1.completedFlag = self.haveGet_
	var_6_1.clickFun = handler(self, self.OnClickCommonItem)

	self.commonItem_:SetData(var_6_1)
end

function MailBoxRewardItem:OnEnter()
	return
end

function MailBoxRewardItem:OnExit()
	return
end

function MailBoxRewardItem:OnClickCommonItem(arg_9_1)
	ShowPopItem(POP_ITEM, {
		arg_9_1.id,
		arg_9_1.number
	})
	OperationRecorder.Record("MailBoxRewardItem", "popItem")
end

function MailBoxRewardItem:Dispose()
	self:RemoveAllListeners()

	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	MailBoxRewardItem.super.Dispose(self)
end

return MailBoxRewardItem
