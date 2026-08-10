local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeOathRingShopPageView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.canBuyController = arg_1_0.controllers_:GetController("canbuy")
	arg_1_0.hasDiscountController = arg_1_0.controllers_:GetController("discount")
	arg_1_0.priceShowDiscountContrller = arg_1_0.controllers_:GetController("price")
	arg_1_0.showGetDiscountTicketController = arg_1_0.controllers_:GetController("canGetMoreTicket")
	arg_1_0.hasDiscountTicketController = arg_1_0.controllers_:GetController("hasTicket")
	arg_1_0.selectCouponDisplay = RechargeOathRingShopCouponItem.New(arg_1_0.curSelectCoupon_)

	arg_1_0.selectCouponDisplay:SetOnClick(function()
		JumpTools.OpenPageByJump("rechargeOathRingShopSelectCouponPop", {
			selectCoupon = arg_1_0.selectCoupon,
			okCallback = function(arg_3_0)
				arg_1_0.selectCoupon = arg_3_0

				arg_1_0:RefreshShop(false)
			end
		})
	end)

	function arg_1_0.onUpdateHandler()
		arg_1_0:OnUpdate()
	end
end

function var_0_1.Dispose(arg_5_0)
	arg_5_0.selectCouponDisplay:Dispose()
	var_0_1.super.Dispose(arg_5_0)
end

local var_0_2 = ItemConst.OATH_RING_COUPON
local var_0_3 = ItemConst.OATH_RING

function var_0_1.GetShopID()
	return ShopConst.SHOP_ID.OATH_RING_SHIP
end

function var_0_1.GetSelectCouponList(arg_7_0)
	local var_7_0 = arg_7_0.selectCoupon

	if var_7_0 then
		return {
			{
				num = 1,
				id = var_7_0.id,
				timeValid = var_7_0.timeValid
			}
		}
	else
		return nil
	end
end

function var_0_1.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.buyBtn_, nil, function()
		var_0_1.GoToBuyGood(arg_8_0:GetSelectCouponList())
	end)
	arg_8_0:AddBtnListener(arg_8_0.getMoreCouponBtn_, nil, function()
		ShowPopItemSourceWithCustomItemInfo({
			id = var_0_2
		}, {
			showTotalCntIgnoreTimeValid = true
		})
	end)
end

function var_0_1.AddEventListener(arg_11_0)
	arg_11_0:RegistEventListener(MATERIAL_MODIFY, function(arg_12_0, ...)
		if arg_12_0 == var_0_2 then
			arg_11_0:RefreshShop(false)
		end
	end)
	arg_11_0:RegistEventListener(MATERIAL_INIT, function()
		arg_11_0:RefreshShop(false)
	end)
end

function var_0_1.OnEnter(arg_14_0)
	arg_14_0:StartScheduleUpdate()
	arg_14_0:AddEventListener()
	arg_14_0:RefreshShop(true)
	manager.redPoint:setTip(RedPointConst.OATH_RING_COUPON_WILL_EXPIRE, 0)
end

function var_0_1.OnExit(arg_15_0)
	arg_15_0:StopScheduleUpdate()
	arg_15_0:RemoveAllEventListener()
end

function var_0_1.Show(arg_16_0)
	var_0_1.super.Show(arg_16_0)
	arg_16_0:RefreshShop(false)
	manager.redPoint:setTip(RedPointConst.OATH_RING_COUPON_WILL_EXPIRE, 0)
end

function var_0_1.StartScheduleUpdate(arg_17_0)
	arg_17_0:StopScheduleUpdate()

	arg_17_0.updateScheduler = FrameTimer.New(arg_17_0.onUpdateHandler, 1, -1)

	arg_17_0.updateScheduler:Start()
end

function var_0_1.StopScheduleUpdate(arg_18_0)
	if arg_18_0.updateScheduler then
		arg_18_0.updateScheduler:Stop()

		arg_18_0.updateScheduler = nil
	end
end

function var_0_1.OnUpdate(arg_19_0)
	if arg_19_0.selectCoupon then
		if arg_19_0:IsCurrentSelectCouponValid() then
			arg_19_0.selectCouponDisplay:UpdateLastTime()
		else
			arg_19_0:RefreshShop(true)
		end
	end
end

function var_0_1.RefreshShop(arg_20_0, arg_20_1)
	arg_20_0.allCoupon, arg_20_0.totalCouponCnt = var_0_1.CollectAllCoupon()

	if arg_20_1 or not arg_20_0:IsCurrentSelectCouponValid() then
		arg_20_0.selectCoupon = nil
	end

	if arg_20_0.selectCoupon == nil then
		arg_20_0.selectCoupon = var_0_1.AutoSelectCoupon(arg_20_0.allCoupon)
	end

	arg_20_0:RefreshSelectCouponDisplay()
	arg_20_0:RefreshPriceDisplay()

	local var_20_0 = arg_20_0:RefreshJumpToGetMoreCoupon()

	if arg_20_0.selectCoupon or var_20_0 then
		arg_20_0.hasDiscountController:SetSelectedState("have")
	else
		arg_20_0.hasDiscountController:SetSelectedState("no")
	end
end

local function var_0_4(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.id
	local var_21_1 = arg_21_0.num
	local var_21_2 = arg_21_0.timeValid or 0
	local var_21_3 = arg_21_1.id
	local var_21_4 = arg_21_1.num
	local var_21_5 = arg_21_1.timeValid or 0

	return var_21_0 == var_21_3 and var_21_2 == var_21_5
end

function var_0_1.IsCurrentSelectCouponValid(arg_22_0)
	if arg_22_0.selectCoupon then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.allCoupon) do
			if var_0_4(iter_22_1, arg_22_0.selectCoupon) and not ItemTools.IsItemExpired(arg_22_0.selectCoupon) then
				return true
			end
		end
	end

	return false
