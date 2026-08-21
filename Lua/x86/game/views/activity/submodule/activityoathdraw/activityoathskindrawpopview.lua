local var_0_0 = class("ActivityOathSkinDrawPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return OathDrawTools.GetPopUIName(arg_1_0.params_.mainActivity)
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

		arg_5_0:UpdateSliderValue()
	end)
	arg_5_0:AddToggleListener(arg_5_0.connect2Tgl_, function(arg_7_0)
		arg_5_0.choose_ = 2

		arg_5_0:UpdateSliderValue()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		local var_10_0 = arg_5_0.goods_[arg_5_0.choose_]

		if arg_5_0.cntList_[arg_5_0.choose_] > arg_5_0:GetRemainCanDrawCnt() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("WEDDING_AUTO_DRAW_TIPS2"),
				OkCallback = function()
					ShopAction.BuyItem({
						{
							goodID = var_10_0,
							buyNum = arg_5_0.cntList_[arg_5_0.choose_]
						}
					})
				end,
				CancelCallback = function()
					return
				end
			})
		else
			ShopAction.BuyItem({
				{
					goodID = var_10_0,
					buyNum = arg_5_0.cntList_[arg_5_0.choose_]
				}
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.delBtn_, nil, function()
		arg_5_0:OnChangeBuyCnt(-1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.addBtn_, nil, function()
		arg_5_0:OnChangeBuyCnt(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.maxBtn_, nil, function()
		arg_5_0:OnChangeBuyCnt(arg_5_0:GetRemainCanBuyCnt(arg_5_0.choose_) - arg_5_0.cntList_[arg_5_0.choose_])
	end)
	arg_5_0.useNumSli_.onValueChanged:AddListener(function(arg_16_0)
		if arg_16_0 < 1 then
			arg_16_0 = 1
			arg_5_0.useNumSli_.value = 1

			return
		end

		arg_5_0.cntList_[arg_5_0.choose_] = arg_16_0

		arg_5_0:UpdateSliderText()
		arg_5_0:RefrehGoodsInfo(arg_5_0.choose_)
		arg_5_0:UpdateDelAddBtn()
	end)
end

function var_0_0.UpdateSliderValue(arg_17_0)
	local var_17_0 = arg_17_0.cntList_[arg_17_0.choose_]
	local var_17_1 = math.min(arg_17_0:GetMaxCanBuyCount(arg_17_0.choose_), arg_17_0:GetRemainCanBuyCnt(arg_17_0.choose_))

	arg_17_0.useNumSli_.maxValue = var_17_1
	arg_17_0.useNumSli_.minValue = 0
	arg_17_0.useNumSli_.value = var_17_0

	arg_17_0:UpdateDelAddBtn()
end

function var_0_0.OnChangeBuyCnt(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.cntList_[arg_18_0.choose_] + arg_18_1
	local var_18_1 = Mathf.Clamp(var_18_0, 1, arg_18_0:GetRemainCanBuyCnt(arg_18_0.choose_))

	arg_18_0.useNumSli_.value = var_18_1

	arg_18_0:UpdateSliderText()
	arg_18_0:RefrehGoodsInfo(arg_18_0.choose_)
end

function var_0_0.UpdateDelAddBtn(arg_19_0)
	local var_19_0 = arg_19_0.cntList_[arg_19_0.choose_]
	local var_19_1 = math.min(arg_19_0:GetMaxCanBuyCount(arg_19_0.choose_), arg_19_0:GetRemainCanBuyCnt(arg_19_0.choose_))

	arg_19_0.delBtn_.interactable = var_19_0 > 1
	arg_19_0.addBtn_.interactable = var_19_0 < var_19_1
end

function var_0_0.UpdateSliderText(arg_20_0)
	arg_20_0.useNumText_.text = tostring(arg_20_0.cntList_[arg_20_0.choose_])

	arg_20_0:RefreshGoods()
end

function var_0_0.GetRemainCanDrawCnt(arg_21_0)
	if arg_21_0.remainCanDrawCnt then
		return arg_21_0.remainCanDrawCnt
	end

	arg_21_0.remainCanDrawCnt = ActivityOathDrawData:GetRemainCanDrawCnt(arg_21_0.activityID_)

	return arg_21_0.remainCanDrawCnt
end

function var_0_0.GetRemainCanBuyCnt(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.goods_[arg_22_1]
	local var_22_1 = getShopCfg(var_22_0)
	local var_22_2 = ShopData.GetShop(var_22_1.shop_id)[var_22_0]

	return var_22_1.limit_num - (var_22_2 and var_22_2.buy_times or 0)
end

function var_0_0.GetDrawingReaminCnt(arg_23_0)
	local var_23_0 = ActivityOathDrawData:GetDrawData(arg_23_0.activityID_)
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if not iter_23_1.isOpen then
			var_23_1 = var_23_1 + 1
		end
	end

	return var_23_1
end

function var_0_0.GetHaveCnt(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.goods_[arg_24_1]
	local var_24_1 = getShopCfg(var_24_0).give_id

	return ItemTools.getItemNum(var_24_1)
end

function var_0_0.GetDefaultBuyCnt(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:GetDrawingReaminCnt()
	local var_25_1 = arg_25_0:GetHaveCnt(arg_25_1)
	local var_25_2 = math.max(var_25_0 - var_25_1, 1)

	return math.min(var_25_2, arg_25_0:GetRemainCanBuyCnt(arg_25_1))
end

function var_0_0.GetMaxCanBuyCount(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetHaveCnt(arg_26_1)

	return math.max(arg_26_0:GetRemainCanDrawCnt() - var_26_0, 1)
end

function var_0_0.OnEnter(arg_27_0)
	arg_27_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_28_0)
	arg_28_0.activityID_ = arg_28_0.params_.poolActivityID
	arg_28_0.poolID_ = arg_28_0.params_.poolID
	arg_28_0.goods_ = arg_28_0.params_.goods
	arg_28_0.defaultBuyCnt_ = arg_28_0.params_.defaultBuyCnt or -1
	arg_28_0.cntList_ = {}

	for iter_28_0 = 1, 2 do
		if arg_28_0.defaultBuyCnt_ and arg_28_0.defaultBuyCnt_ > 0 then
			arg_28_0.cntList_[iter_28_0] = arg_28_0.defaultBuyCnt_
		else
			arg_28_0.cntList_[iter_28_0] = arg_28_0:GetDefaultBuyCnt(iter_28_0)
		end
	end

	arg_28_0:RefreshState()
	arg_28_0:RefreshGoods()
	arg_28_0:UpdateSliderValue()
	arg_28_0:UpdateDelAddBtn()

	arg_28_0.titlteText_.text = string.format(GetTips("EXCHANGE_TIP"), ItemTools.getItemName(arg_28_0.giveId[arg_28_0.choose_]))
end

function var_0_0.RefreshState(arg_29_0)
	arg_29_0.disconut_ = arg_29_0.params_.discount

	if arg_29_0.disconut_[2] < arg_29_0.disconut_[1] or arg_29_0.disconut_[1] == 0 then
		arg_29_0.choose_ = 2
		arg_29_0.connect2Tgl_.isOn = true
	else
		arg_29_0.choose_ = 1
		arg_29_0.connect1Tgl_.isOn = true
	end
end

function var_0_0.RefreshGoods(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0.goods_) do
		arg_30_0:RefrehGoodsInfo(iter_30_0)
	end

	arg_30_0.descText_.text = string.format(GetTips("WEDDING_TICKET_DRAW_TIPS1"), arg_30_0.cntList_[arg_30_0.choose_], arg_30_0:GetRemainCanBuyCnt(arg_30_0.choose_))
end

function var_0_0.RefrehGoodsInfo(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.goods_[arg_31_1]
	local var_31_1 = getShopCfg(var_31_0)
	local var_31_2 = var_31_1.cost_id
	local var_31_3 = var_31_1.give_id
	local var_31_4 = var_31_1.cost

	if var_31_1.discount ~= 0 then
		var_31_4 = var_31_1.cheap_cost
	end

	arg_31_0.giveId[arg_31_1] = var_31_3
	arg_31_0.costNumText_[arg_31_1].text = var_31_4 * arg_31_0.cntList_[arg_31_1]
	arg_31_0.costImg_[arg_31_1].sprite = ItemTools.getItemSprite(var_31_2)
	arg_31_0.costNameText_[arg_31_1].text = ItemTools.getItemName(var_31_2)
	arg_31_0.giveNumText_[arg_31_1].text = arg_31_0.cntList_[arg_31_1]
	arg_31_0.giveImg_[arg_31_1].sprite = ItemTools.getItemSprite(var_31_3, nil, true)
	arg_31_0.giveNameText_[arg_31_1].text = ItemTools.getItemName(var_31_3, nil, true)
	arg_31_0.discountText_[arg_31_1].text = ShopTools.GetDiscountLabelByPercent(arg_31_0.disconut_[arg_31_1])

	arg_31_0.disconutController_[arg_31_1]:SetSelectedState(arg_31_0.disconut_[arg_31_1] ~= 0 and "show" or "hide")
end

function var_0_0.OnShopBuyResult(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0:Back()

	if arg_32_2 == arg_32_0.goods_[arg_32_0.choose_] and arg_32_0.params_.drawCallback then
		arg_32_0.params_.drawCallback(arg_32_0.cntList_[index])
	end
end

function var_0_0.OnExit(arg_33_0)
	arg_33_0.remainCanDrawCnt = nil

	arg_33_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_34_0)
	arg_34_0:RemoveAllListeners()
	arg_34_0.super.Dispose(arg_34_0)
end

return var_0_0
