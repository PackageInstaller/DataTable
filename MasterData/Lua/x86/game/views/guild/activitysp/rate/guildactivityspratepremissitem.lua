local GuildActivitySPRatePremissItem = class("GuildActivitySPRatePremissItem", ReduxView)

function GuildActivitySPRatePremissItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivitySPRatePremissItem:Init()
	self:InitUI()
end

function GuildActivitySPRatePremissItem:InitUI()
	self:BindCfgUI()

	self.complateController = ControllerUtil.GetController(self.transform_, "name")
end

function GuildActivitySPRatePremissItem:SetData(arg_4_1, arg_4_2)
	self.ID_ = arg_4_1
	self.activityID_ = arg_4_2

	local var_4_0, var_4_1, var_4_2 = IsConditionAchieved(self.ID_)

	self.curNum_ = math.min(var_4_1, var_4_2)
	self.needNum_ = var_4_2
	self.currentText_.text = self.curNum_
	self.targetText_.text = string.format("/%d", var_4_2)
	self.descText_.text = GuildActivityTools.GetGuildSpConditionDesc(self.ID_)

	if var_4_2 <= self.curNum_ then
		self.complateController:SetSelectedState("true")
	else
		self.complateController:SetSelectedState("false")
	end
end

return GuildActivitySPRatePremissItem
