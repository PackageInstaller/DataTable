local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeSkinDlcPageView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.goodTypeController_ = ControllerUtil.GetController(arg_1_0.transform_, "text")

	local var_1_0 = arg_1_0.viewTrs_.rect.width
	local var_1_1 = arg_1_0.contTrs_:GetComponent("HorizontalLayoutGroup").spacing

	arg_1_0.loopScrollView_ = LoopScrollView.New(arg_1_0, arg_1_0.scrollEx_, arg_1_0.contTrs_, arg_1_0.viewTrs_, var_1_0, var_1_1, nil, true)
	arg_1_0.item1Pool = {}
	arg_1_0.item2Pool = {}
end

function var_0_1.OnItemOutOfDate(arg_2_0, arg_2_1)
	arg_2_0:RefreshList()

	if #arg_2_0.skinDataList_ == 0 and arg_2_0.treeRefreshHandler_ ~= nil then
		arg_2_0.treeRefreshHandler_()
	end
end

function var_0_1.AddEventListeners(arg_3_0)
	arg_3_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_4_0)
		if arg_4_0 > 0 and arg_4_0 == arg_3_0.curShopId_ then
			arg_3_0:RefreshList()
		end
	end)
	arg_3_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_5_0, arg_5_1)
		arg_3_0:RefreshShopGoodInfo(arg_5_0, arg_5_1)
	end)
	arg_3_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_6_0)
		arg_3_0:SwitchPage(arg_3_0.curShopId_)
	end)
end

