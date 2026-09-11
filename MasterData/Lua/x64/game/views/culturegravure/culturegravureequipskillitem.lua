local CultureGravureEquipSkillItem = class("CultureGravureEquipSkillItem", ReduxView)

function CultureGravureEquipSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureEquipSkillItem:Init()
	self:InitUI()
	self:AddListeners()
end

function CultureGravureEquipSkillItem:InitUI()
	self:BindCfgUI()

	self.recommendController_ = self.transCon_:GetController("recommend")
end

function CultureGravureEquipSkillItem:AddListeners()
	return
end

function CultureGravureEquipSkillItem:SetData(arg_5_1)
	self.equipSkillId_ = arg_5_1.id
	self.recommmendLevel_ = arg_5_1.recommendLevel
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[self.equipSkillId_].icon)
	self.nameText_.text = EquipSkillCfg[self.equipSkillId_].name

	local var_5_0 = GetCfgDescriptionWithValue(EquipSkillCfg[self.equipSkillId_].desc[1], tostring(EquipSkillCfg[self.equipSkillId_].upgrade / EquipSkillCfg[self.equipSkillId_].percent * EquipSkillCfg[self.equipSkillId_].lvmax))

	if EquipSkillCfg[self.equipSkillId_].desc_spec_value ~= nil and EquipSkillCfg[self.equipSkillId_].desc_spec_value ~= "" then
		var_5_0 = string.gsub(var_5_0, tostring(EquipSkillCfg[self.equipSkillId_].upgrade / EquipSkillCfg[self.equipSkillId_].percent * EquipSkillCfg[self.equipSkillId_].lvmax), EquipSkillCfg[self.equipSkillId_].desc_spec_value[EquipSkillCfg[self.equipSkillId_].lvmax])
	end

	self.descText_.text = GetI18NText(var_5_0)

	self.recommendController_:SetSelectedState(self.recommmendLevel_)
end

function CultureGravureEquipSkillItem:Dispose()
	CultureGravureEquipSkillItem.super.Dispose(self)
end

return CultureGravureEquipSkillItem
