local FoodMaterialItem = class("FoodMaterialItem", ReduxView)

function FoodMaterialItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FoodMaterialItem:Init()
	self:InitUI()

	self.colorController = ControllerUtil.GetController(self.transform_, "numcolor1")
	self.shopController = ControllerUtil.GetController(self.transform_, "shopBtn")
end

function FoodMaterialItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function FoodMaterialItem:AddUIListener()
	self:AddBtnListener(self.shopBtn_, nil, function()
		if self.goodID then
			JumpTools.GoToSystem("/activityShop", {
				hideHomeBtn = 1,
				shopId = ShopConst.SHOP_ID.CANTEEN_SHOP,
				showShops = {
					ShopConst.SHOP_ID.CANTEEN_SHOP
				},
				goodId = self.goodID
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
end

function FoodMaterialItem:RefreshItem(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.id = arg_6_1[1]
	self.num = arg_6_1[2]
	self.textText_.text = ItemTools.getItemName(self.id)

	self.colorController:SetSelectedState("1")

	self.iconImg_.sprite = ItemTools.getItemSprite(self.id)

	if arg_6_2 then
		local var_6_0 = 0

		for iter_6_0, iter_6_1 in ipairs(BackHomeCanteenFoodCfg[arg_6_2].ingredient_list) do
			if iter_6_1[1] == self.id then
				var_6_0 = iter_6_1[2]
			end
		end

		self.num = var_6_0 * arg_6_3
	end

	self.costNumText_.text = NumberTools.RetractNumberForWindBar(self.num)

	if arg_6_4 == DormEnum.FoodSellType.SignFood then
		self.hadNumText_.text = ""
	end

	local var_6_2

	do
		local var_6_1 = CanteenFoodData:GetCateenIngredientNum(self.id)

		self.hadNumText_.text = NumberTools.RetractNumberForWindBar(var_6_1)

		if var_6_1 < self.num then
			self.colorController:SetSelectedState("2")
		end

		self.costNumText_.text = "/" .. NumberTools.RetractNumberForWindBar(self.num)
		var_6_2 = false
	end

	for iter_6_2, iter_6_3 in ipairs((getGoodListByGiveID(self.id))) do
		if ShopTools.IsGoodCanBuy(ShopConst.SHOP_ID.CANTEEN_SHOP, iter_6_3) then
			var_6_2 = true
			self.goodID = iter_6_3

			break
		end
	end

	if var_6_2 then
		self.shopController:SetSelectedState("true")
	else
		self.shopController:SetSelectedState("false")
	end
end

function FoodMaterialItem:RegistCallBack(arg_7_1)
	if arg_7_1 then
		self.btnCallBack = arg_7_1
	end
end

function FoodMaterialItem:Dispose()
	FoodMaterialItem.super.Dispose(self)
end

return FoodMaterialItem
