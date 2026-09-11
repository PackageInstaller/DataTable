local CultivateHeroTaskItem = class("CultivateHeroTaskItem", ReduxView)

function CultivateHeroTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultivateHeroTaskItem:Init()
	self:InitUI()
	self:AddListeners()

	self.rewardState_ = ControllerUtil.GetController(self.transform_, "status")
end

function CultivateHeroTaskItem:InitUI()
	self:BindCfgUI()
end

function CultivateHeroTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		CultivateHeroAction.RequireReceiveHeroTaskList(self.activityID_, {
			self.taskID_
		}, function()
			self.onReceived_()
		end)
	end)
end

function CultivateHeroTaskItem:Dispose()
	self.onReceived_ = nil

	self.commonItem_:Dispose()

	self.commonItem_ = nil

	CultivateHeroTaskItem.super.Dispose(self)
end

function CultivateHeroTaskItem:SetData(arg_8_1, arg_8_2)
	self.activityID_ = arg_8_1
	self.taskID_ = arg_8_2

	self:RefreshUI()
end

function CultivateHeroTaskItem:SetAni(arg_9_1)
	if self.animator_ then
		self.animator_:Play(arg_9_1, 0, 0)
		self.animator_:Update(0)
	end
end

function CultivateHeroTaskItem:RefreshUI()
	self:RefreshDesc()
	self:RefreshState()
	self:RefreshItem()
end

function CultivateHeroTaskItem:RefreshDesc()
	self.descText_.text = GetI18NText(CultivateHeroTaskCfg[self.taskID_].desc)

	local var_11_0 = 0

	if HeroTools.GetHeroIsUnlock(CultivateHeroTaskCfg[self.taskID_].hero) then
		if CultivateHeroData:IsHeroTaskReceived(self.activityID_, self.taskID_) then
			var_11_0 = CultivateHeroTaskCfg[self.taskID_].condition
		else
			local var_11_1 = CultivateHeroData:GetHeroTaskInfoList(self.activityID_)[self.taskID_]

			if var_11_1 and var_11_1.progress then
				var_11_0 = CultivateHeroTaskCfg[self.taskID_].condition > var_11_1.progress and var_11_1.progress or CultivateHeroTaskCfg[self.taskID_].condition
			end
		end
	end

	self.progressText_.text = string.format("%d/%d", var_11_0, CultivateHeroTaskCfg[self.taskID_].condition)
	self.progressSlider_.value = var_11_0 / CultivateHeroTaskCfg[self.taskID_].condition
end

function CultivateHeroTaskItem:RefreshItem()
	self.rewardCfg_ = CultivateHeroTaskCfg[self.taskID_].reward[1]

	if self.commonItem_ == nil then
		self.commonItem_ = CommonItemView.New(self.rewardItemGo_, true)
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_.clickFun(arg_13_0)
			ShowPopItem(POP_ITEM, arg_13_0)
		end
	end

	self.itemData_.id = self.rewardCfg_[1]
	self.itemData_.number = self.rewardCfg_[2]
	self.itemData_.grayFlag = not not self.itemGray_

	self.commonItem_:SetData(self.itemData_)
end

function CultivateHeroTaskItem:RefreshState()
	local var_14_0 = CultivateHeroData:GetHeroTaskInfoList(self.activityID_)

	if not CultivateHeroData:IsHeroTaskCompleted(self.activityID_, self.taskID_) then
		self.itemGray_ = false

		self.rewardState_:SetSelectedState("uncomplete")
	elseif not CultivateHeroData:IsHeroTaskReceived(self.activityID_, self.taskID_) then
		self.itemGray_ = false

		self.rewardState_:SetSelectedState("unreceive")
	else
		self.itemGray_ = true

		self.rewardState_:SetSelectedState("received")
	end
end

function CultivateHeroTaskItem:SetReveivedHandler(arg_15_1)
	self.onReceived_ = arg_15_1
end

return CultivateHeroTaskItem
