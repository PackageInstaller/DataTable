local var_0_0 = class("CookFoodView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamDoTheDishesPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.canCookFoodItemScroll = LuaList.New(handler(arg_4_0, arg_4_0.IndexCookFoodItem), arg_4_0.fooduilistUilist_, CookFoodItem)
	arg_4_0.cookMaterialItemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexFoodMaterialItem), arg_4_0.ingredientuilistUilist_, FoodMaterialItem)
	arg_4_0.finishIngredientItemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexFoodMaterialItem), arg_4_0.finishingredientuilistUilist_, FoodMaterialItem)
	arg_4_0.chooseTasteItemScroll = LuaList.New(handler(arg_4_0, arg_4_0.IndexTasteItem), arg_4_0.tasteuilistUilist_, CookFoodItem)
	arg_4_0.cookStateController_ = ControllerUtil.GetController(arg_4_0.transform_, "cookState")
	arg_4_0.cookFinishController_ = ControllerUtil.GetController(arg_4_0.transform_, "finish")
	arg_4_0.cookCompletedBgController_ = ControllerUtil.GetController(arg_4_0.transform_, "completedBg")
	arg_4_0.cookcompletedLvController_ = ControllerUtil.GetController(arg_4_0.transform_, "completedLv")
	arg_4_0.qteStartController_ = ControllerUtil.GetController(arg_4_0.transform_, "qteStart")
	arg_4_0.finishFoodController_ = ControllerUtil.GetController(arg_4_0.finishfoodnameGo_, "name")
	arg_4_0.tasteFoodController_ = ControllerUtil.GetController(arg_4_0.tastenameGo_, "name")
	arg_4_0.particleController = ControllerUtil.GetController(arg_4_0.switchwokTrs_, "switchWok")
	arg_4_0.foodId = nil
	arg_4_0.taste = nil
end

local function var_0_1(arg_5_0)
	ShowMessageBox({
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = arg_5_0
	})
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListenerScale(arg_6_0.startbtnBtn_, nil, function()
		if arg_6_0.foodId == nil then
			var_0_1(GetTips("CANTEEN_FOOD_UNCHOOSE"))

			return
		end

		if arg_6_0.taste == nil then
			var_0_1(GetTips("CANTEEN_INGREDIENTS_UNCHOOSE"))

			return
		end

		arg_6_0:StartCookFoodQTE()
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.confirmbtnBtn_, nil, function()
		JumpTools:Back()
	end)
end

function var_0_0.ExitOnCanteenModeChange(arg_9_0)
	arg_9_0.cookFoodFlag = nil

	arg_9_0:Back()
end

