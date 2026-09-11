local RegressionGiftPopView = class("RegressionGiftPopView", ReduxView)

function RegressionGiftPopView:UIName()
	return "Widget/System/ReturnThree/RT3rd_GiftPopUI"
end

function RegressionGiftPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RegressionGiftPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionGiftPopView:InitUI()
	self:BindCfgUI()
end

function RegressionGiftPopView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		self:Back()
		RegressionActionNew.ClosePopView()
		RegressionActionNew.CheckRegressionStory()
	end)
end

function RegressionGiftPopView:OnEnter()
	self:RefreshUI()
end

function RegressionGiftPopView:RefreshUI()
	local var_8_0 = RegressionDataNew:GetLastOfflineTime()

	self.letterText_.text = string.format(GetTips("REGRESSION_GIFT_DESCRIPE"), manager.time:STimeDescS(RegressionDataNew:GetRegressionLoginTime() - var_8_0 * 86400, "!%Y/%m/%d"), var_8_0)
	self.timeText_.text = var_8_0
	self.timedescText_.text = string.format(GetTips("NEW_REGRESSION_FIND_DAYS_DESC"), var_8_0)
end

function RegressionGiftPopView:OnExit()
	manager.windowBar:HideBar()
end

function RegressionGiftPopView:Dispose()
	RegressionGiftPopView.super.Dispose(self)
end

return RegressionGiftPopView
