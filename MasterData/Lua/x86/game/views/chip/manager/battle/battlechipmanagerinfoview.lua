local BattleChipManagerInfoView = class("BattleChipManagerInfoView", (import("game.views.chip.manager.MimirChipManagerInfoView")))

function BattleChipManagerInfoView:InitUI()
	BattleChipManagerInfoView.super.InitUI(self)

	self.chipManagerUnlockView_ = ChipManagerUnlockView.New(self.chipGo_)
end

function BattleChipManagerInfoView:RefreshData(arg_2_1)
	self.chipManagerID = arg_2_1
	self.chipManagerName_.text = GetI18NText(ChipCfg[self.chipManagerID].suit_name)
	self.skillText_.text = GetI18NText(ChipCfg[self.chipManagerID].desc)

	local var_2_0, var_2_1, var_2_2 = IsConditionAchieved(ChipCfg[self.chipManagerID].new_condition)
	local var_2_3 = self.chipManagerDataTemplate_:GetChipManagerIsUnLock(self.chipManagerID)

	self.isUnlock_ = var_2_0

	self.chipManagerLockView_:SetActive(not var_2_3)
	self.chipManagerUnlockView_:SetActive(var_2_3)

	if var_2_3 == false then
		if self.isUnlock_ then
			self.btnState:SetSelectedState("unLock2")
		else
			self.btnState:SetSelectedState("unLock1")
		end

		self.chipManagerLockView_:SetChipManagerID(self.chipManagerID)
	else
		if self.chipManagerDataTemplate_:GetISUseChipmanager(self.chipManagerID) then
			self.btnState:SetSelectedState("unUse")
		else
			self.btnState:SetSelectedState("use")
		end

		self.chipManagerUnlockView_:SetDataTemplate(self.chipManagerDataTemplate_)
		self.chipManagerUnlockView_:SetChipManagerID(self.chipManagerID)
	end

	if self.lastIndex then
		self:SelectTab(self.lastIndex)
	end

	manager.redPoint:bindUIandKey(self.btn_unlock2Btn_.transform, string.format("%s_%s", RedPointConst.CHIP_MANAGER, self.chipManagerID))
end

function BattleChipManagerInfoView:AddListeners()
	self.super.AddListeners(self)
	self:AddBtnListener(self.btn_unuseBtn_, nil, function()
		self.chipManagerDataTemplate_:SetUseChipmanagerId(0)

		if self.enableIDFunc_ then
			self.enableIDFunc_(0)
		end

		ShowTips("CHIP_MANAGER_UNLOAD_SUCCESS")
	end)
	self:AddBtnListener(self.btn_useBtn_, nil, function()
		self.chipManagerDataTemplate_:SetUseChipmanagerId(self.chipManagerID)

		if self.enableIDFunc_ then
			self.enableIDFunc_(self.chipManagerID)
		end

		ShowTips("CHIP_MANAGER_USE_SUCCESS")
	end)
end

function BattleChipManagerInfoView:RegistEnableIDFunc(arg_6_1)
	self.enableIDFunc_ = arg_6_1
end

function BattleChipManagerInfoView:Dispose()
	BattleChipManagerInfoView.super.Dispose(self)

	if self.chipManagerUnlockView_ then
		self.chipManagerUnlockView_:Dispose()

		self.chipManagerUnlockView_ = nil
	end
end

return BattleChipManagerInfoView
