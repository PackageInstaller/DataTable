local var_0_0 = class("ShopEquipContentView", ShopContentViewBase)

function var_0_0.InitUI(arg_1_0)
	local var_1_0 = Asset.Load("UI/Shop/contentViews/equipView")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_0.containerGo_.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.list_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.listGo_, ExchangeItemView)
	arg_1_0.positionDropdown_ = arg_1_0.positionDropdownGo_.transform:GetComponent("Dropdown")
	arg_1_0.suitDropdown_ = arg_1_0.suitDropdownGo_.transform:GetComponent("Dropdown")
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddToggleListener(arg_2_0.positionDropdown_, function(arg_3_0)
		if arg_3_0 == 0 then
			arg_2_0.selectedPos = 0
		else
			arg_2_0.selectedPos = arg_3_0
		end

		arg_2_0:UpdateListByFilter()
	end)
	arg_2_0:AddToggleListener(arg_2_0.suitDropdown_, function(arg_4_0)
		if arg_4_0 == 0 then
			arg_2_0.selectedSuitId = 0

			OperationRecorder.Record("shop", "shop_equip_all")
		else
			arg_2_0.selectedSuitId = EquipSuitCfg[arg_2_0:GetShopSuits()[arg_4_0]].id

			OperationRecorder.Record("shop", "shop_equip_one")
		end

		arg_2_0:UpdateListByFilter()
	end)
end

function var_0_0.ResetFilter(arg_5_0)
	arg_5_0.positionDropdown_.value = 0
	arg_5_0.suitDropdown_.value = 0
end

function var_0_0.InitEquipDropdownData(arg_6_0)
	arg_6_0.positionDropdown_.options:Clear()

	local var_6_0 = GetTips("ALL_POSITION")
	local var_6_1 = ShopListCfg[arg_6_0.shopId_]

	if var_6_1.params ~= nil and #var_6_1.params > 0 and var_6_1.params[1].POS_ALL_LABEL ~= nil then
		var_6_0 = GetTips(var_6_1.params[1].POS_ALL_LABEL)
	end

	arg_6_0.positionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_6_0)))

	for iter_6_0 = 1, 6 do
		arg_6_0.positionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(GetTips("POSITION_TIP"), iter_6_0)))
	end

	arg_6_0.positionDropdown_:RefreshShownValue()
	arg_6_0.suitDropdown_.options:Clear()

	local var_6_2 = GetTips("ALL_EQUIP")

	if var_6_1.params ~= nil and #var_6_1.params > 0 and var_6_1.params[1].SUIT_ALL_LABEL ~= nil then
		var_6_2 = GetTips(var_6_1.params[1].SUIT_ALL_LABEL)
	end

	arg_6_0.suitDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_6_2), allIcon))

	local var_6_3 = arg_6_0:GetShopSuits()

	for iter_6_1 = 1, #var_6_3 do
		local var_6_4 = EquipSuitCfg[var_6_3[iter_6_1]]
		local var_6_5 = AtlasManager.GetSpriteWithoutAtlas(SpritePathCfg.EquipIcon_s.path .. var_6_4.equip_skill_icon)

		arg_6_0.suitDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_6_4.name, var_6_5))
	end

	arg_6_0.suitDropdown_:RefreshShownValue()
end

function var_0_0.GetShopSuits(arg_7_0)
	local var_7_0 = arg_7_0.shopId_
	local var_7_1 = {}
	local var_7_2 = HideInfoData:GetEquipSuitHideList()

	for iter_7_0, iter_7_1 in ipairs(ShopData.GetShop(var_7_0).shopItemIDs) do
		local var_7_3 = getShopCfg(iter_7_1, arg_7_0.shopId_)

		if var_7_3.taken_down == 0 then
			local var_7_4 = ItemCfg[var_7_3.give_id].type == ItemConst.ITEM_TYPE.EQUIP
			local var_7_5

			if var_7_4 then
				local var_7_6 = EquipCfg[var_7_3.give_id]

				if table.indexof(var_7_1, var_7_6.suit) == false and not var_7_2[var_7_6.suit] then
					table.insert(var_7_1, var_7_6.suit)
				end
			end
		end
	end

	return var_7_1
end

function var_0_0.UpdateListByFilter(arg_8_0)
	arg_8_0:RefreshList()
end

function var_0_0.RefreshList(arg_9_0, arg_9_1)
	var_0_0.super.RefreshList(arg_9_0, arg_9_1)

	arg_9_0.shopDataList_ = arg_9_0:GetShopGoodList(arg_9_0.shopId_)

	if arg_9_1 and arg_9_0.list_:GetNum() == #arg_9_0.shopDataList_ then
		arg_9_0.list_:Refresh()
	else
		arg_9_0.list_:StartScroll(#arg_9_0.shopDataList_)
	end

	arg_9_0:InitEquipDropdownData()
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:RegistCallBack(handler(arg_10_0, arg_10_0.OnShopClick))
	arg_10_2:SetData(arg_10_0.shopDataList_[arg_10_1])
end

function var_0_0.GetShopGoodList(arg_11_0)
	local var_11_0 = ShopTools.FilterShopDataList(arg_11_0.shopId_)
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_2 = iter_11_1.id
		local var_11_3 = getShopCfg(var_11_2, arg_11_0.shopId_)
		local var_11_4 = ItemCfg[var_11_3.give_id].type == ItemConst.ITEM_TYPE.EQUIP
		local var_11_5 = false
		local var_11_6 = false
		local var_11_7

		if var_11_4 then
			local var_11_8 = EquipCfg[var_11_3.give_id]

			var_11_5 = (arg_11_0.selectedSuitId == 0 or arg_11_0.selectedSuitId == nil or arg_11_0.selectedSuitId == var_11_8.suit) and true or false
			var_11_6 = (arg_11_0.selectedPos == 0 or arg_11_0.selectedPos == nil or arg_11_0.selectedPos == var_11_8.pos) and true or false
		end

		if var_11_4 then
			if var_11_5 and var_11_6 then
				table.insert(var_11_1, iter_11_1)
			end
		elseif (arg_11_0.selectedPos == 0 or arg_11_0.selectedPos == nil) and (arg_11_0.selectedSuitId == 0 or arg_11_0.selectedSuitId == nil) then
			table.insert(var_11_1, iter_11_1)
		end
	end

	return var_11_1
end

function var_0_0.ScrollByPosition(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_2 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.shopDataList_) do
			if iter_12_1.id == arg_12_2 then
				var_12_0 = iter_12_0

				break
			end
		end
	end

	if var_12_0 ~= nil then
		arg_12_0.list_:ScrollToIndex(var_12_0)
	elseif arg_12_1 then
		arg_12_0.list_:SetScrolledPosition(arg_12_1)
	end
end

function var_0_0.GetLuaList(arg_13_0)
	return arg_13_0.list_
end

function var_0_0.GetItemList(arg_14_0)
	return arg_14_0.list_:GetItemList()
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.list_ then
		arg_15_0.list_:Dispose()

		arg_15_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
