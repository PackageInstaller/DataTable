local RechargeOathRingShopSelectCouponPopView = class("RechargeOathRingShopSelectCouponPopView", ReduxView)

function RechargeOathRingShopSelectCouponPopView:UIName()
	return "Widget/System/Recharge/RechargeOathDiscountPopUI"
end

function RechargeOathRingShopSelectCouponPopView:UIParent()
	return manager.ui.uiPop.transform
end

local var_0_1 = ItemConst.OATH_RING_COUPON

function RechargeOathRingShopSelectCouponPopView:Init()
	self:BindCfgUI()

	self.list = LuaList.New(function(...)
		self:RenderItem(...)
	end, self.list_, RechargeOathRingShopCouponItem)

	function self:onCouponSelectHandler()
		self.selectIndex = self.index
		self.selectCoupon = self.info

		self.list:Refresh()
	end

	function self.onUpdateHandler()
		self:OnUpdate()
	end

	self:AddUIListener()
end

function RechargeOathRingShopSelectCouponPopView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.params_.okCallback then
			self.params_.okCallback(self.selectCoupon)
		end

		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, JumpTools.Back)
end

function RechargeOathRingShopSelectCouponPopView:OnEnter()
	self:UpdateView()
	self:RegistEventListener(MATERIAL_MODIFY, function(arg_10_0)
		if arg_10_0 == var_0_1 then
			self:UpdateView()
		end
	end)
	self:StartScheduleUpdate()
end

local function var_0_2(arg_11_0, arg_11_1)
	if nullable(arg_11_0, "id") == nullable(arg_11_1, "id") and nullable(arg_11_0, "timeValid") == nullable(arg_11_1, "timeValid") then
		return true
	end

	return false
end

local function var_0_3(arg_12_0)
	if not var_0_2(nullable(arg_12_0.allCoupon, arg_12_0.selectIndex), arg_12_0.selectCoupon) then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.allCoupon) do
			if var_0_2(iter_12_1, arg_12_0.selectCoupon) then
				arg_12_0.selectIndex = iter_12_0

				return
			end
		end

		arg_12_0.selectIndex = nil
	end
end

function RechargeOathRingShopSelectCouponPopView:UpdateView()
	self.allCoupon = RechargeOathRingShopSelectCouponPopView.CollectAllCoupon()
	self.selectCoupon = self.params_.selectCoupon or RechargeOathRingShopSelectCouponPopView.AutoSelectCoupon(self.allCoupon)

	var_0_3(self)
	self.list:StartScroll(#self.allCoupon)
end

function RechargeOathRingShopSelectCouponPopView:OnExit()
	self:StopScheduleUpdate()
	self:RemoveAllEventListener()
end

function RechargeOathRingShopSelectCouponPopView:Dispose()
	self.list:Dispose()
	RechargeOathRingShopSelectCouponPopView.super.Dispose(self)
end

function RechargeOathRingShopSelectCouponPopView:StartScheduleUpdate()
	self:StopScheduleUpdate()

	self.updateScheduler = FrameTimer.New(self.onUpdateHandler, 1, -1)

	self.updateScheduler:Start()
end

function RechargeOathRingShopSelectCouponPopView:StopScheduleUpdate()
	if self.updateScheduler then
		self.updateScheduler:Stop()

		self.updateScheduler = nil
	end
end

function RechargeOathRingShopSelectCouponPopView:OnUpdate()
	for iter_18_0 = 0, #self.allCoupon do
		local var_18_0 = self.list:GetItemByIndex(iter_18_0)

		if var_18_0 then
			var_18_0:UpdateLastTime()
		end
	end
end

function RechargeOathRingShopSelectCouponPopView:RenderItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.allCoupon[arg_19_1], arg_19_1)
	arg_19_2:SetOnClick(self.onCouponSelectHandler)
	arg_19_2:SetSelected(arg_19_2.index == self.selectIndex)
end

function RechargeOathRingShopSelectCouponPopView.CollectAllCoupon()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(MaterialData:GetMaterialListById(var_0_1)) do
		if iter_20_0 == 0 or iter_20_0 > manager.time:GetServerTime() then
			local var_20_1 = {
				num = 1,
				id = var_0_1
			}

			if iter_20_0 ~= 0 then
				var_20_1.timeValid = iter_20_0
			end

			for iter_20_2 = 1, iter_20_1 do
				table.insert(var_20_0, var_20_1)
			end
		end
	end

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		return (arg_21_0.timeValid or math.huge) < (arg_21_1.timeValid or math.huge)
	end)

	return var_20_0
end

function RechargeOathRingShopSelectCouponPopView:AutoSelectCoupon()
	return nullable(self, 1)
end

return RechargeOathRingShopSelectCouponPopView
