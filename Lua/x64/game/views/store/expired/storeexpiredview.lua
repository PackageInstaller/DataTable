local var_0_0 = class("StoreExpiredView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bag/BagExpiredUI"
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

	arg_4_0.haveBonusController_ = arg_4_0.controllerEx_:GetController("haveBonus")
	arg_4_0.expiredItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexExpiredItem), arg_4_0.expiredListGo_, CommonItemView)
	arg_4_0.expiredItemList2_ = LuaList.New(handler(arg_4_0, arg_4_0.indexExpiredItem), arg_4_0.expiredListGo2_, CommonItemView)
	arg_4_0.getItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexGetItem), arg_4_0.getListGo_, CommonItemView)
end

function var_0_0.indexGetItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = arg_5_0.getItemDataList_[arg_5_1].id
	var_5_0.number = arg_5_0.getItemDataList_[arg_5_1].num

	arg_5_2:SetData(var_5_0)
end

function var_0_0.indexExpiredItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.expiredList_[arg_6_1]
	local var_6_1 = clone(ItemTemplateData)

	var_6_1.id = var_6_0.id
	var_6_1.number = var_6_0.num
	var_6_1.transform = var_6_0.transform

	arg_6_2:SetData(var_6_1)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.okBtn2_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.expiredList_ = arg_10_0.params_.expiredList

	local var_10_0 = {}

	arg_10_0.getItemDataList_ = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.expiredList_) do
		local var_10_1 = iter_10_1.id
		local var_10_2 = iter_10_1.num
		local var_10_3 = ItemCfg[var_10_1]

		if var_10_3.time_exchange_item then
			if not var_10_0[var_10_3.time_exchange_item[1]] then
				var_10_0[var_10_3.time_exchange_item[1]] = var_10_3.time_exchange_item[2] * var_10_2
			else
				var_10_0[var_10_3.time_exchange_item[1]] = var_10_0[var_10_3.time_exchange_item[1]] + var_10_3.time_exchange_item[2] * var_10_2
			end

			iter_10_1.transform = true
		end
	end

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		table.insert(arg_10_0.getItemDataList_, {
			id = iter_10_2,
			num = iter_10_3
		})
	end

	if #arg_10_0.getItemDataList_ > 0 then
		arg_10_0.haveBonusController_:SetSelectedState("true")
		arg_10_0.expiredItemList_:StartScroll(#arg_10_0.expiredList_)
		arg_10_0.getItemList_:StartScroll(#arg_10_0.getItemDataList_)
	else
		arg_10_0.expiredItemList2_:StartScroll(#arg_10_0.expiredList_)
		arg_10_0.haveBonusController_:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.expiredItemList_:Dispose()

	arg_12_0.expiredItemList_ = nil

	arg_12_0.expiredItemList2_:Dispose()

	arg_12_0.expiredItemList2_ = nil

	arg_12_0.getItemList_:Dispose()

	arg_12_0.getItemList_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
