local DrawLeftToggleGroupItem = class("DrawLeftToggleGroupItem", ReduxView)

function DrawLeftToggleGroupItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.switchHandler_ = handler(self, self.OnSwitch)

	manager.notify:RegistListener(DRAW_SELECT_GROUP, self.switchHandler_)
end

function DrawLeftToggleGroupItem:Dispose()
	manager.notify:RemoveListener(DRAW_SELECT_GROUP, self.switchHandler_)

	self.switchHandler_ = nil

	if self.rewardItemView_ then
		self.rewardItemView_:Dispose()

		self.rewardItemView_ = nil
	end

	DrawLeftToggleGroupItem.super.Dispose(self)
end

function DrawLeftToggleGroupItem:AddListeners()
	return
end

function DrawLeftToggleGroupItem:SetData(arg_4_1, arg_4_2)
	self.activityID_ = DrawTools.HasDrawBonusPoolList(arg_4_1)

	if self.activityID_ then
		self.rewardItemView_ = self.rewardItemView_ or DrawLeftToggleRewardItem.New(self.bonusGo_)

		self.rewardItemView_:SetData(self.activityID_)
	elseif self.rewardItemView_ then
		self.rewardItemView_:Show(false)
	end

	self.index_ = arg_4_2
end

function DrawLeftToggleGroupItem:OnSwitch(arg_5_1)
	return
end

return DrawLeftToggleGroupItem
