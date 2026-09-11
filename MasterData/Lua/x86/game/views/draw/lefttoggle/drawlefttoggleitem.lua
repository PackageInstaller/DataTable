local DrawLeftToggleItem = class("DrawLeftToggleItem", ReduxView)

function DrawLeftToggleItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.switchHandler_ = handler(self, self.OnSwitch)

	manager.notify:RegistListener(DRAW_SELECT_ITEM, self.switchHandler_)
end

function DrawLeftToggleItem:Dispose()
	manager.notify:RemoveListener(DRAW_SELECT_ITEM, self.switchHandler_)

	self.switchHandler_ = nil

	if self.rewardItemView_ then
		self.rewardItemView_:Dispose()

		self.rewardItemView_ = nil
	end

	DrawLeftToggleItem.super.Dispose(self)
end

function DrawLeftToggleItem:AddListeners()
	return
end

function DrawLeftToggleItem:SetData(arg_4_1, arg_4_2)
	self.activityID_ = DrawTools.HasDrawBonusPoolID(DrawTools.GetDrawBonusActivityIDList(), arg_4_1)
	self.index_ = arg_4_2

	if self.activityID_ then
		self.rewardItemView_ = self.rewardItemView_ or DrawLeftToggleRewardItem.New(self.bonusGo_)

		self.rewardItemView_:SetData(self.activityID_)
	elseif self.rewardItemView_ then
		self.rewardItemView_:Show(false)
	end
end

function DrawLeftToggleItem:OnSwitch(arg_5_1)
	if self.rewardItemView_ then
		self.rewardItemView_:RefreshSelectState(self.index_ == arg_5_1)
	end
end

return DrawLeftToggleItem
