local SpringPreheatLetterSelectTextItem = class("SpringPreheatLetterSelectTextItem", ReduxView)

function SpringPreheatLetterSelectTextItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function SpringPreheatLetterSelectTextItem:InitUI()
	self:BindCfgUI()

	self.selController = ControllerUtil.GetController(self.transform_, "select")
end

function SpringPreheatLetterSelectTextItem:AddUIListener()
	self:AddBtnListener(self.letterBtn_, nil, function()
		if self.onClickHandler_ then
			self:onClickHandler_(self.textId)
		end
	end)
end

function SpringPreheatLetterSelectTextItem:SetClickHandler(arg_5_1)
	if arg_5_1 then
		self.onClickHandler_ = arg_5_1
	end
end

function SpringPreheatLetterSelectTextItem:SetSelected(arg_6_1)
	self.selected_ = arg_6_1

	return self.selected_
end

function SpringPreheatLetterSelectTextItem:SetLetterTextId(arg_7_1)
	self.textId = arg_7_1
end

function SpringPreheatLetterSelectTextItem:RefreshUI()
	self.letterText_.text = GetTips(self.textId)

	self.selController:SetSelectedState(self.selected_ and "true" or "false")
end

function SpringPreheatLetterSelectTextItem:Dispose()
	SpringPreheatLetterSelectTextItem.super.Dispose(self)
end

return SpringPreheatLetterSelectTextItem
