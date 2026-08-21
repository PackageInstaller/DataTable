local var_0_0 = class("ExchangeFatigueByItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.isEmptyController_ = arg_1_0.controllerEx_:GetController("isEmpty")
	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshItem), arg_1_0.uiListGo_, CommonItemView)
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.dataList_ = StoreTools.GetMaterialListBySubTypes({
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY,
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID
	})

	table.sort(arg_2_0.dataList_, function(arg_3_0, arg_3_1)
		local var_3_0 = ItemTools.GetItemExpiredTimeByInfo(arg_3_0) or 0
		local var_3_1 = ItemTools.GetItemExpiredTimeByInfo(arg_3_1) or 0
		local var_3_2 = var_3_0 > 0 and 1 or 0
		local var_3_3 = var_3_1 > 0 and 1 or 0

		if var_3_2 ~= var_3_3 then
			return var_3_3 < var_3_2
		end

		if var_3_0 ~= var_3_1 then
			return var_3_0 < var_3_1
		end

		return arg_3_0.id < arg_3_1.id
	end)
end

function var_0_0.OnEnter(arg_4_0)
	if #arg_4_0.dataList_ <= 0 then
		arg_4_0.isEmptyController_:SetSelectedState("true")

		return
	else
		arg_4_0.isEmptyController_:SetSelectedState("false")
	end

	arg_4_0.selectDic_ = {}

	arg_4_0.uiList_:StartScroll(#arg_4_0.dataList_)
	arg_4_0:UpdatePreview()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.uiList_:StopRender()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.uiList_:Dispose()

	arg_6_0.uiList_ = nil
end

function var_0_0.OnExchange(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0.selectDic_) do
		local var_7_2 = tonumber(string.split(iter_7_0, "_")[1])
		local var_7_3 = tonumber(string.split(iter_7_0, "_")[2] or 0)
		local var_7_4 = iter_7_1

		if var_7_4 > 0 then
			var_7_1 = var_7_1 + iter_7_1

			table.insert(var_7_0, {
				item_info = {
					id = var_7_2,
					num = var_7_4,
					time_valid = var_7_3
				},
				use_list = {}
			})
		end
	end

	if #var_7_0 == 0 or var_7_1 == 0 then
		ShowTips("TIP_CHOOSE_EMPTY")

		return
	end

	if arg_7_0:GetSelectTotalVitality() + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return false
	end

	CommonAction.TryToUseItem(var_7_0)
end

function var_0_0.RefreshItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.dataList_[arg_8_1].id
	local var_8_1 = arg_8_0.dataList_[arg_8_1].timeValid
	local var_8_2 = clone(ItemTemplateData)

	var_8_2.id = var_8_0
	var_8_2.number = arg_8_0.dataList_[arg_8_1].num
	var_8_2.timeValid = var_8_1
	var_8_2.need_count_down = true

	local var_8_3 = arg_8_0:GetKey(var_8_0, var_8_1)

	var_8_2.topAmountValue = arg_8_0.selectDic_[var_8_3] or 0

	function var_8_2.longClickFun(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_2.dragging then
			return false
		end

		arg_8_0:AddSelect(var_8_0, var_8_1)
		arg_8_2:RefreshTopAmount(arg_8_0.selectDic_[var_8_3])
		arg_8_0:UpdatePreview()

		return true
	end

	function var_8_2.clickAmountFun(arg_10_0)
		arg_8_0:DeleteSelect(var_8_0, var_8_1)
		arg_8_2:RefreshTopAmount(arg_8_0.selectDic_[var_8_3])
		arg_8_0:UpdatePreview()

		return true
	end

	arg_8_2:SetData(var_8_2)
end

function var_0_0.GetKey(arg_11_0, arg_11_1, arg_11_2)
	return string.format("%d_%s", arg_11_1, tostring(arg_11_2))
end

function var_0_0.AddSelect(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:GetKey(arg_12_1, arg_12_2)

	if not arg_12_0.selectDic_[var_12_0] then
		arg_12_0.selectDic_[var_12_0] = 0
	end

	local var_12_1 = ItemTools.getItemNum(arg_12_1, arg_12_2)
	local var_12_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_12_3 = ItemCfg[arg_12_1].param[1][2]

	if arg_12_0:GetSelectTotalVitality() + var_12_3 + var_12_2 > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return
	end

	arg_12_0.selectDic_[var_12_0] = math.min(var_12_1, arg_12_0.selectDic_[var_12_0] + 1)
end

function var_0_0.DeleteSelect(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetKey(arg_13_1, arg_13_2)

	if not arg_13_0.selectDic_[var_13_0] then
		arg_13_0.selectDic_[var_13_0] = 0
	end

	arg_13_0.selectDic_[var_13_0] = math.max(arg_13_0.selectDic_[var_13_0] - 1, 0)
end

function var_0_0.GetSelectTotalVitality(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.selectDic_) do
		local var_14_1 = tonumber(string.split(iter_14_0, "_")[1])
		local var_14_2 = string.split(iter_14_0, "_")[2]
		local var_14_3 = iter_14_1

		var_14_0 = var_14_0 + ItemCfg[var_14_1].param[1][2] * var_14_3
	end

	return var_14_0
end

function var_0_0.UpdatePreview(arg_15_0)
	local var_15_0 = arg_15_0:GetSelectTotalVitality()

	arg_15_0.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_LIST_EXCHANGE"), var_15_0, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_VITALITY))
	arg_15_0.getNumText_.text = var_15_0
end

function var_0_0.HasMaterial(arg_16_0)
	return #arg_16_0.dataList_ > 0
end

return var_0_0
