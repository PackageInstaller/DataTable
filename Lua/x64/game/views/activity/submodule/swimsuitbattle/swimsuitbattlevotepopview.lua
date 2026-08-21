local var_0_0 = class("SwimsuitBattleVotePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitVotePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.voteActivityID_ = 0
	arg_4_0.voteID_ = 0
	arg_4_0.heroID_ = 0
	arg_4_0.skinID_ = 0
	arg_4_0.voteNum_ = 0
	arg_4_0.rank_ = 0
	arg_4_0.round_ = 0
	arg_4_0.rankController_ = arg_4_0.mainControllerEx_:GetController("rank")
	arg_4_0.btnController_ = arg_4_0.mainControllerEx_:GetController("btn")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0.voteSlr_.onValueChanged:AddListener(function(arg_6_0)
		arg_5_0.numText_.text = arg_6_0

		arg_5_0.btnController_:SetSelectedState(arg_6_0 > 0 and "state0" or "state1")

		arg_5_0.subBtn_.interactable = arg_6_0 > 0
		arg_5_0.addBtn_.interactable = arg_6_0 < arg_5_0.voteSlr_.maxValue
	end)
	arg_5_0:AddBtnListener(arg_5_0.subBtn_, nil, function()
		if arg_5_0.voteSlr_.value > 0 then
			arg_5_0.voteSlr_.value = arg_5_0.voteSlr_.value - 1
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.addBtn_, nil, function()
		if arg_5_0.voteSlr_.value < arg_5_0.voteSlr_.maxValue then
			arg_5_0.voteSlr_.value = arg_5_0.voteSlr_.value + 1
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.voteBtn_, nil, function()
		if arg_5_0.voteSlr_.value <= 0 then
			return
		end

		if not SwimsuitBattleData:CheckInRoundTime() then
			return
		end

		manager.ui:UIEventEnabledByUI(false, true)
		SwimsuitBattleAction.VoteForHero(arg_5_0.voteActivityID_, arg_5_0.round_, arg_5_0.voteID_, arg_5_0.voteSlr_.value)
		arg_5_0.voteAni_:Play("Vote", -1, 0)

		arg_5_0.exitTimer_ = Timer.New(function()
			arg_5_0:Back()
			manager.ui:UIEventEnabledByUI(true, false)

			if arg_5_0.exitTimer_ then
				arg_5_0.exitTimer_:Stop()

				arg_5_0.exitTimer_ = nil
			end
		end, 1.5, 1)

		arg_5_0.exitTimer_:Start()
	end)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_5_0.params_.item
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.retBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.voteActivityID_ = arg_13_0.params_.voteActivity
	arg_13_0.voteID_ = arg_13_0.params_.id
	arg_13_0.heroID_ = SwimsuitVoteHeroCfg[arg_13_0.voteID_].hero_id
	arg_13_0.skinID_ = SwimsuitBattleData:GetSkinByHeroID(arg_13_0.heroID_)

	if not arg_13_0.skinID_ then
		arg_13_0.skinID_ = tonumber(SwimsuitVoteHeroCfg[arg_13_0.voteID_].show_image)
	end

	arg_13_0.voteNum_ = arg_13_0.params_.vote
	arg_13_0.rank_ = arg_13_0.params_.rank
	arg_13_0.round_ = SwimsuitBattleData:GetCurVoteRound()

	arg_13_0:UpdateView()
end

function var_0_0.UpdateView(arg_14_0)
	local var_14_0 = SwimsuitVoteHeroCfg[arg_14_0.voteID_]

	arg_14_0.avatarImg_.spriteAsync = "TextureConfig/Character/Icon/" .. var_14_0.show_image
	arg_14_0.attr1Img_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_14_0.heroID_, true)
	arg_14_0.attr2Img_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_14_0.heroID_, false)
	arg_14_0.name1Text_.text = HeroCfg[arg_14_0.heroID_].suffix
	arg_14_0.name2Text_.text = SkinCfg[arg_14_0.skinID_].name
	arg_14_0.scoreText_.text = arg_14_0.voteNum_
	arg_14_0.rankText_.text = arg_14_0.rank_
	arg_14_0.supportText_.text = var_14_0.vote_support
	arg_14_0.numText_.text = 0

	local var_14_1 = arg_14_0.rank_ >= 4 and "4" or tostring(arg_14_0.rank_)

	arg_14_0.rankController_:SetSelectedState(var_14_1)

	arg_14_0.voteSlr_.minValue = 0
	arg_14_0.voteSlr_.maxValue = ItemTools.getItemNum(arg_14_0.params_.item)
	arg_14_0.itemText_.text = ItemTools.getItemNum(arg_14_0.params_.item)

	if arg_14_0.voteSlr_.value == 0 then
		arg_14_0.btnController_:SetSelectedState("state1")

		arg_14_0.subBtn_.interactable = false
		arg_14_0.addBtn_.interactable = arg_14_0.voteSlr_.maxValue > 0
	else
		arg_14_0.voteSlr_.value = 0
	end
end

function var_0_0.OnExit(arg_15_0)
	if arg_15_0.exitTimer_ then
		arg_15_0.exitTimer_:Stop()

		arg_15_0.exitTimer_ = nil
	end
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()
end

return var_0_0
