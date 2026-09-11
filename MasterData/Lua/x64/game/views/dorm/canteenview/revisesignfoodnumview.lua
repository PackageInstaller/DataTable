local ReviseSignFoodNumView = class("ReviseSignFoodNumView", ReduxView)

function ReviseSignFoodNumView:UIName()
	return "Widget/BackHouseUI/Dining/ShelfPresetUI"
end

function ReviseSignFoodNumView:UIParent()
	return manager.ui.uiMain.transform
end

function ReviseSignFoodNumView:OnCtor()
	return
end

function ReviseSignFoodNumView:Init()
	self:InitUI()
	self:AddUIListener()

	self.sceneID = DormConst.CANTEEN_ID
	self.foodMaterialScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FoodMaterialItem)
end

function ReviseSignFoodNumView:InitUI()
	self:BindCfgUI()
end

function ReviseSignFoodNumView:OnEnter()
	self.foodID = self.params_.foodID
	self.sellNum = self.sellNum or 0

	manager.windowBar:HideBar()
	self:SetfurNum(self.sellNum)

	self.progressSlr_.maxValue = CanteenFoodData:CalculateFoodCanCookNum(self.foodID)
	self.furNumMax = CanteenFoodData:CalculateFoodCanCookNum(self.foodID)

	self:RegisterEvent()
	self:RefreshView()
end

function ReviseSignFoodNumView:RegisterEvent()
	self:RegistEventListener(CANTEEN_SET_SIGNFOOD_SUCCESS, function()
		ShowTips(GetTips("DORM_FOOD_SET_SUCCESS"))
		self:SetfurNum(0)
		JumpTools:Back()
	end)
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_9_0)
		if arg_9_0 == 0 or arg_9_0 == ShopConst.SHOP_ID.CANTEEN_SHOP then
			self.foodMaterialScroll:Refresh()
		end
	end)
end

function ReviseSignFoodNumView:OnExit()
	self:RemoveAllEventListener()
end

function ReviseSignFoodNumView:AddUIListener()
	self:AddBtnListenerScale(self.signBtn_, nil, function()
		if self.sellNum <= 0 then
			ShowTips(GetTips("DORM_FOOD_SET_NULL"))

			return
		end

		CanteenAction:SendSignFoodInfo(self.foodID, self.sellNum)
	end)
	self:AddToggleListener(self.progressSlr_, function()
		if self.foodID then
			self:SetfurNum(self.progressSlr_.value)
		end
	end)
	self:AddPressingByTimeListener(self.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if self.foodID and self.sellNum > 0 then
			self:SetfurNum(self.progressSlr_.value - 1)

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if self.foodID and self.sellNum < self.furNumMax then
			self:SetfurNum(self.progressSlr_.value + 1)

			return true
		end

		return false
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self.sellNum = 0

		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.takeOffBtn_, nil, function()
		self.sellNum = 0

		JumpTools.Back()
	end)
end

function ReviseSignFoodNumView:SetfurNum(arg_18_1)
	self.sellNum = arg_18_1
	self.numText_.text = arg_18_1
	self.progressSlr_.value = arg_18_1

	self:RefreshSellNumAndIncome()
	self:RefreshBtnState()
end

function ReviseSignFoodNumView:RefreshBtnState()
	self.reduceNumBtn_.interactable = self.sellNum > 0
	self.addNumBtn_.interactable = self.sellNum < self.progressSlr_.maxValue
end

function ReviseSignFoodNumView:indexItem(arg_20_1, arg_20_2)
	arg_20_2:RefreshItem(self.foodMaterialList[arg_20_1], self.foodID, self.sellNum)
end

function ReviseSignFoodNumView:RefreshView()
	self:RefreshFoodInfo()
	self:RefreshFoodMaterialList()
	self:RefreshSellNumAndIncome()
end

function ReviseSignFoodNumView:RefreshFoodMaterialList()
	self.foodMaterialList = BackHomeCanteenFoodCfg[self.foodID].ingredient_list

	if self.foodMaterialList then
		self.foodMaterialScroll:StartScroll(#self.foodMaterialList)
	end
end

function ReviseSignFoodNumView:RefreshSellNumAndIncome()
	self.sellNumTex_.text = self.sellNum
	self.incomeNumTex_.text = math.floor(CanteenFoodData:GetFoodUnitCost(self.foodID) * self.sellNum)
	self.costTimeTex.text = DormTools:SecondSwitchTime(math.ceil(BackHomeCanteenFoodCfg[self.foodID].cost_time * self.sellNum * ((100 - DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostQucik, nil, nil, BackHomeCanteenFoodCfg[self.foodID].cook_type)) / 100)))

	self.foodMaterialScroll:Refresh()
end

function ReviseSignFoodNumView:RefreshFoodInfo()
	self.iconImg_.sprite = CanteenTools.GetFoodSprite(self.foodID)
	self.foodName.text = GetI18NText(BackHomeCanteenFoodCfg[self.foodID].name)
	self.descText_.text = GetI18NText(BackHomeCanteenFoodCfg[self.foodID].desc)
end

function ReviseSignFoodNumView:Dispose()
	if self.foodMaterialScroll then
		self.foodMaterialScroll:Dispose()
	end

	ReviseSignFoodNumView.super.Dispose(self)
end

return ReviseSignFoodNumView
