local var_0_0 = class("FoodMenuItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.statusController = ControllerUtil.GetController(arg_1_0.transform_, "state")
	arg_1_0.selectedController = ControllerUtil.GetController(arg_1_0.transform_, "select")

	arg_1_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.itemBtn_, nil, function()
		if arg_2_0.clickFunc then
			arg_2_0.clickFunc(arg_2_0.ID, arg_2_0.type)
		end
	end)
end

function var_0_0.RefreshItem(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.ID = arg_4_1
	arg_4_0.type = arg_4_2

	if arg_4_0.selectedController then
		if arg_4_0.ID == arg_4_3 then
			arg_4_0.selectedController:SetSelectedState("on")
		else
			arg_4_0.selectedController:SetSelectedState("off")
		end
	end

	if arg_4_2 == DormEnum.MenuType.foodMenu then
		local var_4_0 = BackHomeCanteenFoodCfg[arg_4_1].unlock

		if not CanteenTools:CheckFoodUnLock(arg_4_1) then
			arg_4_0.statusController:SetSelectedState("on")

			arg_4_0.locktextText_.text = BackHomeTools:GetBackHomeConditionDes(var_4_0)
		else
			arg_4_0.statusController:SetSelectedState("off")

			arg_4_0.nameText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_4_1].name)
			arg_4_0.iconimageImg_.sprite = pureGetSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[arg_4_1].icon)
		end
	elseif arg_4_2 == DormEnum.MenuType.bag then
		local var_4_1 = CanteenFoodData:GetCateenIngredient()[arg_4_1]

		arg_4_0.nameText_.text = ItemTools.getItemName(arg_4_1)
		arg_4_0.numText_.text = NumberTools.RetractNumberForWindBar(var_4_1)
		arg_4_0.foodiconImg_.sprite = ItemTools.getItemSprite(arg_4_1)
	end
end

function var_0_0.RegisterClickCallBack(arg_5_0, arg_5_1)
	if arg_5_1 ~= nil then
		arg_5_0.clickFunc = arg_5_1
	end
end

return var_0_0
