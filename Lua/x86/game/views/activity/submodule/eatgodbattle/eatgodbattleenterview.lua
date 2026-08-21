local var_0_0 = class("EatGodBattleEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Monster/V4_2_GodEaterUI_Monster_MainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.bossStateController_ = arg_4_0.bossCon_:GetController("state")
	arg_4_0.bossAttackingController_ = arg_4_0.bossCon_:GetController("attacking")
	arg_4_0.moveController_ = arg_4_0.transCon_:GetController("move")
	arg_4_0.stageInfoController_ = arg_4_0.transCon_:GetController("stageInfo")
	arg_4_0.benefitController_ = arg_4_0.transCon_:GetController("benefit")
	arg_4_0.reswardList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.rewardGo_, CommonItemView)
	arg_4_0.dailyMonster_ = {}

	for iter_4_0 = 1, 4 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, arg_4_0["dailyMonster_" .. iter_4_0])

		var_4_0.stateController = var_4_0.monsterCon_:GetController("state")
		var_4_0.selectController = var_4_0.monsterCon_:GetController("select")

		local var_4_1 = BattleGodEaterDailyMonsterCfg[ActivityGodEaterDailyMonsterCfg.all[iter_4_0]]

		var_4_0.stageId = var_4_1.id
		var_4_0.stageType = var_4_1.type

		arg_4_0:AddBtnListener(var_4_0.btnSelect_, nil, function()
			arg_4_0:OnSelectStage(iter_4_0)
		end)

		arg_4_0.dailyMonster_[iter_4_0] = var_4_0
	end

	arg_4_0.bossStatusController_ = {}

	for iter_4_1 = 1, 3 do
		arg_4_0.bossStatusController_[iter_4_1] = arg_4_0["bossStatusCon_" .. iter_4_1]:GetController("status")
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnBoss_, nil, function()
		JumpTools.OpenPageByJump("/weekBossMainView")
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnMask_, nil, function()
		arg_6_0:ResetSelect()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnGo_, nil, function()
		DailyMonsterData:SetBattleType("dailyMonster")

		local var_9_0 = DailyMonsterData:GetActivityId()

		JumpTools.OpenPageByJump("/weekBossHeroView", {
			isBoss = false,
			type = "dailyMonster",
			stageType = arg_6_0.selectStageType,
			stageId = arg_6_0.selectStageId_,
			activityId = var_9_0
		})
		arg_6_0:ResetSelect()
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_4")
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.descText_.text = GetTips("GOD_EATER_GAME_DESC_2")

	arg_11_0:UpdateWeekBoss()
	arg_11_0:UpdateDailyMonster()
	arg_11_0:BindRedPoint()
end

function var_0_0.UpdateWeekBoss(arg_12_0)
	local var_12_0, var_12_1 = WeekBossData:GetRemainHpProp()

	arg_12_0.bossStateController_:SetSelectedState(var_12_1 == 3 and var_12_0 <= 0 and "complete" or "unlock")
	arg_12_0.bossAttackingController_:SetSelectedState(tostring(var_12_0 > 0))

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.bossStatusController_) do
		if iter_12_0 < var_12_1 then
			iter_12_1:SetSelectedState("clear")
		elseif iter_12_0 == var_12_1 then
			iter_12_1:SetSelectedState(var_12_0 > 0 and "normal" or "clear")
		else
			iter_12_1:SetSelectedState("lock")
		end
	end
end

