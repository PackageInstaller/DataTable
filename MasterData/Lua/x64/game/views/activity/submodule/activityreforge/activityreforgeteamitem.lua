local ActivityReforgeTeamItem = class("ActivityReforgeTeamItem", ReduxView)

function ActivityReforgeTeamItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeTeamItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityReforgeTeamItem:InitUI()
	self:BindCfgUI()

	self.levelUpController_ = self.controllerEx_:GetController("levelUp")
	self.usingcontroller_ = self.controllerEx_:GetController("using")
	self.recommendcontroller_ = self.controllerEx_:GetController("recommend")
	self.curSelectcontroller_ = self.controllerEx_:GetController("curSelect")
	self.heroHeadItemList_ = {}

	for iter_3_0 = 1, 3 do
		self.heroHeadItemList_[iter_3_0] = ActivityReforgeHeroHeadItem.New(self["heroHeadGo" .. iter_3_0 .. "_"])
	end
end

function ActivityReforgeTeamItem:AddUIListener()
	self:AddBtnListener(self.resetTeamLevelBtn_, nil, function()
		if self.teamInfo_ and self.teamInfo_.level > 1 then
			ActivityReforgeAction.ResetTeamLevel(self.chapterActivityID_, self.levelID_, self.teamInfo_.teamID)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_NO_LEVELUP")
		end
	end)
	self:AddBtnListener(self.teamLevelUpBtn_, nil, function()
		if self.teamInfo_ and #self.teamCfg_.team_info > self.teamInfo_.level then
			ActivityReforgeAction.TeamLevelUp(self.chapterActivityID_, self.levelID_, self.teamInfo_.teamID, function()
				self.teamInfoAni_:Play("LevelUp")
			end)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_LEVEL_MAX")
		end
	end)
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.curWaveID_ == self.curUsingWaveID_ then
			return
		end

		if self.curUsingWaveID_ ~= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_REFORGE_TEAM_USED"),
				OkCallback = function()
					ActivityReforgeAction.SetWaveTeam(self.chapterActivityID_, self.levelID_, self.curWaveID_, self.teamInfo_.teamID, function()
						JumpTools.Back()
					end)
				end
			})
		else
			ActivityReforgeAction.SetWaveTeam(self.chapterActivityID_, self.levelID_, self.curWaveID_, self.teamInfo_.teamID, function()
				JumpTools.Back()
			end)
		end
	end)
end

function ActivityReforgeTeamItem:SetData(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self.chapterActivityID_ = arg_12_1
	self.levelID_ = arg_12_2
	self.curWaveID_ = arg_12_3
	self.teamID_ = arg_12_4
	self.teamInfo_ = ActivityReforgeData:GetTeamInfo(self.teamID_)
	self.teamCfg_ = ActivityReforgeTeamCfg[self.teamID_]
	self.curUsingWaveID_ = ActivityReforgeData:GetTeamCurUsingWaveID(self.teamID_)

	self:UpdateView()
end

function ActivityReforgeTeamItem:UpdateView()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(ActivityReforgeTeamCfg[self.teamInfo_.teamID].team_info[self.teamInfo_.level]) do
		table.insert(var_13_0, iter_13_1)
	end

	for iter_13_2 = 1, 3 do
		self.heroHeadItemList_[iter_13_2]:SetData(ActivityReforgeTeamCfg[self.teamInfo_.teamID].team_info[self.teamInfo_.level][iter_13_2])
		self.heroHeadItemList_[iter_13_2]:SetClickCallBack(function(arg_14_0)
			JumpTools.OpenPageByJump("/newHero", {
				isEnter = true,
				hid = arg_14_0,
				type = HeroConst.HERO_DATA_TYPE.TRIAL,
				tempHeroList = var_13_0
			})
		end)
	end

	self.levelText_.text = self.teamInfo_.level
	self.levelDesText.text = self.teamCfg_.description

	if self.teamCfg_.combo_skill_id > 0 then
		SetActive(self.comboSkillGo_, true)

		self.comboName_.text = GetI18NText(HeroSkillCfg[ComboSkillCfg[self.teamCfg_.combo_skill_id].skill_id].name)
		self.comboLevelText_.text = ComboSkillCfg[self.teamCfg_.combo_skill_id].maxLevel
		self.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", ComboSkillCfg[self.teamCfg_.combo_skill_id].skill_id)
	else
		SetActive(self.comboSkillGo_, false)
	end

	self.teamLevelUpCost_.text = self.teamCfg_.cost[self.teamInfo_.level]

	if self.teamInfo_.level == 1 then
		self.levelUpController_:SetSelectedState("noDown")
	elseif #self.teamCfg_.team_info <= self.teamInfo_.level then
		self.levelUpController_:SetSelectedState("noUp")
	else
		self.levelUpController_:SetSelectedState("mid")
	end

	if table.indexof(ActivityReforgeWaveCfg[self.curWaveID_].recommend_team, self.teamID_) then
		self.recommendcontroller_:SetSelectedState("true")
	else
		self.recommendcontroller_:SetSelectedState("false")
	end

	if self.curUsingWaveID_ == 0 then
		self.usingcontroller_:SetSelectedState("false")
		self.curSelectcontroller_:SetSelectedState("false")
	elseif self.curWaveID_ == self.curUsingWaveID_ then
		self.usingcontroller_:SetSelectedState("false")
		self.curSelectcontroller_:SetSelectedState("true")
	else
		self.usingcontroller_:SetSelectedState("true")
		self.curSelectcontroller_:SetSelectedState("false")

		self.usingWaveText_.text = string.format(GetTips("ACTIVITY_REFORGE_WAVE_USED"), (table.indexof(ActivityReforgeLevelCfg[self.levelID_].wave_list, self.curUsingWaveID_)))
	end
end

function ActivityReforgeTeamItem:Dispose()
	for iter_15_0 = 1, 3 do
		self.heroHeadItemList_[iter_15_0]:Dispose()

		self.heroHeadItemList_[iter_15_0] = nil
	end

	self.heroHeadItemList_ = nil

	ActivityReforgeTeamItem.super.Dispose(self)
end

return ActivityReforgeTeamItem
