local SPHeroChallengeStroyItem = class("SPHeroChallengeStroyItem", import("game.views.sectionSelect.SectionBaseItem"))

function SPHeroChallengeStroyItem:IsOpenSectionInfo()
	return self:IsOpenRoute("spHeroChallengeSectionView")
end

function SPHeroChallengeStroyItem:InitCustom()
	SetActive(self.collectGo_, false)
	SetActive(self.storyIconGo_, false)
end

function SPHeroChallengeStroyItem:OnClick()
	if not self.isLock_ then
		self:Go("spHeroChallengeSectionView", {
			challengeType = SpHeroChallengeConst.ChapterType.story,
			sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
			section = self.stageID_
		})
	end
end

function SPHeroChallengeStroyItem:RefreshData()
	return
end

function SPHeroChallengeStroyItem:RefreshUI()
	local var_5_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_5_0[1], var_5_0[2], 0)
	self.isLock_ = not table.indexof(SPHeroChallengeTools:GetStoryOpenStageList(SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].storyChapter, BattleVerthandiExclusiveCfg), self.stageID_)

	self.isBossController_:SetSelectedState("false")
	SetActive(self.gameObject_, not self.isLock_)
	self:RefreshText()
	self:RefreshStar()
end

function SPHeroChallengeStroyItem:GetPosition()
	return (BattleVerthandiExclusiveCfg[self.stageID_] or nil) and (BattleVerthandiExclusiveCfg[self.stageID_].position or {
		0,
		0
	})
end

function SPHeroChallengeStroyItem:RefreshText()
	self.text_.text = BattleVerthandiExclusiveCfg[self.stageID_].name
end

function SPHeroChallengeStroyItem:RefreshStar()
	if SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(self.stageID_) then
		for iter_8_0 = 1, 3 do
			self.threeStarBarList_[iter_8_0]:SetData(true)
		end
	else
		for iter_8_1 = 1, 3 do
			self.threeStarBarList_[iter_8_1]:SetData(false)
		end
	end
end

return SPHeroChallengeStroyItem
