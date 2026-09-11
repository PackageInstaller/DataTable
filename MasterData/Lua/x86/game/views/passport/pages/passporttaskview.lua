local PassportTaskView = class("PassportTaskView", ReduxView)

function PassportTaskView:UIName()
	return "Widget/System/Passport/PassportTaskUI"
end

function PassportTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function PassportTaskView:Init()
	self.curGroup_ = 0

	self:InitUI()
	self:AddUIListener()
end

function PassportTaskView:InitUI()
	self:BindCfgUI()

	self.receiveBtnController_ = self.gameObject_:GetComponent("ControllerExCollection"):GetController("receiveBtn_all")
	self.controller = Object.Instantiate(Asset.Load(BattlePassListCfg[PassportData:GetId()].prefab_path), self.container_.transform):GetComponent("ControllerExCollection"):GetController("default")

	self.controller:SetSelectedState("bg")

	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, PassportTaskItemView)
	self.tree_ = LuaTree.New(self.treeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect))
end

function PassportTaskView:OnGroupSelect(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if self.curGroup_ == arg_5_1 then
		return
	end

	self.curGroup_ = arg_5_1

	if arg_5_2 == 1 then
		self:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_DAILY)
	elseif arg_5_2 == 2 then
		self:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_WEEKLY)
	elseif arg_5_2 == 3 then
		self:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_CHALLENGE)
	end
end

function PassportTaskView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.taskDataList_[arg_6_1])
end

function PassportTaskView:AddUIListener()
	self:AddBtnListener(self.buyLevelBtn_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level = PassportData:GetLevel()
		})
		JumpTools.OpenPageByJump("passportBuyLevel", nil, ViewConst.SYSTEM_ID.PASSPORT_BUY_LEVEL)
	end)
	self:AddBtnListener(self.oneKeyGetBtn_, nil, function()
		local var_9_0 = TaskTools:GetFinishTaskIds(7)
		local var_9_1 = TaskTools:GetFinishTaskIds(8)
		local var_9_2 = TaskTools:GetFinishTaskIds(9)

		if #var_9_0 + #var_9_1 + #var_9_2 <= 0 then
			return
		end

		local var_9_4 = getData("passport_task", "tip_deadline")

		if (var_9_4 and tonumber(var_9_4) > manager.time:GetServerTime() or nil) and false and #var_9_0 + #var_9_1 > 0 and PassportData:GetExpWeekly() >= GameSetting.battlepass_exp_limit_weekly.value[1] then
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

function PassportTaskView:RegisterRedPoint()
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(1), RedPointConst.PASSPORT_TASK_BONUS_7)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(2), RedPointConst.PASSPORT_TASK_BONUS_8)
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(3), RedPointConst.PASSPORT_TASK_BONUS_9)
end

function PassportTaskView:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(1), RedPointConst.PASSPORT_TASK_BONUS_7)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(2), RedPointConst.PASSPORT_TASK_BONUS_8)
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(3), RedPointConst.PASSPORT_TASK_BONUS_9)
end

function PassportTaskView:SetTaskType(arg_14_1)
	if self.curType_ then
		-- block empty
	end

	self.curType_ = arg_14_1

	self:UpdateView()
end

