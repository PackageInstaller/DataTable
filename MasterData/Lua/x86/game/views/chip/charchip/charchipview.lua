local CharChipView = class("CharChipView", ReduxView)

function CharChipView:UIName()
	return "Widget/System/Administrators/AdministratorsChipUI"
end

function CharChipView:UIParent()
	return manager.ui.uiMain.transform
end

function CharChipView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = self.conEx_:GetController("Unlock")
	self.starController_ = self.chipConEx_:GetController("light")
	self.unlockBtnController_ = self.unlockBtnConEx_:GetController("btn")
	self.activateBtnController_ = self.activateBtnConEx_:GetController("btn")
	self.affixController_ = self.listConEx_:GetController("activate")
	self.affixItems_ = {}
	self.condItems_ = {}

	SetActive(self.affixItem_, false)
	SetActive(self.condItem_, false)

	self.skillItems_ = {}

	for iter_3_0 = 1, 3 do
		if self["skillGo" .. iter_3_0 .. "_"] then
			self.skillItems_[iter_3_0] = CharChipExtraItem.New(self["skillGo" .. iter_3_0 .. "_"].gameObject)
		end
	end
end

function CharChipView:AddListeners()
	self:AddBtnListener(self.unlockBtn_, nil, function()
		if ChipTools.IsCharChipBaseUnlock(self.baseID_) then
			ChipAction.ActivateCharChipExtra(self.nextIDToUnlock_)
		else
			ChipAction.ActivateCharChipBase(self.baseID_)
		end
	end)
end

function CharChipView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.baseID_ = self.params_.baseID
	self.affixList_ = ChipTools.GetCharChipExtraIDList(self.baseID_)
	self.sectionProxy_ = self.params_.sectionProxy

	self:UpdateNextID()
	self:RefreshUI()
end

function CharChipView:OnExit()
	manager.windowBar:HideBar()
	self:UnbindRedPoint()
end

function CharChipView:IndexItemAffix(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.affixList_[arg_8_1])
end

function CharChipView:IndexItemCond(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.condList_[arg_9_1])
end

function CharChipView:UpdateNextID()
	self.nextIDToUnlock_ = ChipTools.GetNextCharChipIDToUnlock(self.baseID_)
	self.affixUnlockList_ = ChipTools.GetCharChipExtraIDListUnlock(self.baseID_)

	if self.nextIDToUnlock_ == 0 then
		self.nextIDToUnlock_ = self.affixUnlockList_[#self.affixUnlockList_]
	end

	self.condList_ = ChipCfg[self.nextIDToUnlock_].module_condition
end

function CharChipView:OnActivateCharChip()
	self:UpdateNextID()
	self:RefreshUI()
	JumpTools.OpenPageByJump("charChipPowerup", {
		baseID = self.baseID_
	})
end

function CharChipView:RefreshUI()
	self.charImg_.spriteSync = ChipTools.GetCharChipIcon(self.baseID_)
	self.charName_.text = ChipCfg[self.baseID_].suit_name
	self.charDesc_.text = ChipCfg[self.baseID_].desc

	if self:IsCharChipBaseUnlock(self.baseID_) then
		self.starController_:SetSelectedState(tostring(#self.affixUnlockList_ + 1))
		self.lockController_:SetSelectedState("unlock")

		if #self.affixList_ == #self.affixUnlockList_ then
			self.activateBtnController_:SetSelectedState("hide")
		else
			self.activateBtnController_:SetSelectedState(ChipTools.IsCharChipExtraCanUnlock(self.nextIDToUnlock_) and "unLock2" or "unLock1")
		end
	else
		self.starController_:SetSelectedState("0")
		self.lockController_:SetSelectedState("lock")
		self.activateBtnController_:SetSelectedState(ChipTools.IsCharChipBaseCanUnlock(self.baseID_) and "unLock2" or "unLock1")
	end

	for iter_12_0, iter_12_1 in ipairs(self.skillItems_) do
		if iter_12_0 == 1 then
			iter_12_1:SetData(self.baseID_, self.nextIDToUnlock_, self.sectionProxy_)
		else
			iter_12_1:SetData(self.affixList_[iter_12_0 - 1], self.nextIDToUnlock_, self.sectionProxy_)
		end
	end

	if self.sectionProxy_ and self.sectionProxy_:IsCharChipCanOperate() then
		-- block empty
	else
		self:UnbindRedPoint()
	end

	if self.sectionProxy_ ~= nil then
		if self.sectionProxy_:IsCharChipCanOperate() then
			self:BindRedPoint()
		else
			self.activateBtnController_:SetSelectedState("hide")
			self:UnbindRedPoint()
		end
	else
		self:BindRedPoint()
	end
end

function CharChipView:IsCharChipBaseUnlock(arg_13_1)
	if self.sectionProxy_ ~= nil then
		return self.sectionProxy_:IsCharChipBaseUnlock(arg_13_1)
	else
		return ChipTools.IsCharChipBaseUnlock(arg_13_1)
	end
end

function CharChipView:RefreshAffixList()
	return
end

function CharChipView:RefreshCondList()
	local var_15_0 = #self.condList_

	for iter_15_0, iter_15_1 in ipairs(self.condItems_) do
		SetActive(iter_15_1.gameObject_, iter_15_0 <= var_15_0)
	end

	for iter_15_2 = 1, var_15_0 do
		local var_15_1 = self.condItems_[iter_15_2]

		if not self.condItems_[iter_15_2] then
			local var_15_2 = Object.Instantiate(self.condItem_, self.condListTrans_)

			SetActive(var_15_2, true)

			var_15_1 = CharChipCondItem.New(var_15_2)
			self.condItems_[iter_15_2] = var_15_1
		end

		self:IndexItemCond(iter_15_2, var_15_1)
	end
end

function CharChipView:Dispose()
	CharChipView.super.Dispose(self)

	for iter_16_0, iter_16_1 in ipairs(self.skillItems_) do
		iter_16_1:Dispose()
	end
end

function CharChipView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.unlockBtn_.transform, string.format("%s_%s", RedPointConst.CHIP_CHAR_CHIP, self.baseID_))
end

function CharChipView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.unlockBtn_.transform)
end

return CharChipView
