local SpringPreheatLetterSelectTextToggleItem = class("SpringPreheatLetterSelectTextToggleItem", ReduxView)

function SpringPreheatLetterSelectTextToggleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function SpringPreheatLetterSelectTextToggleItem:InitUI()
	self:BindCfgUI()

	self.selController = ControllerUtil.GetController(self.transform_, "select")
end

function SpringPreheatLetterSelectTextToggleItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClickHandler_ then
			self:onClickHandler_(self.index_)
		end
	end)
end

function SpringPreheatLetterSelectTextToggleItem:SetClickHandler(arg_5_1)
	if arg_5_1 then
		self.onClickHandler_ = arg_5_1
	end
end

function SpringPreheatLetterSelectTextToggleItem:SetSelected(arg_6_1)
	self.selected_ = arg_6_1

	return self.selected_
end

function SpringPreheatLetterSelectTextToggleItem:SetIndex(arg_7_1)
	self.index_ = arg_7_1
end

function SpringPreheatLetterSelectTextToggleItem:RefreshUI()
	self.text_.text = GetTips((string.format("SPRING_PREHEAT_SELECT_WORD_%d", self.index_)))

	self.selController:SetSelectedState(self.selected_ and "true" or "false")
end

function SpringPreheatLetterSelectTextToggleItem:Dispose()
	SpringPreheatLetterSelectTextToggleItem.super.Dispose(self)
end

return SpringPreheatLetterSelectTextToggleItem
