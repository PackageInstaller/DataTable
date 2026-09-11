local AdminMimirChipItem = class("AdminMimirChipItem", AdminChipBaseItem)

function AdminMimirChipItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockControl_ = self.conEx_:GetController("lock")
	self.selectControl_ = self.conEx_:GetController("Select")
	self.useControl_ = self.conEx_:GetController("subscript")
	self.posControl_ = self.conEx_:GetController("role")
	self.selected_ = false
end

function AdminMimirChipItem:AddListeners()
	self:AddBtnListener(self.selectBtn_, nil, function()
		manager.notify:CallUpdateFunc("OnClickMimirItem", self, self.chipManagerID_)
	end)
end

function AdminMimirChipItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.chipManagerID_ = arg_4_1
	self.index_ = arg_4_2
	self.animInfo_ = arg_4_4

	self:Show(true)
	self:RefreshUI(arg_4_3)
end

function AdminMimirChipItem:GetItemHeight()
	if self.selected_ then
		return self.posTrs_.sizeDelta.x + self.descTrs_.sizeDelta.x
	else
		return self.posTrs_.sizeDelta.x
	end
end

function AdminMimirChipItem:RefreshUI(arg_6_1)
	self.gameObject_.name = self.chipManagerID_

	local var_6_0 = ChipCfg[self.chipManagerID_]

	self.nameText_.text = ChipCfg[self.chipManagerID_].suit_name
	self.descText_.text = var_6_0.desc
	self.mimirImg_.spriteSync = ChipTools.GetChipManagerIconPath(self.chipManagerID_)

	if self.posControl_ then
		self.posControl_:SetSelectedState(tostring(self.chipManagerID_))
	end

	local var_6_1 = table.keyof(self:GetUnlockChipManagerList(), self.chipManagerID_) == nil
	local var_6_2 = self.chipManagerDataTemplate_:GetISUseChipmanager(self.chipManagerID_)

	self.selectControl_:SetSelectedState(arg_6_1 and "selected" or "unselected")

	if var_6_1 then
		if IsConditionAchieved(var_6_0.new_condition) then
			self.lockControl_:SetSelectedState("Mewlock")
		else
			self.lockControl_:SetSelectedState("locked")
		end
	else
		self.lockControl_:SetSelectedState("unlock")
	end

	self.useControl_:SetSelectedState(var_6_2 and "equiped" or "unequiped")

	if self.chipManagerDataTemplate_ and not self.chipManagerDataTemplate_.isNoRed then
		self:BindRedPoint()
	end

	self:UpdateAnim(arg_6_1, arg_6_1 and "MewItem_expand" or "MewItem_fold")

	self.selected_ = arg_6_1
end

function AdminMimirChipItem:SetTemplateData(arg_7_1)
	self.chipManagerDataTemplate_ = arg_7_1
end

function AdminMimirChipItem:Dispose()
	self:UnbindRedPoint()
	AdminMimirChipItem.super.Dispose(self)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, self.handler_)

	self.handler_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function AdminMimirChipItem:GetUnlockChipManagerList()
	return self.chipManagerDataTemplate_.unlockChipManagerIDList_
end

function AdminMimirChipItem:GetEnabledChipManagerID()
	return ChipData:GetEnabledChipManagerID()
end

function AdminMimirChipItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.notice_, string.format("%s_%s", RedPointConst.CHIP_MANAGER, self.chipManagerID_))
end

function AdminMimirChipItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.notice_)
end

return AdminMimirChipItem
