local ExchangeFatigueByItem = class("ExchangeFatigueByItem", ReduxView)

function ExchangeFatigueByItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.isEmptyController_ = self.controllerEx_:GetController("isEmpty")
	self.uiList_ = LuaList.New(handler(self, self.RefreshItem), self.uiListGo_, CommonItemView)
end

function ExchangeFatigueByItem:InitData()
	self.dataList_ = StoreTools.GetMaterialListBySubTypes({
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY,
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID
	})

	table.sort(self.dataList_, function(arg_3_0, arg_3_1)
		local var_3_0 = ItemTools.GetItemExpiredTimeByInfo(arg_3_0) or 0
		local var_3_1 = ItemTools.GetItemExpiredTimeByInfo(arg_3_1) or 0

		if (var_3_0 > 0 and 1 or 0) ~= (var_3_1 > 0 and 1 or 0) then
			return (var_3_1 > 0 and 1 or 0) < (var_3_0 > 0 and 1 or 0)
		end

		if var_3_0 ~= var_3_1 then
			return var_3_0 < var_3_1
		end

		return arg_3_0.id < arg_3_1.id
	end)
end

function ExchangeFatigueByItem:OnEnter()
	if #self.dataList_ <= 0 then
		self.isEmptyController_:SetSelectedState("true")

		return
	else
		self.isEmptyController_:SetSelectedState("false")
	end

	self.selectDic_ = {}

	self.uiList_:StartScroll(#self.dataList_)
	self:UpdatePreview()
end

function ExchangeFatigueByItem:OnExit()
	self.uiList_:StopRender()
end

function ExchangeFatigueByItem:Dispose()
	ExchangeFatigueByItem.super.Dispose(self)
	self.uiList_:Dispose()

	self.uiList_ = nil
end

function ExchangeFatigueByItem:OnExchange()
	local var_7_0 = {}
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(self.selectDic_) do
		local var_7_2 = tonumber(string.split(iter_7_0, "_")[1])
		local var_7_3 = tonumber(string.split(iter_7_0, "_")[2] or 0)

		if iter_7_1 > 0 then
			var_7_1 = var_7_1 + iter_7_1

			table.insert(var_7_0, {
				item_info = {
					id = var_7_2,
					num = iter_7_1,
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

	if self:GetSelectTotalVitality() + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return false
	end

	CommonAction.TryToUseItem(var_7_0)
end

function ExchangeFatigueByItem:RefreshItem(arg_8_1, arg_8_2)
	local var_8_0 = self.dataList_[arg_8_1].id
	local var_8_1 = self.dataList_[arg_8_1].timeValid
	local var_8_2 = clone(ItemTemplateData)

	var_8_2.id = self.dataList_[arg_8_1].id
	var_8_2.number = self.dataList_[arg_8_1].num
	var_8_2.timeValid = self.dataList_[arg_8_1].timeValid
	var_8_2.need_count_down = true

	local var_8_3 = self:GetKey(self.dataList_[arg_8_1].id, self.dataList_[arg_8_1].timeValid)

	var_8_2.topAmountValue = self.selectDic_[var_8_3] or 0

	function var_8_2.longClickFun(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_2.dragging then
			return false
		end

		self:AddSelect(var_8_0, var_8_1)
		arg_8_2:RefreshTopAmount(self.selectDic_[var_8_3])
		self:UpdatePreview()

		return true
	end

	function var_8_2.clickAmountFun(arg_10_0)
		self:DeleteSelect(var_8_0, var_8_1)
		arg_8_2:RefreshTopAmount(self.selectDic_[var_8_3])
		self:UpdatePreview()

		return true
	end

	arg_8_2:SetData(var_8_2)
end

function ExchangeFatigueByItem:GetKey(arg_11_1, arg_11_2)
	return string.format("%d_%s", arg_11_1, tostring(arg_11_2))
end

function ExchangeFatigueByItem:AddSelect(arg_12_1, arg_12_2)
	local var_12_0 = self:GetKey(arg_12_1, arg_12_2)

	self.selectDic_[var_12_0] = self.selectDic_[var_12_0] or 0

	local var_12_1 = ItemTools.getItemNum(arg_12_1, arg_12_2)

	if self:GetSelectTotalVitality() + ItemCfg[arg_12_1].param[1][2] + ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return
	end

	self.selectDic_[var_12_0] = math.min(var_12_1, self.selectDic_[var_12_0] + 1)
end

function ExchangeFatigueByItem:DeleteSelect(arg_13_1, arg_13_2)
	local var_13_0 = self:GetKey(arg_13_1, arg_13_2)

	self.selectDic_[var_13_0] = self.selectDic_[var_13_0] or 0
	self.selectDic_[var_13_0] = math.max(self.selectDic_[var_13_0] - 1, 0)
end

function ExchangeFatigueByItem:GetSelectTotalVitality()
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self.selectDic_) do
		local var_14_1 = string.split(iter_14_0, "_")[2]

		var_14_0 = var_14_0 + ItemCfg[tonumber(string.split(iter_14_0, "_")[1])].param[1][2] * iter_14_1
	end

	return var_14_0
end

function ExchangeFatigueByItem:UpdatePreview()
	local var_15_0 = self:GetSelectTotalVitality()

	self.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_LIST_EXCHANGE"), var_15_0, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_VITALITY))
	self.getNumText_.text = var_15_0
end

function ExchangeFatigueByItem:HasMaterial()
	return #self.dataList_ > 0
end

return ExchangeFatigueByItem
