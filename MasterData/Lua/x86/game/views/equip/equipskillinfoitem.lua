local EquipSkillInfoItem = class("EquipSkillInfoItem", ReduxView)

function EquipSkillInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function EquipSkillInfoItem:RefreshData(arg_2_1, arg_2_2)
	self.handler_ = arg_2_1
	self.info_ = arg_2_2

	self:RefreshUI()
end

function EquipSkillInfoItem:InitUI()
	self:BindCfgUI()
end

function EquipSkillInfoItem:RefreshUI()
	self.infoCG_.alpha = self.info_.alpha
	self.lv_.text = self.info_.level
	self.desc_.text = self.info_.desc
end

function EquipSkillInfoItem:GetItemInfo()
	return self.info_
end

function EquipSkillInfoItem:Dispose()
	EquipSkillInfoItem.super.Dispose(self)
end

return EquipSkillInfoItem
