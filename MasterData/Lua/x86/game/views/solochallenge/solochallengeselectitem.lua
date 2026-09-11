local SoloChallengeSelectItem = class("SoloChallengeSelectItem", ReduxView)

function SoloChallengeSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function SoloChallengeSelectItem:Init()
	self.affixList_ = {}

	self:InitUI()
	self:AddUIListener()

	self.heroSelectController = ControllerUtil.GetController(self.transform_, "heroSelect")
	self.lockStateController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.adaptImg_ = self:FindCom("AdaptImage", nil, self.bossTrans_)
end

function SoloChallengeSelectItem:InitUI()
	self:BindCfgUI()
end

function SoloChallengeSelectItem:AddUIListener()
	self:AddBtnListener(self.heroBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		HeroData:ResetSortValue()
		BattleFieldData:SetCurrentSelectHeroData(self.heroID_, self.trialID_)
		self:Go("/heroTeamInfoSoloChallenge", {
			isEnter = true,
			reorder = false,
			selectHeroPos = self.selectHeroPos_,
			stageID = self.stageID_,
			activityID = self.activityID_,
			stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
			difficultyIndex = self.difficultyIndex_,
			reserveParams = self.reserveParams_
		})
	end)

	if self.bossBtn_ ~= nil then
		self:AddBtnListener(self.bossBtn_, nil, function()
			local var_6_0

			if not ActivityData:GetActivityIsOpen(self.activityID_) then
				ShowTips("TIME_OVER")

				do return end

				var_6_0 = {
					activityID = self.activityID_
				}
			end

			var_6_0.bossID = ActivitySoloChallengeCfg[self.activityID_].boss_id_list[self.selectHeroPos_]

			JumpTools.OpenPageByJump("soloChallengeBossInfo", var_6_0)
		end)
	end
end

function SoloChallengeSelectItem:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.activityID_ = arg_7_1
	self.stageID_ = arg_7_2
	self.selectHeroPos_ = arg_7_3
	self.difficultyIndex_ = arg_7_4
	self.difficultId_ = ActivitySoloChallengeCfg[self.activityID_].stage_id[self.difficultyIndex_][1]
	self.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE, self.difficultId_, self.selectHeroPos_, {
		stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
		stageID = self.stageID_,
		activityID = self.activityID_,
		difficultyIndex = self.difficultyIndex_
	})

	self:RefreshUI()
end

function SoloChallengeSelectItem:RefreshUI()
	self:RefreshAffix()
	self:RefreshHeroState()
	self:RefreshEnemyUI()
	self:RefreshLockState()
	self:RefreshTitle()
end

function SoloChallengeSelectItem:RefreshAffix()
	local var_9_0 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, self.stageID_):GetContDataTemplateById(self.difficultId_):GetAffixList(self.selectHeroPos_)

	for iter_9_0 = 1, SoloChallengeData:GetMaxAffixCount(self.activityID_) do
		local var_9_2 = var_9_0[iter_9_0] or 0

		if self.affixList_[iter_9_0] == nil then
			self.affixList_[iter_9_0] = SoloChallengeAffixItem.New((Object.Instantiate(self.affixItemTemplate_, self.affixListTrans_)))
		end

		self.affixList_[iter_9_0]:SetData(self.activityID_, var_9_2)
		self.affixList_[iter_9_0]:SetState({
			stageID = self.stageID_,
			pos = iter_9_0
		})
	end
end

function SoloChallengeSelectItem:RefreshHeroState()
	local var_10_0, var_10_1, var_10_2, var_10_3 = ReserveTools.GetHeroList(self.reserveParams_)

	self.heroID_ = var_10_0[1]
	self.trialID_ = var_10_3[1]

	if self.heroID_ ~= 0 then
		self.heroSelectController:SetSelectedState("on")

		self.headIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", SkinCfg[self.trialID_ ~= 0 and HeroStandardSystemCfg[self.trialID_].skin_id or HeroTools.HeroUsingSkinInfo(self.heroID_).id].picture_id)

		self.headIcon_:SetNativeSize()
	else
		self.heroSelectController:SetSelectedState("off")
	end
end

function SoloChallengeSelectItem:RefreshEnemyUI()
	self.bossIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", BattleSoloChallengeStageCfg[self.stageID_].hd_image)

	self.adaptImg_:AdaptImg()
end

function SoloChallengeSelectItem:RefreshTitle()
	self.titleText_.text = GetTips(string.format("TEAM_%d", self.selectHeroPos_))
end

function SoloChallengeSelectItem:RefreshLockState()
	if table.keyof(SoloChallengeData:GetCompletedStageList(self.activityID_)[self.difficultyIndex_], self.stageID_) then
		self.heroBtn_.interactable = false

		self.lockStateController_:SetSelectedState("lock")
	else
		self.heroBtn_.interactable = true

		self.lockStateController_:SetSelectedState("unlock")
	end
end

function SoloChallengeSelectItem:Dispose()
	if self.affixList_ then
		for iter_14_0, iter_14_1 in pairs(self.affixList_) do
			iter_14_1:Dispose()

			self.affixList_[iter_14_0] = nil
		end

		self.affixList_ = nil
	end

	SoloChallengeSelectItem.super.Dispose(self)
end

return SoloChallengeSelectItem
