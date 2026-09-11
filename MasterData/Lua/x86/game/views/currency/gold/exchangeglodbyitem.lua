local ExchangeGlodByItem = class("ExchangeGlodByItem", ReduxView)

function ExchangeGlodByItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.isEmptyController_ = self.controllerEx_:GetController("isEmpty")
	self.uiList_ = LuaList.New(handler(self, self.RefreshItem), self.uiListGo_, CommonItemView)
end

function ExchangeGlodByItem:InitData()
	self.dataList_ = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]
end

function ExchangeGlodByItem:OnEnter()
	if not self:HasMaterial() then
		self.isEmptyController_:SetSelectedState("true")

		return
	else
		self.isEmptyController_:SetSelectedState("false")
	end

	self.selectIndex_ = 0
	self.selectNum_ = 1
	self.canUseMaxNum_ = 1

	for iter_3_0, iter_3_1 in ipairs(self.dataList_) do
		local var_3_0 = ItemTools.getItemNum(iter_3_1)

		if var_3_0 > 0 then
			self.selectIndex_ = iter_3_0
			self.selectNum_ = 1
			self.canUseMaxNum_ = var_3_0

			break
		end
	end

	self.uiList_:StartScroll(#self.dataList_)
	self:UpdatePreview(self.selectNum_)
end

function ExchangeGlodByItem:OnExit()
	self.uiList_:StopRender()
end

function ExchangeGlodByItem:Dispose()
	ExchangeGlodByItem.super.Dispose(self)
	self.uiList_:Dispose()

	self.uiList_ = nil
end

function ExchangeGlodByItem:AddListeners()
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		local var_7_0 = self.selectNum_

		if self.selectNum_ >= self.canUseMaxNum_ then
			return false
		end

		var_7_0 = self.pressCnt_ > 1 and (self.pressCnt_ == 2 and var_7_0 + 9 or var_7_0 + 10) or var_7_0 + 1

		if var_7_0 < self.canUseMaxNum_ then
			self:UpdatePreview(var_7_0)

			return true
		end

		self:UpdatePreview(self.canUseMaxNum_)

		return false
	end)
	self:AddPressingByTimeListener(self.delBtn_.gameObject, 3, 0.5, 0.2, function()
		local var_8_0 = self.selectNum_

		if self.selectNum_ <= 1 then
			return false
		end

		var_8_0 = self.pressCnt_ > 1 and (self.pressCnt_ == 2 and var_8_0 - 9 or var_8_0 - 10) or var_8_0 - 1

		if var_8_0 > 1 then
			self:UpdatePreview(var_8_0)

			return true
		end

		self:UpdatePreview(1)

		return false
	end)
	self:AddToggleListener(self.slider_, function(arg_9_0)
		self.selectNum_ = arg_9_0

		self:UpdatePreview(arg_9_0)
	end)
end

function ExchangeGlodByItem:OnExchange()
	CommonAction.TryToUseItem({
		{
			item_info = {
				id = self.dataList_[self.selectIndex_],
				num = self.selectNum_
			},
			use_list = {}
		}
	})
end

function ExchangeGlodByItem:RefreshItem(arg_11_1, arg_11_2)
	local var_11_0 = ItemTools.getItemNum(self.dataList_[arg_11_1])
	local var_11_1 = clone(ItemTemplateData)

	var_11_1.id = self.dataList_[arg_11_1]
	var_11_1.number = var_11_0
	var_11_1.need_count_down = true
	var_11_1.selectStyle = arg_11_1 == self.selectIndex_

	function var_11_1.clickFun(arg_12_0)
		if var_11_0 > 0 and self.selectIndex_ ~= arg_11_1 then
			self.selectIndex_ = arg_11_1
			self.selectNum_ = 1
			self.canUseMaxNum_ = var_11_0

			self.uiList_:Refresh()
			self:UpdatePreview(self.selectNum_)
		end
	end

	arg_11_2:SetData(var_11_1)
	arg_11_2:RefreshGray(var_11_0 == 0)
end

function ExchangeGlodByItem:GetSelectTotalValue()
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in pairs(ItemCfg[self.dataList_[self.selectIndex_]].param or {}) do
		if iter_13_1[1] == CurrencyConst.CURRENCY_TYPE_GOLD then
			var_13_1 = iter_13_1[2]
		end
	end

	return var_13_1 * self.selectNum_
end

function ExchangeGlodByItem:UpdatePreview(arg_14_1)
	self.selectNum_ = arg_14_1

	local var_14_0 = formatNumber(self:GetSelectTotalValue())

	self.tipsText_.text = string.format(GetTips("SELECT_MATERIAL_LIST_EXCHANGE"), var_14_0, ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_GOLD))
	self.getNumText_.text = var_14_0
	self.useCntText_.text = arg_14_1

	self:RefreshSlider()
end

function ExchangeGlodByItem:RefreshSlider()
	self.slider_.maxValue = self.canUseMaxNum_

	if self.canUseMaxNum_ == 1 then
		self.slider_.minValue = 0
		self.slider_.interactable = false
	else
		self.slider_.minValue = 1
		self.slider_.interactable = true
	end

	if self.slider_.value ~= self.selectNum_ then
		self.slider_.value = self.selectNum_
	end

	self.addBtn_.interactable = self.selectNum_ < self.canUseMaxNum_
	self.delBtn_.interactable = self.selectNum_ > 1
end

function ExchangeGlodByItem:HasMaterial()
	for iter_16_0, iter_16_1 in ipairs(self.dataList_) do
		if ItemTools.getItemNum(iter_16_1) > 0 then
			return true
		end
	end

	return false
end

return ExchangeGlodByItem
