local SkinDiscountGiftEntranceView = class("SkinDiscountGiftEntranceView", ReduxView)

function SkinDiscountGiftEntranceView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SkinDiscountGiftEntranceItem)
end

function SkinDiscountGiftEntranceView:OnEnter()
	self:RefreshList()
	self:RefreshScrollView()
end

function SkinDiscountGiftEntranceView:OnExit()
	for iter_3_0, iter_3_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_3_1:OnExit()
	end
end

function SkinDiscountGiftEntranceView:Dispose()
	SkinDiscountGiftEntranceView.super.Dispose(self)
	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil
end

function SkinDiscountGiftEntranceView:AddListeners()
	return
end

function SkinDiscountGiftEntranceView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:Refresh(self.list_[arg_6_1])
end

function SkinDiscountGiftEntranceView:RefreshList()
	self.list_ = {}

	for iter_7_0, iter_7_1 in ipairs(SkinDiscountGiftTools.GetActivityList() or {}) do
		if SkinDiscountGiftTools.IsShowMain(iter_7_1) then
			table.insert(self.list_, iter_7_1)
		end
	end

	self.scrollHelper_:StartScroll(#self.list_)
end

function SkinDiscountGiftEntranceView:RefreshScrollView()
	if #self.list_ <= 0 then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	if #self.list_ > 1 then
		self.scrollView_.enabled = true
	else
		self.scrollView_.verticalNormalizedPosition = 0
		self.scrollView_.enabled = false
	end
end

return SkinDiscountGiftEntranceView
