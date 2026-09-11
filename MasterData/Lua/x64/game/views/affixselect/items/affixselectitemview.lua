local AffixSelectItemView = class("AffixSelectItemView", ReduxView)

function AffixSelectItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AffixSelectItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:StartTimer()
end

function AffixSelectItemView:InitUI()
	self:BindCfgUI()

	self.btn_ = self.gameObject_:GetComponent(typeof(Button))
	self.item_stateController_ = ControllerUtil.GetController(self.gameObject_.transform, "item_state")
end

function AffixSelectItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_stage_" .. self.activityId_)

		if not ActivityData:GetActivityIsOpen(self.activityId_) then
			local var_5_0 = ActivityData:GetActivityData(self.activityId_)

			if var_5_0 and manager.time:GetServerTime() < var_5_0.startTime then
				ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_5_0.startTime)))
			else
				ShowTips("SOLO_TIME_OVER")
			end

			return
		end

		ActivityAffixSelectData:ReadInnerRedPoint(self.activityId_)
		ActivityAffixSelectData:SetClickState(self.activityId_)
		JumpTools.OpenPageByJump("/affixSelectDetailJapanRegion", {
			activityId = self.activityId_,
			index = self.index_
		})
	end)
end

function AffixSelectItemView:AddEventListeners()
	return
end

function AffixSelectItemView:SetData(arg_7_1, arg_7_2)
	self.index_ = arg_7_1
	self.activityId_ = arg_7_2

	self:UpdateView()
end

function AffixSelectItemView:GetActivityData()
	return ActivityAffixSelectData:GetSubActivityData(self.activityId_)
end

function AffixSelectItemView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateView()
		end, 1, -1)
	end

	self.timer_:Start()
end

function AffixSelectItemView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AffixSelectItemView:UpdateView()
	local var_12_0 = ActivityData:GetActivityIsOpen(self.activityId_)

	if not var_12_0 or self:GetActivityData() == nil then
		self.item_stateController_:SetSelectedState("lock")

		local var_12_1 = ActivityData:GetActivityData(self.activityId_)

		self.lockLabel_.text = manager.time:GetServerTime() >= var_12_1.startTime and GetTips("SOLO_TIME_OVER") or string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_12_1.startTime))
	else
		if self:GetActivityData().clearState == 1 then
			self.item_stateController_:SetSelectedState("unlock")
		else
			self.item_stateController_:SetSelectedState("passed")
		end

		self.highestScoreLabel_.text = self:GetActivityData().point
		self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. ActivityAffixSelectCfg[self.activityId_].boss_id[1])
	end

	if var_12_0 and not ActivityAffixSelectData:HaveReadInnerPoint(self.activityId_) and self:GetActivityData().clearState == 1 then
		SetActive(self.noticeGo_, true)
	else
		SetActive(self.noticeGo_, false)
	end
end

function AffixSelectItemView:OnEnter()
	self:AddEventListeners()
end

function AffixSelectItemView:OnExit()
	self:RemoveAllEventListener()
end

function AffixSelectItemView:OnMainHomeViewTop()
	return
end

function AffixSelectItemView:Dispose()
	self:StopTimer()
	AffixSelectItemView.super.Dispose(self)
end

return AffixSelectItemView
