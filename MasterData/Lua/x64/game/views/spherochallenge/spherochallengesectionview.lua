SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local SPHeroChallengeSectionView = class("SPHeroChallengeSectionView", SectionBaseView)

function SPHeroChallengeSectionView:Init()
	SPHeroChallengeSectionView.super.Init(self)
	self.hideStageDescController_:SetSelectedState("false")

	self.sectionInfoThreeStarBar_ = SectionInfoThreeStarBar.New(self.threeStarGo_)
end

function SPHeroChallengeSectionView:AddListeners()
	SPHeroChallengeSectionView.super.AddListeners(self)
	self:AddBtnListener(self.timeInfoBtn, nil, function()
		if self.challengeTimeController_:GetSelectedState() == "show" then
			self.challengeTimeController_:SetSelectedState("showTip")

			self.infoTipText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")
		else
			self.challengeTimeController_:SetSelectedState("show")
		end
	end)
end

function SPHeroChallengeSectionView:OnEnter()
	self.info = SPHeroChallengeData:GetCurActivityInfo()

	SPHeroChallengeSectionView.super.OnEnter(self)
	self:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_CHALLENGE, function()
		self:RefreshPlayTime()
	end)
end

function SPHeroChallengeSectionView:UpdateBar()
	return
end

function SPHeroChallengeSectionView:RefreshData()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)

	self.hideFatigueController_:SetSelectedState("close")
	self.btnWebController_:SetSelectedState("close")

	if self.params_.challengeType == SpHeroChallengeConst.ChapterType.story then
		if SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(self.params_.section) then
			self.challengeTimeController_:SetSelectedState("close")
		else
			self.challengeTimeController_:SetSelectedState("show")
		end
	elseif self.params_.sectionType == SpHeroChallengeConst.ChapterType.train then
		self.challengeTimeController_:SetSelectedState("show")
	elseif self.params_.sectionType == SpHeroChallengeConst.ChapterType.boss then
		self.challengeTimeController_:SetSelectedState("show")
		self.refreshTimeController_:SetSelectedState("show")
	end

	self.lock_, self.lockTips_ = SPHeroChallengeTools:CheckStageIsOpen(self.params_.section)
	self.cost_ = 0
	self.isFirstClear_ = self:CheckStageIsFirstClear(self.params_.section)
	self.dropLibID_ = BattleVerthandiExclusiveCfg[self.params_.section].drop_lib_id

	self:RefreshPlayTime()
end

function SPHeroChallengeSectionView:RefreshPlayTime()
	if SPHeroChallengeTools:CheckScheduleNeedCostTime(self.params_.section) then
		self.challengeTimeController_:SetSelectedState("close")

		self.totalNum = 0
		self.curNum = 0
	else
		self.totalNum, self.curNum = SPHeroChallengeData:GetCurActivityInfo():GetChallengeTimes()

		self.challengeTimeController_:SetSelectedState("show")

		self.challengeTime.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REMAIN_TIME"), self.totalNum - self.curNum <= 0 and string.format("<color='#FF000B'>%d</color>", tostring(self.totalNum - self.curNum)) or tostring(self.totalNum - self.curNum), tonumber(1))
	end
end

function SPHeroChallengeSectionView:CheckStageIsFirstClear(arg_9_1)
	if BattleVerthandiExclusiveCfg[arg_9_1].sub_type == SpHeroChallengeConst.ScheduleSubType.story then
		return not table.indexof(self.info.storyFinStageList, arg_9_1)
	else
		return true
	end
end

function SPHeroChallengeSectionView:RefreshStageInfo()
	self.btnWebController_:SetSelectedState("notshow")

	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)

	if self.cfg_ and self.oldCfgID_ ~= self.cfg_.id then
		self.sectionName_.text = GetI18NText(self.cfg_.name)
		self.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, self.cfg_.background_1)
		self.oldCfgID_ = self.cfg_.id
		self.multiple_ = 1

		self.hideThreeStarController_:SetSelectedState("true")

		self.storyText_.text = BattleVerthandiExclusiveCfg[self.params_.section].tips

		if self.params_.challengeType == SpHeroChallengeConst.ChapterType.story then
			self.hideThreeStarController_:SetSelectedState("false")

			self.threeStarDataList_ = {
				{
					SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(self.params_.section),
					{
						8
					}
				},
				{
					false
				},
				{
					false
				}
			}

			self.sectionInfoThreeStarBar_:SetData(self.threeStarDataList_)
		end
	end
end

function SPHeroChallengeSectionView:OnClickBtn()
	local var_11_0, var_11_1 = SPHeroChallengeTools:CheckStoryStageCanBattle(self.params_.section)

	if var_11_0 then
		ShowTips(var_11_1)

		return
	end

	self:GoToSelectHero()
end

function SPHeroChallengeSectionView:GoToSelectHero()
	if not SPHeroChallengeTools:CheckActivityCloseWithTips() then
		if (self.params_.challengeType == SpHeroChallengeConst.ChapterType.train or self.params_.challengeType == SpHeroChallengeConst.ChapterType.boss) and self.totalNum - self.curNum <= 0 then
			local var_12_0 = ""

			if self.params_.challengeType == SpHeroChallengeConst.ChapterType.train then
				var_12_0 = "ACTIVITY_HERO_CHALLENGE_NONE_TRAIN"
			elseif self.params_.challengeType == SpHeroChallengeConst.ChapterType.boss then
				var_12_0 = "ACTIVITY_HERO_CHALLENGE_NONE_BOSS"
			end

			ShowMessageBox({
				content = GetTips(var_12_0),
				OkCallback = function()
					self:Go("/sectionSelectHero", {
						section = self.params_.section,
						sectionType = self.params_.sectionType,
						activityID = self.params_.activityId,
						multiple = self.multiple_,
						dest = self.params_.index
					})
				end,
				CancelCallback = function()
					return
				end
			})
		else
			self:Go("/sectionSelectHero", {
				section = self.params_.section,
				sectionType = self.params_.sectionType,
				activityID = self.params_.activityId,
				multiple = self.multiple_,
				dest = self.params_.index
			})
		end
	end
end

function SPHeroChallengeSectionView:Dispose()
	self.sectionInfoThreeStarBar_:Dispose()

	self.sectionInfoThreeStarBar_ = nil

	SPHeroChallengeSectionView.super.Dispose(self)
end

return SPHeroChallengeSectionView
