local NewHeroChipItem = class("NewHeroChipItem", ReduxView)

function NewHeroChipItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.selectController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("select")
	self.lockController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("lock")
	self.equipController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("equip")

	self:AddListeners()
end

function NewHeroChipItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_(self.chipID_)
		end
	end)
end

function NewHeroChipItem:SetData(arg_4_1, arg_4_2)
	self.chipID_ = arg_4_1
	self.curChipID_ = arg_4_2

	self:RefreshUI()
end

function NewHeroChipItem:SetCallBack(arg_5_1)
	self.clickFunc_ = arg_5_1
end

function NewHeroChipItem:RefreshUI()
	self.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[self.chipID_].picture_id)
	self.name_.text = ChipCfg[self.chipID_].suit_name

	self:RefreshStatus()
	self:BindRedPoint()
end

function NewHeroChipItem:RefreshStatus()
	if ChipData:GetIsUnlockHeroChip(self.chipID_) then
		self.lockController_:SetSelectedState("no")
	else
		self.lockController_:SetSelectedState("yes")
	end

	local var_7_0, var_7_1 = ChipData:GetHeroChipIsEnableByChipId(self.chipID_)

	if var_7_0 then
		self.equipController_:SetSelectedState("yes")
	else
		self.equipController_:SetSelectedState("no")
	end

	if self.chipID_ == self.curChipID_ then
		self.selectController_:SetSelectedState("yes")
	else
		self.selectController_:SetSelectedState("no")
	end
end

function NewHeroChipItem:Dispose()
	self:UnbindRedPoint()
	NewHeroChipItem.super.Dispose(self)

	self.clickFunc_ = nil
end

function NewHeroChipItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.redPoint_, ChipCfg[self.chipID_].cost_condition ~= "" and RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. ChipCfg[self.chipID_].spec_char .. "_" .. ChipCfg[self.chipID_].role_type_id .. "_" .. self.chipID_ or RedPointConst.CHIP_HERO_CHIP .. "_" .. ChipCfg[self.chipID_].spec_char .. "_" .. ChipCfg[self.chipID_].role_type_id .. "_" .. self.chipID_)
end

function NewHeroChipItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.redPoint_, ChipCfg[self.chipID_].cost_condition ~= "" and RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. ChipCfg[self.chipID_].spec_char .. "_" .. ChipCfg[self.chipID_].role_type_id .. "_" .. self.chipID_ or RedPointConst.CHIP_HERO_CHIP .. "_" .. ChipCfg[self.chipID_].spec_char .. "_" .. ChipCfg[self.chipID_].role_type_id .. "_" .. self.chipID_)
end

return NewHeroChipItem
