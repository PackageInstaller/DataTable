local SkuldPuzzleConditionItem = class("SkuldPuzzleConditionItem", ReduxView)

function SkuldPuzzleConditionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function SkuldPuzzleConditionItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerexcollection_:GetController("state")
	self.remindController_ = self.controllerexcollection_:GetController("remind")
	self.showNumController_ = self.controllerexcollection_:GetController("showNum")
end

function SkuldPuzzleConditionItem:RefreshUI(arg_3_1)
	self.conditionID = arg_3_1
	self.descText_.text = SkuldPuzzleConditionCfg[arg_3_1].condition_desc

	self:ChangeState(false)
	self:ShowRemindState(false)

	self.taskitemAni_.enabled = false
end

function SkuldPuzzleConditionItem:CheckIsUseAllChipCondition()
	return SkuldPuzzleConditionCfg[self.conditionID].condition_type == 1
end

function SkuldPuzzleConditionItem:GetFinishConditionNum()
	return SkuldPuzzleConditionCfg[self.conditionID].condition_value[2]
end

function SkuldPuzzleConditionItem:GetIsFinish()
	return self.isFinish
end

function SkuldPuzzleConditionItem:GetConditionID()
	return self.conditionID
end

function SkuldPuzzleConditionItem:ChangeState(arg_8_1)
	self.stateController_:SetSelectedState(arg_8_1 and "finish" or "normal")

	if self.isFinish == false and arg_8_1 then
		self.taskitemAni_:Play("item_finish", 0, 0)

		self.taskitemAni_.enabled = true
	end

	self.isFinish = arg_8_1
end

function SkuldPuzzleConditionItem:ShowRemindState(arg_9_1)
	if arg_9_1 and self.isFinish == false then
		self.remindController_:SetSelectedState("show")
	else
		self.remindController_:SetSelectedState("hide")
	end
end

function SkuldPuzzleConditionItem:UpdateShowNum(arg_10_1)
	if self:CheckIsUseAllChipCondition() then
		self.showNumController_:SetSelectedState("false")
	else
		self.showNumController_:SetSelectedState("true")

		self.textnumText_.text = string.format(GetTips("SKULD_PUZZLE_CONDITION"), arg_10_1, self:GetFinishConditionNum())
	end
end

function SkuldPuzzleConditionItem:Dispose()
	SkuldPuzzleConditionItem.super.Dispose(self)
end

return SkuldPuzzleConditionItem