function var_0_0.OnEnter(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	arg_10_0.kitchenwareEid = arg_10_0.params_.cookEid
	arg_10_0.playerEid = arg_10_0.params_.playerEid
	arg_10_0.cookType = CanteenAIFunction:GetEntityType(arg_10_0.kitchenwareEid)

	arg_10_0:UpdataFoodData()
	arg_10_0.canCookFoodItemScroll:StartScroll(#arg_10_0.canCookFoodList_)

	arg_10_0.cookFoodFlag = false
	arg_10_0.startFlag = false

	local var_10_0 = handler(arg_10_0, arg_10_0.ExitOnCanteenModeChange)

	arg_10_0:RegistEventListener(DORM_RESTAURANT_START_AUTO, var_10_0)
	arg_10_0:RegistEventListener(DORM_RESTAURANT_START_MANUAL, var_10_0)
	arg_10_0.particleController:SetSelectedState("off")
end

function var_0_0.OnTop(arg_11_0)
	return
end

function var_0_0.UpdataFoodData(arg_12_0)
	arg_12_0.canCookFoodList_ = {}

	local var_12_0 = CanteenFoodData:GetChooseFoodList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = BackHomeCanteenFoodCfg[iter_12_1].cook_type

		if DormEnum.RestaurantKitchenWare[var_12_1] == arg_12_0.cookType then
			local var_12_2 = {
				type = DormEnum.UniversalUIType.FoodName,
				id = iter_12_1
			}

			table.insert(arg_12_0.canCookFoodList_, var_12_2)
		end
	end

	if #arg_12_0.canCookFoodList_ == 0 then
		arg_12_0.cookFinishController_:SetSelectedState("none")
	else
		arg_12_0.cookFinishController_:SetSelectedState("making")
	end
end

function var_0_0.IndexTasteItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_0.chooseFoodTasteList[arg_13_1], arg_13_0.taste)
	arg_13_2:RegistCallBack(function(arg_14_0)
		if arg_13_0.startFlag then
			return
		end

		if arg_13_0.taste == arg_14_0 then
			return
		end

		arg_13_0.taste = arg_14_0

		arg_13_0.chooseTasteItemScroll:Refresh()
		arg_13_0:CheckCookFoodPrecondition()
	end)
end

function var_0_0.UpdataChooseFoodTaste(arg_15_0, arg_15_1)
	arg_15_0.chooseFoodTasteList = {}

	for iter_15_0, iter_15_1 in ipairs(BackHomeCanteenFoodCfg[arg_15_1].tag) do
		local var_15_0 = {
			type = DormEnum.UniversalUIType.TasteName,
			id = iter_15_1
		}

		table.insert(arg_15_0.chooseFoodTasteList, var_15_0)
	end
end

function var_0_0.UpdataChooseFoodMaterial(arg_16_0, arg_16_1)
	arg_16_0.chooseFoodMaterialList = BackHomeCanteenFoodCfg[arg_16_1].ingredient_list
end

function var_0_0.IndexFoodMaterialItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:RefreshItem(arg_17_0.chooseFoodMaterialList[arg_17_1], nil, nil, DormEnum.FoodSellType.SignFood)
end

function var_0_0.IndexCookFoodItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:RefreshUI(arg_18_0.canCookFoodList_[arg_18_1], arg_18_0.foodId)
	arg_18_2:RegistCallBack(handler(arg_18_0, arg_18_0.RefreshFoodTasteAndMaterial))
end

function var_0_0.RefreshFoodTasteAndMaterial(arg_19_0, arg_19_1)
	if arg_19_0.startFlag then
		return
	end

	if arg_19_1 == arg_19_0.foodId then
		return
	end

	arg_19_0.foodId = arg_19_1
	arg_19_0.taste = nil

	arg_19_0.canCookFoodItemScroll:Refresh()
	arg_19_0:UpdataChooseFoodMaterial(arg_19_1)
	arg_19_0.cookMaterialItemScroll_:StartScroll(#arg_19_0.chooseFoodMaterialList)
	arg_19_0:UpdataChooseFoodTaste(arg_19_1)
	arg_19_0.chooseTasteItemScroll:StartScroll(#arg_19_0.chooseFoodTasteList)
	arg_19_0:InitProgressBar(arg_19_1)
end

function var_0_0.CheckCookFoodPrecondition(arg_20_0)
	if arg_20_0.foodId ~= nil then
		local var_20_0 = arg_20_0.foodId

		if CanteenFoodData:GetSignFoodCanCookNum(var_20_0) <= 0 then
			arg_20_0.cookStateController_:SetSelectedState("lack")
		end
	end
end

function var_0_0.StartCookFoodQTE(arg_21_0)
	arg_21_0.qteStartController_:SetSelectedState("true")

	if arg_21_0.timer == nil then
		arg_21_0.timer = FrameTimer.New(function()
			arg_21_0:UpdataCursor()
		end, 0.016666666666666666, -1)

		arg_21_0.timer:Start()

		arg_21_0.startFlag = true

		arg_21_0.particleController:SetSelectedState("on")
		manager.windowBar:HideBar()
	else
		arg_21_0.timer:Stop()

		arg_21_0.timer = nil

		local var_21_0 = arg_21_0:QTEResult()

		if var_21_0 == DormEnum.FoodQuality.low then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_bad", "")
		elseif var_21_0 == DormEnum.FoodQuality.normal then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_commonly", "")
		elseif var_21_0 == DormEnum.FoodQuality.high then
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_perfect", "")
		end

		arg_21_0.startFlag = false

		arg_21_0.particleController:SetSelectedState("off")
		arg_21_0:CookFinish(var_21_0)
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end
end

function var_0_0.InitProgressBar(arg_23_0, arg_23_1)
	local var_23_0 = CanteenFoodData:GetFoodProficiency(arg_23_1)

	arg_23_0.progress1Angel = 0
	arg_23_0.progress2Angel = 0

	for iter_23_0 = 1, #BackHomeCanteenFoodCfg[arg_23_1].cook_range do
		if var_23_0 < BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0][1] then
			arg_23_0.progress1Angel = BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0 - 1][2]
			arg_23_0.progress2Angel = BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0 - 1][3]

			break
		end

		arg_23_0.progress1Angel = BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0][2]
		arg_23_0.progress2Angel = BackHomeCanteenFoodCfg[arg_23_1].cook_range[iter_23_0][3]
	end

	local var_23_1 = GameDisplayCfg.canteen_cook_range_speed.value[1]

	arg_23_0.MaxEuler = GameDisplayCfg.canteen_cook_range.value[2]
	arg_23_0.MinEuler = GameDisplayCfg.canteen_cook_range.value[1]

	arg_23_0:RandomProgressBar()

	arg_23_0.CursorTickEuler = var_23_1 / DormConst.COOK_CURSOR_FRAME
	arg_23_0.turnNum = 1
	arg_23_0.cursorTrs_.localEulerAngles = Vector3.New(0, 0, arg_23_0.MaxEuler)
