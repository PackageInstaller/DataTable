local ChipItem = class("ChipItem", ReduxView)

function ChipItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockControl = self.mimirchipControllerexcollection_:GetController("lock")
	self.selectControl = self.mimirchipControllerexcollection_:GetController("select")
	self.equipControl = self.mimirchipControllerexcollection_:GetController("equip")
end

function ChipItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(ON_CLICK_CHIP_ITEM, self.chipID_)
	end)
end

function ChipItem:SetChipID(arg_4_1)
	self.chipID_ = arg_4_1
end

function ChipItem:SetTemplateData(arg_5_1)
	self.chipManagerDataTemplate_ = arg_5_1
end

function ChipItem:RefreshUI(arg_6_1, arg_6_2)
	self.gameObject_.name = self.chipID_
	self.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[self.chipID_].picture_id)
	self.name_.text = GetI18NText(ChipCfg[self.chipID_].suit_name)

	local var_6_0 = self:GetUnlockChipIDList()

	if self.chipID_ == arg_6_1 then
		self.selectControl:SetSelectedState("yes")
	else
		self.selectControl:SetSelectedState("no")
	end

	if self.chipManagerDataTemplate_:GetIsUnlockChip(self.chipID_) then
		self.lockControl:SetSelectedState("no")
	else
		self.lockControl:SetSelectedState("yes")
	end

	if self.chipManagerDataTemplate_:GetIsUesChipID(self.chipID_) then
		self.equipControl:SetSelectedState("yes")
	else
		self.equipControl:SetSelectedState("no")
	end

	if self.chipManagerDataTemplate_ and not self.chipManagerDataTemplate_.isNoRed then
		self:BindRedPoint()
	end
end

function ChipItem:Dispose()
	self:UnbindRedPoint()
	ChipItem.super.Dispose(self)
end

function ChipItem:GetUnlockChipIDList()
	return ChipData:GetUnlockChipIDList()
end

function ChipItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.notice_, string.format("%s_%s", RedPointConst.CHIP_CHIP, self.chipID_), {
		x = 0,
		y = 0
	})
end

function ChipItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.notice_)
end

return ChipItem
