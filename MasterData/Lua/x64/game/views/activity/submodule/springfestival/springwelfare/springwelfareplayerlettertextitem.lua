local SpringWelfarePlayerLetterTextItem = class("SpringWelfarePlayerLetterTextItem", ReduxView)

function SpringWelfarePlayerLetterTextItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.richText_ = self:FindCom("RichText", "", arg_1_1.transform)
	self.buttonUpAudio_ = self:FindCom("ButtonUpAudio", "", arg_1_1.transform)
	self.buttonUpAudio_.enabled = false
end

function SpringWelfarePlayerLetterTextItem:Dispose()
	SpringWelfarePlayerLetterTextItem.super.Dispose(self)
end

function SpringWelfarePlayerLetterTextItem:SetText(arg_3_1)
	self.richText_.text = arg_3_1
end

return SpringWelfarePlayerLetterTextItem
