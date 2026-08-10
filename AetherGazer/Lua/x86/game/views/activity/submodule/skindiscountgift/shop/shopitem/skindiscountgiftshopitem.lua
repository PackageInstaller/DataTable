LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local var_0_0 = class("SkinDiscountGiftShopItem", LoopScrollViewBaseItem)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddUIListener()

	arg_1_0.skinItemView_ = SkinDiscountGiftShopSkinItem.New(arg_1_0.gameObject_)
end

function var_0_0.AddUIListener(arg_2_0)
	return
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.skinItemView_:SetData(arg_3_1)

	arg_3_0.index_ = arg_3_2

	arg_3_0:Show(true)
end

function var_0_0.GetItemHeight(arg_4_0)
	return arg_4_0.rectGo_.sizeDelta.x
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.skinItemView_:Dispose()

	arg_5_0.skinItemView_ = nil

	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil
end

return var_0_0
