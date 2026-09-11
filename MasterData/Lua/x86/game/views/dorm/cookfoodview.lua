local CookFoodView = class("CookFoodView", ReduxView)

function CookFoodView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamDoTheDishesPop"
end

function CookFoodView:UIParent()
	return manager.ui.uiMain.transform
end

function CookFoodView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CookFoodView:InitUI()
	self:BindCfgUI()

	self.canCookFoodItemScroll = LuaList.New(handler(self, self.IndexCookFoodItem), self.fooduilistUilist_, CookFoodItem)
	self.cookMaterialItemScroll_ = LuaList.New(handler(self, self.IndexFoodMaterialItem), self.ingredientuilistUilist_, FoodMaterialItem)
	self.finishIngredientItemScroll_ = LuaList.New(handler(self, self.IndexFoodMaterialItem), self.finishingredientuilistUilist_, FoodMaterialItem)
	self.chooseTasteItemScroll = LuaList.New(handler(self, self.IndexTasteItem), self.tasteuilistUilist_, CookFoodItem)
	self.cookStateController_ = ControllerUtil.GetController(self.transform_, "cookState")
	self.cookFinishController_ = ControllerUtil.GetController(self.transform_, "finish")
	self.cookCompletedBgController_ = ControllerUtil.GetController(self.transform_, "completedBg")
	self.cookcompletedLvController_ = ControllerUtil.GetController(self.transform_, "completedLv")
	self.qteStartController_ = ControllerUtil.GetController(self.transform_, "qteStart")
	self.finishFoodController_ = ControllerUtil.GetController(self.finishfoodnameGo_, "name")
	self.tasteFoodController_ = ControllerUtil.GetController(self.tastenameGo_, "name")
	self.particleController = ControllerUtil.GetController(self.switchwokTrs_, "switchWok")
	self.foodId = nil
	self.taste = nil
end

local function var_0_1(arg_5_0)
	ShowMessageBox({
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = arg_5_0
	})
end

function CookFoodView:AddUIListener()
	self:AddBtnListenerScale(self.startbtnBtn_, nil, function()
		if self.foodId == nil then
			var_0_1(GetTips("CANTEEN_FOOD_UNCHOOSE"))

			return
		end

		if self.taste == nil then
			var_0_1(GetTips("CANTEEN_INGREDIENTS_UNCHOOSE"))

			return
		end

		self:StartCookFoodQTE()
	end)
	self:AddBtnListenerScale(self.confirmbtnBtn_, nil, function()
		JumpTools:Back()
	end)
end

function CookFoodView:ExitOnCanteenModeChange()
	self.cookFoodFlag = nil

	self:Back()
end

