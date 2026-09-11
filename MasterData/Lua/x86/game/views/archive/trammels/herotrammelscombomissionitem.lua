local HeroTrammelsComboMissionItem = class("HeroTrammelsComboMissionItem", ReduxView)

function HeroTrammelsComboMissionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTrammelsComboMissionItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrammelsComboMissionItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function HeroTrammelsComboMissionItem:AddUIListener()
	return
end

function HeroTrammelsComboMissionItem:SetData(arg_5_1, arg_5_2)
	local var_5_0 = GetI18NText(ComboSkillLevelCfg[arg_5_1].des)

	if ComboSkillLevelCfg[arg_5_1].condition_type ~= 1 then
		var_5_0 = string.format(var_5_0, GetI18NText(HeroSkillCfg[ComboSkillCfg[arg_5_2].skill_id].name))
	end

	self.m_des.text = var_5_0

	local var_5_1, var_5_2, var_5_3 = ComboSkillTools.CheckComboSkillUpContion(arg_5_1, arg_5_2)

	if var_5_1 then
		self.stateController:SetSelectedIndex(1)
	else
		self.stateController:SetSelectedIndex(0)
	end

	self.m_process.text = var_5_2 .. "/" .. var_5_3
end

function HeroTrammelsComboMissionItem:Dispose()
	HeroTrammelsComboMissionItem.super.Dispose(self)
end

return HeroTrammelsComboMissionItem
