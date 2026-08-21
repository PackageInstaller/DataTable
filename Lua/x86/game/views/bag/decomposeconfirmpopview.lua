local var_0_0 = class("DecomposeConfirmPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bag/SplitGetPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemScroller_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.itemListGo_, CommonItemView)
	arg_4_0.returnScroller_ = LuaList.New(handler(arg_4_0, arg_4_0.indexReturnItem), arg_4_0.returnListGo_, CommonItemView)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnConfirm_, nil, function()
		if arg_5_0.type_ == "equip" then
			EquipAction.EquipDecompose(arg_5_0.params_.itemList)
		elseif arg_5_0.type_ == "servant" then
			ServantAction.ServantDecompose(arg_5_0.params_.itemList)
		end

		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.type_ = arg_8_0.params_.type
	arg_8_0.itemList_ = arg_8_0:SortItem(arg_8_0.params_.itemList)
	arg_8_0.returnList_ = arg_8_0.params_.returnList

	arg_8_0.itemScroller_:StartScroll(#arg_8_0.itemList_)
	arg_8_0.returnScroller_:StartScroll(#arg_8_0.returnList_)
end

function var_0_0.SortItem(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		table.insert(var_9_0, iter_9_1)
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.id or arg_10_0.prefab_id
		local var_10_1 = arg_10_1.id or arg_10_1.prefab_id

		return ItemCfg[var_10_0].rare < ItemCfg[var_10_1].rare
	end)

	return var_9_0
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = clone(ItemTemplateData)
	local var_11_1 = arg_11_0.itemList_[arg_11_1]

	var_11_0.id = arg_11_0.type_ == "equip" and var_11_1.prefab_id or var_11_1.id
	var_11_0.hideBottomRightTextFlag = true

	if arg_11_0.type_ == "equip" then
		var_11_0.equipLevel = EquipTools.CountEquipLevel(var_11_1)
	end

	arg_11_2:SetData(var_11_0)
end

function var_0_0.indexReturnItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = clone(ItemTemplateData)
	local var_12_1 = arg_12_0.returnList_[arg_12_1]

	var_12_0.id = var_12_1.id
	var_12_0.number = var_12_1.number

	arg_12_2:SetData(var_12_0)
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.itemScroller_:Dispose()
	arg_14_0.returnScroller_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
