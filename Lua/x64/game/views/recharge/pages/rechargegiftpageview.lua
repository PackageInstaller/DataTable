local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeGiftPageView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.giftList_ = LuaList.New(handler(arg_1_0, arg_1_0.indexItem), arg_1_0.listGo_, RechargeGiftItem)
end

function var_0_1.indexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:SetData(arg_2_0.shopDataList_[arg_2_1])
	arg_2_2:SetOutOfDateHandler(handler(arg_2_0, arg_2_0.OnItemOutOfDate))
end

function var_0_1.OnItemOutOfDate(arg_3_0, arg_3_1)
	arg_3_0:RefreshList()

	if #arg_3_0.shopDataList_ == 0 and arg_3_0.treeRefreshHandler_ ~= nil then
		arg_3_0.treeRefreshHandler_()
	end
end

function var_0_1.OnBuySuccess(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.curShopId_ == arg_4_2 then
		arg_4_0:RefreshList(true)
	end
end

function var_0_1.AddUIListener(arg_5_0)
	if SDKTools.GetIsInputServer("kr") then
		arg_5_0:AddBtnListener(arg_5_0.refundbtn_, nil, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = {
					"Widget/System/Recharge/RefundPolicyKR_01"
				}
			})
		end)
	end
end

function var_0_1.SwitchPage(arg_7_0, arg_7_1)
	arg_7_0.curShopId_ = arg_7_1
	arg_7_0.shopDataList_ = arg_7_0:InitShopList(arg_7_1)

	arg_7_0.giftList_:StartScroll(#arg_7_0.shopDataList_)
	SetActive(arg_7_0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(arg_7_0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(arg_7_0.refundbtn_.gameObject, arg_7_0.curPageIndex_ ~= 4 and arg_7_0.curPageIndex_ ~= 6)
	end
end

function var_0_1.RefreshList(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or false
	arg_8_0.shopDataList_ = arg_8_0:InitShopList(arg_8_0.curShopId_)

	if arg_8_1 then
		local var_8_0 = arg_8_0.giftList_:GetScrolledPosition()

		arg_8_0.giftList_:StartScrollByPosition(#arg_8_0.shopDataList_, var_8_0)
	else
		arg_8_0.giftList_:StartScroll(#arg_8_0.shopDataList_)
	end
end

function var_0_1.InitShopList(arg_9_0, arg_9_1)
	local var_9_0 = ShopTools.FilterShopDataList(arg_9_1)

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		local var_10_0 = getShopCfg(arg_10_0.id, arg_9_1)
		local var_10_1 = getShopCfg(arg_10_1.id, arg_9_1)
		local var_10_2 = arg_9_0:GetGoodStatus(arg_10_0.id, arg_9_1)
		local var_10_3 = arg_9_0:GetGoodStatus(arg_10_1.id, arg_9_1)

		if var_10_2 ~= var_10_3 then
			return var_10_2 < var_10_3
		end

		if var_10_0.shop_sort ~= var_10_1.shop_sort then
			return var_10_0.shop_sort > var_10_1.shop_sort
		end

		return var_10_0.goods_id > var_10_1.goods_id
	end)

	return var_9_0
end

function var_0_1.GetGoodStatus(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = false
	local var_11_1 = getShopCfg(arg_11_1, arg_11_2)
	local var_11_2 = ShopData.GetShop(var_11_1.shop_id)[arg_11_1]
	local var_11_3 = RechargeShopDescriptionCfg[var_11_1.description]

	if ShopData.IsGoodOutOfDate(arg_11_1, arg_11_2) then
		return 3
	end

	if var_11_2 ~= nil and var_11_1.limit_num ~= nil and var_11_1.limit_num ~= -1 and var_11_1.limit_num - var_11_2.buy_times <= 0 then
		var_11_0 = true
	end

	if var_11_0 then
		return 3
	end

	if var_11_3 and var_11_3.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
		for iter_11_0, iter_11_1 in ipairs(var_11_3.param) do
			if iter_11_1[1] then
				local var_11_4 = ItemCfg[iter_11_1[1]]

				if ItemTools.getItemNum(iter_11_1[1]) == 1 and var_11_4.type == ItemConst.ITEM_TYPE.HERO_SKIN then
					return 2
				end
			end
		end
	end

	if ShopData.IsGoodUnlock(arg_11_1, arg_11_2) == 0 then
		return 1
	end

	return 0
end

function var_0_1.AddEventListeners(arg_12_0)
	arg_12_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_13_0)
		if arg_13_0 > 0 and arg_13_0 == arg_12_0.curShopId_ then
			arg_12_0:RefreshList()
		end
	end)
	arg_12_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_14_0, arg_14_1)
		arg_12_0:RefreshShopGoodInfo(arg_14_0, arg_14_1)
	end)
	arg_12_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_15_0)
		arg_12_0:RefreshList(true)
	end)
end

function var_0_1.UpdateShopList(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0.curShopId_ then
		arg_16_0.giftList_:Refresh()
	end
end

function var_0_1.RefreshShopGoodInfo(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.curShopId_ ~= arg_17_1 then
		return
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.giftList_:GetItemList()) do
		if arg_17_2 == iter_17_1.goodId_ then
			iter_17_1:SetData(iter_17_1.index_, iter_17_1.shopId_, iter_17_1.goodId_)
		end
	end
end

function var_0_1.OnShopBuyResult(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_1 == 0 then
		arg_18_0:RefreshList(true)
	end
end

function var_0_1.OnTop(arg_19_0)
	return
end

function var_0_1.OnEnter(arg_20_0)
	arg_20_0:AddEventListeners()

	if arg_20_0.timer_ == nil then
		arg_20_0.timer_ = FrameTimer.New(function()
			if arg_20_0.giftList_ ~= nil then
				for iter_21_0, iter_21_1 in ipairs(arg_20_0.giftList_:GetItemList()) do
					iter_21_1:UpdateTimerView()
				end
			end
		end, 1, -1)

		arg_20_0.timer_:Start()
	end

	SetActive(arg_20_0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(arg_20_0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(arg_20_0.refundbtn_.gameObject, arg_20_0.curPageIndex_ ~= 4 and arg_20_0.curPageIndex_ ~= 6)
	end
end

function var_0_1.OnExit(arg_22_0)
	arg_22_0:RemoveAllEventListener()

	if arg_22_0.timer_ ~= nil then
		arg_22_0.timer_:Stop()

		arg_22_0.timer_ = nil
	end
end

function var_0_1.Hide(arg_23_0)
	var_0_1.super.Hide(arg_23_0)
end

function var_0_1.SetTreeRefreshHandler(arg_24_0, arg_24_1)
	arg_24_0.treeRefreshHandler_ = arg_24_1
end

function var_0_1.Dispose(arg_25_0)
	if arg_25_0.giftList_ then
		arg_25_0.giftList_:Dispose()

		arg_25_0.giftList_ = nil
	end

	arg_25_0.treeRefreshHandler_ = nil

	var_0_1.super.Dispose(arg_25_0)
end

return var_0_1
