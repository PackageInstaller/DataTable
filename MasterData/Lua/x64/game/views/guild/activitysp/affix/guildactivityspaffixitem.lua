local GuildActivitySPAffixItem = class("GuildActivitySPAffixItem", ReduxView)

function GuildActivitySPAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1.gameObject
	self.transform_ = arg_1_1

	SetActive(self.gameObject_, true)
	self:Init()
end

function GuildActivitySPAffixItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPAffixItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.unlockController_ = ControllerUtil.GetController(self.transform_, "unlock")
end

function GuildActivitySPAffixItem:AddUIListener()
	self:AddBtnListener(self.Btn_, nil, function()
		if self.selectCallBack_ then
			self.selectCallBack_(self.affixID_, self.level_)
		end
	end)
end

function GuildActivitySPAffixItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	if self.affixID_ == nil then
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, TalentTreeCfg[arg_6_1].activity_id, TalentTreeCfg[arg_6_1].race, arg_6_1))
	elseif self.affixID_ ~= arg_6_1 then
		manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, TalentTreeCfg[self.affixID_].activity_id, TalentTreeCfg[self.affixID_].race, self.affixID_)))
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, TalentTreeCfg[arg_6_1].activity_id, TalentTreeCfg[arg_6_1].race, arg_6_1)))
	end

	self.affixID_ = arg_6_1
	self.unlock_ = arg_6_2
	self.level_ = arg_6_3

	self.unlockController_:SetSelectedState(tostring(arg_6_2))

	if arg_6_2 then
		self.levelText_.text = GetTips("LEVEL") .. arg_6_3
	end

	self.nameText_.text = AffixTypeCfg[TalentTreeCfg[arg_6_1].affix_id].name
end

function GuildActivitySPAffixItem:SetSelectCallBack(arg_7_1)
	self.selectCallBack_ = arg_7_1
end

function GuildActivitySPAffixItem:SetSelect(arg_8_1)
	self.selectController_:SetSelectedState(tostring(self.affixID_ == arg_8_1))
end

function GuildActivitySPAffixItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, TalentTreeCfg[self.affixID_].activity_id, TalentTreeCfg[self.affixID_].race, self.affixID_))

	self.gameObject_ = nil
	self.transform_ = nil
	self.selectCallBack_ = nil

	GuildActivitySPAffixItem.super.Dispose(self)
end

function GuildActivitySPAffixItem:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

return GuildActivitySPAffixItem
