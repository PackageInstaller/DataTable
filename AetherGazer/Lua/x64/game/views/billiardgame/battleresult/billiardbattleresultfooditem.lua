local var_0_0 = class("BilliardBattleResultFoodItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.foodBtn_, nil, function()
		arg_3_0:OnBtnClick()
	end)
end

function var_0_0.OnBtnClick(arg_5_0)
	arg_5_0.parent:OnChildClick(arg_5_0)
end

function var_0_0.Render(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.parent = arg_6_2
	arg_6_0.itemId = arg_6_1
	arg_6_0.foodIcon_.sprite = pureGetSpriteWithoutAtlas(ItemTools.getItemSprite(arg_6_0.itemId))
end

function var_0_0.GetItemId(arg_7_0)
	return arg_7_0.itemId
end

function var_0_0.GetTipTrans(arg_8_0)
	return arg_8_0.tipsTrans_
end

return var_0_0
