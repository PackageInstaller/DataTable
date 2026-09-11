local TangramRegionContentItem = class("TangramRegionContentItem", ReduxView)

function TangramRegionContentItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.regionType_ = arg_1_2
	self.regionIdList_ = arg_1_3
end

function TangramRegionContentItem:OnExit()
	self:StopAnimTimer()
end

function TangramRegionContentItem:SetData(arg_3_1)
	self.activityID_ = arg_3_1

	self:RefreshUI()
end

function TangramRegionContentItem:RefreshUI()
	self:RefreshStatus()
end

function TangramRegionContentItem:RefreshStatus()
	local var_5_0 = TangramPuzzleData:GetUnlockRegionDic(self.activityID_)

	self.unlock_ = true

	for iter_5_0, iter_5_1 in ipairs(self.regionIdList_) do
		if not var_5_0[iter_5_1] then
			self.unlock_ = false

			break
		end
	end

	if not self.unlock_ then
		self.statusController_:SetSelectedState("lock")
	elseif self:IsAllReceived() and TangramPuzzleTools.CheckRegionAllRightByType(self.activityID_, self.regionType_) then
		self:SetActive(false)
	else
		self.statusController_:SetSelectedState("normal")
	end
end

function TangramRegionContentItem:IsAllReceived()
	local var_6_0 = TangramPuzzleData:GetRegionReceivedDic(self.activityID_)

	for iter_6_0, iter_6_1 in ipairs(self.regionIdList_) do
		if not var_6_0[iter_6_1] then
			return false
		end
	end

	return true
end

function TangramRegionContentItem:GetRegionContentTrans()
	return self.regionContentTrans_
end

function TangramRegionContentItem:PlayCompletedAnim(arg_8_1)
	self:PlayAnim(self.animator_, "regionContentTemplate", arg_8_1)
end

function TangramRegionContentItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function TangramRegionContentItem:StopAnimTimer()
	if self.animtimer_ then
		self.animtimer_:Stop()

		self.animtimer_ = nil
	end
end

function TangramRegionContentItem:PlayAnim(arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_1 then
		if arg_11_3 then
			arg_11_3()
		end

		return
	end

	self:StopAnimTimer()

	arg_11_1.enabled = true

	arg_11_1:Play(arg_11_2, -1, 0)
	arg_11_1:Update(0)

	self.animtimer_ = Timer.New(function()
		local var_12_0 = arg_11_1:GetCurrentAnimatorStateInfo(0)

		if var_12_0:IsName(arg_11_2) and var_12_0.normalizedTime >= 1 then
			self:StopAnimTimer()

			arg_11_1.enabled = false

			if arg_11_3 then
				arg_11_3()
			end
		end
	end, 0.033, -1)

	self.animtimer_:Start()
end

return TangramRegionContentItem
