local DodgeBarrageStageItem = class("DodgeBarrageStageItem", ReduxView)

function DodgeBarrageStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DodgeBarrageStageItem:Init()
	self:InitUI()
	self:AddUIListeners()

	self.stausController_ = self.transCon_:GetController("stage")
	self.lockController_ = self.transCon_:GetController("lock")
	self.posController_ = self.transCon_:GetController("pos")
	self.finishController_ = self.transCon_:GetController("finished")
	self.isSelect_ = false
end

function DodgeBarrageStageItem:InitUI()
	self:BindCfgUI()
end

function DodgeBarrageStageItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self.clickCallBack_(self.index_)
	end)
end

function DodgeBarrageStageItem:RegisterClick(arg_6_1)
	self.clickCallBack_ = arg_6_1
end

function DodgeBarrageStageItem:SelectItem()
	self.stausController_:SetSelectedState(self.isNormal_ and "select" or "hardSelect")
end

function DodgeBarrageStageItem:UnSelectItem()
	self.stausController_:SetSelectedState(self.isNormal_ and "normal" or "hardNormal")
end

function DodgeBarrageStageItem:RefreshUI(arg_9_1, arg_9_2, arg_9_3)
	self.index_ = arg_9_1
	self.data_ = ActivityDodgeBarrageCfg[arg_9_2]
	self.stageData_ = BattleDodgeBarrageCfg[self.data_.stage_id]
	self.isNormal_ = self.data_.diff == 0
	self.stageName_.text = self.stageData_.name

	self.posController_:SetSelectedState(arg_9_1 % 2 == 1 and "right" or "left")

	self.isActivityOpen_ = ActivityData:GetActivityIsOpen(self.data_.sub_activity_id)
	self.isLock_ = not self.isActivityOpen_ or not (ActivityDodgeBarrageCfg[self.index_].pre == 0 or DodgeBarrageData:IsStageFinished(ActivityDodgeBarrageCfg[self.index_].pre))

	self.lockController_:SetSelectedState(self.isLock_ and "show" or "hide")

	self.isFinished_ = DodgeBarrageData:IsStageFinished(self.stageData_.id)

	self.finishController_:SetSelectedState(self.isNormal_ and self.isFinished_ and "finished" or "unfinished")

	if arg_9_3 and arg_9_1 == arg_9_3 then
		self:SelectItem()
	else
		self:UnSelectItem()
	end
end

function DodgeBarrageStageItem:GetIsNormal()
	return self.isNormal_
end

function DodgeBarrageStageItem:GetIsLock()
	return self.isLock_
end

function DodgeBarrageStageItem:GetActivityOpen()
	return self.isActivityOpen_
end

function DodgeBarrageStageItem:GetStageData()
	return self.stageData_
end

function DodgeBarrageStageItem:GetStageActivityId()
	return self.data_.sub_activity_id
end

function DodgeBarrageStageItem:GetLockText()
	if self.isActivityOpen_ then
		return GetTips("ACTIVITY_MONSTER_COSPLAY_STAGE_CONDITION")
	else
		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(ActivityData:GetActivityData(self.data_.sub_activity_id).startTime, nil, true))
	end
end

function DodgeBarrageStageItem:Dispose()
	DodgeBarrageStageItem.super.Dispose(self)
end

return DodgeBarrageStageItem
