local var_0_0 = class("ActivityRaceStageItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.selctController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.indexController_ = ControllerUtil.GetController(arg_1_0.transform_, "index")

	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		if arg_2_0.isLock_ then
			local var_3_0 = ActivityRaceCfg[arg_2_0.activityID_].stage_list
			local var_3_1 = table.keyof(var_3_0, arg_2_0.stageID_)
			local var_3_2 = BattleActivityRaceStageCfg[var_3_0[var_3_1 - 1]].name

			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), GetI18NText(var_3_2)))

			return
		end

		if manager.time:GetServerTime() >= arg_2_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceData:SetSelectActivityID(arg_2_0.activityID_)

		if arg_2_0.selectCallBack_ ~= nil then
			arg_2_0.selectCallBack_(arg_2_0.index_, arg_2_0.stageID_)
		end

		ActivityRaceData:SetTempActivityID(arg_2_0.activityID_)
		arg_2_0:Go("activityRaceSectionInfo", {
			section = arg_2_0.stageID_,
			stageIndex = arg_2_0.index_,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE,
			activityID = arg_2_0.activityID_
		})
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.activityID_ = arg_4_1
	arg_4_0.stageID_ = arg_4_2
	arg_4_0.index_ = arg_4_3
	arg_4_0.isLock_ = arg_4_4

	local var_4_0 = ActivityRaceCfg[arg_4_0.activityID_].stage_list

	arg_4_0.isBossStage_ = arg_4_0.stageID_ == var_4_0[#var_4_0]
	arg_4_0.stopTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).stopTime

	arg_4_0:RefreshUI()
end

function var_0_0.SetSelectCallBack(arg_5_0, arg_5_1)
	arg_5_0.selectCallBack_ = arg_5_1
end

function var_0_0.RefreshUI(arg_6_0)
	if not arg_6_0.isBossStage_ then
		arg_6_0.indexController_:SetSelectedState(tostring(arg_6_0.index_))
	end

	arg_6_0.lockController_:SetSelectedState(tostring(arg_6_0.isLock_))
	arg_6_0:RefreshTitle()
	arg_6_0:RefreshScore()
	arg_6_0:RefreshCompleted()
end

function var_0_0.RefreshTitle(arg_7_0)
	arg_7_0.titleText_.text = GetI18NText(BattleActivityRaceStageCfg[arg_7_0.stageID_].name)
end

function var_0_0.RefreshCompleted(arg_8_0)
	if arg_8_0.completedImageGo_ ~= nil then
		if ActivityRaceData:GetStateList()[arg_8_0.activityID_].completedStageList[arg_8_0.stageID_] == true then
			SetActive(arg_8_0.completedImageGo_, true)
		else
			SetActive(arg_8_0.completedImageGo_, false)
		end
	end
end

function var_0_0.RefreshScore(arg_9_0)
	if arg_9_0.isBossStage_ then
		SetActive(arg_9_0.scorePanelGo_, true)

		arg_9_0.scoreText_.text = ActivityRaceData:GetStateList()[arg_9_0.activityID_].score
	else
		SetActive(arg_9_0.scorePanelGo_, false)
	end
end

function var_0_0.RefreshSelect(arg_10_0, arg_10_1)
	if arg_10_1 == arg_10_0.stageID_ then
		arg_10_0.selctController_:SetSelectedState("true")
	else
		arg_10_0.selctController_:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.selctController_:SetSelectedState("false")
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
