local var_0_0 = class("PolyhedronShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/PolyhedronBattle/PolyhedronShopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.shopList = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_shopList, PolyhedronShopItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_refreshBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("MATRIX_SHOP_REFRESH"), ItemTools.getItemName(arg_5_0.coinId), arg_5_0.refreshCost),
			OkCallback = function()
				PolyhedronAction.QueryRefreshShop()
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_addBloodBtn, nil, function()
		PolyhedronAction.QueryShopBloodReturn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_back, nil, function()
		gameContext:Go("/polyhedronBlank/polyhedronBattle")
	end)
end

function var_0_0.OnTop(arg_10_0)
	return
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:RefreshUI()
end

function var_0_0.OnExit(arg_12_0)
	LuaForCursor.SwitchCursor(false)
end

function var_0_0.RefreshUI(arg_13_0, arg_13_1)
	local var_13_0 = PolyhedronData:GetPolyhedronInfo()

	arg_13_0.polyhedronInfo = var_13_0
	arg_13_0.shops = var_13_0:GetShopItemList()

	if arg_13_1 then
		arg_13_0.shopList:StartScrollByPosition(#arg_13_0.shops, arg_13_1)
	else
		arg_13_0.shopList:StartScroll(#arg_13_0.shops)
	end

	arg_13_0.refreshCount = var_13_0:GetShopRefreshTimes()

	local var_13_1 = var_13_0:GetShopMaxRefreshTimes()
	local var_13_2 = var_13_0:GetShopFressRefreshTimes()

	arg_13_0.coinId = var_13_0:GetPolyhedronCoinId()

	if var_13_1 > arg_13_0.refreshCount then
		SetActive(arg_13_0.m_refreshContent, true)

		arg_13_0.refreshCost = 0
		arg_13_0.m_refreshCount.text = string.format("%d/%d", arg_13_0.refreshCount, var_13_1)

		if var_13_2 <= arg_13_0.refreshCount then
			local var_13_3 = arg_13_0.refreshCount - var_13_2

			arg_13_0.refreshCost = var_13_0:GetShopRefreshCost(var_13_3 + 1)
		else
			arg_13_0.refreshCost = 0
		end

		arg_13_0.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(arg_13_0.coinId)
		arg_13_0.m_refreshCost.text = arg_13_0.refreshCost
	else
		SetActive(arg_13_0.m_refreshContent, false)
	end

	arg_13_0.recoverCount = var_13_0:GetShopRecoverTimes()

	if var_13_0:GetShopRecoverMaxTimes() > arg_13_0.recoverCount then
		SetActive(arg_13_0.m_recoverContent, true)
	else
		SetActive(arg_13_0.m_recoverContent, false)
	end

	local var_13_4 = PolyhedronSettingCfg[PolyhedronConst.POLYHEDRON_SETTING_ID.SHOP_RECOVER].value[1]
	local var_13_5 = PolyhedronEffectCfg[var_13_4].params[1] / 10

	arg_13_0.m_addBloodDes.text = var_13_5 .. "%"
	arg_13_0.coinId = var_13_0:GetPolyhedronCoinId()
	arg_13_0.m_coinIcon.sprite = ItemTools.getItemLittleSprite(arg_13_0.coinId)
	arg_13_0.m_coinLab.text = var_13_0:GetCoinCount()
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.polyhedronInfo, arg_14_0.shops[arg_14_1])
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.shopList:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.OnPolyhedronGameUpdate(arg_16_0)
	local var_16_0 = arg_16_0.shopList:GetScrolledPosition()

	arg_16_0:RefreshUI(var_16_0)
end

function var_0_0.OnPolyhedronProcessUpdate(arg_17_0)
	local var_17_0 = arg_17_0.shopList:GetScrolledPosition()

	arg_17_0:RefreshUI(var_17_0)
end

return var_0_0