function CookFoodView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	self.kitchenwareEid = self.params_.cookEid
	self.playerEid = self.params_.playerEid
	self.cookType = CanteenAIFunction:GetEntityType(self.kitchenwareEid)

	self:UpdataFoodData()
	self.canCookFoodItemScroll:StartScroll(#self.canCookFoodList_)

	self.cookFoodFlag = false
	self.startFlag = false

	local var_10_0 = handler(self, self.ExitOnCanteenModeChange)

	self:RegistEventListener(DORM_RESTAURANT_START_AUTO, var_10_0)
	self:RegistEventListener(DORM_RESTAURANT_START_MANUAL, var_10_0)
	self.particleController:SetSelectedState("off")
end

function CookFoodView:OnTop()
	return
end

function CookFoodView:UpdataFoodData()
	self.canCookFoodList_ = {}

	for iter_12_0, iter_12_1 in ipairs((CanteenFoodData:GetChooseFoodList())) do
		if DormEnum.RestaurantKitchenWare[BackHomeCanteenFoodCfg[iter_12_1].cook_type] == self.cookType then
			table.insert(self.canCookFoodList_, {
				type = DormEnum.UniversalUIType.FoodName,
				id = iter_12_1
			})
		end
	end

	if #self.canCookFoodList_ == 0 then
		self.cookFinishController_:SetSelectedState("none")
	else
		self.cookFinishController_:SetSelectedState("making")
	end
end

function CookFoodView:IndexTasteItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(self.chooseFoodTasteList[arg_13_1], self.taste)
	arg_13_2:RegistCallBack(function(arg_14_0)
		if self.startFlag then
			return
		end

		if self.taste == arg_14_0 then
			return
		end

		self.taste = arg_14_0

		self.chooseTasteItemScroll:Refresh()
		self:CheckCookFoodPrecondition()
	end)
end

function CookFoodView:UpdataChooseFoodTaste(arg_15_1)
	self.chooseFoodTasteList = {}

	for iter_15_0, iter_15_1 in ipairs(BackHomeCanteenFoodCfg[arg_15_1].tag) do
		table.insert(self.chooseFoodTasteList, {
			type = DormEnum.UniversalUIType.TasteName,
			id = iter_15_1
		})
	end
end

function CookFoodView:UpdataChooseFoodMaterial(arg_16_1)
	self.chooseFoodMaterialList = BackHomeCanteenFoodCfg[arg_16_1].ingredient_list
end

function CookFoodView:IndexFoodMaterialItem(arg_17_1, arg_17_2)
	arg_17_2:RefreshItem(self.chooseFoodMaterialList[arg_17_1], nil, nil, DormEnum.FoodSellType.SignFood)
end

function CookFoodView:IndexCookFoodItem(arg_18_1, arg_18_2)
	arg_18_2:RefreshUI(self.canCookFoodList_[arg_18_1], self.foodId)
	arg_18_2:RegistCallBack(handler(self, self.RefreshFoodTasteAndMaterial))
end

function CookFoodView:RefreshFoodTasteAndMaterial(arg_19_1)
	if self.startFlag then
		return
	end

	if arg_19_1 == self.foodId then
		return
	end

	self.foodId = arg_19_1
	self.taste = nil

	self.canCookFoodItemScroll:Refresh()
	self:UpdataChooseFoodMaterial(arg_19_1)
	self.cookMaterialItemScroll_:StartScroll(#self.chooseFoodMaterialList)
	self:UpdataChooseFoodTaste(arg_19_1)
	self.chooseTasteItemScroll:StartScroll(#self.chooseFoodTasteList)
	self:InitProgressBar(arg_19_1)
end

function CookFoodView:CheckCookFoodPrecondition()
	if self.foodId ~= nil and CanteenFoodData:GetSignFoodCanCookNum(self.foodId) <= 0 then
		self.cookStateController_:SetSelectedState("lack")
	end
end

function CookFoodView:StartCookFoodQTE()
	self.qteStartController_:SetSelectedState("true")

	if self.timer == nil then
		self.timer = FrameTimer.New(function()
			self:UpdataCursor()
		end, 0.016666666666666666, -1)

		self.timer:Start()

		self.startFlag = true

		self.particleController:SetSelectedState("on")
		manager.windowBar:HideBar()
	else
		self.timer:Stop()

		self.timer = nil

		local var_21_0 = self:QTEResult()

		if var_21_0 == DormEnum.FoodQuality.low then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_bad", "")
		elseif var_21_0 == DormEnum.FoodQuality.normal then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_commonly", "")
		elseif var_21_0 == DormEnum.FoodQuality.high then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_perfect", "")
		end

		self.startFlag = false

		self.particleController:SetSelectedState("off")
		self:CookFinish(var_21_0)
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end
end

function CookFoodView:InitProgressBar(arg_23_1)
	local var_23_0 = CanteenFoodData:GetFoodProficiency(arg_23_1)

	self.progress1Angel = 0
	self.progress2Angel = 0

	for iter_23_0 = 1, #BackHomeCanteenFoodCfg[arg_23_1].cook_range do
		if var_23_0 < BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0][1] then
			self.progress1Angel = BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0 - 1][2]
			self.progress2Angel = BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0 - 1][3]

			break
		end

		self.progress1Angel = BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0][2]
		self.progress2Angel = BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0][3]
	end

	local var_23_1 = GameDisplayCfg.canteen_cook_range_speed.value[1]

	self.MaxEuler = GameDisplayCfg.canteen_cook_range.value[2]
	self.MinEuler = GameDisplayCfg.canteen_cook_range.value[1]

	self:RandomProgressBar()

	self.CursorTickEuler = var_23_1 / DormConst.COOK_CURSOR_FRAME
	self.turnNum = 1
	self.cursorTrs_.localEulerAngles = Vector3.New(0, 0, self.MaxEuler)
end

function CookFoodView:RandomProgressBar()
	self.progressbar1Img_.fillAmount = self.progress1Angel / 180 - self.progress1Angel / 180 % 0.01
	self.progressbar2Img_.fillAmount = self.progress2Angel / 180 - self.progress2Angel / 180 % 0.01

	local var_24_0 = math.floor((math.random(self.MinEuler + 90, self.MaxEuler + 90 - self.progress1Angel)))

	self.progressbar1Trs_.localEulerAngles = Vector3.New(0, 0, var_24_0)
	self.progressbar2Trs_.localEulerAngles = Vector3.New(0, 0, (math.floor((math.random(var_24_0, var_24_0 + self.progress1Angel - self.progress2Angel)))))
end

