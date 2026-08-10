local var_0_0 = class("DestroyBoxGameNormalItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.boxStateController_ = ControllerUtil.GetController(arg_1_0.transform_, "boxState")

	if arg_1_3 % 2 == 0 then
		-- block empty
	end

	arg_1_0:Show(true)
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.id_ = arg_2_1

	local var_2_0 = DestroyBoxGameCfg[arg_2_0.id_]

	arg_2_0.activityID_ = var_2_0.activity_id

	local var_2_1 = DestroyBoxGameData:GetDifficultList(var_2_0.main_activity_id)[var_2_0.difficult]
	local var_2_2 = table.keyof(var_2_1, arg_2_0.id_)

	arg_2_0.numText_.text = string.format("%02d", var_2_2)
	arg_2_0.index_ = var_2_2
	arg_2_0.isClearStage_ = DestroyBoxGameData:IsClearStage(arg_2_1)
	arg_2_0.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(arg_2_1)

	arg_2_0:RefreshScore()
	arg_2_0:AddTimer()
	arg_2_0:AddRedPoint()
end

function var_0_0.RefreshScore(arg_3_0)
	local var_3_0 = DestroyBoxGameData:GetStageData(arg_3_0.id_)

	if var_3_0 then
		arg_3_0.text8Text_.text = var_3_0.maxScore
	else
		arg_3_0.text8Text_.text = 0
	end
end

function var_0_0.OnExit(arg_4_0)
	arg_4_0:StopTimer()
	arg_4_0:RemoveRedPoint()
end

function var_0_0.AddRedPoint(arg_5_0)
	local var_5_0 = DestroyBoxGameCfg[arg_5_0.id_]

	manager.redPoint:bindUIandKey(arg_5_0.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, var_5_0.difficult, arg_5_0.activityID_))
end

function var_0_0.RemoveRedPoint(arg_6_0)
	local var_6_0 = DestroyBoxGameCfg[arg_6_0.id_]

	manager.redPoint:unbindUIandKey(arg_6_0.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, var_6_0.difficult, arg_6_0.activityID_))
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.transform_ = nil
	arg_7_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.button_, nil, function()
		local var_9_0 = DestroyBoxGameCfg[arg_8_0.id_]
		local var_9_1 = var_9_0.activity_id
		local var_9_2 = var_9_0.main_activity_id

		if arg_8_0.isTimeLock_ then
			local var_9_3 = ActivityData:GetActivityData(var_9_1)
			local var_9_4 = manager.time:GetServerTime()

			if var_9_4 < var_9_3.startTime then
				local var_9_5 = GetTips("OPEN_TIME")

				ShowTips(string.format(var_9_5, manager.time:GetLostTimeStr2(var_9_3.startTime, nil, true)))
			elseif var_9_4 >= var_9_3.stopTime then
				ShowTips("TIME_OVER")
			end

			return
		elseif not arg_8_0.isFinishPreStage_ then
			local var_9_6 = DestroyBoxGameCfg[arg_8_0.id_].unlock_condition
			local var_9_7 = DestroyBoxGameCfg[var_9_6[1]]
			local var_9_8 = var_9_7.difficult

			if var_9_8 == 1 then
				var_9_8 = GetTips("HARDLEVEL_EASY")
			elseif var_9_8 == 2 then
				var_9_8 = GetTips("HARDLEVEL_HARD")
			end

			if var_9_6[2] > 1 then
				ShowTips(string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE_1"), ActivityCfg[var_9_7.activity_id].remark, var_9_8, var_9_6[2]))
			else
				ShowTips(string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE"), ActivityCfg[var_9_7.activity_id].remark, var_9_8))
			end

			return
		end

		DestroyBoxGameAction.ClickBoxStageItem(arg_8_0.activityID_, arg_8_0.id_)

		if DestroyBoxGameData:GetSelectID(var_9_2) ~= arg_8_0.id_ then
			DestroyBoxGameData:SetSelectIDAndDifficult(var_9_2, arg_8_0.id_)
		end

		arg_8_0:GotoBattle(var_9_2)
	end)
end

function var_0_0.GotoBattle(arg_10_0, arg_10_1)
	local var_10_0 = ActivityData:GetActivityData(arg_10_1)
	local var_10_1 = manager.time:GetServerTime()

	if var_10_1 < var_10_0.startTime then
		local var_10_2 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_10_2, manager.time:GetLostTimeStr2(var_10_0.startTime, nil, true)))

		return
	elseif var_10_1 >= var_10_0.stopTime then
		ShowTips("TIME_OVER")

		return
	end

	local var_10_3 = DestroyBoxGameCfg[arg_10_0.id_]

	DestroyBoxGameAction.ClickBoxStageItem(var_10_3.activity_id, arg_10_0.id_)
	arg_10_0:Go("/sectionSelectHero", {
		canChangeTeam = false,
		activityID = var_10_3.activity_id,
		section = var_10_3.stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME
	})
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.SwitchDifficult(arg_12_0)
	local var_12_0 = DestroyBoxGameCfg[arg_12_0.id_]
	local var_12_1 = var_12_0.main_activity_id
	local var_12_2 = DestroyBoxGameData:GetSelectDifficult(var_12_1)

	arg_12_0:RemoveRedPoint()

	arg_12_0.id_ = DestroyBoxGameCfg.get_id_list_by_activity_id[var_12_0.activity_id][var_12_2]

	arg_12_0:AddRedPoint()

	arg_12_0.isClearStage_ = DestroyBoxGameData:IsClearStage(arg_12_0.id_)
	arg_12_0.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(arg_12_0.id_)

	arg_12_0:RefreshScore()
	arg_12_0:AddTimer()
end

function var_0_0.RefreshBoxState(arg_13_0)
	local var_13_0 = DestroyBoxGameCfg[arg_13_0.id_]

	if arg_13_0.isClearStage_ then
		arg_13_0.boxStateController_:SetSelectedState("clear")
	elseif not arg_13_0.isFinishPreStage_ or arg_13_0.isTimeLock_ then
		arg_13_0.boxStateController_:SetSelectedState("lock")
	else
		arg_13_0.boxStateController_:SetSelectedState("unlock")
	end
end

function var_0_0.SwitchSelectItem(arg_14_0, arg_14_1)
	if arg_14_0.id_ == arg_14_1 then
		-- block empty
	end
end

function var_0_0.AddTimer(arg_15_0)
	arg_15_0:StopTimer()

	local var_15_0 = DestroyBoxGameCfg[arg_15_0.id_]

	arg_15_0.isTimeLock_ = ActivityTools.GetActivityStatus(var_15_0.activity_id) ~= 1

	arg_15_0:RefreshBoxState()

	if arg_15_0.isFinishPreStage_ then
		arg_15_0.timer_ = Timer.New(function()
			local var_16_0 = ActivityTools.GetActivityStatus(var_15_0.activity_id) ~= 1

			if var_16_0 ~= arg_15_0.isTimeLock_ then
				arg_15_0.isTimeLock_ = var_16_0

				arg_15_0:RefreshBoxState()
			end
		end, 1, -1)

		arg_15_0.timer_:Start()
	end
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

return var_0_0
