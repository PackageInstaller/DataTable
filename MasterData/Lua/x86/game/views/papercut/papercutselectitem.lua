local PaperCutSelectItem = class("PaperCutSelectItem", ReduxView)

function PaperCutSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PaperCutSelectItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function PaperCutSelectItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function PaperCutSelectItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		PaperCutData:SetSelectActivityID(self.activityID_)

		if self.clickHandler_ then
			self.clickHandler_(self.activityID_)
		end
	end)
end

function PaperCutSelectItem:SetData(arg_6_1, arg_6_2)
	if self.activityID_ == nil then
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, arg_6_1, arg_6_2)))
	elseif self.activityID_ ~= arg_6_2 then
		manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, arg_6_1, self.activityID_)))
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, arg_6_1, arg_6_2)))
	end

	self.activityID_ = arg_6_2
	self.mainActivityID_ = arg_6_1
	self.startTime_ = ActivityData:GetActivityData(self.activityID_).startTime
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RefreshUI()
end

function PaperCutSelectItem:SetClickCallBack(arg_7_1)
	self.clickHandler_ = arg_7_1
end

function PaperCutSelectItem:Dispose()
	self.clickHandler_ = nil

	self:UnRegisterRedPoint()
	PaperCutSelectItem.super.Dispose(self)
end

function PaperCutSelectItem:RefreshLock()
	if self.isLock_ == false then
		return
	end

	self.isLock_ = manager.time:GetServerTime() < self.startTime_

	if self.isLock_ == true then
		self.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
	else
		self.statusController_:SetSelectedState("uncomplete")
	end
end

function PaperCutSelectItem:RefreshUI()
	self.isLock_ = manager.time:GetServerTime() < self.startTime_

	if self.isLock_ == true then
		self.statusController_:SetSelectedState("lock")

		self.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
	elseif PaperCutData:GetPlayedList(self.activityID_) == true then
		self.statusController_:SetSelectedState("completed")

		self.icon_.color = Color(1, 0.8117647058823529, 0.5294117647058824, 1)
		self.scoreText_.text = PaperCutData:GetScore(self.activityID_) or 0
	else
		self.statusController_:SetSelectedState("uncomplete")

		self.icon_.color = Color(0.7019607843137254, 0.5215686274509804, 0.4588235294117647, 1)
	end

	self:RefreshImage()
	self:RefreshTitle()
end

function PaperCutSelectItem:RefreshImage()
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/paperCut/" .. PaperCutCfg[self.activityID_].picture)
end

function PaperCutSelectItem:RefreshTitle()
	self.titleText_.text = GetI18NText(PaperCutCfg[self.activityID_].name)
end

function PaperCutSelectItem:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, self.mainActivityID_, self.activityID_)))
end

return PaperCutSelectItem
