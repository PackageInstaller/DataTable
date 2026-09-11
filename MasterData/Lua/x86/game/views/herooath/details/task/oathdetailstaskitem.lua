local OathDetailsTaskItem = class("OathDetailsTaskItem", ReduxView)

function OathDetailsTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function OathDetailsTaskItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controller_:GetController("state")
end

function OathDetailsTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self.isNeedPlayFinishAni = true

		OathAssignmentAction.SubmitOathTask({
			self.taskID
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(WeddingAssignmentCfg[self.taskID].jump)
	end)
end

function OathDetailsTaskItem:SetData(arg_6_1, arg_6_2)
	self.taskID = arg_6_1
	self.taskCount = arg_6_2

	self:RefreshUI()
end

function OathDetailsTaskItem:RefreshUI()
	local var_7_0 = OathAssignmentData:GetOathAssignmentByID(self.taskID)

	self.titleText_.text = WeddingAssignmentCfg[self.taskID].desc
	self.storyText_.text = WeddingAssignmentCfg[self.taskID].story
	self.rewardValueText_.text = 1 / self.taskCount * 100 .. "%"
	self.progressBar_.value = var_7_0.progress / WeddingAssignmentCfg[self.taskID].need
	self.progressText_.text = string.format("%s/%s", math.min(var_7_0.progress, WeddingAssignmentCfg[self.taskID].need), WeddingAssignmentCfg[self.taskID].need)

	if var_7_0.status == 0 then
		if var_7_0.progress < WeddingAssignmentCfg[self.taskID].need then
			self.stateController_:SetSelectedState("unComplete")
		else
			self.stateController_:SetSelectedState("received")
		end
	else
		self.stateController_:SetSelectedState("finish")
		self:OpenPlayAni()
	end
end

function OathDetailsTaskItem:DelAniTimer()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end
end

function OathDetailsTaskItem:OpenPlayAni()
	self:DelAniTimer()

	self.aniTimer_ = Timer.New(function()
		self:PlayFinishAni()
	end, 0.1)

	self.aniTimer_:Start()
end

function OathDetailsTaskItem:PlayFinishAni()
	if self.isNeedPlayFinishAni then
		self.completeAni_:Play("UI_complete_cx", 0, 0)
		self.completeAni_:Update(0)

		self.isNeedPlayFinishAni = false
	else
		self.completeAni_:Play("UI_complete_cx", 0, 1)
		self.completeAni_:Update(1)
	end
end

function OathDetailsTaskItem:Dispose()
	self:DelAniTimer()
	self:RemoveAllListeners()
	OathDetailsTaskItem.super.Dispose(self)
end

return OathDetailsTaskItem
