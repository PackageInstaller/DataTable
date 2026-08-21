local var_0_0 = class("FishingGroupPageView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uiListGo_, FishingIllustratedItemView)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.fishIdList_[arg_4_1])
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.AddEventListeners(arg_6_0)
	arg_6_0:RegistEventListener(CURRENCY_UPDATE, function(arg_7_0)
		if arg_7_0 == 0 or arg_7_0 == CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN then
			arg_6_0.coinValueLabel_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
		end
	end)
	arg_6_0:RegistEventListener(FISHING_GROUP_REWARD_CHANGE, function()
		arg_6_0.uiList_:Refresh()
	end)
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_10_0)
	return
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
	arg_11_0:SortData()
	arg_11_0:UpdateView()
end

function var_0_0.SortData(arg_12_0)
	arg_12_0.fishIdList_ = RareFishCfg.all

	table.sort(arg_12_0.fishIdList_, function(arg_13_0, arg_13_1)
		local var_13_0 = FishingData:GetFish(arg_13_0)
		local var_13_1 = FishingData:GetFish(arg_13_1)
		local var_13_2 = RareFishCfg[arg_13_0]
		local var_13_3 = RareFishCfg[arg_13_1]

		if var_13_0 == nil and var_13_1 ~= nil or var_13_0 ~= nil and var_13_1 == nil then
			return var_13_0 ~= nil
		end

		if var_13_2.rare ~= var_13_3.rare then
			return var_13_2.rare > var_13_3.rare
		end

		return var_13_2.id < var_13_3.id
	end)
end

function var_0_0.UpdateView(arg_14_0)
	arg_14_0:SortData()
	arg_14_0.uiList_:StartScroll(#arg_14_0.fishIdList_)

	arg_14_0.coinValueLabel_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.uiList_ then
		arg_17_0.uiList_:Dispose()

		arg_17_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
