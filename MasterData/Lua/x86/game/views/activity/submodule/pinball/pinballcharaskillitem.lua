local PinballCharaSkillItem = class("PinballCharaSkillItem", BaseView)

function PinballCharaSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PinballCharaSkillItem:Init()
	self:BindCfgUI()
end

function PinballCharaSkillItem:SetData(arg_3_1)
	if PinballSkillCfg[arg_3_1] then
		self.name_.text = GetI18NText(PinballSkillCfg[arg_3_1].name)
		self.desc_.text = PinballTools.GetSkillDesc(arg_3_1)
		self.icon_.spriteSync = PinballTools.GetSkillIconPath(arg_3_1)

		if self.cooldown_ then
			self.cooldown_.text = GetTipsF("PINBALL_SKILL_CD_TIPS", PinballSkillCfg[arg_3_1].cd)
		end

		if self.cost_ then
			self.cost_.text = PinballSkillCfg[arg_3_1].cost
		end
	end
end

function PinballCharaSkillItem:SetVisible(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

return PinballCharaSkillItem
