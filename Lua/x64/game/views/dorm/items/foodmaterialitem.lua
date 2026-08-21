local var_0_0 = class("FoodMaterialItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.colorController = ControllerUtil.GetController(arg_2_0.transform_, "numcolor1")
	arg_2_0.shopController = ControllerUtil.GetController(arg_2_0.transform_, "shopBtn")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.shopBtn_, nil, function()
		if arg_4_0.goodID then
			JumpTools.GoToSystem("/activityShop", {
				hideHomeBtn = 1,
				shopId = ShopConst.SHOP_ID.CANTEEN_SHOP,
				showShops = {
					ShopConst.SHOP_ID.CANTEEN_SHOP
				},
				goodId = arg_4_0.goodID
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
end

function var_0_0.RefreshItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.id = arg_6_1[1]
	arg_6_0.num = arg_6_1[2]
	arg_6_0.textText_.text = ItemTools.getItemName(arg_6_0.id)

	arg_6_0.colorController:SetSelectedState("1")

	arg_6_0.iconImg_.sprite = ItemTools.getItemSprite(arg_6_0.id)

	if arg_6_2 then
		local var_6_0 = BackHomeCanteenFoodCfg[arg_6_2].ingredient_list
		local var_6_1 = 0

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if iter_6_1[1] == arg_6_0.id then
				var_6_1 = iter_6_1[2]
			end
		end

		arg_6_0.num = var_6_1 * arg_6_3
	end

	arg_6_0.costNumText_.text = NumberTools.RetractNumberForWindBar(arg_6_0.num)

	if arg_6_4 == DormEnum.FoodSellType.SignFood then
		arg_6_0.hadNumText_.text = ""
	else
		local var_6_2 = CanteenFoodData:GetCateenIngredientNum(arg_6_0.id)

		arg_6_0.hadNumText_.text = NumberTools.RetractNumberForWindBar(var_6_2)

		if var_6_2 < arg_6_0.num then
			arg_6_0.colorController:SetSelectedState("2")
		end

		arg_6_0.costNumText_.text = "/" .. NumberTools.RetractNumberForWindBar(arg_6_0.num)
	end

	local var_6_3 = getGoodListByGiveID(arg_6_0.id)
	local var_6_4 = false

	for iter_6_2, iter_6_3 in ipairs(var_6_3) do
		if ShopTools.IsGoodCanBuy(ShopConst.SHOP_ID.CANTEEN_SHOP, iter_6_3) then
			var_6_4 = true
			arg_6_0.goodID = iter_6_3

			break
		end
	end

	if var_6_4 then
		arg_6_0.shopController:SetSelectedState("true")
	else
		arg_6_0.shopController:SetSelectedState("false")
	end
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.btnCallBack = arg_7_1
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
