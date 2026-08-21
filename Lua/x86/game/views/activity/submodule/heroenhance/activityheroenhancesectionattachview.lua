local var_0_0 = class("ActivityHeroEnhanceSectionAttachView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.heroItem_ = ActivityHeroEnhanceHeroItem.New(arg_2_0.heroGo_)
	arg_2_0.talentList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexTalentItem), arg_2_0.talentListGo_, ActivityHeroEnhanceTalentItem)
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.IndexTalentItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.talentIdList_[arg_4_1]

	arg_4_2:SetData(arg_4_0.activityId_, var_4_0)

	if var_4_0 then
		local var_4_1 = ActivityHeroEnhanceTools.IsTalentLock(arg_4_0.activityId_, var_4_0)

		arg_4_2:SetLock(var_4_1)
		arg_4_2:SetFirstAddFlag(false)
	else
		local var_4_2 = arg_4_1
		local var_4_3 = ActivityHeroEnhanceCfg[arg_4_0.cfgId_]
		local var_4_4 = ActivityHeroEnhanceTools.IsCfgTalentStageLock(var_4_3, var_4_2, true)

		arg_4_2:SetLock(var_4_4)
		arg_4_2:SetFirstAddFlag(ActivityHeroEnhanceTools.IsCfgTalentStageFirstCanAdd(var_4_3, var_4_2))
	end

	arg_4_2:SetClickHandler(function(arg_5_0)
		JumpTools.OpenPageByJump("/activityHeroEnhanceHero", {
			activityID = arg_4_0.activityId_,
			cfgId = arg_4_0.cfgId_,
			stageToView = arg_4_1,
			talentIdToView = arg_5_0
		})
	end)
	arg_4_2:RefreshUI()
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ActivityHeroEnhanceCfg[arg_6_1]

	arg_6_0.cfgId_ = arg_6_1
	arg_6_0.activityId_ = var_6_0.activity_id
	arg_6_0.talentIdList_ = arg_6_2

	arg_6_0.heroItem_:SetData(arg_6_1)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.heroItem_:SetIgnorePass(true)
	arg_7_0.heroItem_:RefreshUI()

	local var_7_0 = ActivityHeroEnhanceCfg[arg_7_0.cfgId_]
	local var_7_1 = ActivityHeroEnhanceTools.GetCfgTalentMaxStage(var_7_0)

	arg_7_0.talentList_:StartScroll(var_7_1)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.heroItem_:Dispose()
	arg_8_0.talentList_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