function CookFoodView:UpdataCursor()
	if self.turnNum % 2 == 1 then
		self.cursorTrs_.localEulerAngles = self.cursorTrs_.localEulerAngles - Vector3.New(0, 0, self.CursorTickEuler)

		if (self.cursorTrs_.localEulerAngles.z > 180 and self.cursorTrs_.localEulerAngles.z - 360 or self.cursorTrs_.localEulerAngles.z) <= self.MinEuler then
			self.turnNum = self.turnNum + 1
		end
	elseif self.turnNum % 2 == 0 then
		self.cursorTrs_.localEulerAngles = self.cursorTrs_.localEulerAngles + Vector3.New(0, 0, self.CursorTickEuler)

		if (self.cursorTrs_.localEulerAngles.z > 180 and self.cursorTrs_.localEulerAngles.z - 360 or self.cursorTrs_.localEulerAngles.z) >= self.MaxEuler then
			self.turnNum = self.turnNum + 1
		end
	end

	self.cursorTrs_.localEulerAngles.z = 0
end

function CookFoodView:QTEResult()
	local var_26_0 = 0

	if self:CheckCursorInProgress1() == false then
		var_26_0 = DormEnum.FoodQuality.low
	elseif self:CheckCursorInProgress1() == true and self:CheckCursorInProgress2() == false then
		var_26_0 = DormEnum.FoodQuality.normal
	elseif self:CheckCursorInProgress1() == true and self:CheckCursorInProgress2() == true then
		var_26_0 = DormEnum.FoodQuality.high
	end

	return var_26_0
end

function CookFoodView:CheckCursorInProgress1()
	local var_27_0 = self.cursorTrs_.localEulerAngles.z + 90

	if self.cursorTrs_.localEulerAngles.z + 90 > 360 then
		var_27_0 = var_27_0 - 360
	end

	if var_27_0 >= self.progress1Angel + self.progressbar1Trs_.localEulerAngles.z or var_27_0 <= self.progressbar1Trs_.localEulerAngles.z then
		return false
	end

	return true
end

function CookFoodView:CheckCursorInProgress2()
	local var_28_0 = self.cursorTrs_.localEulerAngles.z + 90

	if self.cursorTrs_.localEulerAngles.z + 90 > 360 then
		var_28_0 = var_28_0 - 360
	end

	if var_28_0 >= self.progress2Angel + self.progressbar2Trs_.localEulerAngles.z or var_28_0 <= self.progressbar2Trs_.localEulerAngles.z then
		return false
	end

	return true
end

function CookFoodView:CookFinish(arg_29_1)
	self.cookFinishController_:SetSelectedState("completed")
	self.cookCompletedBgController_:SetSelectedState("on")
	self.finishFoodController_:SetSelectedState("off")
	self.tasteFoodController_:SetSelectedState("off")

	self.finishfoodtextText_.text = GetI18NText(BackHomeCanteenFoodCfg[self.foodId].name)
	self.finishfoodtastetextText_.text = GetTips(CanteenConst.FoodTaste[self.taste][1])

	self.finishIngredientItemScroll_:StartScroll(#self.chooseFoodMaterialList)
	self.cookcompletedLvController_:SetSelectedState(arg_29_1)

	self.cookFoodFlag = true

	CanteenData:CookFoodComplete(self.playerEid, arg_29_1, self.kitchenwareEid, self.foodId, self.taste)
end

function CookFoodView:ResetView()
	self.cookStateController_:SetSelectedIndex(0)
	self.cookFinishController_:SetSelectedIndex(0)
	self.cookCompletedBgController_:SetSelectedIndex(0)
	self.cookcompletedLvController_:SetSelectedIndex(0)
	self.finishFoodController_:SetSelectedState("none")
	self.tasteFoodController_:SetSelectedState("none")

	self.cursorTrs_.localEulerAngles = Vector3.New(0, 0, self.MaxEuler)
	self.foodId = nil
	self.taste = nil
	self.chooseFoodMaterialList = {}
	self.chooseFoodTasteList = {}
	self.turnNum = 1

	self.chooseTasteItemScroll:StartScroll(#self.chooseFoodTasteList)
	self.cookMaterialItemScroll_:StartScroll(#self.chooseFoodMaterialList)
	self.qteStartController_:SetSelectedState("false")
end

function CookFoodView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if self.cookFoodFlag == false then
		CanteenData:CookFoodCanceled(self.playerEid, self.kitchenwareEid)
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:ResetView()
end

function CookFoodView:Dispose()
	if self.cookMaterialItemScroll_ then
		self.cookMaterialItemScroll_:Dispose()

		self.cookMaterialItemScroll_ = nil
	end

	if self.finishIngredientItemScroll_ then
		self.finishIngredientItemScroll_:Dispose()

		self.finishIngredientItemScroll_ = nil
	end

	if self.canCookFoodItemScroll then
		self.canCookFoodItemScroll:Dispose()

		self.canCookFoodItemScroll = nil
	end

	if self.chooseTasteItemScroll then
		self.chooseTasteItemScroll:Dispose()

		self.chooseTasteItemScroll = nil
	end

	CookFoodView.super.Dispose(self)
end

return CookFoodView
