local var_0_0 = class("MonsterCosplaySectionInfo", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayChapterSectionInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skillStateController = arg_4_0.skillController_:GetController("state")
	arg_4_0.stateController = arg_4_0.controller_:GetController("state")
	arg_4_0.lockController = arg_4_0.lockController_:GetController("lock")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshData()
	arg_5_0:RefreshUI()
	arg_5_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnUpdate(arg_7_0)
	if arg_7_0.stageID_ == arg_7_0.params_.section then
		return
	end

	arg_7_0.stageID_ = arg_7_0.params_.section

	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.parent.infoController:SetSelectedState("state0")

	arg_8_0.parent.selectStageID = nil

	arg_8_0.parent:RefreshSelectItem()
	arg_8_0.super.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.startBtn_, nil, function()
		arg_9_0:OnClickBtn()
	end)
end

function var_0_0.OnClickBtn(arg_11_0)
	local var_11_0 = MonsterCosplayData:GetDataByPara("activityID")
	local var_11_1 = BattleActivityMonsterCosplayCfg[arg_11_0.stageID_]

	saveData("monsterCosplay", "selectID", tostring(arg_11_0.monsterID))

	local var_11_2 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY, arg_11_0.stageID_, {
		activityID = var_11_0,
		monsterID = arg_11_0.monsterID,
		levelID = var_11_1.level
	})

	BattleController.GetInstance():LaunchBattle(var_11_2)
end

function var_0_0.RefreshData(arg_12_0)
	arg_12_0.stageID_ = arg_12_0.params_.section
	arg_12_0.monsterID = arg_12_0.params_.monsterID
	arg_12_0.parent = arg_12_0.params_.parent
	arg_12_0.stageType_ = arg_12_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	arg_12_0.monsterData = MonsterCosplayData:GetDataByPara("monsterData")[arg_12_0.monsterID]
	arg_12_0.openStage = MonsterCosplayData:GetDataByPara("openStage")[arg_12_0.monsterID]
	arg_12_0.stageData = arg_12_0.monsterData.finishedStage
	arg_12_0.finishedPointStageData = arg_12_0.monsterData.finishedPointStage
	arg_12_0.affixID = nil

	for iter_12_0, iter_12_1 in pairs(arg_12_0.monsterData.enhancedSkill) do
		if iter_12_1.stageID == arg_12_0.stageID_ then
			arg_12_0.affixID = iter_12_1.affixID
		end
	end
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = ActivityMonsterCosplayCfg[arg_13_0.monsterID]

	if table.indexof(var_13_0.skill_stage, arg_13_0.stageID_) then
		arg_13_0.skillStateController:SetSelectedState(arg_13_0.affixID and "get1" or "lock")

		if not arg_13_0.affixID then
			arg_13_0.skillLockTxt_.text = GetTips(arg_13_0.monsterID == ActivityMonsterCosplayCfg.all[1] and "ACTIVITY_MONSTER_COSPLAY_ANJINSHU_TALENT_PUTONG_TIPS" or "ACTIVITY_MONSTER_COSPLAY_RENMA_TALENT_PUTONG_TIPS")
		end

		SetActive(arg_13_0.smallGo_, true)
	else
		arg_13_0.skillStateController:SetSelectedState("none")
		SetActive(arg_13_0.smallGo_, false)
	end

	if arg_13_0.affixID then
		local var_13_1 = TalentTreeCfg[arg_13_0.affixID]

		arg_13_0.skillDescTxt_.text = GetI18NText(var_13_1.desc)
		arg_13_0.skillIcon_.sprite = MonsterCosplayData.GetAffixSprite(arg_13_0.affixID)

		local var_13_2 = ActivityMonsterCosplaySkillCfg[var_13_1.stage]

		arg_13_0.skillCountTxt_.text = GetI18NText(var_13_2.skill_index) or ""
	end

	local var_13_3 = BattleActivityMonsterCosplayCfg[arg_13_0.stageID_]

	if IsConditionAchieved(var_13_3.unlock_condition[1]) then
		arg_13_0.unLockConditionTxt_.text = GetTips("NEED_FINISH_PRE_NORMAL_STAGE")
	else
		arg_13_0.unLockConditionTxt_.text = GetTips(ConditionCfg[var_13_3.unlock_condition[1]].desc)
	end

	arg_13_0.lastScoreTxt_.text = GetTips("MATRIX_RANK_NO_INFO")
	arg_13_0.highScoreTxt_.text = GetTips("MATRIX_RANK_NO_INFO")

	arg_13_0.lockController:SetSelectedState("false")

	if arg_13_0.stageData[arg_13_0.stageID_] then
		if arg_13_0.finishedPointStageData[arg_13_0.stageID_] then
			arg_13_0.lastScoreTxt_.text = arg_13_0.finishedPointStageData[arg_13_0.stageID_].lastScore
			arg_13_0.highScoreTxt_.text = arg_13_0.finishedPointStageData[arg_13_0.stageID_].maxScore
		end
	elseif arg_13_0.openStage == arg_13_0.stageID_ and IsConditionAchieved(tonumber(var_13_3.unlock_condition[1])) then
		arg_13_0.stateController:SetSelectedState("none")
	else
		arg_13_0.lockController:SetSelectedState("true")
	end

	if var_13_3.sub_type == 2 then
		arg_13_0.stateController:SetSelectedState("1")
	else
		arg_13_0.stateController:SetSelectedState("2")
	end

	arg_13_0:RefreshTitleDesc()
end

function var_0_0.RefreshTitleDesc(arg_14_0)
	arg_14_0.nameTxt_.text = BattleActivityMonsterCosplayCfg[arg_14_0.stageID_].name
	arg_14_0.descTxt_.text = BattleActivityMonsterCosplayCfg[arg_14_0.stageID_].tips
	arg_14_0.bgIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleActivityMonsterCosplayCfg[arg_14_0.stageID_].background_1))
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
