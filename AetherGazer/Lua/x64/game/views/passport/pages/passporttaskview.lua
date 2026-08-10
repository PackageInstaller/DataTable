local var_0_0 = class("PassportTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Passport/PassportTaskUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.curGroup_ = 0

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.receiveBtnController_ = arg_4_0.gameObject_:GetComponent("ControllerExCollection"):GetController("receiveBtn_all")

	local var_4_0 = Asset.Load(BattlePassListCfg[PassportData:GetId()].prefab_path)

	arg_4_0.controller = Object.Instantiate(var_4_0, arg_4_0.container_.transform):GetComponent("ControllerExCollection"):GetController("default")

	arg_4_0.controller:SetSelectedState("bg")

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, PassportTaskItemView)
	arg_4_0.tree_ = LuaTree.New(arg_4_0.treeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect))
end

function var_0_0.OnGroupSelect(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_0.curGroup_ == arg_5_1 then
		return
	end

	arg_5_0.curGroup_ = arg_5_1

	if arg_5_2 == 1 then
		arg_5_0:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_DAILY)
	elseif arg_5_2 == 2 then
		arg_5_0:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_WEEKLY)
	elseif arg_5_2 == 3 then
		arg_5_0:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_CHALLENGE)
	end
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.taskDataList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buyLevelBtn_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level = PassportData:GetLevel()
		})
		JumpTools.OpenPageByJump("passportBuyLevel", nil, ViewConst.SYSTEM_ID.PASSPORT_BUY_LEVEL)
	end)
	arg_7_0:AddBtnListener(arg_7_0.oneKeyGetBtn_, nil, function()
		local var_9_0 = TaskTools:GetFinishTaskIds(7)
		local var_9_1 = TaskTools:GetFinishTaskIds(8)
		local var_9_2 = TaskTools:GetFinishTaskIds(9)

		if #var_9_0 + #var_9_1 + #var_9_2 <= 0 then
			return
		end

		local var_9_3 = true
		local var_9_4 = getData("passport_task", "tip_deadline")

		if var_9_4 and tonumber(var_9_4) > manager.time:GetServerTime() then
			var_9_3 = false
		end

		if var_9_3 and #var_9_0 + #var_9_1 > 0 and PassportData:GetExpWeekly() >= GameSetting.battlepass_exp_limit_weekly.value[1] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PASSPORT_WEEKLY_EXP_LIMIT_TIP"),
				toggleText = GetTips("WEEKLY_MUTE_TIP"),
				OkCallback = function()
					TaskAction:TryToSubmitPassportTaskList(var_9_0, var_9_1, var_9_2)
				end,
				ToggleCallback = function(arg_11_0)
					if arg_11_0 then
						saveData("passport_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
					end
				end
			})
		else
			TaskAction:TryToSubmitPassportTaskList(var_9_0, var_9_1, var_9_2)
		end
	end)
end

function var_0_0.RegisterRedPoint(arg_12_0)
	manager.redPoint:bindUIandKey(arg_12_0.tree_:GetGroupRedPointContainerById(1), RedPointConst.PASSPORT_TASK_BONUS_7)
	manager.redPoint:bindUIandKey(arg_12_0.tree_:GetGroupRedPointContainerById(2), RedPointConst.PASSPORT_TASK_BONUS_8)
	manager.redPoint:bindUIandKey(arg_12_0.tree_:GetGroupRedPointContainerById(3), RedPointConst.PASSPORT_TASK_BONUS_9)
end

function var_0_0.UnRegisterRedPoint(arg_13_0)
	manager.redPoint:unbindUIandKey(arg_13_0.tree_:GetGroupRedPointContainerById(1), RedPointConst.PASSPORT_TASK_BONUS_7)
	manager.redPoint:unbindUIandKey(arg_13_0.tree_:GetGroupRedPointContainerById(2), RedPointConst.PASSPORT_TASK_BONUS_8)
	manager.redPoint:unbindUIandKey(arg_13_0.tree_:GetGroupRedPointContainerById(3), RedPointConst.PASSPORT_TASK_BONUS_9)
end

