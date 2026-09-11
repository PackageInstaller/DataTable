local EatGodBattleEnterView = class("EatGodBattleEnterView", ReduxView)

function EatGodBattleEnterView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Monster/V4_2_GodEaterUI_Monster_MainUI"
end

function EatGodBattleEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function EatGodBattleEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatGodBattleEnterView:InitUI()
	self:BindCfgUI()

	self.bossStateController_ = self.bossCon_:GetController("state")
	self.bossAttackingController_ = self.bossCon_:GetController("attacking")
	self.moveController_ = self.transCon_:GetController("move")
	self.stageInfoController_ = self.transCon_:GetController("stageInfo")
	self.benefitController_ = self.transCon_:GetController("benefit")
	self.reswardList_ = LuaList.New(handler(self, self.IndexItem), self.rewardGo_, CommonItemView)
	self.dailyMonster_ = {}

	for iter_4_0 = 1, 4 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, self["dailyMonster_" .. iter_4_0])

		var_4_0.stateController = var_4_0.monsterCon_:GetController("state")
		var_4_0.selectController = var_4_0.monsterCon_:GetController("select")
		var_4_0.stageId = BattleGodEaterDailyMonsterCfg[ActivityGodEaterDailyMonsterCfg.all[iter_4_0]].id
		var_4_0.stageType = BattleGodEaterDailyMonsterCfg[ActivityGodEaterDailyMonsterCfg.all[iter_4_0]].type

		self:AddBtnListener(var_4_0.btnSelect_, nil, function()
			self:OnSelectStage(iter_4_0)
		end)

		self.dailyMonster_[iter_4_0] = var_4_0
	end

	self.bossStatusController_ = {}

	for iter_4_1 = 1, 3 do
		self.bossStatusController_[iter_4_1] = self["bossStatusCon_" .. iter_4_1]:GetController("status")
	end
end

function EatGodBattleEnterView:AddUIListener()
	self:AddBtnListener(self.btnBoss_, nil, function()
		JumpTools.OpenPageByJump("/weekBossMainView")
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:ResetSelect()
	end)
	self:AddBtnListener(self.btnGo_, nil, function()
		DailyMonsterData:SetBattleType("dailyMonster")
		JumpTools.OpenPageByJump("/weekBossHeroView", {
			isBoss = false,
			type = "dailyMonster",
			stageType = self.selectStageType,
			stageId = self.selectStageId_,
			activityId = DailyMonsterData:GetActivityId()
		})
		self:ResetSelect()
	end)
end

function EatGodBattleEnterView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_4")
end

function EatGodBattleEnterView:OnEnter()
	self.descText_.text = GetTips("GOD_EATER_GAME_DESC_2")

	self:UpdateWeekBoss()
	self:UpdateDailyMonster()
	self:BindRedPoint()
end

function EatGodBattleEnterView:UpdateWeekBoss()
	local var_12_0, var_12_1 = WeekBossData:GetRemainHpProp()

	self.bossStateController_:SetSelectedState(var_12_1 == 3 and var_12_0 <= 0 and "complete" or "unlock")
	self.bossAttackingController_:SetSelectedState(tostring(var_12_0 > 0))

	for iter_12_0, iter_12_1 in ipairs(self.bossStatusController_) do
		if iter_12_0 < var_12_1 then
			iter_12_1:SetSelectedState("clear")
		elseif iter_12_0 == var_12_1 then
			iter_12_1:SetSelectedState(var_12_0 > 0 and "normal" or "clear")
		else
			iter_12_1:SetSelectedState("lock")
		end
	end
end

