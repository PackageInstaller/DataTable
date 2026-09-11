local HodurSelectBossItem = class("HodurSelectBossItem", ReduxView)

function HodurSelectBossItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HodurSelectBossItem:InitUI()
	self:BindCfgUI()
end

function HodurSelectBossItem:SetData(arg_3_1, arg_3_2)
	self.bossID_ = arg_3_1
	self.skillIndex_ = arg_3_2

	self:RefreshUI()
end

function HodurSelectBossItem:RefreshUI()
	self.nameText_.text = MonsterCfg[self.bossID_]["skill" .. self.skillIndex_]
	self.descText_.text = MonsterCfg[self.bossID_]["skill_desc" .. self.skillIndex_]

	if MonsterCfg[self.bossID_]["skill" .. self.skillIndex_] == "" then
		self:Show(false)
	else
		self:Show(true)
	end
end

function HodurSelectBossItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function HodurSelectBossItem:Dispose()
	HodurSelectBossItem.super.Dispose(self)
end

return HodurSelectBossItem
