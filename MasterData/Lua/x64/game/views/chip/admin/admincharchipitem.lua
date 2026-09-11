AdminChipBaseItem = import("game.views.chip.Admin.AdminChipBaseItem")

local AdminCharChipItem = class("AdminCharChipItem", AdminChipBaseItem)

function AdminCharChipItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockControl_ = self.conEx_:GetController("lock")
	self.selectControl_ = self.conEx_:GetController("Select")
	self.useControl_ = self.conEx_:GetController("subscript")
	self.starControl_ = self.conEx_:GetController("star")
	self.selected_ = false
	self.skillItems_ = {}

	for iter_1_0 = 1, 3 do
		if self["skillGo" .. iter_1_0 .. "_"] then
			self.skillItems_[iter_1_0] = CharChipExtraItem.New(self["skillGo" .. iter_1_0 .. "_"].gameObject)
		end
	end
end

function AdminCharChipItem:AddListeners()
	self:AddBtnListener(self.selectBtn_, nil, function()
		manager.notify:CallUpdateFunc("OnClickCharItem", self, self.charBaseID_)
	end)
end

function AdminCharChipItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	self.charBaseID_ = arg_4_1
	self.index_ = arg_4_2
	self.animInfo_ = arg_4_5
	self.sectionProxy_ = arg_4_6

	self:Show(true)
	self:RefreshUI(arg_4_3, arg_4_4)
end

function AdminCharChipItem:GetItemHeight()
	if self.selected_ then
		return self.posTrs_.sizeDelta.x + self.descTrs_.sizeDelta.x
	else
		return self.posTrs_.sizeDelta.x
	end
end

function AdminCharChipItem:RefreshUI(arg_6_1, arg_6_2)
	self.gameObject_.name = self.charBaseID_
	self.charName_.text = ChipCfg[self.charBaseID_].suit_name
	self.charImg_.spriteSync = ChipTools.GetCharChipIcon(self.charBaseID_)

	local var_6_0 = self:IsCharChipBaseUnlock(self.charBaseID_)
	local var_6_1 = #self:GetCharChipExtraIDListUnlock(self.charBaseID_)

	if var_6_0 then
		var_6_1 = var_6_1 + 1
	end

	self.selectControl_:SetSelectedState(arg_6_1 and "selected" or "unselected")

	if var_6_0 then
		local var_6_2 = ChipTools.GetNextCharChipIDToUnlock(self.charBaseID_)

		if var_6_2 ~= 0 and self:IsCharChipExtraCanUnlock(var_6_2) then
			self.lockControl_:SetSelectedState("AffixUnlock")
		else
			self.lockControl_:SetSelectedState("unlock")
		end
	elseif self:IsCharChipBaseCanUnlock(self.charBaseID_) then
		self.lockControl_:SetSelectedState("RoleUnlock")
	else
		self.lockControl_:SetSelectedState("locked")
	end

	self.useControl_:SetSelectedState(arg_6_2 and "equiped" or "unequiped")
	self.starControl_:SetSelectedState(tostring(var_6_1))

	self.skillCanvasGroup_.blocksRaycasts = arg_6_1

	self:UpdateAnim(arg_6_1, arg_6_1 and "RoleItem_expand" or "RoleItem_fold")

	self.selected_ = arg_6_1

	local var_6_3 = ChipTools.GetCharChipExtraIDList(self.charBaseID_)

	for iter_6_0, iter_6_1 in ipairs(self.skillItems_) do
		if iter_6_0 == 1 then
			iter_6_1:SetData(self.charBaseID_, nil, self.sectionProxy_)
		else
			iter_6_1:SetData(var_6_3[iter_6_0 - 1], nil, self.sectionProxy_)
		end
	end

	if self:IsCharChipCanOperate() then
		self:BindRedPoint()
	end
end

function AdminCharChipItem:IsCharChipCanOperate()
	if self.sectionProxy_ == nil then
		return true
	end

	return self.sectionProxy_:IsCharChipCanOperate()
end

function AdminCharChipItem:IsCharChipBaseUnlock(arg_8_1)
	if self.sectionProxy_ == nil then
		return ChipTools.IsCharChipBaseUnlock(arg_8_1)
	end

	return self.sectionProxy_:IsCharChipBaseUnlock(arg_8_1)
end

function AdminCharChipItem:GetCharChipExtraIDListUnlock(arg_9_1)
	if self.sectionProxy_ == nil then
		return ChipTools.GetCharChipExtraIDListUnlock(arg_9_1)
	end

	return self.sectionProxy_:GetCharChipExtraIDListUnlock(arg_9_1)
end

function AdminCharChipItem:IsCharChipExtraCanUnlock(arg_10_1)
	if self.sectionProxy_ == nil then
		return ChipTools.IsCharChipExtraCanUnlock(arg_10_1)
	end

	return self.sectionProxy_:IsCharChipExtraCanUnlock(arg_10_1)
end

function AdminCharChipItem:IsCharChipBaseCanUnlock(arg_11_1)
	if self.sectionProxy_ == nil then
		return ChipTools.IsCharChipBaseCanUnlock(arg_11_1)
	end

	return self.sectionProxy_:IsCharChipBaseCanUnlock(arg_11_1)
end

function AdminCharChipItem:Dispose()
	AdminCharChipItem.super.Dispose(self)

	for iter_12_0, iter_12_1 in ipairs(self.skillItems_) do
		iter_12_1:Dispose()
	end

	self:UnbindRedPoint()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function AdminCharChipItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.posTrs_, string.format("%s_%s", RedPointConst.CHIP_CHAR_CHIP, self.charBaseID_))
end

function AdminCharChipItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.posTrs_)
end

return AdminCharChipItem
