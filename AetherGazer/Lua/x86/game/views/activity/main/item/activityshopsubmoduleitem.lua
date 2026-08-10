local var_0_0 = class("ActivityShopSubmoduleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.theme_ = ActivityCfg[arg_1_2].activity_theme
	arg_1_0.shopList_ = shopList

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.shopController_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:AddTimer()
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		local var_6_0 = arg_5_0.theme_
		local var_6_1 = {}
		local var_6_2 = {}

		if ActivityShopCfg.get_id_list_by_activity_theme[var_6_0] == nil then
			return
		end

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_0]) do
			table.insert(var_6_1, ShopListCfg[ActivityShopCfg[iter_6_1].shop_id].activity_id)
			table.insert(var_6_2, ActivityShopCfg[iter_6_1].shop_id)
		end

		if #var_6_1 <= 0 then
			return
		end

		local var_6_3
		local var_6_4 = 0
		local var_6_5 = var_6_2[1]

		for iter_6_2, iter_6_3 in ipairs(var_6_1) do
			local var_6_6 = ActivityData:GetActivityData(iter_6_3).stopTime - manager.time:GetServerTime()

			if var_6_6 > 0 and (var_6_4 == 0 or var_6_6 < var_6_4) then
				var_6_4 = var_6_6
				var_6_5 = var_6_2[iter_6_2]
			end
		end

		local var_6_7, var_6_8 = ShopTools.IsShopOpen(var_6_5)

		if var_6_7 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_5,
				showShops = var_6_2
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_8 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_8 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
end

function var_0_0.AddTimer(arg_7_0)
	arg_7_0:StopTimer()

	local var_7_0 = arg_7_0.theme_
	local var_7_1 = {}

	if ActivityShopCfg.get_id_list_by_activity_theme[var_7_0] == nil or arg_7_0.shopTimeText_ == nil then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_7_0]) do
		table.insert(var_7_1, ShopListCfg[ActivityShopCfg[iter_7_1].shop_id].activity_id)
	end

	if #var_7_1 <= 0 then
		return
	end

	local var_7_2
	local var_7_3 = 0

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		local var_7_4 = ActivityData:GetActivityData(iter_7_3).stopTime - manager.time:GetServerTime()

		if var_7_4 > 0 and (var_7_3 == 0 or var_7_4 < var_7_3) then
			var_7_3 = var_7_4
			var_7_2 = iter_7_3
		end
	end

	if var_7_2 == nil then
		arg_7_0.shopController_:SetSelectedState("off")

		return
	end

	local var_7_5 = ActivityData:GetActivityData(var_7_2).stopTime
	local var_7_6 = var_7_5 - manager.time:GetServerTime()

	if var_7_6 < 0 then
		arg_7_0.shopController_:SetSelectedState("off")

		return
	end

	local var_7_7 = true
	local var_7_8 = 432000

	if var_7_6 <= var_7_8 then
		arg_7_0.shopController_:SetSelectedState("on")

		arg_7_0.shopTimeText_.text = manager.time:GetLostTimeStr2(var_7_5, nil, true)
	else
		arg_7_0.shopController_:SetSelectedState("off")

		var_7_7 = false
	end

	arg_7_0.timer_ = Timer.New(function()
		var_7_6 = var_7_5 - manager.time:GetServerTime()

		if var_7_6 <= var_7_8 then
			if var_7_6 <= 0 then
				arg_7_0.shopController_:SetSelectedState("off")
				arg_7_0:StopTimer()
				arg_7_0:AddTimer()

				return
			end

			if var_7_7 then
				arg_7_0.shopController_:SetSelectedState("on")

				arg_7_0.shopTimeText_.text = manager.time:GetLostTimeStr2(var_7_5, nil, true)
				var_7_7 = false
			end

			arg_7_0.shopTimeText_.text = manager.time:GetLostTimeStr2(var_7_5, nil, true)
		elseif var_7_7 == false then
			arg_7_0.shopController_:SetSelectedState("off")

			var_7_7 = true
		end
	end, 1, -1)

	arg_7_0.timer_:Start()
end

function var_0_0.StopTimer(arg_9_0)
	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end
end

return var_0_0
