local ActivityNewbieRebateView = class("ActivityNewbieRebateView", ReduxView)

function ActivityNewbieRebateView:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/Activity/NewbieRechargeReturnUI"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityNewbieRebateView:OnEnter()
	self:UpdateBar()
	self:RefreshUI()
end

function ActivityNewbieRebateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityNewbieRebateView:InitUI()
	self:BindCfgUI()
	self:RefreshUI()
end

function ActivityNewbieRebateView:AddUIListener()
	self:AddBtnListener(self.toRechargeBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 2,
			page = 3
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function ActivityNewbieRebateView:RefreshUI()
	self.totalRechargeNum_ = RechargeData:GetTotalRechargeNum()
	self.rebateAmount_ = self:calculate()

	if self.totalRechargeNumText_ ~= nil then
		self.totalRechargeNumText_.text = self.totalRechargeNum_
	end

	if self.rebateAmountText_ ~= nil then
		self.rebateAmountText_.text = self.rebateAmount_
	end
end

function ActivityNewbieRebateView:calculate()
	local var_8_0 = self.totalRechargeNum_
	local var_8_1 = 0

	if self.totalRechargeNum_ > 3000 then
		var_8_1 = var_8_1 + (var_8_0 - 3000) * 1.25
		var_8_0 = 3000
	end

	if var_8_0 > 1000 then
		var_8_1 = var_8_1 + (var_8_0 - 1000) * 1.75
		var_8_0 = 1000
	end

	if var_8_0 > 100 then
		var_8_1 = var_8_1 + (var_8_0 - 100) * 3
		var_8_0 = 100
	end

	if var_8_0 > 6 then
		var_8_1 = var_8_1 + (var_8_0 - 6) * 5
		var_8_0 = 6
	end

	if var_8_0 > 0 then
		var_8_1 = var_8_1 + var_8_0 * 10
	end

	return var_8_1 * 10
end

function ActivityNewbieRebateView:Show(arg_9_1)
	if arg_9_1 == false then
		self:OnExit()
	end

	SetActive(self.gameObject_, arg_9_1)
end

function ActivityNewbieRebateView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "activityNewbieRebateIllustrate",
		type = "jump",
		params = {}
	})
end

function ActivityNewbieRebateView:Dispose()
	ActivityNewbieRebateView.super.Dispose(self)
end

return ActivityNewbieRebateView
