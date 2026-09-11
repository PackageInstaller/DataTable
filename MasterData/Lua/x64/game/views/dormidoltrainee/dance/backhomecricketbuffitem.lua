local BackHomeCricketBuffItem = class("BackHomeCricketBuffItem", ReduxView)

function BackHomeCricketBuffItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function BackHomeCricketBuffItem:InitUI()
	self:BindCfgUI()
	self.AddBtnListener(self, self.buffBtn_, nil, self.OnClick, self)
end

function BackHomeCricketBuffItem:RefreshUI(arg_3_1, arg_3_2)
	self.buffID = arg_3_1.id
	self.buffIcon_.sprite = IdolTraineeTools:GetBuffIcon(self.buffID)
	self.buffRoundText_.text = arg_3_1.showDuration and arg_3_1.duration or ""
	self.showInfoFunc = arg_3_2
end

function BackHomeCricketBuffItem:Dispose()
	BackHomeCricketBuffItem.super.Dispose(self)
end

function BackHomeCricketBuffItem:OnClick()
	manager.notify:CallUpdateFunc("OnBuffIconClick", self.buffID, self.showInfoFunc)
end

return BackHomeCricketBuffItem
