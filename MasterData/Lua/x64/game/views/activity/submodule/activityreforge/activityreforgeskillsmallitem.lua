local ActivityReforgeSkillSmallItem = class("ActivityReforgeSkillSmallItem", ReduxView)

function ActivityReforgeSkillSmallItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeSkillSmallItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeSkillSmallItem:InitUI()
	self:BindCfgUI()

	self.emptyController_ = self.controllerEx_:GetController("empty")
end

function ActivityReforgeSkillSmallItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 1,
			viewType = 2,
			activityID = self.activityID_,
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_,
			skillID = self.skillID_,
			slot = self.index_
		})
	end)
end

function ActivityReforgeSkillSmallItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.activityID_ = arg_6_1
	self.chapterActivityID_ = arg_6_2
	self.levelID_ = arg_6_3
	self.index_ = arg_6_4
	self.skillID_ = ActivityReforgeData:GetCurUsingInitiativeSkill(self.index_)

	if self.skillID_ == 0 then
		self.emptyController_:SetSelectedState("true")
	else
		self.emptyController_:SetSelectedState("false")

		self.icon_.sprite = getSprite("Atlas/ValhallaSkillAtlas", ActivityReforgeSkillCfg[self.skillID_].icon)
	end
end

function ActivityReforgeSkillSmallItem:Dispose()
	self.super.Dispose(self)
end

return ActivityReforgeSkillSmallItem
