local SeaWarfareStageItem = class("SeaWarfareStageItem", ReduxView)

function SeaWarfareStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SeaWarfareStageItem:Init()
	self:InitUI()
	self:AddListeners()
end

function SeaWarfareStageItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.completeController_ = self.controllerEx_:GetController("complete")
	self.numberController_ = self.controllerEx_:GetController("number")
end

function SeaWarfareStageItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			ShowTips("NEED_COMPLETE_PRE_STAGE")

			return
		end

		self.clickCallback_(self.stageID_)
	end)
end

function SeaWarfareStageItem:SetData(arg_6_1, arg_6_2)
	self.stageID_ = arg_6_1
	self.stageIndex_ = arg_6_2

	self:ResetAnim()
	self:RefreshLock()
	self:RefreshComplete()
	self:RefreshNumber()
	self:InitAnimStatus()
end

function SeaWarfareStageItem:SetSelect(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "on" or "off")
end

function SeaWarfareStageItem:RefreshLock()
	self.isLock_ = SeaWarfareTools.IsStageLock(self.stageID_)

	self.lockController_:SetSelectedState(self.isLock_ and "on" or "off")
end

function SeaWarfareStageItem:RefreshComplete()
	self.completeController_:SetSelectedState(SeaWarfareTools.IsStageCompleted(self.stageID_) and "on" or "off")
end

function SeaWarfareStageItem:RefreshNumber()
	self.numberController_:SetSelectedState(tostring(self.stageIndex_))
end

function SeaWarfareStageItem:SetClickCallback(arg_11_1)
	self.clickCallback_ = arg_11_1
end

function SeaWarfareStageItem:GetStageID()
	return self.stageID_
end

function SeaWarfareStageItem:InitAnimStatus()
	if self.stageID_ == SeaWarfareTools.GetNeedFirstUnlockAnimStageID() then
		self.lockController_:SetSelectedState("on")
	end

	if self.stageID_ == SeaWarfareTools.GetNeedFirstCompleteAnimStageID() then
		self.completeController_:SetSelectedState("off")
	end
end

function SeaWarfareStageItem:PlayUnlockAnim(arg_14_1)
	self.unlockAnimtimer_ = SeaWarfareTools.PlayAnim(self.unlockAnim_, "UI_lock_cx", function()
		self.lockController_:SetSelectedState("off")

		if arg_14_1 then
			arg_14_1()
		end
	end)
end

function SeaWarfareStageItem:PlayCompletedAnim(arg_16_1)
	self.completeController_:SetSelectedState("on")

	self.completeAnimtimer_ = SeaWarfareTools.PlayAnim(self.completeAnim_, "UI_complet_cx", function()
		if arg_16_1 then
			arg_16_1()
		end
	end)
end

function SeaWarfareStageItem:ResetAnim()
	self.unlockAnim_.enabled = false

	if self.unlockAnimtimer_ then
		self.unlockAnimtimer_:Stop()

		self.unlockAnimtimer_ = nil
	end

	self.completeAnim_.enabled = false

	if self.completeAnimtimer_ then
		self.completeAnimtimer_:Stop()

		self.completeAnimtimer_ = nil
	end
end

return SeaWarfareStageItem
