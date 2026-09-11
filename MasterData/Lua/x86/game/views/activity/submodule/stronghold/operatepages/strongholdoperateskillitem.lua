local StrongholdOperateSkillItem = class("StrongholdOperateSkillItem", ReduxView)

function StrongholdOperateSkillItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.skill_type = arg_1_2

	self:Init()
end

function StrongholdOperateSkillItem:Init()
	self:InitUI()
end

function StrongholdOperateSkillItem:InitUI()
	self:BindCfgUI()

	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
end

function StrongholdOperateSkillItem:RefreshUI()
	for iter_4_0 = 1, 3 do
		local var_4_0 = StrongholdData:GetSkillAffix(self.skill_type, iter_4_0)

		self["m_skillDes" .. iter_4_0].text = getAffixDesc(var_4_0)

		if iter_4_0 == 1 then
			self.m_name.text = getAffixName(var_4_0)
		end
	end

	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. self.skill_type)

	local var_4_1, var_4_2, var_4_3, var_4_4 = StrongholdData:GetStrongholdLevel(self.skill_type)
	local var_4_5 = StrongholdData:GetSkillLimitLv()

	if var_4_2 < var_4_5 then
		self.lockController:SetSelectedIndex(1)

		self.m_lockLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_TYPE_LIMIT_LV"), GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. self.skill_type), var_4_5)
	else
		self.lockController:SetSelectedIndex(0)
	end
end

return StrongholdOperateSkillItem
