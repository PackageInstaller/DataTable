local var_0_0 = class("ActivitySkinDrawPopViewOld", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawToolsOld.GetPopUIName(arg_1_0.params_.mainActivity)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.discountCon_ = ControllerUtil.GetController(arg_4_0.transform_, "discount")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddToggleListener(arg_5_0.tgl1_, function(arg_6_0)
		arg_5_0.choose_ = 1
	end)
	arg_5_0:AddToggleListener(arg_5_0.tgl2_, function(arg_7_0)
		arg_5_0.choose_ = 2
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		local var_10_0 = arg_5_0.goods_[arg_5_0.choose_]

		ShopAction.BuyItem({
			{
				goodID = var_10_0,
				buyNum = arg_5_0.cnt_
			}
		})
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.choose_ = 2
	arg_11_0.tgl2_.isOn = true

	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.poolActivityID
	arg_12_0.poolID_ = arg_12_0.params_.poolID
	arg_12_0.goods_ = arg_12_0.params_.goods
	arg_12_0.cnt_ = arg_12_0.params_.cnt

	arg_12_0:RefreshGoods()
	arg_12_0:RefreshDiscount()
end

function var_0_0.RefreshGoods(arg_13_0)
	arg_13_0.text1_.text = arg_13_0:GetGoodsDesc(1)
	arg_13_0.text2_.text = arg_13_0:GetGoodsDesc(2)
end

function var_0_0.GetGoodsDesc(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.goods_[arg_14_1]
	local var_14_1 = getShopCfg(var_14_0)
	local var_14_2 = var_14_1.cost_id
	local var_14_3 = var_14_1.give_id
	local var_14_4 = var_14_1.cost

	if var_14_1.discount ~= 0 then
		var_14_4 = var_14_1.cheap_cost
	end

	return string.format(GetTips("GENGCHEN_SWIMWEAR_TICKET_TIPS"), var_14_4 * arg_14_0.cnt_, ItemTools.getItemName(var_14_2), ItemTools.getItemName(var_14_3), arg_14_0.cnt_)
end

function var_0_0.RefreshDiscount(arg_15_0)
	local var_15_0 = arg_15_0.goods_[2]
	local var_15_1 = getShopCfg(var_15_0)

	if var_15_1.discount ~= 0 then
		arg_15_0.discount_.text = ShopTools.GetDiscountLabelByPercent(var_15_1.discount)

		arg_15_0.discountCon_:SetSelectedState("true")
	else
		arg_15_0.discountCon_:SetSelectedState("false")
	end
end

function var_0_0.OnShopBuyResult(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:Back()

	if arg_16_2 == arg_16_0.goods_[arg_16_0.choose_] then
		ActivitySkinDrawActionOld.StartDraw(arg_16_0.activityID_, arg_16_0.poolID_, arg_16_0.cnt_)
	end
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveAllListeners()
	arg_18_0.super.Dispose(arg_18_0)
end

return var_0_0