end

function var_0_1.OnShopBuyResult(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_3 == ShopConst.SHOP_ID.OATH_RING_SHIP and arg_23_1 == 0 then
		arg_23_0:RefreshShop(true)
	end
end

function var_0_1.RefreshSelectCouponDisplay(arg_24_0)
	if arg_24_0.selectCoupon then
		arg_24_0.hasDiscountTicketController:SetSelectedState("true")
		arg_24_0.selectCouponDisplay:SetData(arg_24_0.selectCoupon)

		arg_24_0.totalCnt_.text = GetTipsF("WEDDING_RING_BUY_TIPS2", arg_24_0.totalCouponCnt)
	else
		arg_24_0.hasDiscountTicketController:SetSelectedState("false")
	end
end

function var_0_1.RefreshPriceDisplay(arg_25_0)
	local var_25_0 = var_0_1.GetShopID()
	local var_25_1, var_25_2 = var_0_1.GetPaymentAndGoodsID(var_25_0, arg_25_0:GetSelectCouponList())
	local var_25_3, var_25_4 = var_0_1.GetPaymentAndGoodsID(var_25_0, nil)

	if ShopTools.GetDiscount(var_25_2) < 100 or arg_25_0.selectCoupon then
		arg_25_0.priceShowDiscountContrller:SetSelectedState("sale")

		local var_25_5 = ShopTools.GetPrice(var_25_2)
		local var_25_6 = GetTipsF("WEDDING_RING_PRICE_TIPS1", var_25_5)

		arg_25_0.price_.text = var_25_6
	else
		arg_25_0.priceShowDiscountContrller:SetSelectedState("default")

		local var_25_7 = GetTipsF("WEDDING_RING_PRICE_TIPS1", ShopTools.GetOriPrice(var_25_4))

		arg_25_0.price_.text = var_25_7
	end
end

local function var_0_5()
	local var_26_0 = ActivityTools.GetAnyOpenActivityByTemplate(ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN)

	if var_26_0 and not ActivityOathDrawData:IsGetSkinLastDrop(var_26_0) then
		return true
	end

	return false
end

function var_0_1.RefreshJumpToGetMoreCoupon(arg_27_0)
	local var_27_0 = OathTools.CheckAnySkinGiveBackOathRingCoupon()
	local var_27_1 = var_0_5()
	local var_27_2 = var_27_0 or var_27_1

	if var_27_2 then
		arg_27_0.showGetDiscountTicketController:SetSelectedState("true")
	else
		arg_27_0.showGetDiscountTicketController:SetSelectedState("false")
	end

	return var_27_2
end

function var_0_1.CollectAllCoupon()
	local var_28_0 = {}
	local var_28_1 = 0
	local var_28_2 = manager.time:GetServerTime()

	for iter_28_0, iter_28_1 in pairs(MaterialData:GetMaterialListById(var_0_2)) do
		if iter_28_0 == 0 or var_28_2 < iter_28_0 then
			local var_28_3 = {
				id = var_0_2,
				num = iter_28_1,
				timeValid = iter_28_0
			}

			table.insert(var_28_0, var_28_3)

			var_28_1 = var_28_1 + iter_28_1
		end
	end

	table.sort(var_28_0, function(arg_29_0, arg_29_1)
		return (arg_29_0.timeValid == 0 and math.huge or arg_29_0.timeValid) < (arg_29_1.timeValid == 0 and math.huge or arg_29_1.timeValid)
	end)

	return var_28_0, var_28_1
end

function var_0_1.AnyCouponAvailable(arg_30_0)
	local var_30_0 = manager.time:GetServerTime()

	for iter_30_0, iter_30_1 in ipairs(arg_30_0) do
		if iter_30_1.timeValid == 0 or var_30_0 < iter_30_1.timeValid then
			return true
		end
	end

	return false
end

function var_0_1.AutoSelectCoupon(arg_31_0)
	return nullable(arg_31_0, 1)
end

local function var_0_6(arg_32_0)
	local var_32_0 = getShopCfg(arg_32_0)

	return nullable(var_32_0, "cost_id")
end

function var_0_1.GetPaymentAndGoodsID(arg_33_0, arg_33_1)
	local var_33_0 = ShopTools.FilterShopDataList(arg_33_0)

	if arg_33_1 ~= nil then
		for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
			if iter_33_1.id == var_0_2 then
				local var_33_1 = var_33_0[2].id

				return var_0_6(var_33_1), var_33_1
			end
		end
	end

	local var_33_2 = var_33_0[1].id

	return var_0_6(var_33_2), var_33_2
end

function var_0_1.GoToBuyGood(arg_34_0, arg_34_1)
	if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	local var_34_0 = var_0_1.GetShopID()
	local var_34_1, var_34_2 = var_0_1.GetPaymentAndGoodsID(var_34_0, arg_34_0)

	SendMessageManagerToSDK("purchase_click_gp_once")

	local var_34_3 = 0
	local var_34_4 = OathTools.GetOathAvailableHeroCnt()

	if var_34_4 <= ItemTools.getItemNum(var_0_3) then
		local var_34_5

		if var_34_4 == 0 then
			var_34_5 = GetTips("WEDDING_RING_BUY_TIPS3")
		else
			var_34_5 = GetTips("WEDDING_RING_BUY_TIPS1")
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = var_34_5,
			OkCallback = function()
				PayAction.RequestGSPay(var_34_1, 1, var_34_0, var_34_2, var_34_3, arg_34_0, arg_34_1)
			end
		})
	else
		PayAction.RequestGSPay(var_34_1, 1, var_34_0, var_34_2, var_34_3, arg_34_0, arg_34_1)
	end
end

return var_0_1
