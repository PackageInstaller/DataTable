local var_0_0 = class("ExchangeGlodByItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.isEmptyController_ = arg_1_0.controllerEx_:GetController("isEmpty")
	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshItem), arg_1_0.uiListGo_, CommonItemView)
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.dataList_ = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]
end

function var_0_0.OnEnter(arg_3_0)
	if not arg_3_0:HasMaterial() then
		arg_3_0.isEmptyController_:SetSelectedState("true")

		return
	else
		arg_3_0.isEmptyController_:SetSelectedState("false")
	end

	arg_3_0.selectIndex_ = 0
	arg_3_0.selectNum_ = 1
	arg_3_0.canUseMaxNum_ = 1

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.dataList_) do
		local var_3_0 = ItemTools.getItemNum(iter_3_1)

		if var_3_0 > 0 then
			arg_3_0.selectIndex_ = iter_3_0
			arg_3_0.selectNum_ = 1
			arg_3_0.canUseMaxNum_ = var_3_0

			break
		end
	end

	arg_3_0.uiList_:StartScroll(#arg_3_0.dataList_)
	arg_3_0:UpdatePreview(arg_3_0.selectNum_)
end

function var_0_0.OnExit(arg_4_0)
	arg_4_0.uiList_:StopRender()
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	arg_5_0.uiList_:Dispose()

	arg_5_0.uiList_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddPressingByTimeListener(arg_6_0.addBtn_.gameObject, 3, 0.5, 0.2, function()
		local var_7_0 = arg_6_0.selectNum_

		if var_7_0 >= arg_6_0.canUseMaxNum_ then
			return false
		end

		if arg_6_0.pressCnt_ > 1 then
			if arg_6_0.pressCnt_ == 2 then
				var_7_0 = var_7_0 + 9
			else
				var_7_0 = var_7_0 + 10
			end
		else
			var_7_0 = var_7_0 + 1
		end

		if var_7_0 < arg_6_0.canUseMaxNum_ then
			arg_6_0:UpdatePreview(var_7_0)

			return true
		end

		local var_7_1 = arg_6_0.canUseMaxNum_

		arg_6_0:UpdatePreview(var_7_1)

		return false
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.delBtn_.gameObject, 3, 0.5, 0.2, function()
		local var_8_0 = arg_6_0.selectNum_

		if var_8_0 <= 1 then
			return false
		end

		if arg_6_0.pressCnt_ > 1 then
			if arg_6_0.pressCnt_ == 2 then
				var_8_0 = var_8_0 - 9
			else
				var_8_0 = var_8_0 - 10
			end
		else
			var_8_0 = var_8_0 - 1
		end

		if var_8_0 > 1 then
			arg_6_0:UpdatePreview(var_8_0)

			return true
		end

		local var_8_1 = 1

		arg_6_0:UpdatePreview(var_8_1)

		return false
	end)
	arg_6_0:AddToggleListener(arg_6_0.slider_, function(arg_9_0)
		arg_6_0.selectNum_ = arg_9_0

		arg_6_0:UpdatePreview(arg_9_0)
	end)
end

function var_0_0.OnExchange(arg_10_0)
	local var_10_0 = arg_10_0.dataList_[arg_10_0.selectIndex_]

	CommonAction.TryToUseItem({
		{
			item_info = {
				id = var_10_0,
				num = arg_10_0.selectNum_
			},
			use_list = {}
		}
	})
end

function var_0_0.RefreshItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.dataList_[arg_11_1]
	local var_11_1 = ItemTools.getItemNum(var_11_0)
	local var_11_2 = clone(ItemTemplateData)

	var_11_2.id = var_11_0
	var_11_2.number = var_11_1
	var_11_2.need_count_down = true

	if arg_11_1 == arg_11_0.selectIndex_ then
		var_11_2.selectStyle = true
	else
		var_11_2.selectStyle = false
	end

	function var_11_2.clickFun(arg_12_0)
		if var_11_1 > 0 and arg_11_0.selectIndex_ ~= arg_11_1 then
			arg_11_0.selectIndex_ = arg_11_1
			arg_11_0.selectNum_ = 1
			arg_11_0.canUseMaxNum_ = var_11_1

			arg_11_0.uiList_:Refresh()
			arg_11_0:UpdatePreview(arg_11_0.selectNum_)
		end
	end

	arg_11_2:SetData(var_11_2)
	arg_11_2:RefreshGray(var_11_1 == 0)
end

function var_0_0.GetSelectTotalValue(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = arg_13_0.dataList_[arg_13_0.selectIndex_]
	local var_13_2 = 0

	for iter_13_0, iter_13_1 in pairs(ItemCfg[var_13_1].param or {}) do
		if iter_13_1[1] == CurrencyConst.CURRENCY_TYPE_GOLD then
			var_13_2 = iter_13_1[2]
		end
	end

	return var_13_2 * arg_13_0.selectNum_
end

function var_0_0.UpdatePreview(arg_14_0, arg_14_1)
	arg_14_0.selectNum_ = arg_14_1

	local var_14_0 = formatNumber(arg_14_0:GetSelectTotalValue())

	arg_14_0.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_LIST_EXCHANGE"), var_14_0, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_GOLD))
	arg_14_0.getNumText_.text = var_14_0
	arg_14_0.useCntText_.text = arg_14_1

	arg_14_0:RefreshSlider()
end

function var_0_0.RefreshSlider(arg_15_0)
	arg_15_0.slider_.maxValue = arg_15_0.canUseMaxNum_

	if arg_15_0.canUseMaxNum_ == 1 then
		arg_15_0.slider_.minValue = 0
		arg_15_0.slider_.interactable = false
	else
		arg_15_0.slider_.minValue = 1
		arg_15_0.slider_.interactable = true
	end

	if arg_15_0.slider_.value ~= arg_15_0.selectNum_ then
		arg_15_0.slider_.value = arg_15_0.selectNum_
	end

	arg_15_0.addBtn_.interactable = arg_15_0.selectNum_ < arg_15_0.canUseMaxNum_
	arg_15_0.delBtn_.interactable = arg_15_0.selectNum_ > 1
end

function var_0_0.HasMaterial(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.dataList_) do
		if ItemTools.getItemNum(iter_16_1) > 0 then
			return true
		end
	end

	return false
end

return var_0_0
