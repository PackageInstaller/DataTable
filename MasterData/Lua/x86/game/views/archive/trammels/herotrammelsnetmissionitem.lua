local HeroTrammelsNetMissionItem = class("HeroTrammelsNetMissionItem", ReduxView)

function HeroTrammelsNetMissionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTrammelsNetMissionItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrammelsNetMissionItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function HeroTrammelsNetMissionItem:AddUIListener()
	self:AddBtnListener(nil, self.m_unlockBtn, function()
		ArchiveAction.QueryUnlockRelationNet(self.net_id, self.complete)
	end)
end

function HeroTrammelsNetMissionItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	self.net_id = HeroRelationNetCfg.get_id_list_by_hero_id[arg_6_4][arg_6_2]
	self.complete = arg_6_3

	local var_6_0 = HeroRelationUpgradeCfg[arg_6_1].condition_id

	self.m_conditionDes.text = ArchiveTools.GetRelationUpgradeConditionDes(HeroRelationUpgradeCfg[arg_6_1].condition_id)

	local var_6_1 = GetI18NText(PublicAttrCfg[HeroRelationUpgradeCfg[arg_6_1].attr[1][1]].name)
	local var_6_2 = ""

	var_6_2 = PublicAttrCfg[HeroRelationUpgradeCfg[arg_6_1].attr[1][1]].percent == 1 and string.format("%s+%.2f%%", var_6_1, HeroRelationUpgradeCfg[arg_6_1].attr[1][2] / 10) or string.format("%s+%d", var_6_1, HeroRelationUpgradeCfg[arg_6_1].attr[1][2])
	self.m_attrAdd.text = var_6_2
	self.m_lockEffectDes.text = GetTipsF("HERO_RELATION_UPGRADE_UNLOCK", var_6_2)

	if HeroData:GetHeroData(arg_6_4).relation:GetIsUnlock(arg_6_2, arg_6_3) then
		self.stateController:SetSelectedIndex(2)
	elseif ArchiveTools.CheckRelationUpgradeCondition(var_6_0, arg_6_5) then
		self.stateController:SetSelectedIndex(1)
	else
		self.stateController:SetSelectedIndex(0)
	end
end

function HeroTrammelsNetMissionItem:Dispose()
	HeroTrammelsNetMissionItem.super.Dispose(self)
end

return HeroTrammelsNetMissionItem
