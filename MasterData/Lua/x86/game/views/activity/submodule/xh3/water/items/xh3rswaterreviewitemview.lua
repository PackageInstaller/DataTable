local XH3rsWaterReviewItemView = class("XH3rsWaterReviewItemView", ReduxView)

function XH3rsWaterReviewItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function XH3rsWaterReviewItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rsWaterReviewItemView:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.gameObject_.transform, "select")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.roleStatusController1_ = ControllerUtil.GetController(self.head1Go_.transform, "status")
	self.roleStatusController2_ = ControllerUtil.GetController(self.head2Go_.transform, "status")
end

function XH3rsWaterReviewItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickListener_ ~= nil then
			self.clickListener_(self.index_, self.data_)
		end
	end)
end

function XH3rsWaterReviewItemView:AddEventListeners()
	return
end

function XH3rsWaterReviewItemView:SetSelect(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "yes" or "no")
end

function XH3rsWaterReviewItemView:RegisterClickListener(arg_8_1)
	self.clickListener_ = arg_8_1
end

function XH3rsWaterReviewItemView:SetData(arg_9_1, arg_9_2, arg_9_3)
	self.index_ = arg_9_1
	self.data_ = arg_9_2
	self.activityId_ = arg_9_3

	self:UpdateView()
end

function XH3rsWaterReviewItemView:UpdateView()
	self.nameText_.text = ActivityWaterCfg[self.data_.schedule_id].schedule_name
	self.head1_.sprite = HeroTools.GetHeadSprite(HeroStandardSystemCfg[ActivityWaterCompetitionCfg[self.data_.competition_list[1].competition_id].hero_id].hero_id)
	self.head2_.sprite = HeroTools.GetHeadSprite(HeroStandardSystemCfg[ActivityWaterCompetitionCfg[self.data_.competition_list[2].competition_id].hero_id].hero_id)

	local var_10_0
	local var_10_2

	if self.data_.competition_list[1].assistance_process > self.data_.competition_list[2].assistance_process then
		var_10_0 = "win"
		var_10_2 = "lose"
	elseif self.data_.competition_list[1].assistance_process == self.data_.competition_list[2].assistance_process then
		var_10_0 = "draw"
		var_10_2 = "draw"
	else
		var_10_0 = "lose"
		var_10_2 = "win"
	end

	if self.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(self.activityId_).schedule_id then
		var_10_0 = "current"
		var_10_2 = "current"

		self.statusController_:SetSelectedState("progress")
	else
		self.statusController_:SetSelectedState("over")
	end

	self.roleStatusController1_:SetSelectedState(var_10_0)
	self.roleStatusController2_:SetSelectedState(var_10_2)

	if self.data_.is_success and self.data_.is_success > 0 and not ActivityWaterData:HaveGotHistoryReward(self.data_.schedule_id) then
		SetActive(self.noticeGo_, true)
	else
		SetActive(self.noticeGo_, false)
	end
end

function XH3rsWaterReviewItemView:OnEnter()
	self:AddEventListeners()
end

function XH3rsWaterReviewItemView:OnExit()
	self:RemoveAllEventListener()
end

function XH3rsWaterReviewItemView:OnMainHomeViewTop()
	return
end

function XH3rsWaterReviewItemView:Dispose()
	self.data_ = nil
	self.clickListener_ = nil

	XH3rsWaterReviewItemView.super.Dispose(self)
end

return XH3rsWaterReviewItemView