end

function var_0_0.RandomProgressBar(arg_24_0)
	local var_24_0 = arg_24_0.MaxEuler + 90 - arg_24_0.progress1Angel

	arg_24_0.progressbar1Img_.fillAmount = arg_24_0.progress1Angel / 180 - arg_24_0.progress1Angel / 180 % 0.01
	arg_24_0.progressbar2Img_.fillAmount = arg_24_0.progress2Angel / 180 - arg_24_0.progress2Angel / 180 % 0.01

	local var_24_1 = math.random(arg_24_0.MinEuler + 90, var_24_0)
	local var_24_2 = math.floor(var_24_1)
	local var_24_3 = math.random(var_24_2, var_24_2 + arg_24_0.progress1Angel - arg_24_0.progress2Angel)
	local var_24_4 = math.floor(var_24_3)

	arg_24_0.progressbar1Trs_.localEulerAngles = Vector3.New(0, 0, var_24_2)
	arg_24_0.progressbar2Trs_.localEulerAngles = Vector3.New(0, 0, var_24_4)
end

function var_0_0.UpdataCursor(arg_25_0)
	local var_25_0 = 0

	if arg_25_0.turnNum % 2 == 1 then
		arg_25_0.cursorTrs_.localEulerAngles = arg_25_0.cursorTrs_.localEulerAngles - Vector3.New(0, 0, arg_25_0.CursorTickEuler)

		local var_25_1 = 0

		if arg_25_0.cursorTrs_.localEulerAngles.z > 180 then
			var_25_1 = arg_25_0.cursorTrs_.localEulerAngles.z - 360
		else
			var_25_1 = arg_25_0.cursorTrs_.localEulerAngles.z
		end

		if var_25_1 <= arg_25_0.MinEuler then
			arg_25_0.turnNum = arg_25_0.turnNum + 1
		end
	elseif arg_25_0.turnNum % 2 == 0 then
		arg_25_0.cursorTrs_.localEulerAngles = arg_25_0.cursorTrs_.localEulerAngles + Vector3.New(0, 0, arg_25_0.CursorTickEuler)

		local var_25_2 = 0

		if arg_25_0.cursorTrs_.localEulerAngles.z > 180 then
			var_25_2 = arg_25_0.cursorTrs_.localEulerAngles.z - 360
		else
			var_25_2 = arg_25_0.cursorTrs_.localEulerAngles.z
		end

		if var_25_2 >= arg_25_0.MaxEuler then
			arg_25_0.turnNum = arg_25_0.turnNum + 1
		end
	end

	arg_25_0.cursorTrs_.localEulerAngles.z = var_25_0
end

function var_0_0.QTEResult(arg_26_0)
	local var_26_0 = 0

	if arg_26_0:CheckCursorInProgress1() == false then
		var_26_0 = DormEnum.FoodQuality.low
	elseif arg_26_0:CheckCursorInProgress1() == true and arg_26_0:CheckCursorInProgress2() == false then
		var_26_0 = DormEnum.FoodQuality.normal
	elseif arg_26_0:CheckCursorInProgress1() == true and arg_26_0:CheckCursorInProgress2() == true then
		var_26_0 = DormEnum.FoodQuality.high
	end

	return var_26_0
end

