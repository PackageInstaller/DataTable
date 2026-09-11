local EquipSkillLocationItem = class("EquipSkillLocationItem", ReduxView)

function EquipSkillLocationItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function EquipSkillLocationItem:RefreshData(arg_2_1, arg_2_2)
	self.handler_ = arg_2_1
	self.info_ = arg_2_2

	self:RefreshUI()
end

function EquipSkillLocationItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.stateCon_:GetController("state")
	self.posController_ = self.stateCon_:GetController("pos")
end

function EquipSkillLocationItem:RefreshUI()
	if self.info_.isEquip then
		self.stateController_:SetSelectedState("equip")

		self.equipIcon_.sprite = ItemTools.getItemSprite(self.info_.prefab_id)

		self.posController_:SetSelectedState(EquipCfg[self.info_.prefab_id].pos)

		self.nameText_.text = ItemTools.getItemName(self.info_.prefab_id)
	else
		self.stateController_:SetSelectedState("transition")

		self.nameText_.text = GetTips("UPGRADE_STAR")
	end

	self.lvText_.text = "+" .. self.info_.level
end

function EquipSkillLocationItem:GetItemInfo()
	return self.info_
end

function EquipSkillLocationItem:Dispose()
	EquipSkillLocationItem.super.Dispose(self)
end

return EquipSkillLocationItem
