local var_0_0 = class("SoloChallengeSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.affixList_ = {}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.heroSelectController = ControllerUtil.GetController(arg_2_0.transform_, "heroSelect")
	arg_2_0.lockStateController_ = ControllerUtil.GetController(arg_2_0.transform_, "lock")
	arg_2_0.adaptImg_ = arg_2_0:FindCom("AdaptImage", nil, arg_2_0.bossTrans_)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.heroBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		HeroData:ResetSortValue()
		BattleFieldData:SetCurrentSelectHeroData(arg_4_0.heroID_, arg_4_0.trialID_)
		arg_4_0:Go("/heroTeamInfoSoloChallenge", {
			isEnter = true,
			reorder = false,
			selectHeroPos = arg_4_0.selectHeroPos_,
			stageID = arg_4_0.stageID_,
			activityID = arg_4_0.activityID_,
			stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
			difficultyIndex = arg_4_0.difficultyIndex_,
			reserveParams = arg_4_0.reserveParams_
		})
	end)

	if arg_4_0.bossBtn_ ~= nil then
		arg_4_0:AddBtnListener(arg_4_0.bossBtn_, nil, function()
			if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			local var_6_0 = ActivitySoloChallengeCfg[arg_4_0.activityID_].boss_id_list[arg_4_0.selectHeroPos_]

			JumpTools.OpenPageByJump("soloChallengeBossInfo", {
				activityID = arg_4_0.activityID_,
				bossID = var_6_0
			})
		end)
	end
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.stageID_ = arg_7_2
	arg_7_0.selectHeroPos_ = arg_7_3
	arg_7_0.difficultyIndex_ = arg_7_4
	arg_7_0.difficultId_ = ActivitySoloChallengeCfg[arg_7_0.activityID_].stage_id[arg_7_0.difficultyIndex_][1]
	arg_7_0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE, arg_7_0.difficultId_, arg_7_0.selectHeroPos_, {
		stageType = BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE,
		stageID = arg_7_0.stageID_,
		activityID = arg_7_0.activityID_,
		difficultyIndex = arg_7_0.difficultyIndex_
	})

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshAffix()
	arg_8_0:RefreshHeroState()
	arg_8_0:RefreshEnemyUI()
	arg_8_0:RefreshLockState()
	arg_8_0:RefreshTitle()
end

function var_0_0.RefreshAffix(arg_9_0)
	local var_9_0 = ReserveTools.GetReserveTemplate(BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE, arg_9_0.stageID_):GetContDataTemplateById(arg_9_0.difficultId_):GetAffixList(arg_9_0.selectHeroPos_)
	local var_9_1 = SoloChallengeData:GetMaxAffixCount(arg_9_0.activityID_)
	local var_9_2 = 0

	for iter_9_0 = 1, var_9_1 do
		local var_9_3 = var_9_0[iter_9_0] or 0

		if arg_9_0.affixList_[iter_9_0] == nil then
			local var_9_4 = Object.Instantiate(arg_9_0.affixItemTemplate_, arg_9_0.affixListTrans_)

			arg_9_0.affixList_[iter_9_0] = SoloChallengeAffixItem.New(var_9_4)
		end

		arg_9_0.affixList_[iter_9_0]:SetData(arg_9_0.activityID_, var_9_3)

		local var_9_5 = {
			stageID = arg_9_0.stageID_,
			pos = iter_9_0
		}

		arg_9_0.affixList_[iter_9_0]:SetState(var_9_5)
	end
end

function var_0_0.RefreshHeroState(arg_10_0)
	local var_10_0, var_10_1, var_10_2, var_10_3 = ReserveTools.GetHeroList(arg_10_0.reserveParams_)

	arg_10_0.heroID_ = var_10_0[1]
	arg_10_0.trialID_ = var_10_3[1]

	if arg_10_0.heroID_ ~= 0 then
		arg_10_0.heroSelectController:SetSelectedState("on")

		local var_10_4 = 0

		if arg_10_0.trialID_ ~= 0 then
			var_10_4 = HeroStandardSystemCfg[arg_10_0.trialID_].skin_id
		else
			var_10_4 = HeroTools.HeroUsingSkinInfo(arg_10_0.heroID_).id
		end

		arg_10_0.headIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", SkinCfg[var_10_4].picture_id)

		arg_10_0.headIcon_:SetNativeSize()
	else
		arg_10_0.heroSelectController:SetSelectedState("off")
	end
end

function var_0_0.RefreshEnemyUI(arg_11_0)
	local var_11_0 = BattleSoloChallengeStageCfg[arg_11_0.stageID_].hd_image

	arg_11_0.bossIcon_.sprite = getSpriteViaConfig("StoryHeadIcon", var_11_0)

	arg_11_0.adaptImg_:AdaptImg()
end

function var_0_0.RefreshTitle(arg_12_0)
	arg_12_0.titleText_.text = GetTips(string.format("TEAM_%d", arg_12_0.selectHeroPos_))
end

function var_0_0.RefreshLockState(arg_13_0)
	local var_13_0 = SoloChallengeData:GetCompletedStageList(arg_13_0.activityID_)

	if table.keyof(var_13_0[arg_13_0.difficultyIndex_], arg_13_0.stageID_) then
		arg_13_0.heroBtn_.interactable = false

		arg_13_0.lockStateController_:SetSelectedState("lock")
	else
		arg_13_0.heroBtn_.interactable = true

		arg_13_0.lockStateController_:SetSelectedState("unlock")
	end
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.affixList_ then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.affixList_) do
			iter_14_1:Dispose()

			arg_14_0.affixList_[iter_14_0] = nil
		end

		arg_14_0.affixList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
