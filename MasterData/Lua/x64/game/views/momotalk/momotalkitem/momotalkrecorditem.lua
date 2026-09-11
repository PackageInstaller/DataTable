local MomoTalkRecordItem = class("MomoTalkRecordItem", ReduxView)

function MomoTalkRecordItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function MomoTalkRecordItem:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.onClick_ then
			self.onClick_(self.sessionID_)
		end
	end)
end

function MomoTalkRecordItem:SetData(arg_4_1, arg_4_2)
	self.sessionID_ = arg_4_1.sessionID
	self.onClick_ = arg_4_2

	if self.text_ then
		self.text_.text = GetI18NText(arg_4_1.preview)
	end
end

function MomoTalkRecordItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function MomoTalkRecordItem:Dispose()
	self:RemoveAllListeners()
	MomoTalkRecordItem.super.Dispose(self)
end

return MomoTalkRecordItem
