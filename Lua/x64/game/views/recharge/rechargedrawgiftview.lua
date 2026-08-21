local var_0_0 = class("DrawGiftView", ReduxView)
local var_0_1 = 15

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeDrawGiftUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, RechargeGiftItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_bgmask, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	local var_7_0 = DrawTools.GetCostTicketList(arg_7_0.poolId)
	local var_7_1 = DrawTools.GetActivityCostTicket(arg_7_0.poolId)

	if var_7_1 == 0 or ItemTools.IsItemExpiredByItemId(var_7_1) then
		local var_7_2 = table.insertto(var_7_0, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})

		manager.windowBar:SwitchBar(var_7_2)
	else
		local var_7_3 = {}

		if ItemTools.getItemNum(var_7_1) > 0 then
			table.insert(var_7_3, var_7_1)
		end

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			table.insert(var_7_3, iter_7_1)
		end

		table.insertto(var_7_3, {
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SwitchBar(var_7_3)

		if ItemTools.getItemNum(var_7_1) > 0 then
			manager.windowBar:SetBarCanAdd(var_7_1, false)
			manager.windowBar:SetBarCanClick(var_7_1, true)
		end
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	arg_7_0.list:Refresh()
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.poolId = arg_8_0.params_.poolId

	arg_8_0:RefreshUI()
	arg_8_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_9_0)
		arg_8_0.list:Refresh()
	end)
	arg_8_0:RegistEventListener(CURRENCY_UPDATE, function(arg_10_0)
		arg_8_0.list:Refresh()
	end)
	arg_8_0:RegistEventListener(SHOP_BUY_SUCCESS, function(arg_11_0, arg_11_1)
		arg_8_0:RefreshUI()
	end)
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.recharge_shop_list = DrawTools.GetRechargeDrawGiftList(arg_12_0.poolId)

	arg_12_0.list:StartScroll(#arg_12_0.recharge_shop_list)
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData({
		id = arg_14_0.recharge_shop_list[arg_14_1]
	})
end

function var_0_0.OnItemOutOfDate(arg_15_0, arg_15_1)
	arg_15_0:RefreshUI()
end

function var_0_0.OnShopBuyResult(arg_16_0)
	arg_16_0.list:Refresh()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.list:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
