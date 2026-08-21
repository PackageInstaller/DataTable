local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeSkinPageView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.goodTypeController_ = ControllerUtil.GetController(arg_1_0.transform_, "text")
	arg_1_0.skinList_ = LuaList.New(handler(arg_1_0, arg_1_0.indexItem), arg_1_0.listGo_, RechargeSkinNewItem)
end

function var_0_1.indexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:SetData(arg_2_0.skinDataList_[arg_2_1])
	arg_2_2:SetOutOfDateHandler(handler(arg_2_0, arg_2_0.OnItemOutOfDate))
end

function var_0_1.OnItemOutOfDate(arg_3_0, arg_3_1)
	arg_3_0:RefreshList()

	if #arg_3_0.skinDataList_ == 0 and arg_3_0.treeRefreshHandler_ ~= nil then
		arg_3_0.treeRefreshHandler_()
	end
end

function var_0_1.AddEventListeners(arg_4_0)
	arg_4_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_5_0)
		if arg_5_0 > 0 and arg_5_0 == arg_4_0.curShopId_ then
			arg_4_0:RefreshList()
		end
	end)
	arg_4_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_6_0, arg_6_1)
		arg_4_0:RefreshShopGoodInfo(arg_6_0, arg_6_1)
	end)
	arg_4_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_7_0)
		arg_4_0:RefreshList()
	end)
end

function var_0_1.AddUIListener(arg_8_0)
	if SDKTools.GetIsInputServer("kr") then
		arg_8_0:AddBtnListener(arg_8_0.refundbtn_, nil, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = {
					"Widget/System/Recharge/RefundPolicyKR_01"
				}
			})
		end)
	end

	if arg_8_0.fundsettlementmethodBtn_ and arg_8_0.commercialBtn_ then
		arg_8_0:AddBtnListener(arg_8_0.fundsettlementmethodBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		arg_8_0:AddBtnListener(arg_8_0.commercialBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end
end

function var_0_1.SwitchPage(arg_12_0, arg_12_1)
	arg_12_0.curShopId_ = arg_12_1
	arg_12_0.skinDataList_ = arg_12_0:InitDataList(arg_12_1)

	arg_12_0.skinList_:StartScroll(#arg_12_0.skinDataList_)
end

function var_0_1.RefreshList(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or false
	arg_13_0.skinDataList_ = arg_13_0:InitDataList(arg_13_0.curShopId_)

	if arg_13_1 then
		local var_13_0 = arg_13_0.skinList_:GetScrolledPosition()

		arg_13_0.skinList_:StartScrollByPosition(#arg_13_0.skinDataList_, var_13_0)
	elseif arg_13_0.skinList_ then
		arg_13_0.skinList_:StartScroll(#arg_13_0.skinDataList_)
	end
end

function var_0_1.InitDataList(arg_14_0, arg_14_1)
	local var_14_0 = ShopTools.FilterShopDataList(arg_14_1)
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = getShopCfg(iter_14_1.id).description
		local var_14_3 = RechargeShopDescriptionCfg[var_14_2]

		if SkinCfg[var_14_3.param[1]] then
			table.insert(var_14_1, iter_14_1)
		end
	end

	table.sort(var_14_1, function(arg_15_0, arg_15_1)
		local var_15_0 = var_0_1.CheckSkinOwn(arg_15_0.id) and 1 or 0
		local var_15_1 = var_0_1.CheckSkinOwn(arg_15_1.id) and 1 or 0

		if var_15_0 ~= var_15_1 then
			return var_15_0 < var_15_1
		end

		local var_15_2 = getShopCfg(arg_15_0.id)
		local var_15_3 = getShopCfg(arg_15_1.id)
		local var_15_4 = ShopTools.GetGoodStatus(arg_15_0.id)
		local var_15_5 = ShopTools.GetGoodStatus(arg_15_1.id)

		if var_15_4 ~= var_15_5 then
			return var_15_4 < var_15_5
		end

		if var_15_2.shop_sort ~= var_15_3.shop_sort then
			return var_15_2.shop_sort > var_15_3.shop_sort
		end

		return var_15_2.goods_id > var_15_3.goods_id
	end)

	return var_14_1
end

function var_0_1.CheckSkinOwn(arg_16_0)
	local var_16_0 = getShopCfg(arg_16_0)
	local var_16_1 = RechargeShopDescriptionCfg[var_16_0.description].param[1]
	local var_16_2 = SkinCfg[var_16_1]

	if ShopTools.HaveSkin(var_16_2.id) or HeroTools.CanChangeSkin(var_16_2.id) then
		return true
	else
		return false
	end

	return false
end

function var_0_1.GetGoodStatus(arg_17_0, arg_17_1)
	local var_17_0 = getShopCfg(arg_17_1).description
	local var_17_1 = RechargeShopDescriptionCfg[var_17_0].param[1]

	if ShopTools.HaveSkin(var_17_1) or HeroTools.CanChangeSkin(var_17_1) then
		return 2
	end

	if ShopData.IsGoodUnlock(arg_17_1) == 0 then
		return 1
	end

	return 0
end

function var_0_1.RefreshShopGoodInfo(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.curShopId_ ~= arg_18_1 then
		return
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.skinList_:GetItemList()) do
		if arg_18_2 == iter_18_1.goodId_ then
			iter_18_1:SetData(iter_18_1.index_, iter_18_1.shopId_, iter_18_1.goodId_)
		end
	end
end

function var_0_1.OnEnter(arg_19_0)
	arg_19_0:AddEventListeners()
	SetActive(arg_19_0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(arg_19_0.refundbtn_.gameObject, false)

	if arg_19_0.timer_ == nil then
		arg_19_0.timer_ = FrameTimer.New(function()
			if arg_19_0.skinList_ ~= nil then
				for iter_20_0, iter_20_1 in pairs(arg_19_0.skinList_:GetItemList()) do
					iter_20_1:UpdateTimerView()
				end
			end

			arg_19_0:UpdateTimer()
		end, 1, -1)

		arg_19_0.timer_:Start()
	end

	SetActive(arg_19_0.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(arg_19_0.refundGo_, not SDKTools.GetIsKorea())
	SetActive(arg_19_0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(arg_19_0.refundbtn_.gameObject, arg_19_0.curPageIndex_ ~= 4 and arg_19_0.curPageIndex_ ~= 6)
	end
end

function var_0_1.UpdateTimer(arg_21_0)
	return
end

function var_0_1.Show(arg_22_0)
	var_0_1.super.Show(arg_22_0)
	arg_22_0:RefreshList()
end

function var_0_1.OnExit(arg_23_0)
	if arg_23_0.timer_ ~= nil then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end
end

function var_0_1.Hide(arg_24_0)
	var_0_1.super.Hide(arg_24_0)
end

function var_0_1.SetTreeRefreshHandler(arg_25_0, arg_25_1)
	arg_25_0.treeRefreshHandler_ = arg_25_1
end

function var_0_1.Dispose(arg_26_0)
	arg_26_0:RemoveAllEventListener()

	if arg_26_0.skinList_ then
		arg_26_0.skinList_:Dispose()

		arg_26_0.skinList_ = nil
	end

	arg_26_0.treeRefreshHandler_ = nil

	var_0_1.super.Dispose(arg_26_0)
end

function var_0_1.OnBuySuccess(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0.curShopId_ == arg_27_2 or arg_27_2 == 54 then
		arg_27_0:RefreshList(true)
	end
end

return var_0_1
