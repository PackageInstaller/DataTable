local AccumulateDiscountModule = class("AccumulateDiscountModule", ReduxView)
local var_0_1 = {
	[0] = "CUMULATIVE_LOGIN_SALE_0",
	"CUMULATIVE_LOGIN_SALE_1",
	"CUMULATIVE_LOGIN_SALE_2",
	"CUMULATIVE_LOGIN_SALE_3",
	"CUMULATIVE_LOGIN_SALE_3",
	"CUMULATIVE_LOGIN_SALE_3"
}

function AccumulateDiscountModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AccumulateDiscountModule:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.isUse_ = true
end

function AccumulateDiscountModule:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		JumpTools.OpenPageByJump("accumulateSignView")
	end)
end

function AccumulateDiscountModule:SetData(arg_5_1, arg_5_2)
	self.type_ = arg_5_1
	self.num_ = 0
	self.lv_ = 0
	self.isUse_ = arg_5_2

	if self.type_ == 1 then
		self.num_, self.lv_ = AccumulateSignData:GetMonthCardNumAndLv()
	else
		self.num_, self.lv_ = AccumulateSignData:GetPassportNumAndLv()
	end

	self:RefreshText()
end

function AccumulateDiscountModule:RefreshOpen()
	return
end

function AccumulateDiscountModule:RefreshText()
	self.text_num.text = GetTips(var_0_1[self.lv_])
	self.text_title.text = GetTips("ACTIVITY_ACCUMULATIVE_CUR_DISCOUNT")
end

function AccumulateDiscountModule:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function AccumulateDiscountModule:OnExit()
	return
end

function AccumulateDiscountModule:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return AccumulateDiscountModule