function EatGodBattleEnterView:UpdateDailyMonster()
	self.dropTitle_.text = GetTips("BATTLE_DROP")

	self.benefitController_:SetSelectedState(ActivityData:GetActivityData(DailyMonsterData:GetBenefitActivityId()):IsActivitying() and "show" or "hide")

	self.openStage_ = DailyMonsterData:GetOpenStage()
	self.timerList_ = {}

	for iter_13_0, iter_13_1 in ipairs(self.dailyMonster_) do
		local var_13_0 = Timer.New(function()
			local var_14_0 = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)
			local var_14_1 = DailyMonsterData:GetOpenStageById(iter_13_1.stageId)

			if var_14_1 then
				iter_13_1.stateController:SetSelectedState(var_14_1.firstPass == 0 and "unlock" or "complete")

				iter_13_1.remainTime_.text = manager.time:GetLostTimeStr2(var_14_0, false, true)
			else
				iter_13_1.stateController:SetSelectedState("lock")
			end
		end, 0.33, -1)

		table.insert(self.timerList_, nil)
		var_13_0:Start()
	end
end

function EatGodBattleEnterView:OnSelectStage(arg_15_1)
	if not self.openStage_[self.dailyMonster_[arg_15_1].stageId] then
		ShowTips(GetTips("DORM_AREA_NOT_OPEN"))

		return
	end

	if self.openStage_[self.dailyMonster_[arg_15_1].stageId].firstPass == 1 then
		return
	end

	self.selectIndex_ = arg_15_1

	self.moveController_:SetSelectedState(arg_15_1)

	if self.selectStage_ then
		self.selectStage_.selectController:SetSelectedState("off")
	end

	self.selectStage_ = self.dailyMonster_[arg_15_1]

	self.selectStage_.selectController:SetSelectedState("on")

	self.selectStageId_ = self.selectStage_.stageId
	self.selectStageType = self.selectStage_.stageType

	self:RefreshStageInfo()
	self.stageInfoController_:SetSelectedState("show")
end

function EatGodBattleEnterView:RefreshStageInfo()
	self.stageImg_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleGodEaterDailyMonsterCfg[self.selectStageId_].background_1))
	self.stageName_.text = BattleGodEaterDailyMonsterCfg[self.selectStageId_].name
	self.stageDesc_.text = BattleGodEaterDailyMonsterCfg[self.selectStageId_].tips
	self.rewardData_ = getRewardFromDropCfg(BattleGodEaterDailyMonsterCfg[self.selectStageId_].drop_lib_id, true)

	self.reswardList_:StartScroll(#self.rewardData_)
end

function EatGodBattleEnterView:IndexItem(arg_17_1, arg_17_2)
	local var_17_0 = clone(ItemTemplateData)

	var_17_0.id = self.rewardData_[arg_17_1].id
	var_17_0.number = self.rewardData_[arg_17_1].num

	function var_17_0.clickFun()
		ShowPopItem(POP_ITEM, {
			var_17_0.id,
			var_17_0.number
		})
	end

	arg_17_2:SetData(var_17_0)
end

function EatGodBattleEnterView:ResetSelect()
	self.selectIndex_ = nil

	self.moveController_:SetSelectedState("normal")
	self.stageInfoController_:SetSelectedState("hide")

	if self.selectStage_ then
		self.selectStage_.selectController:SetSelectedState("off")

		self.selectStage_ = nil
	end
end

function EatGodBattleEnterView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.btnBoss_.transform, RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE)
end

function EatGodBattleEnterView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.btnBoss_.transform, RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE)
end

function EatGodBattleEnterView:OnExit()
	manager.windowBar:HideBar()
	self:ResetSelect()
	self:UnBindRedPoint()

	for iter_22_0, iter_22_1 in ipairs(self.timerList_) do
		iter_22_1:Stop()
	end

	self.timerList_ = {}
end

function EatGodBattleEnterView:Dispose()
	if self.reswardList_ then
		self.reswardList_:Dispose()

		self.reswardList_ = nil
	end

	for iter_23_0, iter_23_1 in ipairs(self.timerList_) do
		iter_23_1:Stop()
	end

	self.timerList_ = {}

	EatGodBattleEnterView.super.Dispose(self)
end

return EatGodBattleEnterView
