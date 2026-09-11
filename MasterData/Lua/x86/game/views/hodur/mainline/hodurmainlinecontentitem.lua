local HodurMainlineContentItem = class("HodurMainlineContentItem", ReduxView)

function HodurMainlineContentItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HodurMainlineContentItem:InitUI()
	self:BindCfgUI()

	self.eventController_ = self.mainControllerEx_:GetController("Event")
	self.stageController_ = self.mainControllerEx_:GetController("Checkpoint")
	self.stageItem_ = nil
	self.eventItem_ = nil
	self.stageID_ = nil
	self.eventID_ = nil
end

function HodurMainlineContentItem:SetData(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.stageID_ = arg_3_1
	self.eventID_ = arg_3_2
	self.pos_ = arg_3_3
	self.last_ = arg_3_4
	self.chapterID_ = arg_3_5

	self:RefreshUI()
end

function HodurMainlineContentItem:SetCallback(arg_4_1, arg_4_2)
	self.stageHandler_ = arg_4_1
	self.eventHandler_ = arg_4_2

	if self.stageItem_ then
		self.stageItem_:SetClickHandler(self.stageHandler_)
	end

	if self.eventItem_ then
		self.eventItem_:SetClickHandler(self.eventHandler_)
	end
end

function HodurMainlineContentItem:RefreshUI()
	if self.stageID_ then
		if self.stageItem_ == nil then
			self.stageItem_ = HodurMainlineStageItem.New(self.stageItemGo_)
		end

		self.stageItem_:SetData(self.stageID_, self.pos_, self.last_, self.chapterID_)
	end

	if self.eventID_ and HodurTools.GetEventUnlock(self.eventID_, self.chapterID_) then
		if self.eventItem_ == nil then
			self.eventItem_ = HodurMainlineEventItem.New(self.eventItemGo_)
		end

		self.eventItem_:SetData(self.eventID_, self.chapterID_)
		self.eventController_:SetSelectedState("on")
	else
		self.eventController_:SetSelectedState("off")
	end
end

function HodurMainlineContentItem:SetSelect(arg_6_1, arg_6_2)
	if arg_6_1 == HodurConst.INFO_VIEW_TYPE.STAGE then
		if self.stageID_ == arg_6_2 then
			self.stageItem_:SetSelected(true)

			return true
		else
			self.stageItem_:SetSelected(false)
		end
	elseif self.eventItem_ then
		if self.eventID_ == arg_6_2 then
			self.eventItem_:SetSelected(true)

			return true
		else
			self.eventItem_:SetSelected(false)
		end
	end

	return false
end

function HodurMainlineContentItem:SetSelectFalse()
	if self.stageItem_ then
		self.stageItem_:SetSelected(false)
	end

	if self.eventItem_ then
		self.eventItem_:SetSelected(false)
	end
end

function HodurMainlineContentItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function HodurMainlineContentItem:Dispose()
	if self.stageItem_ then
		self.stageItem_:Dispose()

		self.stageItem_ = nil
	end

	if self.eventItem_ then
		self.eventItem_:Dispose()

		self.eventItem_ = nil
	end

	HodurMainlineContentItem.super.Dispose(self)
end

return HodurMainlineContentItem
