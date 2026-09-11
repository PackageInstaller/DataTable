local RestaurantFoodMenuView = class("RestaurantFoodMenuView", ReduxView)

function RestaurantFoodMenuView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamRecipePop"
end

function RestaurantFoodMenuView:UIParent()
	return manager.ui.uiMain.transform
end

function RestaurantFoodMenuView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
end

function RestaurantFoodMenuView:InitUI()
	self.itemScroll_ = LuaList.New(handler(self, self.indexItem), self.itemuilistGo_, FoodMenuItem)
	self.bagScroll_ = LuaList.New(handler(self, self.indexItem), self.baguilistUilist_, FoodMenuItem)
	self.tasteItemList_ = {}
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.infoController = ControllerUtil.GetController(self.transform_, "info")
	self.materialItemScroll_ = LuaList.New(handler(self, self.indexMaterialItem), self.materiallistUilist_, FoodMaterialItem)
	self.btnController = {
		[3] = ControllerUtil.GetController(self.fryingpanBtn_.transform, "name"),
		[4] = ControllerUtil.GetController(self.steamerBtn_.transform, "name"),
		[5] = ControllerUtil.GetController(self.grillBtn_.transform, "name"),
		[6] = ControllerUtil.GetController(self.potBtn_.transform, "name")
	}
	self.menuController = ControllerUtil.GetController(self.recipeGo_.transform, "toggle")
	self.bagController = ControllerUtil.GetController(self.bagGo_.transform, "toggle")
end

function RestaurantFoodMenuView:AddUIListener()
	self:AddBtnListener(self.recipeBtn_, nil, function()
		self.curChooseIndex = DormEnum.FurnitureTypeNum.Pan

		self:UpdataFoodMenuView()
	end)
	self:AddBtnListener(self.fryingpanBtn_, nil, function()
		self.curChooseIndex = DormEnum.FurnitureTypeNum.Pan

		self:UpdataFoodMenuView()
	end)
	self:AddBtnListener(self.grillBtn_, nil, function()
		self.curChooseIndex = DormEnum.FurnitureTypeNum.Oven

		self:UpdataFoodMenuView()
	end)
	self:AddBtnListener(self.steamerBtn_, nil, function()
		self.curChooseIndex = DormEnum.FurnitureTypeNum.Steamer

		self:UpdataFoodMenuView()
	end)
	self:AddBtnListener(self.potBtn_, nil, function()
		self.curChooseIndex = DormEnum.FurnitureTypeNum.Pot

		self:UpdataFoodMenuView()
	end)
	self:AddBtnListener(self.bagBtn_, nil, function()
		self:UpdataBagView()
	end)
	self:AddBtnListener(self.proiconBtn_, nil, function()
		JumpTools.OpenPageByJump("canteenProDesView")
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function RestaurantFoodMenuView:OnEnter()
	self.isEnter = true

	manager.windowBar:HideBar()

	self.menuType = self.params_.state

	if self.menuType == DormEnum.MenuType.foodMenu then
		self.curChooseIndex = self.curChooseIndex or DormEnum.FurnitureTypeNum.Pan

		self:UpdataFoodMenuView()
	elseif self.menuType == DormEnum.MenuType.bag then
		self:UpdataBagView()
	end

	self:RegisterEvent()
	self:BindFoodTypeRedPoint(self.fryingpanBtn_.transform, DormEnum.FurnitureTypeNum.Pan)
	self:BindFoodTypeRedPoint(self.grillBtn_.transform, DormEnum.FurnitureTypeNum.Oven)
	self:BindFoodTypeRedPoint(self.steamerBtn_.transform, DormEnum.FurnitureTypeNum.Steamer)
	self:BindFoodTypeRedPoint(self.potBtn_.transform, DormEnum.FurnitureTypeNum.Pot)

	self.isEnter = false
end

function RestaurantFoodMenuView:OnTop()
	return
end

function RestaurantFoodMenuView:RegisterEvent()
	self:RegistEventListener(CANTEEN_CLICK_MENU_ITEM, function(arg_17_0, arg_17_1)
		if arg_17_1 == DormEnum.MenuType.bag then
			self.bagScroll_:Refresh()
		else
			self.itemScroll_:Refresh()
		end

		self:RefreshInfoPage(arg_17_0)
	end)
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_18_0)
		if (arg_18_0 == 0 or arg_18_0 == ShopConst.SHOP_ID.CANTEEN_SHOP) and self.menuType == DormEnum.MenuType.foodMenu then
			self:UpdataFoodMenuView()
		end
	end)
end

