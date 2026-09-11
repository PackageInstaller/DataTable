local GuildActivityRatePremissItem = class("GuildActivityRatePremissItem", ReduxView)

function GuildActivityRatePremissItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivityRatePremissItem:Init()
	self:InitUI()
end

function GuildActivityRatePremissItem:InitUI()
	self:BindCfgUI()
end

function GuildActivityRatePremissItem:SetData(arg_4_1, arg_4_2)
	self.ID_ = arg_4_1
	self.activityID_ = arg_4_2

	local var_4_0, var_4_1, var_4_2 = GuildActivityTools.IsConditionAchieved(self.ID_)

	self.curNum_ = var_4_1
	self.needNum_ = var_4_2
	self.currentText_.text = self.curNum_
	self.targetText_.text = string.format("/%d", var_4_2)

	SetActive(self.completeFlagGo_, var_4_0)

	self.descText_.text = GetI18NText(ConditionCfg[self.ID_].desc)
end

return GuildActivityRatePremissItem
