local MimirChipManagerInfoView = class("MimirChipManagerInfoView", ReduxView)

function MimirChipManagerInfoView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.ctrl = arg_1_2

	self:InitUI()
end

function MimirChipManagerInfoView:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.btnState = self.btnControllerexcollection_:GetController("btn")
	self.tabControl = self.tabControllerexcollection_:GetController("select")
	self.chipManagerLockView_ = ChipManagerLockView.New(self.lockPanel_)
end

function MimirChipManagerInfoView:OnEnter()
	return
end

function MimirChipManagerInfoView:OnExit()
	manager.redPoint:unbindUIandKey(self.btn_unlock2Btn_.transform)
end

function MimirChipManagerInfoView:SetTemplateData(arg_5_1)
	self.chipManagerDataTemplate_ = arg_5_1
end

function MimirChipManagerInfoView:RefreshData(arg_6_1)
	self.chipManagerID = arg_6_1
	self.chipManagerName_.text = GetI18NText(ChipCfg[self.chipManagerID].suit_name)
	self.skillText_.text = GetI18NText(ChipCfg[self.chipManagerID].desc)

	local var_6_0, var_6_1, var_6_2 = IsConditionAchieved(ChipCfg[self.chipManagerID].new_condition)
	local var_6_3 = self.chipManagerDataTemplate_:GetChipManagerIsUnLock(self.chipManagerID)

	self.isUnlock_ = var_6_0

	self.chipManagerLockView_:SetChipManagerID(self.chipManagerID)
	self.chipManagerLockView_:SetActive(not var_6_3)

	if var_6_3 == false then
		if self.isUnlock_ then
			self.btnState:SetSelectedState("unLock2")
		else
			self.btnState:SetSelectedState("unLock1")
		end
	else
		self.btnState:SetSelectedState("unlocked")
	end

	if self.lastIndex then
		self:SelectTab(self.lastIndex)
	end

	manager.redPoint:bindUIandKey(self.btn_unlock2Btn_.transform, string.format("%s_%s", RedPointConst.CHIP_MANAGER, self.chipManagerID))
end

function MimirChipManagerInfoView:AddListeners()
	self:AddBtnListener(self.btn_unlock2Btn_, nil, function()
		if self.isUnlock_ then
			ChipAction.UnlockChipManager(self.chipManagerID)
		else
			ShowTips("CHIP_MANAGER_UNLOCK_FAILED")
		end
	end)
	self:AddBtnListener(self.btn_unlock1Btn_, nil, function()
		ShowTips("CHIP_MANAGER_UNLOCK_FAILED")
	end)

	for iter_7_0 = 1, 2 do
		self:AddBtnListener(self[string.format("btnTab%s_", iter_7_0)], nil, function()
			self:SelectTab(iter_7_0)
		end)
	end
end

function MimirChipManagerInfoView:SelectTab(arg_11_1)
	if arg_11_1 == 1 then
		OperationRecorder.Record("chipManager", "pageDetail")

		self.skillText_.text = GetI18NText(ChipCfg[self.chipManagerID].desc)
		self.lastIndex = arg_11_1
	elseif arg_11_1 == 2 then
		OperationRecorder.Record("chipManager", "pageStory")

		self.skillText_.text = GetI18NText(ChipCfg[self.chipManagerID].story)
		self.lastIndex = arg_11_1
	end

	self.tabControl:SetSelectedState(string.format("select%s", arg_11_1))
end

function MimirChipManagerInfoView:RemoveListeners()
	return
end

function MimirChipManagerInfoView:Dispose()
	MimirChipManagerInfoView.super.Dispose(self)
	self:RemoveListeners()

	if self.chipManagerLockView_ then
		self.chipManagerLockView_:Dispose()

		self.chipManagerLockView_ = nil
	end

	if self.chipManagerUnlockView_ then
		self.chipManagerUnlockView_:Dispose()

		self.chipManagerUnlockView_ = nil
	end

	self.ctrl = nil
end

return MimirChipManagerInfoView
