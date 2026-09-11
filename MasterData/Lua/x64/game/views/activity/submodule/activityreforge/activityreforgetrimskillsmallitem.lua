local ActivityReforgeTrimSkillSkillItem = class("ActivityReforgeTrimSkillSkillItem", ReduxView)

function ActivityReforgeTrimSkillSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeTrimSkillSkillItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeTrimSkillSkillItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.skillStateController_ = self.controllerEx_:GetController("skillState")
end

function ActivityReforgeTrimSkillSkillItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 2,
			viewType = 2,
			activityID = self.activityID_,
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_,
			skillID = self.skillID_
		})
	end)
end

function ActivityReforgeTrimSkillSkillItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.activityID_ = arg_6_1
	self.chapterActivityID_ = arg_6_2
	self.levelID_ = arg_6_3
	self.skillID_ = arg_6_4

	if self.skillID_ == 0 then
		self.stateController_:SetSelectedState("empty")
	else
		self.stateController_:SetSelectedState("icon")

		self.icon_.sprite = getSprite("Atlas/ValhallaSkillAtlas", ActivityReforgeSkillCfg[self.skillID_].icon)
		self.skillStatus_, self.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(self.activityID_, self.levelID_, self.skillID_)

		if self.skillStatus_ == "freeUsing" or self.skillStatus_ == "infiniteUsing" then
			self.skillStateController_:SetSelectedState("infinite")
		else
			self.skillStateController_:SetSelectedState("useNum" .. ActivityReforgeSkillCfg[self.skillID_].count)

			for iter_6_0 = 1, 3 do
				if iter_6_0 <= self.skillCanUseNum_ then
					SetActive(self["useNumGo" .. iter_6_0 .. "_"], true)
				else
					SetActive(self["useNumGo" .. iter_6_0 .. "_"], false)
				end
			end
		end
	end
end

function ActivityReforgeTrimSkillSkillItem:Dispose()
	ActivityReforgeTrimSkillSkillItem.super.Dispose(self)
end

return ActivityReforgeTrimSkillSkillItem
