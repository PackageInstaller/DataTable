local FragmentExchangeItem = class("FragmentExchangeItem", ReduxView)

function FragmentExchangeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function FragmentExchangeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function FragmentExchangeItem:InitUI()
	self:BindCfgUI()

	self.commonItem = CommonItemView.New(self.commonItem_, true)
end

function FragmentExchangeItem:AddUIListener()
	return
end

function FragmentExchangeItem:SetData(arg_5_1, arg_5_2)
	self.data = arg_5_1
	self.number = arg_5_2

	self:UpdateView()
end

function FragmentExchangeItem:UpdateView()
	CommonTools.SetCommonData(self.commonItem, self.data)

	self.numTxt_.text = "x " .. self.number
	self.nameTxt_.text = ItemTools.getItemName(self.data.id)
end

function FragmentExchangeItem:OnEnter()
	return
end

function FragmentExchangeItem:OnExit()
	return
end

function FragmentExchangeItem:Dispose()
	FragmentExchangeItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return FragmentExchangeItem
