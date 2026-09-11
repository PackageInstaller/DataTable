local SPHeroChallengeStoryView = class("SPHeroChallengeStoryView", import("game.views.sectionSelect.SectionBaseView"))
local var_0_1 = 420

function SPHeroChallengeStoryView:OnCtor(arg_1_1, arg_1_2)
	self.activityID_ = arg_1_2
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	SPHeroChallengeStoryView.super.Init(self)

	self.scrollMoveView_.viewportRect_.sizeDelta = Vector2(self.scrollViewTrs.sizeDelta.x - var_0_1, self.scrollMoveView_.viewportRect_.sizeDelta.y)
	self.scrollMoveView_.viewportRect_.anchoredPosition = Vector2(var_0_1 + self.scrollViewTrs.sizeDelta.x / 2, self.scrollMoveView_.viewportRect_.anchoredPosition.y)
end

function SPHeroChallengeStoryView:OnEnter()
	if self.params_.stageID then
		self.params_.isDetailJump = true
	end

	local var_2_0 = SPHeroChallengeData:GetCurActivityInfo()
	local var_2_2 = self:GetCfgName().get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.story][(#var_2_0.storyFinStageList + 1 > #var_2_0.storyFinStageList or nil) and #var_2_0.storyFinStageList]

	SPHeroChallengeStoryView.super.OnEnter(self)

	if self.params_.isDetailJump then
		local var_2_3 = self.params_.stageID and self.params_.stageID or SPHeroChallengeTools:GetNextCanBattleStageID(SpHeroChallengeConst.ScheduleSubType.story)

		for iter_2_0, iter_2_1 in pairs(self.missionItem_) do
			if iter_2_1.stageID_ == var_2_3 then
				iter_2_1:OnClick()
			end
		end

		self.params_.isDetailJump = nil
	end
end

function SPHeroChallengeStoryView:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function SPHeroChallengeStoryView:OnUpdate()
	self.state = self:IsOpenSectionInfo() and 1 or 2

	SPHeroChallengeStoryView.super.OnUpdate(self)
end

function SPHeroChallengeStoryView:RefreshUI()
	SPHeroChallengeStoryView.super.RefreshUI(self)
	self:SwitchBG()
end

function SPHeroChallengeStoryView:OnExit()
	if self.state == 1 then
		self.state = 2
	end

	SPHeroChallengeStoryView.super.OnExit(self)
end

function SPHeroChallengeStoryView:Dispose()
	if self.gameObject_ then
		GameObject.Destroy(self.gameObject_)

		self.gameObject_ = nil
	end

	SPHeroChallengeStoryView.super.Dispose(self)
end

function SPHeroChallengeStoryView:GetCfgName()
	return BattleVerthandiExclusiveCfg
end

function SPHeroChallengeStoryView:GetSectionItemClass()
	return SPHeroChallengeStroyItem
end

function SPHeroChallengeStoryView:IsOpenSectionInfo()
	return self:IsOpenRoute("spHeroChallengeSectionView")
end

function SPHeroChallengeStoryView:RefreshData()
	self.chapterID_ = SPHeroChallengeData.activityCfg[self.activityID_].storyChapter
	self.stageData_ = {}
	self.stageList_ = ChapterCfg[self.chapterID_].section_id_list

	for iter_11_0, iter_11_1 in ipairs(self.stageList_) do
		self.stageData_[iter_11_1] = {
			id = self.stageList_[iter_11_0]
		}
	end

	self.oepnStageList_ = SPHeroChallengeTools:GetStoryOpenStageList(self.chapterID_, self:GetCfgName())
end

return SPHeroChallengeStoryView
