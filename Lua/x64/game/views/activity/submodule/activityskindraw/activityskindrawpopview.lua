local var_0_0 = class("ActivitySkinDrawPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawTools.GetPopUIName(arg_1_0.params_.mainActivity)
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

	arg_4_0.giveId = {}
	arg_4_0.costNumText_ = {}
	arg_4_0.costImg_ = {}
	arg_4_0.costNameText_ = {}
	arg_4_0.giveNumText_ = {}
	arg_4_0.giveImg_ = {}
	arg_4_0.giveNameText_ = {}
	arg_4_0.disconutController_ = {}
	arg_4_0.discountText_ = {}

	for iter_4_0 = 1, 2 do
		arg_4_0.costNumText_[iter_4_0] = arg_4_0["costNumText_" .. iter_4_0]
		arg_4_0.costImg_[iter_4_0] = arg_4_0["costImg_" .. iter_4_0]
		arg_4_0.costNameText_[iter_4_0] = arg_4_0["costNameText_" .. iter_4_0]
		arg_4_0.giveNumText_[iter_4_0] = arg_4_0["giveNumText_" .. iter_4_0]
		arg_4_0.giveImg_[iter_4_0] = arg_4_0["giveImg_" .. iter_4_0]
		arg_4_0.giveNameText_[iter_4_0] = arg_4_0["giveNameText_" .. iter_4_0]
		arg_4_0.disconutController_[iter_4_0] = arg_4_0["discountCon_" .. iter_4_0]:GetController("discount")
		arg_4_0.discountText_[iter_4_0] = arg_4_0["discountText_" .. iter_4_0]
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddToggleListener(arg_5_0.connect1Tgl_, function(arg_6_0)
		arg_5_0.choose_ = 1
	end)
	arg_5_0:AddToggleListener(arg_5_0.connect2Tgl_, function(arg_7_0)
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
	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.poolActivityID
	arg_12_0.poolID_ = arg_12_0.params_.poolID
	arg_12_0.goods_ = arg_12_0.params_.goods
	arg_12_0.cnt_ = arg_12_0.params_.cnt

	arg_12_0:RefreshState()
	arg_12_0:RefreshGoods()
end

function var_0_0.RefreshState(arg_13_0)
	arg_13_0.disconut_ = arg_13_0.params_.discount

	if arg_13_0.disconut_[2] < arg_13_0.disconut_[1] or arg_13_0.disconut_[1] == 0 then
		arg_13_0.choose_ = 2
		arg_13_0.connect2Tgl_.isOn = true
	else
		arg_13_0.choose_ = 1
		arg_13_0.connect1Tgl_.isOn = true
	end
end

function var_0_0.RefreshGoods(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.goods_) do
		arg_14_0:RefrehGoodsInfo(iter_14_0)
	end

	arg_14_0.descText_.text = string.format(GetTips("SELECT_MATERIAL_LIST_EXCHANGE"), arg_14_0.cnt_, ItemTools.getItemName(arg_14_0.giveId[arg_14_0.choose_]))
end

function var_0_0.RefrehGoodsInfo(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.goods_[arg_15_1]
	local var_15_1 = getShopCfg(var_15_0)
	local var_15_2 = var_15_1.cost_id
	local var_15_3 = var_15_1.give_id
	local var_15_4 = var_15_1.cost

	if var_15_1.discount ~= 0 then
		var_15_4 = var_15_1.cheap_cost
	end

	arg_15_0.giveId[arg_15_1] = var_15_3
	arg_15_0.costNumText_[arg_15_1].text = var_15_4 * arg_15_0.cnt_
	arg_15_0.costImg_[arg_15_1].sprite = ItemTools.getItemSprite(var_15_2)
	arg_15_0.costNameText_[arg_15_1].text = ItemTools.getItemName(var_15_2)
	arg_15_0.giveNumText_[arg_15_1].text = arg_15_0.cnt_
	arg_15_0.giveImg_[arg_15_1].sprite = ItemTools.getItemSprite(var_15_3, nil, true)
	arg_15_0.giveNameText_[arg_15_1].text = ItemTools.getItemName(var_15_3, nil, true)
	arg_15_0.discountText_[arg_15_1].text = ShopTools.GetDiscountLabelByPercent(arg_15_0.disconut_[arg_15_1])

	arg_15_0.disconutController_[arg_15_1]:SetSelectedState(arg_15_0.disconut_[arg_15_1] ~= 0 and "show" or "hide")
end

function var_0_0.OnShopBuyResult(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:Back()

	if arg_16_2 == arg_16_0.goods_[arg_16_0.choose_] then
		ActivitySkinDrawAction.StartDraw(arg_16_0.activityID_, arg_16_0.poolID_, arg_16_0.cnt_)
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
