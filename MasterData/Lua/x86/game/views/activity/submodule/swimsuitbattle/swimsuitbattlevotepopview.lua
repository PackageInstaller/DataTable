local SwimsuitBattleVotePopView = class("SwimsuitBattleVotePopView", ReduxView)

function SwimsuitBattleVotePopView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitVotePopUI"
end

function SwimsuitBattleVotePopView:UIParent()
	return manager.ui.uiPop.transform
end

function SwimsuitBattleVotePopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SwimsuitBattleVotePopView:InitUI()
	self:BindCfgUI()

	self.voteActivityID_ = 0
	self.voteID_ = 0
	self.heroID_ = 0
	self.skinID_ = 0
	self.voteNum_ = 0
	self.rank_ = 0
	self.round_ = 0
	self.rankController_ = self.mainControllerEx_:GetController("rank")
	self.btnController_ = self.mainControllerEx_:GetController("btn")
end

function SwimsuitBattleVotePopView:AddUIListeners()
	self.voteSlr_.onValueChanged:AddListener(function(arg_6_0)
		self.numText_.text = arg_6_0

		self.btnController_:SetSelectedState(arg_6_0 > 0 and "state0" or "state1")

		self.subBtn_.interactable = arg_6_0 > 0
		self.addBtn_.interactable = arg_6_0 < self.voteSlr_.maxValue
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		if self.voteSlr_.value > 0 then
			self.voteSlr_.value = self.voteSlr_.value - 1
		end
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		if self.voteSlr_.value < self.voteSlr_.maxValue then
			self.voteSlr_.value = self.voteSlr_.value + 1
		end
	end)
	self:AddBtnListener(self.voteBtn_, nil, function()
		if self.voteSlr_.value <= 0 then
			return
		end

		if not SwimsuitBattleData:CheckInRoundTime() then
			return
		end

		manager.ui:UIEventEnabledByUI(false, true)
		SwimsuitBattleAction.VoteForHero(self.voteActivityID_, self.round_, self.voteID_, self.voteSlr_.value)
		self.voteAni_:Play("Vote", -1, 0)

		self.exitTimer_ = Timer.New(function()
			self:Back()
			manager.ui:UIEventEnabledByUI(true, false)

			if self.exitTimer_ then
				self.exitTimer_:Stop()

				self.exitTimer_ = nil
			end
		end, 1.5, 1)

		self.exitTimer_:Start()
	end)
	self:AddBtnListener(self.itemBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.params_.item
		})
	end)
	self:AddBtnListener(self.retBtn_, nil, function()
		self:Back()
	end)
end

function SwimsuitBattleVotePopView:OnEnter()
	self.voteActivityID_ = self.params_.voteActivity
	self.voteID_ = self.params_.id
	self.heroID_ = SwimsuitVoteHeroCfg[self.voteID_].hero_id
	self.skinID_ = SwimsuitBattleData:GetSkinByHeroID(self.heroID_) or tonumber(SwimsuitVoteHeroCfg[self.voteID_].show_image)
	self.voteNum_ = self.params_.vote
	self.rank_ = self.params_.rank
	self.round_ = SwimsuitBattleData:GetCurVoteRound()

	self:UpdateView()
end

function SwimsuitBattleVotePopView:UpdateView()
	self.avatarImg_.spriteAsync = "TextureConfig/Character/Icon/" .. SwimsuitVoteHeroCfg[self.voteID_].show_image
	self.attr1Img_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroID_, true)
	self.attr2Img_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroID_, false)
	self.name1Text_.text = HeroCfg[self.heroID_].suffix
	self.name2Text_.text = SkinCfg[self.skinID_].name
	self.scoreText_.text = self.voteNum_
	self.rankText_.text = self.rank_
	self.supportText_.text = SwimsuitVoteHeroCfg[self.voteID_].vote_support
	self.numText_.text = 0

	self.rankController_:SetSelectedState(self.rank_ >= 4 and "4" or tostring(self.rank_))

	self.voteSlr_.minValue = 0
	self.voteSlr_.maxValue = ItemTools.getItemNum(self.params_.item)
	self.itemText_.text = ItemTools.getItemNum(self.params_.item)

	if self.voteSlr_.value == 0 then
		self.btnController_:SetSelectedState("state1")

		self.subBtn_.interactable = false
		self.addBtn_.interactable = self.voteSlr_.maxValue > 0
	else
		self.voteSlr_.value = 0
	end
end

function SwimsuitBattleVotePopView:OnExit()
	if self.exitTimer_ then
		self.exitTimer_:Stop()

		self.exitTimer_ = nil
	end
end

function SwimsuitBattleVotePopView:Dispose()
	SwimsuitBattleVotePopView.super.Dispose(self)
	self:RemoveAllListeners()
end

return SwimsuitBattleVotePopView
