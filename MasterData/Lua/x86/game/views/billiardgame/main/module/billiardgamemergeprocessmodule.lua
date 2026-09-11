local BilliardGameMergeProcessModule = class("BilliardGameMergeProcessModule", ReduxView)

function BilliardGameMergeProcessModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameMergeProcessModule:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.infoController_ = self.con_:GetController("info")

	self:InitMergeProcess()
end

function BilliardGameMergeProcessModule:InitMergeProcess()
	local var_3_0 = MergeBallStageCfg[BilliardGameMgr:GetStageId()]

	self.maxProcessList_ = var_3_0.merge_progress
	self.maxProcess_ = var_3_0.merge_progress[#var_3_0.merge_progress]
	self.mergeCallback_ = mergeCallback
	self.mergeLevel_ = 1
	self.mergeProcess_ = 0
	self.totalNeedProcess_ = 0
	self.processImg_.fillAmount = 0
	self.nowNeedProcess_ = self.maxProcessList_[self.mergeLevel_]
	self.lastNeedProcess_ = self.nowNeedProcess_
	self.processText_.text = string.format("%d/%d", self.mergeProcess_, self.nowNeedProcess_)
	self.mergeInfoText_.text = GetTips("MERGE_BALL_MERGER_TIP")
end

function BilliardGameMergeProcessModule:AddUIListener()
	self:AddBtnListener(self.mergeInfoBtn_, nil, function()
		if manager.guide:IsPlaying() then
			return
		end

		self.infoController_:SetSelectedState("show")
	end)
	self:AddBtnListener(self.mergeInfoMask_, nil, function()
		if manager.guide:IsPlaying() then
			return
		end

		self.infoController_:SetSelectedState("hide")
	end)
end

function BilliardGameMergeProcessModule:RefreshMergeProcess(arg_7_1)
	self.mergeProcess_ = self.mergeProcess_ + arg_7_1
	self.processText_.text = string.format("%d/%d", self.mergeProcess_, self.nowNeedProcess_)
	self.processImg_.fillAmount = self.mergeProcess_ / self.nowNeedProcess_

	if self.mergeProcess_ / self.nowNeedProcess_ >= 1 then
		self.isNeedMerge_ = true

		if not self.isShowAnim then
			self.anim_:Play("modify", -1, 0)

			self.isShowAnim = true
		end
	end
end

function BilliardGameMergeProcessModule:OnMergeBack()
	self.mergeProcess_ = math.max(0, self.mergeProcess_ - self.nowNeedProcess_)
	self.mergeLevel_ = self.mergeLevel_ + 1

	if self.mergeLevel_ <= #self.maxProcessList_ then
		self.nowNeedProcess_ = self.maxProcessList_[self.mergeLevel_] or self.maxProcess_
	end

	self.processText_.text = string.format("%d/%d", self.mergeProcess_, self.nowNeedProcess_)
	self.processImg_.fillAmount = self.mergeProcess_ / self.nowNeedProcess_
	self.isNeedMerge_ = self.mergeProcess_ / self.nowNeedProcess_ >= 1
end

function BilliardGameMergeProcessModule:GetIsNeedMerge()
	return self.isNeedMerge_
end

function BilliardGameMergeProcessModule:HideMergePop()
	self.isNeedMerge_ = false
	self.isShowAnim = false
	self.lastNeedProcess_ = self.nowNeedProcess_
end

function BilliardGameMergeProcessModule:FeedbackMergeProcess(arg_11_1)
	self:RefreshMergeProcess((math.floor(self.lastNeedProcess_ * arg_11_1)))
end

function BilliardGameMergeProcessModule:Dispose()
	BilliardGameMergeProcessModule.super.Dispose(self)
end

return BilliardGameMergeProcessModule