function var_0_0.UpdateDailyMonster(arg_13_0)
	arg_13_0.dropTitle_.text = GetTips("BATTLE_DROP")

	local var_13_0 = ActivityData:GetActivityData(DailyMonsterData:GetBenefitActivityId())

	arg_13_0.benefitController_:SetSelectedState(var_13_0:IsActivitying() and "show" or "hide")

	arg_13_0.openStage_ = DailyMonsterData:GetOpenStage()
	arg_13_0.timerList_ = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.dailyMonster_) do
		local var_13_1
		local var_13_2 = Timer.New(function()
			local var_14_0 = GameSetting.refresh_time1.value[1][1]
			local var_14_1 = manager.time:GetNextTime(var_14_0, 0, 0)
			local var_14_2 = DailyMonsterData:GetOpenStageById(iter_13_1.stageId)

			if var_14_2 then
				iter_13_1.stateController:SetSelectedState(var_14_2.firstPass == 0 and "unlock" or "complete")

				iter_13_1.remainTime_.text = manager.time:GetLostTimeStr2(var_14_1, false, true)
			else
				iter_13_1.stateController:SetSelectedState("lock")
			end
		end, 0.33, -1)

		table.insert(arg_13_0.timerList_, var_13_2)
		var_13_2:Start()
	end
end

function var_0_0.OnSelectStage(arg_15_0, arg_15_1)
	if not arg_15_0.openStage_[arg_15_0.dailyMonster_[arg_15_1].stageId] then
		ShowTips(GetTips("DORM_AREA_NOT_OPEN"))

		return
	end

	if arg_15_0.openStage_[arg_15_0.dailyMonster_[arg_15_1].stageId].firstPass == 1 then
		return
	end

	arg_15_0.selectIndex_ = arg_15_1

	arg_15_0.moveController_:SetSelectedState(arg_15_1)

	if arg_15_0.selectStage_ then
		arg_15_0.selectStage_.selectController:SetSelectedState("off")
	end

	arg_15_0.selectStage_ = arg_15_0.dailyMonster_[arg_15_1]

	arg_15_0.selectStage_.selectController:SetSelectedState("on")

	arg_15_0.selectStageId_ = arg_15_0.selectStage_.stageId
	arg_15_0.selectStageType = arg_15_0.selectStage_.stageType

	arg_15_0:RefreshStageInfo()
	arg_15_0.stageInfoController_:SetSelectedState("show")
end

function var_0_0.RefreshStageInfo(arg_16_0)
	local var_16_0 = BattleGodEaterDailyMonsterCfg[arg_16_0.selectStageId_]

	arg_16_0.stageImg_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_16_0.background_1))
	arg_16_0.stageName_.text = var_16_0.name
	arg_16_0.stageDesc_.text = var_16_0.tips
	arg_16_0.rewardData_ = getRewardFromDropCfg(var_16_0.drop_lib_id, true)

	arg_16_0.reswardList_:StartScroll(#arg_16_0.rewardData_)
end

function var_0_0.IndexItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.rewardData_[arg_17_1]
	local var_17_1 = clone(ItemTemplateData)

	var_17_1.id = var_17_0.id
	var_17_1.number = var_17_0.num

	function var_17_1.clickFun()
		ShowPopItem(POP_ITEM, {
			var_17_1.id,
			var_17_1.number
		})
	end

	arg_17_2:SetData(var_17_1)
end

function var_0_0.ResetSelect(arg_19_0)
	arg_19_0.selectIndex_ = nil

	arg_19_0.moveController_:SetSelectedState("normal")
	arg_19_0.stageInfoController_:SetSelectedState("hide")

	if arg_19_0.selectStage_ then
		arg_19_0.selectStage_.selectController:SetSelectedState("off")

		arg_19_0.selectStage_ = nil
	end
end

function var_0_0.BindRedPoint(arg_20_0)
	manager.redPoint:bindUIandKey(arg_20_0.btnBoss_.transform, RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE)
end

function var_0_0.UnBindRedPoint(arg_21_0)
	manager.redPoint:unbindUIandKey(arg_21_0.btnBoss_.transform, RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE)
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
	arg_22_0:ResetSelect()
	arg_22_0:UnBindRedPoint()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.timerList_) do
		iter_22_1:Stop()
	end

	arg_22_0.timerList_ = {}
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.reswardList_ then
		arg_23_0.reswardList_:Dispose()

		arg_23_0.reswardList_ = nil
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.timerList_) do
		iter_23_1:Stop()
	end

	arg_23_0.timerList_ = {}

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