function RestaurantFoodMenuView:UpdataBagView()
	self.menuType = DormEnum.MenuType.bag

	self.stateController:SetSelectedState("bag")
	self.menuController:SetSelectedState("off")
	self.bagController:SetSelectedState("on")
	self.infoController:SetSelectedState("off")

	for iter_19_0, iter_19_1 in pairs(self.btnController) do
		iter_19_1:SetSelectedState("off")
	end

	self:RefreshBag()
	self.bagScroll_:StartScroll(#self.itemList_)
	self:RefreshItemInfo(self.itemList_[1], DormEnum.MenuType.bag)
end

function RestaurantFoodMenuView:UpdataFoodMenuView()
	self.menuType = DormEnum.MenuType.foodMenu

	self:UpdateItemData(self.curChooseIndex)
	self.stateController:SetSelectedState("food")
	self.bagController:SetSelectedState("off")
	self.menuController:SetSelectedState("on")
	self.infoController:SetSelectedState("off")
	self.itemScroll_:StartScroll(#self.itemList_)

	for iter_20_0, iter_20_1 in pairs(self.btnController) do
		if iter_20_0 == self.curChooseIndex then
			iter_20_1:SetSelectedState("on")
		else
			iter_20_1:SetSelectedState("off")
		end
	end

	self:RefreshItemInfo(self.selItem and BackHomeCanteenFoodCfg[self.selItem] and BackHomeCanteenFoodCfg[self.selItem].cook_type == self.curChooseIndex and self.selItem or self.itemList_[1], DormEnum.MenuType.foodMenu)
end

function RestaurantFoodMenuView:indexItem(arg_21_1, arg_21_2)
	arg_21_2:RefreshItem(self.itemList_[arg_21_1], self.menuType, self.selItem)

	if self.menuType == DormEnum.MenuType.foodMenu then
		self.bindPointFlag = true

		self:BindRedPoint(arg_21_1, arg_21_2)
	end

	arg_21_2:RegisterClickCallBack(function(arg_22_0, arg_22_1)
		if self.selItem == arg_22_0 and not self.isEnter then
			return
		end

		self.selItem = arg_22_0

		self:RefreshItemInfo(arg_22_0, arg_22_1)

		if arg_22_1 == DormEnum.MenuType.foodMenu then
			DormRedPointTools:ConsumeNotification(string.format("%s_%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, tostring(BackHomeCanteenFoodCfg[arg_22_0].cook_type), arg_22_0), DormRedPointTools.RedPointType.LocalMachine)
		end
	end)
end

function RestaurantFoodMenuView:BindFoodTypeRedPoint(arg_23_1, arg_23_2)
	manager.redPoint:bindUIandKey(arg_23_1, string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, arg_23_2))
end

function RestaurantFoodMenuView:UnBindFoodTypeRedPoint(arg_24_1, arg_24_2)
	manager.redPoint:unbindUIandKey(arg_24_1, string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, arg_24_2))
end

function RestaurantFoodMenuView:BindRedPoint(arg_25_1, arg_25_2)
	if manager.redPoint:getTipBoolean((string.format("%s_%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, tostring(BackHomeCanteenFoodCfg[self.itemList_[arg_25_1]].cook_type), self.itemList_[arg_25_1]))) then
		manager.redPoint:SetRedPointIndependent(arg_25_2.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_25_2.transform_, false)
	end
end

function RestaurantFoodMenuView:RefreshItemInfo(arg_26_1, arg_26_2)
	if arg_26_1 then
		self.selItem = arg_26_1

		if arg_26_2 == DormEnum.MenuType.bag then
			self.bagScroll_:Refresh()
		else
			self.itemScroll_:Refresh()
		end

		self:RefreshInfoPage(arg_26_1)
	end
end

function RestaurantFoodMenuView:indexMaterialItem(arg_27_1, arg_27_2)
	arg_27_2:RefreshItem(self.materialItemList_[arg_27_1])
end

function RestaurantFoodMenuView:RefreshBag()
	self.itemList_ = {}

	for iter_28_0, iter_28_1 in pairs(CanteenFoodData:GetCateenIngredient()) do
		table.insert(self.itemList_, iter_28_0)
	end
end

function RestaurantFoodMenuView:RefreshInfoPage(arg_29_1)
	if self.menuType == DormEnum.MenuType.foodMenu then
		self.infoController:SetSelectedState("food")

		self.tasteDataList_ = BackHomeCanteenFoodCfg[arg_29_1].tag
		self.foodnameText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_29_1].name)
		self.earningnumText_.text = CanteenFoodData:GetFoodUnitCost(arg_29_1)
		self.fooddescribeText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_29_1].desc)

		self:UpdataMaterialItemData(arg_29_1)
		self.materialItemScroll_:StartScroll(#self.materialItemList_)

		self.foodiconImg_.sprite = pureGetSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[arg_29_1].icon)
		self.progressnumText_.text = CanteenFoodData:GetFoodProficiency(arg_29_1)

		self:UpdataTasteData(arg_29_1)
	elseif self.menuType == DormEnum.MenuType.bag then
		self.infoController:SetSelectedState("ingredient")

		self.ingnameText_.text = ItemTools.getItemName(arg_29_1)
		self.ingdestextText_.text = ItemTools.getItemDesc(arg_29_1)
		self.ingnumText_.text = string.format("x%s", NumberTools.RetractNumberForWindBar(CanteenFoodData:GetCateenIngredient()[arg_29_1]))
		self.foodicon2Img_.sprite = ItemTools.getItemSprite(arg_29_1)
	end
end

function RestaurantFoodMenuView:UpdataTasteData(arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(self.tasteDataList_) do
		self.tasteItemList_[iter_30_0] = self.tasteItemList_[iter_30_0] or CanteenFoodTasteitem.New((Object.Instantiate(self.tasteItemGo_, self.tasteContentTrans_)))

		self.tasteItemList_[iter_30_0]:SetActive(true)
		self.tasteItemList_[iter_30_0]:RefreshUI(iter_30_1)
	end

	for iter_30_2 = #self.tasteDataList_ + 1, #self.tasteItemList_ do
		self.tasteItemList_[iter_30_2]:SetActive(false)
	end
end

function RestaurantFoodMenuView:UpdateItemData(arg_31_1)
	self.itemList_ = {}

	local var_31_0 = 0

	for iter_31_0, iter_31_1 in ipairs(BackHomeCanteenFoodCfg.all) do
		if BackHomeCanteenFoodCfg[iter_31_1].cook_type == arg_31_1 then
			if CanteenTools:CheckFoodUnLock(iter_31_1) then
				var_31_0 = var_31_0 + 1
			end

			table.insert(self.itemList_, iter_31_1)
		end
	end

	CommonTools.UniversalSortEx(self.itemList_, {
		ascend = true,
		map = function(arg_32_0)
			if CanteenTools:CheckFoodUnLock(arg_32_0) then
				return 1
			else
				return 2
			end
		end
	}, {
		ascend = true,
		map = function(arg_33_0)
			return (CanteenTools:GetFoodUnLockLevel(arg_33_0))
		end
	}, {
		ascend = true,
		map = function(arg_34_0)
			return arg_34_0
		end
	})

	self.curnumText_.text = var_31_0
	self.totlanumText_.text = "/" .. #self.itemList_
	self.cooktitleText_.text = GetI18NText(CanteenTools:GetCookCfgName(arg_31_1))

	for iter_31_2, iter_31_3 in pairs(self.btnController) do
		if iter_31_2 == arg_31_1 then
			iter_31_3:SetSelectedState("on")
		else
			iter_31_3:SetSelectedState("off")
		end
	end
end

function RestaurantFoodMenuView:UpdataMaterialItemData(arg_35_1)
	self.materialItemList_ = {}

	for iter_35_0, iter_35_1 in ipairs(BackHomeCanteenFoodCfg[arg_35_1].ingredient_list) do
		table.insert(self.materialItemList_, iter_35_1)
	end
end

function RestaurantFoodMenuView:OnExit()
	self.params_.state = self.menuType
	self.bindPointFlag = nil

	self:RemoveAllEventListener()
	self:UnBindFoodTypeRedPoint(self.fryingpanBtn_.transform, DormEnum.FurnitureTypeNum.Pan)
	self:UnBindFoodTypeRedPoint(self.grillBtn_.transform, DormEnum.FurnitureTypeNum.Oven)
	self:UnBindFoodTypeRedPoint(self.steamerBtn_.transform, DormEnum.FurnitureTypeNum.Steamer)
	self:UnBindFoodTypeRedPoint(self.potBtn_.transform, DormEnum.FurnitureTypeNum.Pot)
end

function RestaurantFoodMenuView:Dispose()
	if self.materialItemScroll_ then
		self.materialItemScroll_:Dispose()
	end

	if self.itemScroll_ then
		self.itemScroll_:Dispose()
	end

	if self.bagScroll_ then
		self.bagScroll_:Dispose()
	end

	for iter_37_0, iter_37_1 in ipairs(self.tasteItemList_) do
		iter_37_1:Dispose()
	end

	RestaurantFoodMenuView.super.Dispose(self)
end

return RestaurantFoodMenuView
