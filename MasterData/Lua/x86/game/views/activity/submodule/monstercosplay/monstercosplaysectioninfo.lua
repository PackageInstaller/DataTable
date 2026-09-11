local MonsterCosplaySectionInfo = class("MonsterCosplaySectionInfo", ReduxView)

function MonsterCosplaySectionInfo:UIName()
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayChapterSectionInfoUI"
end

function MonsterCosplaySectionInfo:UIParent()
	return manager.ui.uiMain.transform
end

function MonsterCosplaySectionInfo:Init()
	self:InitUI()
	self:AddListeners()
end

function MonsterCosplaySectionInfo:InitUI()
	self:BindCfgUI()

	self.skillStateController = self.skillController_:GetController("state")
	self.stateController = self.controller_:GetController("state")
	self.lockController = self.lockController_:GetController("lock")
end

function MonsterCosplaySectionInfo:OnEnter()
	self:RefreshData()
	self:RefreshUI()
	self:UpdateBar()
end

function MonsterCosplaySectionInfo:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MonsterCosplaySectionInfo:OnUpdate()
	if self.stageID_ == self.params_.section then
		return
	end

	self.stageID_ = self.params_.section

	self:RefreshData()
	self:RefreshUI()
end

function MonsterCosplaySectionInfo:OnExit()
	self.parent.infoController:SetSelectedState("state0")

	self.parent.selectStageID = nil

	self.parent:RefreshSelectItem()
	self.super.OnExit(self)
	manager.windowBar:HideBar()
end

function MonsterCosplaySectionInfo:AddListeners()
	self:AddBtnListener(self.startBtn_, nil, function()
		self:OnClickBtn()
	end)
end

function MonsterCosplaySectionInfo:OnClickBtn()
	saveData("monsterCosplay", "selectID", tostring(self.monsterID))
	BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_MONSTER_COSPLAY, self.stageID_, {
		activityID = MonsterCosplayData:GetDataByPara("activityID"),
		monsterID = self.monsterID,
		levelID = BattleActivityMonsterCosplayCfg[self.stageID_].level
	})))
end

function MonsterCosplaySectionInfo:RefreshData()
	self.stageID_ = self.params_.section
	self.monsterID = self.params_.monsterID
	self.parent = self.params_.parent
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	self.monsterData = MonsterCosplayData:GetDataByPara("monsterData")[self.monsterID]
	self.openStage = MonsterCosplayData:GetDataByPara("openStage")[self.monsterID]
	self.stageData = self.monsterData.finishedStage
	self.finishedPointStageData = self.monsterData.finishedPointStage
	self.affixID = nil

	for iter_12_0, iter_12_1 in pairs(self.monsterData.enhancedSkill) do
		if iter_12_1.stageID == self.stageID_ then
			self.affixID = iter_12_1.affixID
		end
	end
end

function MonsterCosplaySectionInfo:RefreshUI()
	if table.indexof(ActivityMonsterCosplayCfg[self.monsterID].skill_stage, self.stageID_) then
		self.skillStateController:SetSelectedState(self.affixID and "get1" or "lock")

		if not self.affixID then
			self.skillLockTxt_.text = GetTips(self.monsterID == ActivityMonsterCosplayCfg.all[1] and "ACTIVITY_MONSTER_COSPLAY_ANJINSHU_TALENT_PUTONG_TIPS" or "ACTIVITY_MONSTER_COSPLAY_RENMA_TALENT_PUTONG_TIPS")
		end

		SetActive(self.smallGo_, true)
	else
		self.skillStateController:SetSelectedState("none")
		SetActive(self.smallGo_, false)
	end

	if self.affixID then
		self.skillDescTxt_.text = GetI18NText(TalentTreeCfg[self.affixID].desc)
		self.skillIcon_.sprite = MonsterCosplayData.GetAffixSprite(self.affixID)
		self.skillCountTxt_.text = GetI18NText(ActivityMonsterCosplaySkillCfg[TalentTreeCfg[self.affixID].stage].skill_index) or ""
	end

	local var_13_0 = BattleActivityMonsterCosplayCfg[self.stageID_]

	self.unLockConditionTxt_.text = IsConditionAchieved(BattleActivityMonsterCosplayCfg[self.stageID_].unlock_condition[1]) and GetTips("NEED_FINISH_PRE_NORMAL_STAGE") or GetTips(ConditionCfg[var_13_0.unlock_condition[1]].desc)
	self.lastScoreTxt_.text = GetTips("MATRIX_RANK_NO_INFO")
	self.highScoreTxt_.text = GetTips("MATRIX_RANK_NO_INFO")

	self.lockController:SetSelectedState("false")

	if self.stageData[self.stageID_] then
		if self.finishedPointStageData[self.stageID_] then
			self.lastScoreTxt_.text = self.finishedPointStageData[self.stageID_].lastScore
			self.highScoreTxt_.text = self.finishedPointStageData[self.stageID_].maxScore
		end
	elseif self.openStage == self.stageID_ and IsConditionAchieved(tonumber(var_13_0.unlock_condition[1])) then
		self.stateController:SetSelectedState("none")
	else
		self.lockController:SetSelectedState("true")
	end

	if var_13_0.sub_type == 2 then
		self.stateController:SetSelectedState("1")
	else
		self.stateController:SetSelectedState("2")
	end

	self:RefreshTitleDesc()
end

function MonsterCosplaySectionInfo:RefreshTitleDesc()
	self.nameTxt_.text = BattleActivityMonsterCosplayCfg[self.stageID_].name
	self.descTxt_.text = BattleActivityMonsterCosplayCfg[self.stageID_].tips
	self.bgIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleActivityMonsterCosplayCfg[self.stageID_].background_1))
end

function MonsterCosplaySectionInfo:Dispose()
	MonsterCosplaySectionInfo.super.Dispose(self)
end

return MonsterCosplaySectionInfo
