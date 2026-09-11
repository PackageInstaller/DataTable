local CanteenManualRewardView = class("CanteenManualRewardView", ReduxView)

function CanteenManualRewardView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamManualModeEndPop"
end

function CanteenManualRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function CanteenManualRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CanteenManualRewardView:InitUI()
	self:BindCfgUI()

	self.materialItemScroll_ = LuaList.New(handler(self, self.refreshItem), self.listUilist_, FoodMaterialItem)
end

function CanteenManualRewardView:AddUIListener()
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		CanteenManualData:ExitManualState()
		JumpTools.OpenPageByJump("/restaurantMain")
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		CanteenManualData:ExitManualState()
		JumpTools.OpenPageByJump("/restaurantMain")
	end)
end

function CanteenManualRewardView:refreshItem(arg_8_1, arg_8_2)
	arg_8_2:RefreshItem(self.materialList[arg_8_1], nil, nil, DormEnum.FoodSellType.SignFood)
end

function CanteenManualRewardView:OnEnter()
	self:RefreshUI()
end

function CanteenManualRewardView:RefreshUI()
	local var_10_0 = CanteenManualData:GetManualInfo()
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(var_10_0.manualSettlementList) do
		var_10_1 = var_10_1 + 1
	end

	self.foodnumText_.text = var_10_1
	self.totalcustomernumText_.text = var_10_0.manualGenCusNum
	self.servercustomernumText_.text = var_10_0.manualSerCusNum
	self.rewardnumText_.text = var_10_0.manualTotalIncome
	self.maxpopnumText_.text = var_10_0.hightPopularityNum
	self.addpopnumText_.text = CanteenManualData:CalculateRemainPopularity()

	local var_10_4, var_10_5 = CanteenManualData:MostPopFoodIdAndNum()

	self.foodnameText_.text = GetI18NText(var_10_4)

	if var_10_5 > 0 then
		self.foodpopnumText_.text = string.format(GetTips("CANTEEN_SELL_INFO"), var_10_5)
	end

	self.materialList = CanteenManualData:ManualConsumeMaterial()

	self.materialItemScroll_:StartScroll(#self.materialList)
end

function CanteenManualRewardView:Dispose()
	if self.materialItemScroll_ then
		self.materialItemScroll_:Dispose()

		self.materialItemScroll_ = nil
	end

	CanteenManualRewardView.super.Dispose(self)
end

return CanteenManualRewardView
