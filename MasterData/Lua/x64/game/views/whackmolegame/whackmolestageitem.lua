local WhackMoleStageItem = class("WhackMoleStageItem", ReduxView)

function WhackMoleStageItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function WhackMoleStageItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.selectController_ = self.controllerEx_:GetController("select")
end

function WhackMoleStageItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self.clickCallback_(self.whackMoleID_, self.transform_.position)
	end)
end

function WhackMoleStageItem:SetClickCallback(arg_5_1)
	self.clickCallback_ = arg_5_1
end

function WhackMoleStageItem:SetData(arg_6_1, arg_6_2)
	self.activityID_ = arg_6_1
	self.whackMoleID_ = arg_6_2

	self:RefreshUI()
end

function WhackMoleStageItem:RefreshUI()
	self.name_.text = BattleWhackMoleStageCfg[ActivityWhackMoleCfg[self.whackMoleID_].stage_id].name

	self:RefreshState()
end

function WhackMoleStageItem:RefreshState()
	self.state_ = WhackMoleTools.GetStageIsLock(self.whackMoleID_) and WhackMoleConst.STAGE_STATE.LOCK or WhackMoleData:IsCompletedStage(self.whackMoleID_) and WhackMoleConst.STAGE_STATE.COMPLETED or WhackMoleConst.STAGE_STATE.UNLOCK

	self.stateController_:SetSelectedState(self.state_)
end

function WhackMoleStageItem:RefreshSelect(arg_9_1)
	self.selectController_:SetSelectedState(arg_9_1 == self.whackMoleID_ and "on" or "off")
end

function WhackMoleStageItem:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

return WhackMoleStageItem
