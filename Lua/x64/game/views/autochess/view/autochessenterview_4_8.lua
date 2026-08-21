local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("AutoChessEnterView_4_8", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_MainUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		local var_5_0 = getData("auto_chess_pop", "PREVIOUS")

		if arg_4_0.curLv < arg_4_0.maxLv and not var_5_0 then
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = AutoChessConst.GAME_TYPE.ONLINE,
				type = AutoChessConst.POP_TYPE.PREVIOUS_ADVICE,
				okCb = function()
					JumpTools.GoToSystem("/chapterMap", {
						chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
						activityID = ActivityConst.ACTIVITY_AUTO_CHESS_MAIN
					})
				end,
				cancelCb = function()
					JumpTools.OpenPageByJump("/autoChessRemakeMainView")
				end
			})
		else
			JumpTools.OpenPageByJump("/autoChessRemakeMainView")
		end

		saveData("auto_chess_pop", "PREVIOUS", true)
	end)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_main_homepage_rules",
			activity_id = AutoChessData:GetActivityID()
		})
		JumpTools.OpenPageByJump("gameHelp", {
			key = "AUTO_CHESS_2_ENTRANCE_TIP",
			content = GetTips("AUTO_CHESS_2_ENTRANCE_TIP")
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.jumpBtn_, nil, function()
		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_MAIN
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.limitTaskBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessLimitTaskView_4_8", {
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK
		})
	end)
end

function var_0_1.OnEnter(arg_11_0)
	arg_11_0.super.OnEnter(arg_11_0)
	arg_11_0:BindRedPoint()

	arg_11_0.curLv, arg_11_0.maxLv = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)
	arg_11_0.processText_.text = string.format("<size=48>%d</size>/%d", arg_11_0.curLv, arg_11_0.maxLv)
	arg_11_0.processImg_.fillAmount = arg_11_0.curLv / arg_11_0.maxLv

	arg_11_0:RefreshTime()
end

function var_0_1.RefreshTime(arg_12_0)
	local var_12_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)

	arg_12_0.timeText_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)

	SetActive(arg_12_0.limitTaskBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK))

	if arg_12_0.limittimer_ == nil then
		arg_12_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK) then
				arg_12_0.timeText_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
			else
				SetActive(arg_12_0.limitTaskBtn_.gameObject, false)
				arg_12_0:LimitStopTimer()
			end
		end, 1, -1)

		arg_12_0.limittimer_:Start()
	end
end

function var_0_1.LimitStopTimer(arg_14_0)
	if arg_14_0.limittimer_ then
		arg_14_0.limittimer_:Stop()

		arg_14_0.limittimer_ = nil
	end
end

function var_0_1.BindRedPoint(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.goBtn_.transform, RedPointConst.AUTO_CHESS_4_8_GO_BTN)
	manager.redPoint:bindUIandKey(arg_15_0.limitTaskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
end

function var_0_1.UnBindRedPoint(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.goBtn_.transform, RedPointConst.AUTO_CHESS_4_8_GO_BTN)
	manager.redPoint:unbindUIandKey(arg_16_0.limitTaskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
end

function var_0_1.OnTop(arg_17_0)
	return
end

function var_0_1.OnExit(arg_18_0)
	if arg_18_0.move then
		Object.Destroy(arg_18_0.move)

		arg_18_0.move = nil
	end

	arg_18_0:LimitStopTimer()
	arg_18_0:UnBindRedPoint()
	var_0_1.super.OnExit(arg_18_0)
end

function var_0_1.Dispose(arg_19_0)
	var_0_1.super.Dispose(arg_19_0)
end

return var_0_1
