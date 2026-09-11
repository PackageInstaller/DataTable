local CharChipDetailView = class("CharChipDetailView", ReduxView)

function CharChipDetailView:UIName()
	return "Widget/System/Administrators/AdministratorsChipUpqradeUI"
end

function CharChipDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function CharChipDetailView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.lineController_ = self.doneConEx_:GetController("line")
	self.btnController_ = self.btnConEx_:GetController("btn")
	self.affixItems_ = {}
	self.condItems_ = {}

	SetActive(self.affixItem_, false)
	SetActive(self.condItem_, false)
end

function CharChipDetailView:AddListeners()
	self:AddBtnListener(self.activateBtn_, nil, function()
		ChipAction.ActivateCharChipExtra(self.nextExtraIDToUnlock_)
	end)
end

function CharChipDetailView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.baseID_ = self.params_.baseID
	self.affixList_ = ChipTools.GetCharChipExtraIDList(self.baseID_)

	self:UpdateNextID()
	self:RefreshUI()
end

function CharChipDetailView:UpdateNextID()
	self.nextExtraIDToUnlock_ = ChipTools.GetNextCharChipExtraIDToUnlock(self.baseID_)
	self.affixUnlockList_ = ChipTools.GetCharChipExtraIDListUnlock(self.baseID_)

	if self.nextExtraIDToUnlock_ == 0 then
		self.nextExtraIDToUnlock_ = self.affixUnlockList_[#self.affixUnlockList_]
	end

	self.condList_ = ChipCfg[self.nextExtraIDToUnlock_].module_condition
end

function CharChipDetailView:OnExit()
	manager.windowBar:HideBar()
end

function CharChipDetailView:IndexItemAffix(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.affixList_[arg_9_1], self.nextExtraIDToUnlock_)
end

function CharChipDetailView:IndexItemCond(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.condList_[arg_10_1])
end

function CharChipDetailView:RefreshUI()
	self.charImg_.spriteSync = ChipTools.GetCharChipIcon(self.baseID_)

	self.btnController_:SetSelectedState(ChipTools.IsCharChipExtraCanUnlock(self.nextExtraIDToUnlock_) and "unLock2" or "unLock1")
	self.lineController_:SetSelectedState(tostring(math.min(2, #self.affixUnlockList_)))
	self:RefreshAffixList()
	self:RefreshCondList()
end

function CharChipDetailView:RefreshAffixList()
	local var_12_0 = #self.affixList_

	for iter_12_0, iter_12_1 in ipairs(self.affixItems_) do
		SetActive(iter_12_1.gameObject_, iter_12_0 <= var_12_0)
	end

	for iter_12_2 = 1, var_12_0 do
		local var_12_1 = self.affixItems_[iter_12_2]

		if not self.affixItems_[iter_12_2] then
			local var_12_2 = Object.Instantiate(self.affixItem_, self.affixListTrans_)

			SetActive(var_12_2, true)

			var_12_1 = CharChipExtraItem.New(var_12_2)
			self.affixItems_[iter_12_2] = var_12_1
		end

		self:IndexItemAffix(iter_12_2, var_12_1)
	end
end

function CharChipDetailView:RefreshCondList()
	local var_13_0 = #self.condList_

	for iter_13_0, iter_13_1 in ipairs(self.condItems_) do
		SetActive(iter_13_1.gameObject_, iter_13_0 <= var_13_0)
	end

	for iter_13_2 = 1, var_13_0 do
		local var_13_1 = self.condItems_[iter_13_2]

		if not self.condItems_[iter_13_2] then
			local var_13_2 = Object.Instantiate(self.condItem_, self.condListTrans_)

			SetActive(var_13_2, true)

			var_13_1 = CharChipCondItem.New(var_13_2)
			self.condItems_[iter_13_2] = var_13_1
		end

		self:IndexItemCond(iter_13_2, var_13_1)
	end
end

function CharChipDetailView:OnActivateCharChip()
	self:UpdateNextID()
	self:RefreshUI()
	JumpTools.OpenPageByJump("charChipPowerup", {
		baseID = self.baseID_
	})
end

function CharChipDetailView:Dispose()
	CharChipDetailView.super.Dispose(self)

	for iter_15_0, iter_15_1 in ipairs(self.affixItems_) do
		iter_15_1:Dispose()
	end

	for iter_15_2, iter_15_3 in ipairs(self.condItems_) do
		iter_15_3:Dispose()
	end
end

return CharChipDetailView