function var_0_0.CheckCursorInProgress1(arg_27_0)
	local var_27_0 = arg_27_0.cursorTrs_.localEulerAngles.z + 90

	if var_27_0 > 360 then
		var_27_0 = var_27_0 - 360
	end

	if var_27_0 >= arg_27_0.progress1Angel + arg_27_0.progressbar1Trs_.localEulerAngles.z or var_27_0 <= arg_27_0.progressbar1Trs_.localEulerAngles.z then
		return false
	end

	return true
end

function var_0_0.CheckCursorInProgress2(arg_28_0)
	local var_28_0 = arg_28_0.cursorTrs_.localEulerAngles.z + 90

	if var_28_0 > 360 then
		var_28_0 = var_28_0 - 360
	end

	if var_28_0 >= arg_28_0.progress2Angel + arg_28_0.progressbar2Trs_.localEulerAngles.z or var_28_0 <= arg_28_0.progressbar2Trs_.localEulerAngles.z then
		return false
	end

	return true
end

function var_0_0.CookFinish(arg_29_0, arg_29_1)
	arg_29_0.cookFinishController_:SetSelectedState("completed")
	arg_29_0.cookCompletedBgController_:SetSelectedState("on")
	arg_29_0.finishFoodController_:SetSelectedState("off")
	arg_29_0.tasteFoodController_:SetSelectedState("off")

	arg_29_0.finishfoodtextText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_29_0.foodId].name)
	arg_29_0.finishfoodtastetextText_.text = GetTips(CanteenConst.FoodTaste[arg_29_0.taste][1])

	arg_29_0.finishIngredientItemScroll_:StartScroll(#arg_29_0.chooseFoodMaterialList)
	arg_29_0.cookcompletedLvController_:SetSelectedState(arg_29_1)

	arg_29_0.cookFoodFlag = true

	CanteenData:CookFoodComplete(arg_29_0.playerEid, arg_29_1, arg_29_0.kitchenwareEid, arg_29_0.foodId, arg_29_0.taste)
end

function var_0_0.ResetView(arg_30_0)
	arg_30_0.cookStateController_:SetSelectedIndex(0)
	arg_30_0.cookFinishController_:SetSelectedIndex(0)
	arg_30_0.cookCompletedBgController_:SetSelectedIndex(0)
	arg_30_0.cookcompletedLvController_:SetSelectedIndex(0)
	arg_30_0.finishFoodController_:SetSelectedState("none")
	arg_30_0.tasteFoodController_:SetSelectedState("none")

	arg_30_0.cursorTrs_.localEulerAngles = Vector3.New(0, 0, arg_30_0.MaxEuler)
	arg_30_0.foodId = nil
	arg_30_0.taste = nil
	arg_30_0.chooseFoodMaterialList = {}
	arg_30_0.chooseFoodTasteList = {}
	arg_30_0.turnNum = 1

	arg_30_0.chooseTasteItemScroll:StartScroll(#arg_30_0.chooseFoodTasteList)
	arg_30_0.cookMaterialItemScroll_:StartScroll(#arg_30_0.chooseFoodMaterialList)
	arg_30_0.qteStartController_:SetSelectedState("false")
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if arg_31_0.cookFoodFlag == false then
		CanteenData:CookFoodCanceled(arg_31_0.playerEid, arg_31_0.kitchenwareEid)
	end

	if arg_31_0.timer then
		arg_31_0.timer:Stop()

		arg_31_0.timer = nil
	end

	arg_31_0:ResetView()
end

function var_0_0.Dispose(arg_32_0)
	if arg_32_0.cookMaterialItemScroll_ then
		arg_32_0.cookMaterialItemScroll_:Dispose()

		arg_32_0.cookMaterialItemScroll_ = nil
	end

	if arg_32_0.finishIngredientItemScroll_ then
		arg_32_0.finishIngredientItemScroll_:Dispose()

		arg_32_0.finishIngredientItemScroll_ = nil
	end

	if arg_32_0.canCookFoodItemScroll then
		arg_32_0.canCookFoodItemScroll:Dispose()

		arg_32_0.canCookFoodItemScroll = nil
	end

	if arg_32_0.chooseTasteItemScroll then
		arg_32_0.chooseTasteItemScroll:Dispose()

		arg_32_0.chooseTasteItemScroll = nil
	end

	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0
