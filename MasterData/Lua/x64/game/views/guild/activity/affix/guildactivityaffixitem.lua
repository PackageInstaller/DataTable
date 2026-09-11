local GuildActivityAffixItem = class("GuildActivityAffixItem", ReduxView)

function GuildActivityAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1.gameObject
	self.transform_ = arg_1_1

	SetActive(self.gameObject_, true)
	self:Init()
end

function GuildActivityAffixItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityAffixItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.unlockController_ = ControllerUtil.GetController(self.transform_, "unlock")
end

function GuildActivityAffixItem:AddUIListener()
	self:AddBtnListener(self.Btn_, nil, function()
		if self.selectCallBack_ then
			self.selectCallBack_(self.affixID_, self.level_)
		end
	end)
end

function GuildActivityAffixItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	if self.affixID_ == nil then
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, TalentTreeCfg[arg_6_1].activity_id, TalentTreeCfg[arg_6_1].race, arg_6_1))
	elseif self.affixID_ ~= arg_6_1 then
		manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, TalentTreeCfg[self.affixID_].activity_id, TalentTreeCfg[self.affixID_].race, self.affixID_)))
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, TalentTreeCfg[arg_6_1].activity_id, TalentTreeCfg[arg_6_1].race, arg_6_1)))
	end

	self.affixID_ = arg_6_1
	self.unlock_ = arg_6_2
	self.level_ = arg_6_3

	self.unlockController_:SetSelectedState(tostring(arg_6_2))

	if arg_6_2 then
		self.levelText_.text = GetTips("LEVEL") .. arg_6_3
	end

	self.nameText_.text = GetI18NText(AffixTypeCfg[TalentTreeCfg[arg_6_1].affix_id].name)
end

function GuildActivityAffixItem:SetSelectCallBack(arg_7_1)
	self.selectCallBack_ = arg_7_1
end

function GuildActivityAffixItem:SetSelect(arg_8_1)
	self.selectController_:SetSelectedState(tostring(self.affixID_ == arg_8_1))
end

function GuildActivityAffixItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, TalentTreeCfg[self.affixID_].activity_id, TalentTreeCfg[self.affixID_].race, self.affixID_))

	self.gameObject_ = nil
	self.transform_ = nil
	self.selectCallBack_ = nil

	GuildActivityAffixItem.super.Dispose(self)
end

function GuildActivityAffixItem:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

return GuildActivityAffixItem
