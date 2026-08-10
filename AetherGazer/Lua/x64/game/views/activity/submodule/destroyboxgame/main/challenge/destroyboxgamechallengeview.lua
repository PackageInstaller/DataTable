local var_0_0 = class("DestroyBoxGameChallengeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.boxStateController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.rewardStateController_ = ControllerUtil.GetController(arg_1_0.transform_, "rewardState")
	arg_1_0.rewardItem_ = CommonItemView.New(arg_1_0.itemGo_)
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.mainActivityID_ = arg_2_1
	arg_2_0.id_ = DestroyBoxGameData:GetDifficultList(arg_2_1)[DestroyBoxGameData.SPECTIAL_HARD_LEVEL][arg_2_0.index_]

	local var_2_0 = DestroyBoxGameCfg[arg_2_0.id_]
	local var_2_1 = var_2_0.activity_id

	arg_2_0.activityID_ = var_2_1

	local var_2_2 = DestroyBoxGameRewardCfg.get_id_list_by_activity_id[var_2_1][1]
	local var_2_3 = DestroyBoxGameRewardCfg[var_2_2].item_list[1]

	arg_2_0.rewardID_ = var_2_2

	local var_2_4 = clone(ItemTemplateData)

	var_2_4.id = var_2_3[1]
	var_2_4.number = var_2_3[2]
	var_2_4.hideBottomRightTextFlag = true

	function var_2_4.clickFun(arg_3_0)
		if arg_2_0.receiveRewardState_ == 1 then
			arg_2_0:ReceiveReward()
		else
			ShowPopItem(POP_ITEM, {
				arg_3_0.id,
				arg_3_0.number
			})
		end
	end

	arg_2_0.rewardItem_:SetData(var_2_4)
	arg_2_0:RefreshData()
	arg_2_0:RefreshUI()
	arg_2_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, var_2_0.difficult, arg_2_0.activityID_))
end

function var_0_0.OnExit(arg_4_0)
	local var_4_0 = DestroyBoxGameCfg[arg_4_0.id_]

	manager.redPoint:unbindUIandKey(arg_4_0.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, var_4_0.difficult, arg_4_0.activityID_))
	arg_4_0:StopTimer()
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	arg_5_0.rewardItem_:Dispose()

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.button_, nil, function()
		local var_7_0 = arg_6_0.activityID_
		local var_7_1 = DestroyBoxGameCfg[arg_6_0.id_]

		if not arg_6_0.isTimeLock_ and not not arg_6_0.isFinishPreStage_ then
			DestroyBoxGameAction.ClickBoxStageItem(var_7_0, arg_6_0.id_)
		else
			return
		end

		local var_7_2 = var_7_1.main_activity_id

		if DestroyBoxGameData:GetSelectID(var_7_2) ~= arg_6_0.id_ then
			DestroyBoxGameData:SetSelectIDAndDifficult(var_7_2, arg_6_0.id_)
		end

		if arg_6_0.receiveRewardState_ == 1 then
			arg_6_0:ReceiveReward()
		else
			arg_6_0:GotoBattle(var_7_2)
		end
	end)
end

function var_0_0.GotoBattle(arg_8_0, arg_8_1)
	local var_8_0 = ActivityData:GetActivityData(arg_8_1)
	local var_8_1 = manager.time:GetServerTime()

	if var_8_1 < var_8_0.startTime then
		local var_8_2 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_8_2, manager.time:GetLostTimeStr2(var_8_0.startTime, nil, true)))

		return
	elseif var_8_1 >= var_8_0.stopTime then
		ShowTips("TIME_OVER")

		return
	end

	local var_8_3 = DestroyBoxGameCfg[arg_8_0.id_]

	DestroyBoxGameAction.ClickBoxStageItem(var_8_3.activity_id, arg_8_0.id_)
	arg_8_0:Go("/sectionSelectHero", {
		canChangeTeam = false,
		activityID = var_8_3.activity_id,
		section = var_8_3.stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME
	})
end

