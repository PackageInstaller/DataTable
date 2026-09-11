local ActivityReforgeTrimSkillBigItem = class("ActivityReforgeTrimSkillBigItem", ReduxView)

function ActivityReforgeTrimSkillBigItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeTrimSkillBigItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeTrimSkillBigItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.skillStateController_ = self.controllerEx_:GetController("skillState")
end

function ActivityReforgeTrimSkillBigItem:AddUIListeners()
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
	self:AddBtnListener(self.addBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 1,
			viewType = 2,
			activityID = self.activityID_,
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_,
			slot = self.index_
		})
	end)
end

function ActivityReforgeTrimSkillBigItem:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.activityID_ = arg_7_1
	self.chapterActivityID_ = arg_7_2
	self.levelID_ = arg_7_3
	self.index_ = arg_7_4
	self.skillID_ = ActivityReforgeData:GetCurUsingInitiativeSkill(self.index_)

	if self.skillID_ == 0 then
		self.stateController_:SetSelectedState("empty")
	else
		self.stateController_:SetSelectedState("icon")

		self.nameText_.text = ActivityReforgeSkillCfg[self.skillID_].name
		self.icon_.sprite = getSprite("Atlas/ValhallaSkillAtlas", ActivityReforgeSkillCfg[self.skillID_].icon)
		self.skillStatus_, self.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(self.activityID_, self.levelID_, self.skillID_)

		if self.skillStatus_ == "freeUsing" or self.skillStatus_ == "infiniteUsing" then
			self.skillStateController_:SetSelectedState("infinite")
		else
			self.skillStateController_:SetSelectedState("useNum" .. ActivityReforgeSkillCfg[self.skillID_].count)

			for iter_7_0 = 1, 3 do
				if iter_7_0 <= self.skillCanUseNum_ then
					SetActive(self["useNumGo" .. iter_7_0 .. "_"], true)
				else
					SetActive(self["useNumGo" .. iter_7_0 .. "_"], false)
				end
			end
		end
	end
end

function ActivityReforgeTrimSkillBigItem:Dispose()
	ActivityReforgeTrimSkillBigItem.super.Dispose(self)
end

return ActivityReforgeTrimSkillBigItem