function var_0_0.SetTaskType(arg_14_0, arg_14_1)
	if arg_14_0.curType_ then
		-- block empty
	end

	arg_14_0.curType_ = arg_14_1

	arg_14_0:UpdateView()
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0.levelLabel_.text = PassportData:GetLevel()

	local var_15_0 = PassportData:GetCurrentExp()
	local var_15_1 = PassportData:GetUpgradeNeedExp()

	if PassportData:GetLevel() >= PassportData:GetMaxLevel() then
		var_15_0 = var_15_1
	end

	local var_15_2 = math.min(var_15_0, var_15_1)

	arg_15_0.expProgress_.value = var_15_2 / var_15_1
	arg_15_0.expLabel_.text = string.format("%d/%d", var_15_2, var_15_1)
	arg_15_0.expLimitLabel_.text = string.format("%d/%d", PassportData:GetExpWeekly(), GameSetting.battlepass_exp_limit_weekly.value[1])

	local var_15_3 = TaskTools:GetTaskIDList(arg_15_0.curType_)
	local var_15_4 = manager.time:GetServerTime()

	arg_15_0.taskDataList_ = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_3) do
		local var_15_5 = TaskData2:GetTask(iter_15_1).expired_timestamp or 0

		if var_15_5 > 0 and var_15_5 - var_15_4 > 0 or var_15_5 == 0 then
			table.insert(arg_15_0.taskDataList_, iter_15_1)
		end
	end

	table.sort(arg_15_0.taskDataList_, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_15_0:GetTaskStatus(arg_16_0)
		local var_16_1 = arg_15_0:GetTaskStatus(arg_16_1)

		if var_16_0 ~= var_16_1 then
			return var_16_0 < var_16_1
		end

		return arg_16_1 < arg_16_0
	end)
	arg_15_0.list_:StartScroll(#arg_15_0.taskDataList_)

	local var_15_6 = TaskTools:GetFinishTaskIds(7)

	table.insertto(var_15_6, TaskTools:GetFinishTaskIds(8))
	table.insertto(var_15_6, TaskTools:GetFinishTaskIds(9))

	local var_15_7 = 0

	for iter_15_2, iter_15_3 in ipairs(var_15_6) do
		local var_15_8 = TaskData2:GetTask(iter_15_3)

		if table.indexof(arg_15_0.taskDataList_, iter_15_3) then
			var_15_7 = var_15_7 + 1
		end
	end

	arg_15_0.receiveBtnController_:SetSelectedState(var_15_7 <= 0 and "ash" or "select")
	SetActive(arg_15_0.buyLevelBtn_.gameObject, PassportData:GetLevel() < PassportData:GetMaxLevel())
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_0.bglvTransform_)
	TaskRedPoint:UpdatePassportTaskRedTip()
end

function var_0_0.OnEnter(arg_17_0)
	if not arg_17_0.timer_ then
		arg_17_0.timer_ = Timer.New(function()
			arg_17_0:UpdateTimer()
		end, 1, -1)
	end

	arg_17_0.timer_:Start()
	arg_17_0:AdaptScreen()
	arg_17_0.tree_:SelectGroup(arg_17_0.curGroup_ == 0 and 1 or arg_17_0.curGroup_)
	arg_17_0:RegisterRedPoint()
	arg_17_0:UpdateTimer()
	arg_17_0:RegistEventListener(CURRENCY_UPDATE, function(arg_19_0)
		if arg_19_0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
			arg_17_0:UpdateView()
		end
	end)
	arg_17_0:UpdateView()
end

function var_0_0.UpdateTimer(arg_20_0)
	local var_20_0 = manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M:%S")
	local var_20_1 = manager.time:STimeDescS(PassportData:GetEndTimestamp(), "!%Y/%m/%d %H:%M:%S")

	arg_20_0.duringLabel1_.text = string.format(GetTips("TIME_DISPLAY_6"), manager.time:GetLostTimeStr(PassportData:GetEndTimestamp())) .. string.format("  %s-%s", var_20_0, var_20_1)

	arg_20_0:CheckOutofDate()

	if arg_20_0.taskDataList_ == nil then
		return
	end

	local var_20_2 = manager.time:GetServerTime()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.taskDataList_) do
		local var_20_3 = TaskData2:GetTask(iter_20_1).expired_timestamp or 0

		if var_20_3 > 0 and var_20_3 - var_20_2 <= 0 then
			arg_20_0:UpdateView()

			break
		end
	end
end

function var_0_0.RemoveTimer(arg_21_0)
	if arg_21_0.timer_ then
		arg_21_0.timer_:Stop()

		arg_21_0.timer_ = nil
	end
end

function var_0_0.CheckOutofDate(arg_22_0)
	local var_22_0 = manager.time:GetServerTime()

	if not PassportData:IsOpen() or var_22_0 >= PassportData:GetEndTimestamp() then
		TimeTools.StartAfterSeconds(0.1, function()
			arg_22_0:Go("/home")
			ShowTips("BATTLEPASS_EXPIRED")
		end, {})

		return true
	end

	return false
end

function var_0_0.OnTop(arg_24_0)
	arg_24_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_25_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "/passportNote",
		type = "jump",
		params = {}
	})
end

function var_0_0.OnExit(arg_26_0)
	arg_26_0:UnRegisterRedPoint()
	arg_26_0:RemoveTimer()
	manager.windowBar:HideBar()
end

function var_0_0.OnTaskListChange(arg_27_0)
	arg_27_0:UpdateView()
end

function var_0_0.GetTaskStatus(arg_28_0, arg_28_1)
	local var_28_0 = AssignmentCfg[arg_28_1]
	local var_28_1 = TaskData2:GetTask(arg_28_1)
	local var_28_2 = TaskData2:GetTaskProgress(arg_28_1)
	local var_28_3 = var_28_0.need

	if var_28_1.complete_flag == 1 then
		return 3
	elseif var_28_3 <= var_28_2 then
		return 1
	else
		return 2
	end
end

function var_0_0.OnMainHomeViewTop(arg_29_0)
	arg_29_0.curGroup_ = 0
end

function var_0_0.Dispose(arg_30_0)
	if arg_30_0.tree_ then
		arg_30_0.tree_:Dispose()

		arg_30_0.tree_ = nil
	end

	if arg_30_0.list_ then
		arg_30_0.list_:Dispose()

		arg_30_0.list_ = nil
	end

	arg_30_0:RemoveTimer()
	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
