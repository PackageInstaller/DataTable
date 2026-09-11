local FoodMenuItem = class("FoodMenuItem", ReduxView)

function FoodMenuItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.statusController = ControllerUtil.GetController(self.transform_, "state")
	self.selectedController = ControllerUtil.GetController(self.transform_, "select")

	self:AddUIListener()
end

function FoodMenuItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.ID, self.type)
		end
	end)
end

function FoodMenuItem:RefreshItem(arg_4_1, arg_4_2, arg_4_3)
	self.ID = arg_4_1
	self.type = arg_4_2

	if self.selectedController then
		if self.ID == arg_4_3 then
			self.selectedController:SetSelectedState("on")
		else
			self.selectedController:SetSelectedState("off")
		end
	end

	if arg_4_2 == DormEnum.MenuType.foodMenu then
		if not CanteenTools:CheckFoodUnLock(arg_4_1) then
			self.statusController:SetSelectedState("on")

			self.locktextText_.text = BackHomeTools:GetBackHomeConditionDes(BackHomeCanteenFoodCfg[arg_4_1].unlock)
		else
			self.statusController:SetSelectedState("off")

			self.nameText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_4_1].name)
			self.iconimageImg_.sprite = pureGetSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[arg_4_1].icon)
		end
	elseif arg_4_2 == DormEnum.MenuType.bag then
		self.nameText_.text = ItemTools.getItemName(arg_4_1)
		self.numText_.text = NumberTools.RetractNumberForWindBar(CanteenFoodData:GetCateenIngredient()[arg_4_1])
		self.foodiconImg_.sprite = ItemTools.getItemSprite(arg_4_1)
	end
end

function FoodMenuItem:RegisterClickCallBack(arg_5_1)
	if arg_5_1 ~= nil then
		self.clickFunc = arg_5_1
	end
end

return FoodMenuItem
