local WindowActivityMatrixCoinItem = class("WindowActivityMatrixCoinItem", import("game.extend.ReduxView"))

function WindowActivityMatrixCoinItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.currencyType_ = arg_1_2

	self:Init()
end

function WindowActivityMatrixCoinItem:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:RefreshUI()

	self.isCanAdd_ = true
	self.isCanClick_ = false
end

function WindowActivityMatrixCoinItem:AddListeners()
	self:AddBtnListener(nil, nil, "OnClick")
	self:AddBtnListener(self.buttonIcon_, nil, function()
		manager.notify:Invoke(WINDOW_BAR_INFO, self.currencyType_, self.gameObject_)
		self:OnClick()
	end)
end

function WindowActivityMatrixCoinItem:OnClick()
	if self.materialType_ then
		ShowPopItem(POP_SOURCE_ITEM, {
			self.materialType_
		})
	end
end

function WindowActivityMatrixCoinItem:SetCanAdd(arg_6_1)
	if self.isCanAdd_ == arg_6_1 then
		return
	end

	self.isCanAdd_ = arg_6_1

	SetActive(self.add_, arg_6_1)
end

function WindowActivityMatrixCoinItem:SetCanClick(arg_7_1)
	self.isCanClick_ = arg_7_1
end

function WindowActivityMatrixCoinItem:RefreshUI()
	self.materialType_ = nil

	if self.activity_id and ActivityCfg[self.activity_id] then
		local var_8_0 = ActivityTools.GetActivityType(self.activity_id)

		if var_8_0 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
			local var_8_1 = ActivityMatrixTools.GetCoinItem(self.activity_id)

			self.icon_.sprite = ItemTools.getItemLittleSprite(var_8_1)
			self.text_.text = ActivityMatrixData:GetMatrixCoint(self.activity_id)
			self.materialType_ = var_8_1

			return
		elseif var_8_0 == ActivityTemplateConst.STRATEGY_MATRIX then
			local var_8_2 = StrategyMatrixTools.GetCoinItem(self.activity_id)

			self.icon_.sprite = ItemTools.getItemLittleSprite(var_8_2)
			self.text_.text = StrategyMatrixData:GetMatrixCoint(self.activity_id)
			self.materialType_ = var_8_2

			return
		end
	end

	self.icon_.sprite = nil
	self.text_.text = ""
end

function WindowActivityMatrixCoinItem:SetActivityId(arg_9_1)
	self.activity_id = arg_9_1

	self:RefreshUI()
end

function WindowActivityMatrixCoinItem:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 then
		self:RegistEventListener(ACTIVITY_MATRIX_PROCESS_CHANGE, handler(self, self.RefreshUI))
		self:RefreshUI()
		self.transform_:SetAsLastSibling()
	else
		self:RemoveAllEventListener()
	end
end

function WindowActivityMatrixCoinItem:UnBindListener()
	self:RemoveAllEventListener()
end

function WindowActivityMatrixCoinItem:Dispose()
	WindowActivityMatrixCoinItem.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return WindowActivityMatrixCoinItem
