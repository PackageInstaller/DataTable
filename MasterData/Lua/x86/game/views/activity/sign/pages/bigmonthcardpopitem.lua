local BigMonthCardPopItem = class("BigMonthCardPopItem", ReduxView)

function BigMonthCardPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BigMonthCardPopItem:Init()
	self:BindCfgUI()

	self.commonItem_ = CommonItemView.New(self.commonitemGo_)
end

function BigMonthCardPopItem:RefreshData(arg_3_1)
	self.commonItem_:SetData(arg_3_1)
end

function BigMonthCardPopItem:SetText(arg_4_1)
	self.text_.text = arg_4_1
end

function BigMonthCardPopItem:OnExit()
	return
end

function BigMonthCardPopItem:Dispose()
	self.commonItem_:Dispose()
	self:RemoveAllListeners()

	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	self.super.Dispose(self)
end

return BigMonthCardPopItem
