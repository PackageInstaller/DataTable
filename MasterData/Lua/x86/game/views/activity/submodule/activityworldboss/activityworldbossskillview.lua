local ActivityWorldBossSkillView = class("ActivityWorldBossSkillView", ReduxView)

function ActivityWorldBossSkillView:UIName()
	return "UI/EmptyDream/WorldBoss/EDream_WorldBossPopUI"
end

function ActivityWorldBossSkillView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityWorldBossSkillView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityWorldBossSkillView:InitUI()
	self:BindCfgUI()

	self.skillList_ = {}
end

function ActivityWorldBossSkillView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function ActivityWorldBossSkillView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ActivityWorldBossSkillView:OnEnter()
	self.bossID_ = self.params_.bossID
	self.portraitImage_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/solo582x648/%s", self.params_.bossID))
	self.nameText_.text = GetMonsterName({
		self.bossID_
	})
	self.tagText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[self.params_.bossID].race)

	local var_8_0 = GetMonsterSkillDesList({
		self.bossID_
	})
	local var_8_1 = 1

	for iter_8_0 = 1, 6 do
		if var_8_0[iter_8_0] then
			self.skillList_[var_8_1] = self.skillList_[var_8_1] or BattleBossChallengeSkillItem.New(self.skillItem_, self.skillParent_)

			self.skillList_[var_8_1]:RefreshUI(var_8_0[iter_8_0])

			var_8_1 = var_8_1 + 1
		end
	end

	for iter_8_1 = var_8_1, #self.skillList_ do
		self.skillList_[iter_8_1]:Hide()
	end
end

function ActivityWorldBossSkillView:OnExit()
	manager.windowBar:HideBar()
end

function ActivityWorldBossSkillView:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.skillList_) do
		iter_10_1:Dispose()
	end

	self.skillList_ = nil

	ActivityWorldBossSkillView.super.Dispose(self)
end

return ActivityWorldBossSkillView
