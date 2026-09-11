local PopSetFoodView = class("PopSetFoodView", ReduxView)

function PopSetFoodView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamShelvesToDeterminePop"
end

function PopSetFoodView:UIParent()
	return manager.ui.uiPop.transform
end

function PopSetFoodView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PopSetFoodView:InitUI()
	self:BindCfgUI()

	self.cookMaterialItemScroll_ = LuaList.New(handler(self, self.indexFoodMaterialItem), self.uilistUilist_, FoodMaterialItem)
end

function PopSetFoodView:AddUIListener()
	self:AddBtnListener(self.confirmbtnBtn_, nil, function()
		DormData:ReviseSignFood(self.foodID, true)
		JumpTools.Back()
	end)
	self:AddBtnListener(self.canclebtnBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function PopSetFoodView:OnEnter()
	self.foodID = self.params_.foodID
	self.titletextText_.text = string.format(GetTips("CANTEEN_FOOD_ADD"), BackHomeCanteenFoodCfg[self.foodID].name)

	self:UpdateFoodMaterialData(self.foodID)
	self.cookMaterialItemScroll_:StartScroll(#self.itemList_)
end

function PopSetFoodView:indexFoodMaterialItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshItem(self.itemList_[arg_10_1])
end

function PopSetFoodView:UpdateFoodMaterialData(arg_11_1)
	self.itemList_ = {}

	for iter_11_0, iter_11_1 in pairs(BackHomeCanteenFoodCfg[arg_11_1].ingredient_list) do
		table.insert(self.itemList_, iter_11_1)
	end
end

function PopSetFoodView:Dispose()
	if self.cookMaterialItemScroll_ then
		self.cookMaterialItemScroll_:Dispose()
	end

	PopSetFoodView.super.Dispose(self)
end

return PopSetFoodView
