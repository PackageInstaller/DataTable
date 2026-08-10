local var_0_0 = class("ActivityHeroEnhanceSectionAttachView_4_5", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.activityId_ = arg_1_3
	arg_1_0.btnCallback_ = arg_1_4

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.cfgIdList_ = ActivityHeroEnhanceTools.GetCfgIdList(arg_2_0.activityId_)
	arg_2_0.heroItemList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.cfgIdList_) do
		local var_2_0 = ActivityHeroEnhanceHeroItem_4_5.New(arg_2_0["tabGo_" .. iter_2_0])

		var_2_0:SetData(iter_2_1)
		var_2_0:SetClickHandler(function(arg_3_0)
			arg_2_0.btnCallback_(arg_3_0)
		end)
		table.insert(arg_2_0.heroItemList_, var_2_0)
	end

	arg_2_0.talentList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexTalentItem), arg_2_0.talentListGo_, ActivityHeroEnhanceTalentItem)

	manager.redPoint:bindUIandKey(arg_2_0.questBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_HERO_ENHANCE_4_5_TASK)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.questBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityConst.ACTIVITY_HERO_ENHANCE_4_5_TASK, "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhance_PopUI")
	end)
	arg_4_0:AddBtnListener(arg_4_0.talentBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityHeroEnhanceHeroView_4_5", {
			stageToView = 1,
			activityID = arg_4_0.activityId_,
			cfgId = arg_4_0.cfgId_,
			talentIdToView = arg_4_0.talentIdList_[1]
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.trialBattleBtn_, nil, function()
		local var_7_0 = ActivityHeroEnhanceCfg[arg_4_0.cfgId_]
		local var_7_1 = HeroCfg[var_7_0.hero_id]
		local var_7_2 = HeroTrialTools.GetLastOpenHeroTrial(var_7_0.hero_id)

		HeroTrialData:SetBattleWay(ActivityHeroTrialConst.BATTLE_WAY.HERO_VIEW, "/activityHeroEnhanceSection_4_5", {
			activityID = arg_4_0.activityId_,
			cfgId = arg_4_0.cfgId_
		})

		if var_7_2 ~= 0 and HeroTrialTools.GetActivityIsUnlock(var_7_2) and PlayerData:GetPlayerInfo().userLevel >= 35 then
			HeroTrialTools.EnterActivityBattle(var_7_2)
		else
			HeroTrialTools.EnterResidentBattle(var_7_1.trial_stage)
		end
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ActivityHeroEnhanceCfg[arg_8_1]

	if arg_8_0.cfgId_ ~= arg_8_1 then
		arg_8_0.enterAnimator_:Play("Fx_tabgroup_cx", 0, 0)
	end

	arg_8_0.cfgId_ = arg_8_1
	arg_8_0.activityId_ = var_8_0.activity_id
	arg_8_0.talentIdList_ = arg_8_2
end

function var_0_0.ChooseCfg(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.heroItemList_) do
		if iter_9_1:GetCfgId() == arg_9_1 then
			iter_9_1:SetSelected(true)
		else
			iter_9_1:SetSelected(false)
		end
	end
end

function var_0_0.IndexTalentItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.talentIdList_[arg_10_1]

	arg_10_2:SetData(arg_10_0.activityId_, var_10_0)
	arg_10_2:SetMainTag(true)

	if var_10_0 then
		if var_10_0 == arg_10_0.unlockTalent_ then
			arg_10_2:SetLock(true)
			arg_10_2:SetPlayAnim(true, function()
				arg_10_0.unlockTalent_ = nil
			end)
			arg_10_2:SetFirstAddFlag(true)
		else
			local var_10_1 = ActivityHeroEnhanceTools.IsTalentLock(arg_10_0.activityId_, var_10_0)

			arg_10_2:SetLock(var_10_1)
			arg_10_2:SetFirstAddFlag(false)
		end
	else
		local var_10_2 = arg_10_1
		local var_10_3 = ActivityHeroEnhanceCfg[arg_10_0.cfgId_]
		local var_10_4 = ActivityHeroEnhanceTools.IsCfgTalentStageLock(var_10_3, var_10_2, true)

		arg_10_2:SetLock(var_10_4)
		arg_10_2:SetFirstAddFlag(false)
	end

	arg_10_2:SetClickHandler(function(arg_12_0)
		JumpTools.OpenPageByJump("/activityHeroEnhanceHeroView_4_5", {
			activityID = arg_10_0.activityId_,
			cfgId = arg_10_0.cfgId_,
			stageToView = arg_10_1,
			talentIdToView = arg_12_0
		})
	end)
	arg_10_2:RefreshUI()
end

function var_0_0.RefreshUI(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.heroItemList_) do
		iter_13_1:RefreshUI()
	end

	local var_13_0 = ActivityHeroEnhanceCfg[arg_13_0.cfgId_]
	local var_13_1 = ActivityHeroEnhanceTools.GetCfgTalentMaxStage(var_13_0)

	arg_13_0.talentList_:StartScroll(var_13_1)

	arg_13_0.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_13_0.hero_id)

	arg_13_0.heroImg_:AdaptImg()
end

function var_0_0.PlayTalentAnim(arg_14_0, arg_14_1)
	arg_14_0.unlockTalent_ = arg_14_1
end

function var_0_0.PlayAnim(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.heroItemList_) do
		if iter_15_1:GetCfgId() == arg_15_1 then
			var_15_0 = iter_15_1

			break
		end
	end

	if var_15_0 then
		var_15_0:PlayAnim(arg_15_2)
	elseif arg_15_2 then
		arg_15_2()
	end
end

function var_0_0.Dispose(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.questBtn_.transform, RedPointConst.ACTIVITY_TASK .. ActivityConst.ACTIVITY_HERO_ENHANCE_4_5_TASK)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.heroItemList_) do
		iter_16_1:Dispose()
	end

	arg_16_0.talentList_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
