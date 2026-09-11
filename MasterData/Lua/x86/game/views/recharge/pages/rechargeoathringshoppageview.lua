local RechargeOathRingShopPageView = class("RechargeOathRingShopPageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeOathRingShopPageView:InitUI()
	self:BindCfgUI()

	self.canBuyController = self.controllers_:GetController("canbuy")
	self.hasDiscountController = self.controllers_:GetController("discount")
	self.priceShowDiscountContrller = self.controllers_:GetController("price")
	self.showGetDiscountTicketController = self.controllers_:GetController("canGetMoreTicket")
	self.hasDiscountTicketController = self.controllers_:GetController("hasTicket")
	self.selectCouponDisplay = RechargeOathRingShopCouponItem.New(self.curSelectCoupon_)

	self.selectCouponDisplay:SetOnClick(function()
		JumpTools.OpenPageByJump("rechargeOathRingShopSelectCouponPop", {
			selectCoupon = self.selectCoupon,
			okCallback = function(arg_3_0)
				self.selectCoupon = arg_3_0

				self:RefreshShop(false)
			end
		})
	end)

	function self.onUpdateHandler()
		self:OnUpdate()
	end
end

function RechargeOathRingShopPageView:Dispose()
	self.selectCouponDisplay:Dispose()
	RechargeOathRingShopPageView.super.Dispose(self)
end

local var_0_1 = ItemConst.OATH_RING_COUPON
local var_0_2 = ItemConst.OATH_RING

function RechargeOathRingShopPageView.GetShopID()
	return ShopConst.SHOP_ID.OATH_RING_SHIP
end

function RechargeOathRingShopPageView:GetSelectCouponList()
	if self.selectCoupon then
		return {
			{
				num = 1,
				id = self.selectCoupon.id,
				timeValid = self.selectCoupon.timeValid
			}
		}
	else
		return nil
	end
end

function RechargeOathRingShopPageView:AddUIListener()
	self:AddBtnListener(self.buyBtn_, nil, function()
		RechargeOathRingShopPageView.GoToBuyGood(self:GetSelectCouponList())
	end)
	self:AddBtnListener(self.getMoreCouponBtn_, nil, function()
		ShowPopItemSourceWithCustomItemInfo({
			id = var_0_1
		}, {
			showTotalCntIgnoreTimeValid = true
		})
	end)
end

function RechargeOathRingShopPageView:AddEventListener()
	self:RegistEventListener(MATERIAL_MODIFY, function(arg_12_0, ...)
		if arg_12_0 == var_0_1 then
			self:RefreshShop(false)
		end
	end)
	self:RegistEventListener(MATERIAL_INIT, function()
		self:RefreshShop(false)
	end)
end

function RechargeOathRingShopPageView:OnEnter()
	self:StartScheduleUpdate()
	self:AddEventListener()
	self:RefreshShop(true)
	manager.redPoint:setTip(RedPointConst.OATH_RING_COUPON_WILL_EXPIRE, 0)
end

function RechargeOathRingShopPageView:OnExit()
	self:StopScheduleUpdate()
	self:RemoveAllEventListener()
end

function RechargeOathRingShopPageView:Show()
	RechargeOathRingShopPageView.super.Show(self)
	self:RefreshShop(false)
	manager.redPoint:setTip(RedPointConst.OATH_RING_COUPON_WILL_EXPIRE, 0)
end

function RechargeOathRingShopPageView:StartScheduleUpdate()
	self:StopScheduleUpdate()

	self.updateScheduler = FrameTimer.New(self.onUpdateHandler, 1, -1)

	self.updateScheduler:Start()
end

function RechargeOathRingShopPageView:StopScheduleUpdate()
	if self.updateScheduler then
		self.updateScheduler:Stop()

		self.updateScheduler = nil
	end
end

function RechargeOathRingShopPageView:OnUpdate()
	if self.selectCoupon then
		if self:IsCurrentSelectCouponValid() then
			self.selectCouponDisplay:UpdateLastTime()
		else
			self:RefreshShop(true)
		end
	end
end

function RechargeOathRingShopPageView:RefreshShop(arg_20_1)
	self.allCoupon, self.totalCouponCnt = RechargeOathRingShopPageView.CollectAllCoupon()

	if arg_20_1 or not self:IsCurrentSelectCouponValid() then
		self.selectCoupon = nil
	end

	if self.selectCoupon == nil then
		self.selectCoupon = RechargeOathRingShopPageView.AutoSelectCoupon(self.allCoupon)
	end

	self:RefreshSelectCouponDisplay()
	self:RefreshPriceDisplay()

	if self.selectCoupon or self:RefreshJumpToGetMoreCoupon() then
		self.hasDiscountController:SetSelectedState("have")
	else
		self.hasDiscountController:SetSelectedState("no")
	end
end

local function var_0_3(arg_21_0, arg_21_1)
	return arg_21_0.id == arg_21_1.id and (arg_21_0.timeValid or 0) == (arg_21_1.timeValid or 0)
end

function RechargeOathRingShopPageView:IsCurrentSelectCouponValid()
	if self.selectCoupon then
		for iter_22_0, iter_22_1 in ipairs(self.allCoupon) do
			if var_0_3(iter_22_1, self.selectCoupon) and not ItemTools.IsItemExpired(self.selectCoupon) then
				return true
			end
		end
	end

	return false
end

function RechargeOathRingShopPageView:OnShopBuyResult(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_3 == ShopConst.SHOP_ID.OATH_RING_SHIP and arg_23_1 == 0 then
		self:RefreshShop(true)
	end
end

function RechargeOathRingShopPageView:RefreshSelectCouponDisplay()
	if self.selectCoupon then
		self.hasDiscountTicketController:SetSelectedState("true")
		self.selectCouponDisplay:SetData(self.selectCoupon)

		self.totalCnt_.text = GetTipsF("WEDDING_RING_BUY_TIPS2", self.totalCouponCnt)
	else
		self.hasDiscountTicketController:SetSelectedState("false")
	end
end

function RechargeOathRingShopPageView:RefreshPriceDisplay()
	local var_25_0 = RechargeOathRingShopPageView.GetShopID()
	local var_25_1, var_25_2 = RechargeOathRingShopPageView.GetPaymentAndGoodsID(var_25_0, self:GetSelectCouponList())
	local var_25_3, var_25_4 = RechargeOathRingShopPageView.GetPaymentAndGoodsID(var_25_0, nil)

	if ShopTools.GetDiscount(var_25_2) < 100 or self.selectCoupon then
		self.priceShowDiscountContrller:SetSelectedState("sale")

		self.price_.text = GetTipsF("WEDDING_RING_PRICE_TIPS1", (ShopTools.GetPrice(var_25_2)))
	else
		self.priceShowDiscountContrller:SetSelectedState("default")

		self.price_.text = GetTipsF("WEDDING_RING_PRICE_TIPS1", ShopTools.GetOriPrice(var_25_4))
	end
end

local function var_0_4()
	local var_26_0 = ActivityTools.GetAnyOpenActivityByTemplate(ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN)

	if var_26_0 and not ActivityOathDrawData:IsGetSkinLastDrop(var_26_0) then
		return true
	end

	return false
end

function RechargeOathRingShopPageView:RefreshJumpToGetMoreCoupon()
	local var_27_0 = OathTools.CheckAnySkinGiveBackOathRingCoupon() or var_0_4()

	if var_27_0 then
		self.showGetDiscountTicketController:SetSelectedState("true")
	else
		self.showGetDiscountTicketController:SetSelectedState("false")
	end

	return var_27_0
end

function RechargeOathRingShopPageView.CollectAllCoupon()
	local var_28_0 = {}
	local var_28_1 = 0
	local var_28_2 = manager.time:GetServerTime()

	for iter_28_0, iter_28_1 in pairs(MaterialData:GetMaterialListById(var_0_1)) do
		if iter_28_0 ~= 0 then
			if var_28_2 < iter_28_0 then
				table.insert(var_28_0, {
					id = var_0_1,
					num = iter_28_1,
					timeValid = iter_28_0
				})

				var_28_1 = var_28_1 + iter_28_1
			end
		end
	end

	table.sort(var_28_0, function(arg_29_0, arg_29_1)
		local var_29_0

		if arg_29_0.timeValid == 0 then
			var_29_0 = math.huge or arg_29_0.timeValid

			local var_29_1

			if arg_29_1.timeValid == 0 then
				var_29_1 = math.huge or arg_29_1.timeValid
			end
		end

		return var_29_0 < var_29_1
	end)

	return var_28_0, var_28_1
end

function RechargeOathRingShopPageView:AnyCouponAvailable()
	local var_30_0 = manager.time:GetServerTime()

	for iter_30_0, iter_30_1 in ipairs(self) do
		if iter_30_1.timeValid == 0 or var_30_0 < iter_30_1.timeValid then
			return true
		end
	end

	return false
end

function RechargeOathRingShopPageView:AutoSelectCoupon()
	return nullable(self, 1)
end

local function var_0_5(arg_32_0)
	return nullable(getShopCfg(arg_32_0), "cost_id")
end

function RechargeOathRingShopPageView:GetPaymentAndGoodsID(arg_33_1)
	local var_33_0 = ShopTools.FilterShopDataList(self)

	if arg_33_1 ~= nil then
		for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
			if iter_33_1.id == var_0_1 then
				return var_0_5(var_33_0[2].id), var_33_0[2].id
			end
		end
	end

	return var_0_5(var_33_0[1].id), var_33_0[1].id
end

function RechargeOathRingShopPageView:GoToBuyGood(arg_34_1)
	if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	local var_34_0 = RechargeOathRingShopPageView.GetShopID()
	local var_34_1, var_34_2 = RechargeOathRingShopPageView.GetPaymentAndGoodsID(var_34_0, self)

	SendMessageManagerToSDK("purchase_click_gp_once")

	local var_34_3 = 0
	local var_34_4 = OathTools.GetOathAvailableHeroCnt()

	if var_34_4 <= ItemTools.getItemNum(var_0_2) then
		local var_34_5 = var_34_4 == 0 and GetTips("WEDDING_RING_BUY_TIPS3") or GetTips("WEDDING_RING_BUY_TIPS1")

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = var_34_5,
			OkCallback = function()
				PayAction.RequestGSPay(var_34_1, 1, var_34_0, var_34_2, var_34_3, self, arg_34_1)
			end
		})
	else
		PayAction.RequestGSPay(var_34_1, 1, var_34_0, var_34_2, var_34_3, self, arg_34_1)
	end
end

return RechargeOathRingShopPageView
