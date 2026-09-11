local TrainBtnItem = class("TrainBtnItem", ReduxView)

function TrainBtnItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function TrainBtnItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.upgradeController_ = self.mainControllerEx_:GetController("upgradeState")
	self.costController_ = self.mainControllerEx_:GetController("costState")
	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function TrainBtnItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.maxState_ then
			return
		end

		if self.select_ and self.timeOut_ then
			ShowTips(GetTips("IDOL_TRAIN_TIMES_NOT_ENOUGH"))

			return
		end

		if self.select_ and not self.costState_ then
			ShowTips(GetTips("DORM_FATIGUE_NOT_ENOUGH"))

			return
		end

		if self.select_ and not self.maxState_ and not self.timeOut_ and self.costState_ then
			IdolTraineeAction.TrainHeroProperty(self.heroID_, self.propertyIndex_)
		end

		if self.clickFunc then
			self.clickFunc(self.propertyIndex_)
		end
	end)
end

function TrainBtnItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	self.heroID_ = arg_5_1
	self.propertyIndex_ = arg_5_2
	self.maxState_ = arg_5_3
	self.timeOut_ = arg_5_6
	self.costState_ = arg_5_4
	self.costText_.text = GameSetting.dorm_idol_hero_exercise_cost.value[1]

	self.costController_:SetSelectedState(arg_5_4 and "true" or "false")

	if arg_5_3 then
		self.upgradeController_:SetSelectedState("max")
	else
		self.upgradeController_:SetSelectedState("cannot")
	end
end

function TrainBtnItem:RegisterClickFunc(arg_6_1)
	self.clickFunc = arg_6_1
end

function TrainBtnItem:RefreshBtnState(arg_7_1)
	if self.propertyIndex_ == arg_7_1 then
		self.selectController_:SetSelectedState("state1")

		self.select_ = true
	else
		self.selectController_:SetSelectedState("state0")

		self.select_ = false
	end
end

function TrainBtnItem:Dispose()
	TrainBtnItem.super.Dispose(self)
end

return TrainBtnItem