function var_0_1.AddUIListener(arg_7_0)
	if SDKTools.GetIsInputServer("kr") then
		arg_7_0:AddBtnListener(arg_7_0.refundbtn_, nil, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = {
					"Widget/System/Recharge/RefundPolicyKR_01"
				}
			})
		end)
	end

	if arg_7_0.fundsettlementmethodBtn_ and arg_7_0.commercialBtn_ then
		arg_7_0:AddBtnListener(arg_7_0.fundsettlementmethodBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		arg_7_0:AddBtnListener(arg_7_0.commercialBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end
end

function var_0_1.SwitchPage(arg_11_0, arg_11_1)
	arg_11_0.curShopId_ = arg_11_1
	arg_11_0.skinDataList_ = arg_11_0:InitDataList(arg_11_1)

	arg_11_0.loopScrollView_:NavigateIndex(1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.loopScrollView_.rectGrid_)

	arg_11_0.loopScrollView_.scrollView_.horizontalNormalizedPosition = 0
end

function var_0_1.RefreshList(arg_12_0, arg_12_1)
	arg_12_0.loopScrollView_:NavigateIndex(arg_12_0.selectIndex_ or 1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.loopScrollView_.rectGrid_)

	arg_12_0.loopScrollView_.scrollView_.horizontalNormalizedPosition = 0

	if arg_12_0.timer_ == nil then
		arg_12_0.timer_ = FrameTimer.New(function()
			for iter_13_0, iter_13_1 in pairs(arg_12_0.item1Pool) do
				iter_13_1.itemView:UpdateTimerView()
			end

			for iter_13_2, iter_13_3 in pairs(arg_12_0.item2Pool) do
				iter_13_3.itemView:UpdateTimerView()
			end

			arg_12_0:UpdateTimer()
		end, 1, -1)

		arg_12_0.timer_:Start()
	end
end

function var_0_1.InitDataList(arg_14_0, arg_14_1)
	local var_14_0 = ShopTools.FilterShopDataList(arg_14_1)
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = getShopCfg(iter_14_1.id).description
		local var_14_3 = RechargeShopDescriptionCfg[var_14_2]

		if var_14_3 and var_14_3.type ~= 21 and SkinCfg[var_14_3.param[1]] then
			table.insert(var_14_1, iter_14_1)
		end
	end

	return ShopTools.CommonSort(var_14_1)
end

function var_0_1.GetGoodStatus(arg_15_0, arg_15_1)
	local var_15_0 = getShopCfg(arg_15_1).description
	local var_15_1 = RechargeShopDescriptionCfg[var_15_0].param[1]

	if ShopTools.HaveSkin(var_15_1) or HeroTools.CanChangeSkin(var_15_1) then
		return 2
	end

	if ShopData.IsGoodUnlock(arg_15_1) == 0 then
		return 1
	end

	return 0
end

function var_0_1.RefreshShopGoodInfo(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.curShopId_ ~= arg_16_1 then
		return
	end
end

function var_0_1.OnEnter(arg_17_0)
	arg_17_0:AddEventListeners()
	SetActive(arg_17_0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(arg_17_0.refundbtn_.gameObject, false)
	arg_17_0:RefreshList()
	SetActive(arg_17_0.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(arg_17_0.refundGo_, not SDKTools.GetIsKorea())
	SetActive(arg_17_0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(arg_17_0.refundbtn_.gameObject, arg_17_0.curPageIndex_ ~= 4 and arg_17_0.curPageIndex_ ~= 6)
	end
end

function var_0_1.UpdateTimer(arg_18_0)
	return
end

function var_0_1.Show(arg_19_0)
	var_0_1.super.Show(arg_19_0)
	arg_19_0:RefreshList()
end

function var_0_1.OnExit(arg_20_0)
	if arg_20_0.timer_ ~= nil then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end

	for iter_20_0, iter_20_1 in pairs(arg_20_0.item1Pool) do
		iter_20_1.itemView:OnExit()
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0.item2Pool) do
		iter_20_3.itemView:OnExit()
	end
end

function var_0_1.Hide(arg_21_0)
	var_0_1.super.Hide(arg_21_0)
end

function var_0_1.SetTreeRefreshHandler(arg_22_0, arg_22_1)
	arg_22_0.treeRefreshHandler_ = arg_22_1
end

function var_0_1.Dispose(arg_23_0)
	arg_23_0:RemoveAllEventListener()

	if arg_23_0.skinList_ then
		arg_23_0.skinList_:Dispose()

		arg_23_0.skinList_ = nil
	end

	arg_23_0.treeRefreshHandler_ = nil

	for iter_23_0, iter_23_1 in pairs(arg_23_0.item1Pool) do
		iter_23_1.itemView:Dispose()
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.item2Pool) do
		iter_23_3.itemView:Dispose()
	end

	arg_23_0.item1Pool = nil
	arg_23_0.item2Pool = nil
	arg_23_0.itemEquipPool = nil

	var_0_1.super.Dispose(arg_23_0)
end

function var_0_1.OnBuySuccess(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.curShopId_ == arg_24_2 or arg_24_2 == 54 then
		arg_24_0:RefreshList(true)
	end
end

function var_0_1.LsRemoveItem(arg_25_0, arg_25_1)
	arg_25_1.itemView:Show(false)

	arg_25_1.isFree = true
end

function var_0_1.GetFreeItem(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in pairs(arg_26_1) do
		if iter_26_1.isFree == true then
			iter_26_1.isFree = false

			return iter_26_1
		end
	end

	local var_26_0 = {
		isFree = false,
		itemView = arg_26_2()
	}

	table.insert(arg_26_1, var_26_0)

	return var_26_0
end

function var_0_1.LsAddItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0
	local var_27_1 = getShopCfg(arg_27_1.id)
	local var_27_2 = var_27_1.dlc ~= nil and var_27_1.dlc ~= 0
	local var_27_3

	if var_27_2 then
		var_27_3 = getShopCfg(var_27_1.dlc)
	end

	if var_27_2 and var_27_3 then
		var_27_0 = arg_27_0:GetFreeItem(arg_27_0.item1Pool, function()
			return RechargeSkinAllItem.New(arg_27_0.item1Go_, arg_27_0.contTrs_.gameObject)
		end)
	else
		var_27_0 = arg_27_0:GetFreeItem(arg_27_0.item2Pool, function()
			return RechargeSkinNormalItem.New(arg_27_0.item2Go_, arg_27_0.contTrs_.gameObject)
		end)
	end

	var_27_0.itemView:SetCallBack(function(arg_30_0)
		arg_27_0.selectIndex_ = arg_30_0
	end)
	var_27_0.itemView:SetData(arg_27_1, arg_27_2)

	return var_27_0
end

function var_0_1.LsGetItemData(arg_31_0)
	return arg_31_0.skinDataList_
end

function var_0_1.LsUpdateItem(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_1.itemView:SetData(arg_32_2, arg_32_3)
end

return var_0_1