function var_0_0.RefreshData(arg_9_0)
	arg_9_0.targetScore_ = DestroyBoxGameRewardCfg[arg_9_0.rewardID_].complete_num

	local var_9_0 = DestroyBoxGameData:GetStageData(arg_9_0.id_)

	if var_9_0 then
		arg_9_0.maxScore_ = var_9_0.maxScore

		if arg_9_0.maxScore_ >= arg_9_0.targetScore_ then
			arg_9_0.receiveRewardState_ = 1
		end
	else
		arg_9_0.maxScore_ = 0
	end

	local var_9_1 = DestroyBoxGameData:GetReceiveRewardList(arg_9_0.mainActivityID_)

	arg_9_0.receiveRewardState_ = table.keyof(var_9_1, arg_9_0.rewardID_) and 2 or arg_9_0.receiveRewardState_
	arg_9_0.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(arg_9_0.id_)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshRewardState()
	arg_10_0:RefreshTips()
end

function var_0_0.RefreshTips(arg_11_0)
	arg_11_0.curScoreText_.text = arg_11_0.maxScore_
	arg_11_0.targetScoreText_.text = string.format("/%s", arg_11_0.targetScore_)

	local var_11_0 = DestroyBoxGameCfg[arg_11_0.id_]
	local var_11_1 = var_11_0.unlock_condition
	local var_11_2 = DestroyBoxGameCfg[var_11_1[1]]
	local var_11_3 = var_11_2.difficult

	if var_11_3 == 1 then
		var_11_3 = GetTips("HARDLEVEL_EASY")
	elseif var_11_3 == 2 then
		var_11_3 = GetTips("HARDLEVEL_HARD")
	end

	local var_11_4 = BattleDestroyBoxGameCfg[var_11_0.stage_id].name

	arg_11_0.titleText_.text = var_11_4
	arg_11_0.lockText_.text = string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE_1"), ActivityCfg[var_11_2.activity_id].remark, var_11_3, var_11_1[2])
end

function var_0_0.RefreshRewardState(arg_12_0)
	arg_12_0.rewardItem_:RefreshCompleted(false)

	if arg_12_0.receiveRewardState_ == 2 then
		arg_12_0.rewardItem_:RefreshCompleted(true)
		arg_12_0.rewardStateController_:SetSelectedState("normal")
	elseif arg_12_0.receiveRewardState_ == 1 then
		arg_12_0.rewardStateController_:SetSelectedState("canReceive")
	else
		arg_12_0.rewardStateController_:SetSelectedState("normal")
	end
end

function var_0_0.RefreshBoxState(arg_13_0)
	local var_13_0 = DestroyBoxGameCfg[arg_13_0.id_]

	if not arg_13_0.isFinishPreStage_ or arg_13_0.isTimeLock_ then
		arg_13_0.rewardStateController_:SetSelectedState("lock")

		if arg_13_0.isFinishPreStage_ and arg_13_0.isTimeLock_ then
			local var_13_1 = GetTips("OPEN_TIME")
			local var_13_2 = DestroyBoxGameCfg[arg_13_0.id_]
			local var_13_3 = ActivityData:GetActivityData(var_13_2.activity_id)

			arg_13_0.lockText_.text = string.format(var_13_1, manager.time:GetLostTimeStr2(var_13_3.startTime, nil, true))
		end
	else
		arg_13_0.rewardStateController_:SetSelectedState("normal")
	end
end

function var_0_0.SwitchSelectItem(arg_14_0, arg_14_1)
	if arg_14_0.id_ == arg_14_1 then
		-- block empty
	end
end

function var_0_0.ReceiveReward(arg_15_0)
	DestroyBoxGameAction.RequestReward(arg_15_0.mainActivityID_, {
		arg_15_0.rewardID_
	}, function()
		arg_15_0:RefreshData()
		arg_15_0:RefreshRewardState()
	end)
end

function var_0_0.AddTimer(arg_17_0)
	arg_17_0:StopTimer()

	local var_17_0 = DestroyBoxGameCfg[arg_17_0.id_]

	arg_17_0.isTimeLock_ = ActivityTools.GetActivityStatus(var_17_0.activity_id) ~= 1

	arg_17_0:RefreshBoxState()

	if arg_17_0.isFinishPreStage_ then
		arg_17_0.timer_ = Timer.New(function()
			local var_18_0 = ActivityTools.GetActivityStatus(var_17_0.activity_id) ~= 1

			if var_18_0 ~= arg_17_0.isTimeLock_ then
				arg_17_0.isTimeLock_ = var_18_0

				arg_17_0:RefreshBoxState()
			end
		end, 1, -1)

		arg_17_0.timer_:Start()
	end
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

return var_0_0