function PassportTaskView:UpdateView()
	self.levelLabel_.text = PassportData:GetLevel()

	local var_15_0 = PassportData:GetCurrentExp()
	local var_15_1 = PassportData:GetUpgradeNeedExp()
	local var_15_2 = math.min((PassportData:GetLevel() >= PassportData:GetMaxLevel() or nil) and var_15_1, var_15_1)

	self.expProgress_.value = var_15_2 / var_15_1
	self.expLabel_.text = string.format("%d/%d", var_15_2, var_15_1)
	self.expLimitLabel_.text = string.format("%d/%d", PassportData:GetExpWeekly(), GameSetting.battlepass_exp_limit_weekly.value[1])

	local var_15_3 = manager.time:GetServerTime()

	self.taskDataList_ = {}

	for iter_15_0, iter_15_1 in ipairs((TaskTools:GetTaskIDList(self.curType_))) do
		local var_15_4 = TaskData2:GetTask(iter_15_1).expired_timestamp or 0

		if var_15_4 > 0 and var_15_4 - var_15_3 > 0 or var_15_4 == 0 then
			table.insert(self.taskDataList_, iter_15_1)
		end
	end

	table.sort(self.taskDataList_, function(arg_16_0, arg_16_1)
		local var_16_0 = self:GetTaskStatus(arg_16_0)
		local var_16_1 = self:GetTaskStatus(arg_16_1)

		if var_16_0 ~= var_16_1 then
			return var_16_0 < var_16_1
		end

		return arg_16_1 < arg_16_0
	end)
	self.list_:StartScroll(#self.taskDataList_)

	local var_15_5 = TaskTools:GetFinishTaskIds(7)

	table.insertto(var_15_5, TaskTools:GetFinishTaskIds(8))
	table.insertto(var_15_5, TaskTools:GetFinishTaskIds(9))

	local var_15_6 = 0

	for iter_15_2, iter_15_3 in ipairs(var_15_5) do
		local var_15_7 = TaskData2:GetTask(iter_15_3)

		if table.indexof(self.taskDataList_, iter_15_3) then
			var_15_6 = var_15_6 + 1
		end
	end

	self.receiveBtnController_:SetSelectedState(var_15_6 <= 0 and "ash" or "select")
	SetActive(self.buyLevelBtn_.gameObject, PassportData:GetLevel() < PassportData:GetMaxLevel())
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bglvTransform_)
	TaskRedPoint:UpdatePassportTaskRedTip()
end

function PassportTaskView:OnEnter()
	self.timer_ = self.timer_ or Timer.New(function()
		self:UpdateTimer()
	end, 1, -1)

	self.timer_:Start()
	self:AdaptScreen()
	self.tree_:SelectGroup(self.curGroup_ == 0 and 1 or self.curGroup_)
	self:RegisterRedPoint()
	self:UpdateTimer()
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_19_0)
		if arg_19_0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
			self:UpdateView()
		end
	end)
	self:UpdateView()
end

function PassportTaskView:UpdateTimer()
	self.duringLabel1_.text = string.format(GetTips("TIME_DISPLAY_6"), manager.time:GetLostTimeStr(PassportData:GetEndTimestamp())) .. string.format("  %s-%s", manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M:%S"), (manager.time:STimeDescS(PassportData:GetEndTimestamp(), "!%Y/%m/%d %H:%M:%S")))

	self:CheckOutofDate()

	if self.taskDataList_ == nil then
		return
	end

	local var_20_0 = manager.time:GetServerTime()

	for iter_20_0, iter_20_1 in ipairs(self.taskDataList_) do
		local var_20_1 = TaskData2:GetTask(iter_20_1).expired_timestamp or 0

		if var_20_1 > 0 and var_20_1 - var_20_0 <= 0 then
			self:UpdateView()

			break
		end
	end
end

function PassportTaskView:RemoveTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PassportTaskView:CheckOutofDate()
	if not PassportData:IsOpen() or manager.time:GetServerTime() >= PassportData:GetEndTimestamp() then
		TimeTools.StartAfterSeconds(0.1, function()
			self:Go("/home")
			ShowTips("BATTLEPASS_EXPIRED")
		end, {})

		return true
	end

	return false
end

function PassportTaskView:OnTop()
	self:UpdateBar()
end

function PassportTaskView:UpdateBar()
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

function PassportTaskView:OnExit()
	self:UnRegisterRedPoint()
	self:RemoveTimer()
	manager.windowBar:HideBar()
end

function PassportTaskView:OnTaskListChange()
	self:UpdateView()
end

function PassportTaskView:GetTaskStatus(arg_28_1)
	if TaskData2:GetTask(arg_28_1).complete_flag == 1 then
		return 3
	elseif AssignmentCfg[arg_28_1].need <= TaskData2:GetTaskProgress(arg_28_1) then
		return 1
	else
		return 2
	end
end

function PassportTaskView:OnMainHomeViewTop()
	self.curGroup_ = 0
end

function PassportTaskView:Dispose()
	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self:RemoveTimer()
	PassportTaskView.super.Dispose(self)
end

return PassportTaskView
