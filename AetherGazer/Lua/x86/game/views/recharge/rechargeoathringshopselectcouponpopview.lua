local var_0_0 = class("RechargeOathRingShopSelectCouponPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeOathDiscountPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

local var_0_1 = ItemConst.OATH_RING_COUPON

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list = LuaList.New(function(...)
		arg_3_0:RenderItem(...)
	end, arg_3_0.list_, RechargeOathRingShopCouponItem)

	function arg_3_0.onCouponSelectHandler(arg_5_0)
		arg_3_0.selectIndex = arg_5_0.index
		arg_3_0.selectCoupon = arg_5_0.info

		arg_3_0.list:Refresh()
	end

	function arg_3_0.onUpdateHandler()
		arg_3_0:OnUpdate()
	end

	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		if arg_7_0.params_.okCallback then
			arg_7_0.params_.okCallback(arg_7_0.selectCoupon)
		end

		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, JumpTools.Back)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
	arg_9_0:RegistEventListener(MATERIAL_MODIFY, function(arg_10_0)
		if arg_10_0 == var_0_1 then
			arg_9_0:UpdateView()
		end
	end)
	arg_9_0:StartScheduleUpdate()
end

local function var_0_2(arg_11_0, arg_11_1)
	if nullable(arg_11_0, "id") == nullable(arg_11_1, "id") and nullable(arg_11_0, "timeValid") == nullable(arg_11_1, "timeValid") then
		return true
	end

	return false
end

local function var_0_3(arg_12_0)
	local var_12_0 = arg_12_0.selectIndex
	local var_12_1 = arg_12_0.selectCoupon

	if not var_0_2(nullable(arg_12_0.allCoupon, var_12_0), var_12_1) then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.allCoupon) do
			if var_0_2(iter_12_1, var_12_1) then
				arg_12_0.selectIndex = iter_12_0

				return
			end
		end

		arg_12_0.selectIndex = nil
	end
end

function var_0_0.UpdateView(arg_13_0)
	arg_13_0.allCoupon = var_0_0.CollectAllCoupon()
	arg_13_0.selectCoupon = arg_13_0.params_.selectCoupon or var_0_0.AutoSelectCoupon(arg_13_0.allCoupon)

	var_0_3(arg_13_0)
	arg_13_0.list:StartScroll(#arg_13_0.allCoupon)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:StopScheduleUpdate()
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.list:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.StartScheduleUpdate(arg_16_0)
	arg_16_0:StopScheduleUpdate()

	arg_16_0.updateScheduler = FrameTimer.New(arg_16_0.onUpdateHandler, 1, -1)

	arg_16_0.updateScheduler:Start()
end

function var_0_0.StopScheduleUpdate(arg_17_0)
	if arg_17_0.updateScheduler then
		arg_17_0.updateScheduler:Stop()

		arg_17_0.updateScheduler = nil
	end
end

function var_0_0.OnUpdate(arg_18_0)
	for iter_18_0 = 0, #arg_18_0.allCoupon do
		local var_18_0 = arg_18_0.list:GetItemByIndex(iter_18_0)

		if var_18_0 then
			var_18_0:UpdateLastTime()
		end
	end
end

function var_0_0.RenderItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_0.allCoupon[arg_19_1], arg_19_1)
	arg_19_2:SetOnClick(arg_19_0.onCouponSelectHandler)
	arg_19_2:SetSelected(arg_19_2.index == arg_19_0.selectIndex)
end

function var_0_0.CollectAllCoupon()
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

function var_0_0.AutoSelectCoupon(arg_22_0)
	return nullable(arg_22_0, 1)
end

return var_0_0
