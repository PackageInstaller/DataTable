local CanteenLackFoodIngredientsView = class("CanteenLackFoodIngredientsView", ReduxView)

function CanteenLackFoodIngredientsView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamLackMaterialPop"
end

function CanteenLackFoodIngredientsView:UIParent()
	return manager.ui.uiPop.transform
end

function CanteenLackFoodIngredientsView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CanteenLackFoodIngredientsView:OnEnter()
	self.foodID = self.params_.foodID
	self.ingredientsList = BackHomeCanteenFoodCfg[self.foodID].ingredient_list

	self.ingredientsListScroll_:StartScroll(#self.ingredientsList)

	self.titletextText_.text = BackHomeCanteenFoodCfg[self.foodID].name .. GetTips("ERROR_ITEM_NO_ENOUGH_MATERIAL")
end

function CanteenLackFoodIngredientsView:InitUI()
	self:BindCfgUI()

	self.ingredientsListScroll_ = LuaList.New(handler(self, self.indexIngredientsItem), self.ingredientslistUilist_, FoodMaterialItem)
end

function CanteenLackFoodIngredientsView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function CanteenLackFoodIngredientsView:indexIngredientsItem(arg_8_1, arg_8_2)
	arg_8_2:RefreshItem(self.ingredientsList[arg_8_1])
end

function CanteenLackFoodIngredientsView:Dispose()
	if self.ingredientsListScroll_ then
		self.ingredientsListScroll_:Dispose()

		self.ingredientsListScroll_ = nil
	end

	CanteenLackFoodIngredientsView.super.Dispose(self)
end

return CanteenLackFoodIngredientsView
