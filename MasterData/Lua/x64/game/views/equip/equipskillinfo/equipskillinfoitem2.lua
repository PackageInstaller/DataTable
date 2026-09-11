local EquipSkillInfoItem2 = class("EquipSkillInfoItem2", ReduxView)

function EquipSkillInfoItem2:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function EquipSkillInfoItem2:Dispose()
	EquipSkillInfoItem2.super.Dispose(self)
end

function EquipSkillInfoItem2:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.lv_.text = GetTips("LEVEL") .. arg_3_3
	self.desc_.text = EquipSkillCfg[arg_3_1].desc_spec_value ~= nil and EquipSkillCfg[arg_3_1].desc_spec_value ~= "" and string.gsub(desc, tostring(EquipSkillCfg[arg_3_1].upgrade / EquipSkillCfg[arg_3_1].percent * arg_3_3), EquipSkillCfg[arg_3_1].desc_spec_value[i]) or GetCfgDescriptionWithValue(EquipSkillCfg[arg_3_1].desc[1], tostring(EquipSkillCfg[arg_3_1].upgrade / EquipSkillCfg[arg_3_1].percent * arg_3_3))
	self.infoCG_.alpha = arg_3_3 <= arg_3_2 and 1 or 0.5
end

return EquipSkillInfoItem2
