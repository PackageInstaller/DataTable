local var_0_0 = class("ShopContentViewBase", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.containerGo_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.ScrollByPosition(arg_5_0, arg_5_1, arg_5_2)
	return
end

function var_0_0.ResetFilter(arg_6_0)
	return
end

function var_0_0.SetShopId(arg_7_0, arg_7_1)
	arg_7_0.shopId_ = arg_7_1
end

function var_0_0.SetShopHideHome(arg_8_0, arg_8_1)
	arg_8_0.hideHomeBtn_ = arg_8_1
end

function var_0_0.UpdateBarByShopId(arg_9_0)
	local var_9_0 = arg_9_0.shopId_
	local var_9_1 = {}

	table.insert(var_9_1, BACK_BAR)

	if arg_9_0.hideHomeBtn_ == nil or arg_9_0.hideHomeBtn_ == 0 then
		table.insert(var_9_1, HOME_BAR)
	end

	table.insert(var_9_1, NAVI_BAR)

	local var_9_2 = {}
	local var_9_3 = ShopListCfg[var_9_0]

	for iter_9_0 = 1, #var_9_3.cost_id do
		local var_9_4

		if CurrencyIdMapCfg[var_9_3.cost_id[iter_9_0]] then
			var_9_4 = CurrencyIdMapCfg[var_9_3.cost_id[iter_9_0]].item_id
		else
			var_9_4 = var_9_3.cost_id[iter_9_0]
		end

		if var_9_4 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			var_9_4 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(var_9_1, var_9_4)
		table.insert(var_9_2, var_9_4)
	end

	manager.windowBar:SwitchBar(var_9_1)

	for iter_9_1 = 1, #var_9_2 do
		local var_9_5 = var_9_2[iter_9_1]

		manager.windowBar:SetBarCanAdd(var_9_2[iter_9_1], ShopConst.ADD_CURRENCY[var_9_5] == true and _G.CHANNEL_MASTER_ID == 1)

		if var_9_5 == CurrencyIdMapCfg.CURRENCY_TYPE_DORM_GOLD.item_id then
			manager.windowBar:SetBarCanClick(var_9_5, true)
		end
	end
end

function var_0_0.OnShopClick(arg_10_0, arg_10_1)
	local var_10_0 = getShopCfg(arg_10_1.id, arg_10_0.shopId_)

	if ItemCfg[var_10_0.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		if ShopTools.HaveSkin(var_10_0.give_id) then
			return
		end
	elseif var_10_0.limit_num then
		if var_10_0.limit_num ~= -1 and var_10_0.limit_num <= arg_10_1.buyTime then
			return
		end

		local var_10_1, var_10_2 = ShopTools.JudgeIsLvLimit(var_10_0.level_limit)

		if var_10_1 then
			return
		end
	end

	JumpTools.OpenPopUp("shopBuy", {
		goodInfo = arg_10_1
	})
end

function var_0_0.GetShopGoodList(arg_11_0)
	return ShopTools.FilterShopDataList(arg_11_0.shopId_)
end

function var_0_0.GetLuaList(arg_12_0)
	return arg_12_0.list_
end

function var_0_0.GetItemList(arg_13_0)
	return
end

function var_0_0.RefreshShopGoodInfo(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0:GetItemList()) do
		local var_14_0 = iter_14_1:GetItemInfo()
		local var_14_1 = ShopData.GetShop(arg_14_0.shopId_)[arg_14_1]
		local var_14_2 = var_14_1 ~= nil and var_14_1.buy_times or 0

		if arg_14_1 == var_14_0.id and var_14_2 ~= var_14_0.buyTime then
			local var_14_3 = {
				id = arg_14_1,
				shopId = arg_14_0.shopId_,
				buyTime = var_14_2,
				next_refresh_timestamp = var_14_1.next_refresh_timestamp
			}

			iter_14_1:SetData(var_14_3)
		end
	end
end

function var_0_0.RefreshList(arg_15_0, arg_15_1)
	arg_15_0:UpdateBarByShopId()
end

function var_0_0.OnEnter(arg_16_0)
	return
end

function var_0_0.OnExit(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.GetScrolledPosition(arg_19_0)
	return arg_19_0:GetLuaList():GetScrolledPosition()
end

return var_0_0
