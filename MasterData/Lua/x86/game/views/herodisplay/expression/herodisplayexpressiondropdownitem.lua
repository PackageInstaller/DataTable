local HeroDisplayExpressionDropdownItem = class("HeroDisplayExpressionDropdownItem", ReduxView)

function HeroDisplayExpressionDropdownItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function HeroDisplayExpressionDropdownItem:Dispose()
	HeroDisplayExpressionDropdownItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function HeroDisplayExpressionDropdownItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(HERO_DISPLAY_EXPRESSION_ITEM, self.index_)
	end)
end

function HeroDisplayExpressionDropdownItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.text_.text = GetI18NText(arg_5_2)

	self:Show(true)
end

function HeroDisplayExpressionDropdownItem:SetSelect(arg_6_1)
	SetActive(self.goSelect_, arg_6_1)
end

function HeroDisplayExpressionDropdownItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return HeroDisplayExpressionDropdownItem
