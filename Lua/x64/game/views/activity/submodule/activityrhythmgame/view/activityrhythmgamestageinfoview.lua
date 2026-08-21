local var_0_0 = class("ActivityRhythmGameStageInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MuiscUI/SummerUI_3_4_InfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:SetData(arg_3_0.params_.activityID, arg_3_0.params_.cfgID, arg_3_0.params_.stageID)
	arg_3_0:RefreshUI()
end

function var_0_0.OnUpdate(arg_4_0)
	if arg_4_0.cfgID_ == arg_4_0.params_.cfgID then
		return
	end

	arg_4_0:SetData(arg_4_0.params_.activityID, arg_4_0.params_.cfgID, arg_4_0.params_.stageID)
	arg_4_0:RefreshUI()
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.OnBehind(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.Init(arg_7_0)
	arg_7_0:InitOwnData()
	arg_7_0:BindCfgUI()
	arg_7_0:BindController()
	arg_7_0:AddUIListeners()

	arg_7_0.sectionTargets_ = {}

	for iter_7_0 = 1, 3 do
		arg_7_0.sectionTargets_[iter_7_0] = ActivityRhythmGameStageInfoStarItem.New(arg_7_0[string.format("ndnum0%sGo_", iter_7_0)], iter_7_0)
	end

	arg_7_0.DefaultConditionText_ = arg_7_0.conditionText_.text
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.sectionTargets_) do
		iter_8_1:Dispose()
	end

	arg_8_0.sectionTargets_ = {}

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.InitOwnData(arg_9_0)
	arg_9_0.activityID_ = 0
	arg_9_0.cfgID_ = 0
	arg_9_0.stageID_ = 0
end

function var_0_0.BindController(arg_10_0)
	arg_10_0.lockController_ = arg_10_0.btnControllerexcollection_:GetController("lock")
end

function var_0_0.ChangeLockController(arg_11_0, arg_11_1)
	arg_11_0.lockController_:SetSelectedIndex(arg_11_1)
end

function var_0_0.AddUIListeners(arg_12_0)
	arg_12_0:AddBtnListener(nil, arg_12_0.battleBtn_, function()
		ActivityRhythmGameTools.StartBattle(arg_12_0.cfgID_, arg_12_0.stageID_, arg_12_0.activityID_)
	end)
end

function var_0_0.SetData(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.activityID_ = arg_14_1
	arg_14_0.cfgID_ = arg_14_2
	arg_14_0.stageID_ = arg_14_3
end

function var_0_0.RefreshUI(arg_15_0)
	SetActive(arg_15_0.backBtn_, false)
	arg_15_0:RefreshStarUI()
	arg_15_0:RefreshTimeUI()
	arg_15_0:RefreshBtnUI()
	arg_15_0:RefreshTitleUI()
end

function var_0_0.RefreshStarUI(arg_16_0)
	local var_16_0 = ActivityRhythmGameCfg[arg_16_0.cfgID_].three_star_need
	local var_16_1 = ActivityRhythmGameData:GetStarsByCfgID(arg_16_0.cfgID_)
	local var_16_2 = {}

	for iter_16_0 = 1, 3 do
		local var_16_3 = false

		if var_16_1 then
			for iter_16_1, iter_16_2 in pairs(var_16_1) do
				if iter_16_2 == 100 + iter_16_0 then
					var_16_3 = true
				end
			end
		end

		var_16_2[iter_16_0] = {
			var_16_3,
			var_16_0[iter_16_0]
		}
	end

	for iter_16_3, iter_16_4 in pairs(var_16_2) do
		arg_16_0.sectionTargets_[iter_16_3]:Refresh(iter_16_4[1], iter_16_4[2])
	end
end

function var_0_0.RefreshTimeUI(arg_17_0)
	local var_17_0 = ActivityRhythmGameData:GetTimeByStageID(arg_17_0.stageID_)
	local var_17_1 = manager.time:DescCdTime2(var_17_0)

	arg_17_0.textnum01Text_.text = var_17_1
end

function var_0_0.RefreshBtnUI(arg_18_0)
	if ActivityRhythmGameData:IsUnlock(arg_18_0.cfgID_) then
		arg_18_0:ChangeLockController(0)
	else
		arg_18_0:ChangeLockController(1)

		local var_18_0 = ActivityRhythmGameCfg[arg_18_0.cfgID_]

		if var_18_0 and var_18_0.condition_list and var_18_0.condition_list ~= 0 and not IsConditionAchieved(var_18_0.condition_list) then
			local var_18_1 = ConditionCfg[var_18_0.condition_list]

			arg_18_0.conditionText_.text = var_18_1.desc

			return
		end

		if not ActivityRhythmGameData:IsUnlockPreStage(arg_18_0.cfgID_) then
			arg_18_0.conditionText_.text = arg_18_0.DefaultConditionText_
		end
	end
end

function var_0_0.RefreshTitleUI(arg_19_0)
	local var_19_0 = BattleRhythmGameStageCfg[arg_19_0.stageID_]

	arg_19_0.textcheckpointnameText_.text = GetI18NText(var_19_0.name)
	arg_19_0.bgImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_19_0.background_1))
end

return var_0_0
