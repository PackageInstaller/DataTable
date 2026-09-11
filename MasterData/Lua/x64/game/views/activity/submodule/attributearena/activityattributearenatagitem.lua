local ActivityAttributeArenaTagItem = class("ActivityAttributeArenaTagItem", ReduxView)

function ActivityAttributeArenaTagItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityAttributeArenaTagItem:Init()
	self:InitUI()
end

function ActivityAttributeArenaTagItem:InitUI()
	self:BindCfgUI()
end

function ActivityAttributeArenaTagItem:SetData(arg_4_1)
	if ActivityAttributeArenaCfg[arg_4_1] then
		self.m_tag.sprite = HeroTools.GetSkillAttributeIcon(ActivityAttributeArenaCfg[arg_4_1].attribute)
	end
end

return ActivityAttributeArenaTagItem
