local OathConditionContent = class("OathConditionContent", ReduxView)

function OathConditionContent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.conditionItemList = {}
end

function OathConditionContent:AddListeners()
	return
end

function OathConditionContent:Show(arg_3_1)
	self.gameObject_:SetActive(arg_3_1)
end

function OathConditionContent:RefreshUI(arg_4_1)
	self.data = arg_4_1

	self:Show(true)
	self:RefreshConditionUI()
	self:OpenTimer()
end

function OathConditionContent:RefreshConditionUI()
	local var_5_0 = OathToLuaBridge:GetOathHeroID()

	for iter_5_0 = 1, #WeddingCfg[var_5_0].condition do
		self.conditionItemList[iter_5_0] = self.conditionItemList[iter_5_0] or OathConditionItem.New(Object.Instantiate(self.conditionItemGo_, self.contentTrs_))

		self.conditionItemList[iter_5_0]:SetData(WeddingCfg[var_5_0].condition[iter_5_0], WeddingCfg[var_5_0].jump[iter_5_0], var_5_0)
		SetActive(self.conditionItemList[iter_5_0].gameObject_, true)
	end

	for iter_5_1 = #WeddingCfg[var_5_0].condition + 1, #self.conditionItemList do
		SetActive(self.conditionItemList[iter_5_1].gameObject_, false)
	end
end

function OathConditionContent:DeleteCountDownTimer()
	if self.countDownTimer_ then
		self.countDownTimer_:Stop()

		self.countDownTimer_ = nil
	end
end

function OathConditionContent:OpenTimer()
	self:DeleteCountDownTimer()
end

function OathConditionContent:OnExit()
	self:DeleteCountDownTimer()

	if self.data then
		self.data.finishCallBack = nil
	end

	self.data = nil
end

function OathConditionContent:Dispose()
	self:DeleteCountDownTimer()

	for iter_9_0, iter_9_1 in pairs(self.conditionItemList) do
		iter_9_1:Dispose()
	end

	OathConditionContent.super.Dispose(self)
end

return OathConditionContent
