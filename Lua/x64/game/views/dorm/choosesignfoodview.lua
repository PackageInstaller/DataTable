local var_0_0 = class("ChooseSignFoodView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamTodayMenuPop"
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

	arg_4_0.foodScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, ChooseFoodItem)
	arg_4_0.chooseItemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.refreshItem), arg_4_0.chooseuilistGo_, TodayMenuItem)
	arg_4_0.chooseListController = ControllerUtil.GetController(arg_4_0.transform_, "food")
	arg_4_0.btnController = {
		[3] = ControllerUtil.GetController(arg_4_0.fryingpanBtn_.transform, "name"),
		[4] = ControllerUtil.GetController(arg_4_0.steamerBtn_.transform, "name"),
		[5] = ControllerUtil.GetController(arg_4_0.grillBtn_.transform, "name"),
		[6] = ControllerUtil.GetController(arg_4_0.potBtn_.transform, "name")
	}
end

function var_0_0.RegisterEvent(arg_5_0)
	arg_5_0:RegistEventListener(CANTEEN_SET_SIGNFOOD_SUCCESS, function()
		arg_5_0:RefreshFoodList()
	end)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.fryingpanBtn_, nil, function()
		arg_7_0.selectIndex_ = DormEnum.FurnitureTypeNum.Pan

		arg_7_0:UpdateItemData()
		arg_7_0.foodScroll_:StartScroll(#arg_7_0.itemList_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.grillBtn_, nil, function()
		arg_7_0.selectIndex_ = DormEnum.FurnitureTypeNum.Oven

		arg_7_0:UpdateItemData()
		arg_7_0.foodScroll_:StartScroll(#arg_7_0.itemList_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.steamerBtn_, nil, function()
		arg_7_0.selectIndex_ = DormEnum.FurnitureTypeNum.Steamer

		arg_7_0:UpdateItemData()
		arg_7_0.foodScroll_:StartScroll(#arg_7_0.itemList_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.potBtn_, nil, function()
		arg_7_0.selectIndex_ = DormEnum.FurnitureTypeNum.Pot

		arg_7_0:UpdateItemData()
		arg_7_0.foodScroll_:StartScroll(#arg_7_0.itemList_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.refreshItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_0.chooseItemList_[arg_13_1])

	arg_13_0.cursignfoodText_.text = #CanteenFoodData:GetChooseFoodList()
	arg_13_0.totalsignfoodText_.text = "/" .. DormSkillData:GetCanSignFoodNum()
end

function var_0_0.indexItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:RefreshUI(arg_14_0.itemList_[arg_14_1])
	arg_14_2:RegistCallBack(function(arg_15_0)
		if (#CanteenFoodData:GetChooseFoodList() or 0) >= DormSkillData:GetCanSignFoodNum() then
			ShowTips(GetTips("CANTEEN_FOOD_MAX"))
		else
			JumpTools.OpenPageByJump("/reviseSignFoodNumView", {
				foodID = arg_15_0
			})
		end
	end)
	arg_14_2:RegisterLackCallBack(function(arg_16_0)
		JumpTools.OpenPageByJump("canteenLackFoodIngredientsView", {
			foodID = arg_16_0
		})
	end)
end

function var_0_0.UpdateItemData(arg_17_0)
	arg_17_0.itemList_ = {}

	for iter_17_0, iter_17_1 in pairs(BackHomeCanteenFoodCfg.all) do
		if arg_17_0.selectIndex_ == BackHomeCanteenFoodCfg[iter_17_1].cook_type then
			if BackHomeCanteenFoodCfg[iter_17_1].unlock > 0 then
				if CanteenTools:CheckFoodUnLock(iter_17_1) then
					table.insert(arg_17_0.itemList_, iter_17_1)
				end
			else
				table.insert(arg_17_0.itemList_, iter_17_1)
			end
		end
	end

	CommonTools.UniversalSortEx(arg_17_0.itemList_, {
		map = function(arg_18_0)
			return arg_18_0
		end
	})

	arg_17_0.cooktitleText_.text = GetI18NText(CanteenTools:GetCookCfgName(arg_17_0.selectIndex_))

	for iter_17_2, iter_17_3 in pairs(arg_17_0.btnController) do
		if arg_17_0.selectIndex_ == iter_17_2 then
			iter_17_3:SetSelectedState("on")
		else
			iter_17_3:SetSelectedState("off")
		end
	end
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.selectIndex_ = arg_19_0.selectIndex_ or DormEnum.FurnitureTypeNum.Pan

	if manager.guide:IsPlaying() then
		arg_19_0.selectIndex_ = DormEnum.FurnitureTypeNum.Pan
	end

	arg_19_0.params_.type = nil

	arg_19_0:RefreshFoodList()
	arg_19_0:RegisterEvent()
end

function var_0_0.RefreshFoodList(arg_20_0)
	arg_20_0:UpdateItemData()
	arg_20_0.foodScroll_:StartScroll(#arg_20_0.itemList_)

	arg_20_0.chooseItemList_ = CanteenFoodData:GetChooseFoodList()

	if #arg_20_0.chooseItemList_ > 0 then
		arg_20_0.chooseListController:SetSelectedState("on")
	else
		arg_20_0.chooseListController:SetSelectedState("off")
	end

	arg_20_0.chooseItemScroll_:StartScroll(#arg_20_0.chooseItemList_)
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.toggleList_ then
		arg_22_0.toggleList_:Dispose()
	end

	if arg_22_0.chooseItemList_ then
		arg_22_0.chooseItemScroll_:Dispose()
	end

	if arg_22_0.foodScroll_ then
		arg_22_0.foodScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
