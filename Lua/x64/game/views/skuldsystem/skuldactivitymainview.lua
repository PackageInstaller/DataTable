ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SkuldActivityMainView", ActivityMainBasePanel)
local var_0_1 = "ACTIVITY_SKULD_DES"
local var_0_2 = 1011243

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_EntranceUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if SkuldSystemData:GetClientKey("IsShowEmptyDreamPop") or BattleStageData:GetStageClearTimes(var_0_2) > 0 then
			JumpTools.OpenPageByJump("/skuldSystemEnterView")
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("SKULD_PRE_CHAPTER"),
				OkCallback = function()
					SkuldSystemAction.SendMark("IsShowEmptyDreamPop")
					JumpTools.OpenPageByJump("/skuldSystemEnterView")
				end
			})
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.taskBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
			JumpTools.OpenPageByJump("/skuldSystemTaskView")
		else
			local var_6_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)

			if manager.time:GetServerTime() < var_6_0.startTime then
				ShowTips(string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_6_0.startTime)))
			else
				ShowTips("TIME_OVER")
			end
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.emptyDreamBtn_, nil, function()
		JumpTools.JumpToPage({
			309,
			12112
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.tipsBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("SKULD_SYSTEM_TIPS_1")
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	var_0_0.super.OnEnter(arg_9_0)
	arg_9_0:UpdatePreview()

	local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
		SetActive(arg_9_0.taskGo_, true)

		arg_9_0.timeLable_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
	elseif manager.time:GetServerTime() < var_9_0.startTime then
		SetActive(arg_9_0.taskGo_, false)
	elseif manager.time:GetServerTime() > var_9_0.stopTime then
		SetActive(arg_9_0.taskGo_, false)
	end

	if arg_9_0.timer_ == nil then
		arg_9_0.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
				SetActive(arg_9_0.taskGo_, true)

				arg_9_0.timeLable_.text = manager.time:GetLostTimeStr2(var_9_0.stopTime)
			elseif manager.time:GetServerTime() < var_9_0.startTime then
				SetActive(arg_9_0.taskGo_, false)
			elseif manager.time:GetServerTime() > var_9_0.stopTime then
				SetActive(arg_9_0.taskGo_, false)
			end
		end, 1, -1)
	end

	arg_9_0.timer_:Start()

	local var_9_1 = ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_EMPTY_DREAM].chapter_list
	local var_9_2 = 0
	local var_9_3 = {}

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		local var_9_4 = ChapterCfg[iter_9_1]

		for iter_9_2, iter_9_3 in pairs(var_9_4.section_id_list) do
			table.insert(var_9_3, iter_9_3)

			if BattleStageData:GetStageClearTimes(iter_9_3) > 0 then
				var_9_2 = var_9_2 + 1
			end
		end
	end

	arg_9_0.emptyDreamFillText_.text = math.floor(var_9_2 / #var_9_3 * 100) .. "%"
	arg_9_0.emptyDreamFillImage_.fillAmount = var_9_2 / #var_9_3
	arg_9_0.desText_.text = GetTips("SKULD_ACTIVITY_DES")
	arg_9_0.btnText_.text = GetTips("SKULD_ACTIVITY_MAINVIEW_BTN")

	local var_9_5 = RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK

	manager.redPoint:bindUIandKey(arg_9_0.taskBtn_.transform, var_9_5)

	local var_9_6 = RedPointConst.ACTIVITY_STORY_STAGE .. ActivityConst.ACTIVITY_SKULD_MAIN

	manager.redPoint:bindUIandKey(arg_9_0.btn_.transform, var_9_6)
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:StopTimer()
	var_0_0.super.OnExit(arg_11_0)

	local var_11_0 = RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK

	manager.redPoint:unbindUIandKey(arg_11_0.taskBtn_.transform, var_11_0)

	local var_11_1 = RedPointConst.ACTIVITY_STORY_STAGE .. ActivityConst.ACTIVITY_SKULD_MAIN

	manager.redPoint:unbindUIandKey(arg_11_0.btn_.transform, var_11_1)
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.isHasLeftTimeDes(arg_13_0)
	return true
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:StopTimer()
	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
