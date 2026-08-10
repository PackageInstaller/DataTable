local var_0_0 = class("DormDispatchMissionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.timeController = ControllerUtil.GetController(arg_3_0.transform_, "task")
	arg_3_0.workController = ControllerUtil.GetController(arg_3_0.transform_, "workbtn")
	arg_3_0.refreshController = ControllerUtil.GetController(arg_3_0.transform_, "refresh")
	arg_3_0.coolController = ControllerUtil.GetController(arg_3_0.transform_, "cooling")
	arg_3_0.levelController = ControllerUtil.GetController(arg_3_0.transform_, "level")
	arg_3_0.lockController = ControllerUtil.GetController(arg_3_0.transform_, "lock")
	arg_3_0.roleuilistScroll_ = LuaList.New(handler(arg_3_0, arg_3_0.indexRecommendRoleItem), arg_3_0.roleuilistUilist_, DormRecommendRoleItem)
	arg_3_0.awarduilistScroll_ = LuaList.New(handler(arg_3_0, arg_3_0.indexAwardItem), arg_3_0.awarduilistUilist_, CommonItemView)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.dispatchbtnBtn_, nil, function()
		if #arg_4_0.heroList == 0 then
			if arg_4_0.confirmCallBack then
				arg_4_0.confirmCallBack(arg_4_0.ID, arg_4_0.pos, arg_4_0.timeLevel)
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_TAKS_CANCEL"),
				OkCallback = function()
					if arg_4_0.cancelCallBack then
						arg_4_0.cancelCallBack(arg_4_0.ID, arg_4_0.pos, arg_4_0.timeLevel)
					end
				end,
				CancelCallback = function()
					return
				end
			})
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.refreshbtnBtn_, nil, function()
		if arg_4_0.refreshTime > 0 then
			local var_8_0 = manager.time:GetNextFreshTime() - manager.time:GetServerTime()

			ShowTips(string.format(GetTips("CANTEEN_TASK_REFRESH_COOLDOWN"), manager.time:DescCDTime(var_8_0)))

			return
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_REFRESH_CONFIRM"),
				OkCallback = function()
					if arg_4_0.refreshCallBack then
						arg_4_0.refreshCallBack(arg_4_0.pos)
					end
				end,
				CancelCallback = function()
					return
				end
			})
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.unLockBtn_, nil, function()
		local var_11_0 = GameSetting.dorm_canteen_task_unlock.value[arg_4_0.pos][2]

		if var_11_0 ~= 0 then
			if IsConditionAchieved(var_11_0) then
				CanteenAction:UnLockEntrust(arg_4_0.pos)
			else
				ShowTips("NO_REACH_UNLOCK")
			end
		else
			CanteenAction:UnLockEntrust(arg_4_0.pos)
		end
	end)

	for iter_4_0 = 1, 3 do
		arg_4_0:AddToggleListener(arg_4_0["level_" .. iter_4_0 .. "Tgl_"], function(arg_12_0)
			if arg_12_0 then
				if arg_4_0.heroList and #arg_4_0.heroList > 0 then
					return
				end

				arg_4_0:SetTimeLevel(iter_4_0)
			end
		end)
	end
end

function var_0_0.SetTimeLevel(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1

	arg_13_0.timeLevel, var_13_1 = (arg_13_1 == nil or tostring(arg_13_1) == "userdata: NULL" or type(arg_13_1) ~= "number") and 1 or arg_13_1, BackHomeCanteenTaskCfg[arg_13_0.entrust.id]
	arg_13_0["level_" .. arg_13_0.timeLevel .. "Tgl_"].isOn = true

	arg_13_0:RefreshRecommendAward(arg_13_0.entrust.id, arg_13_0.entrust.pos, arg_13_0.timeLevel)

	arg_13_0.tasktimeText_.text = DormTools:MinSwitchTime(var_13_1.time[arg_13_0.timeLevel][1])

	CanteenEntrustData:SetTaskTimeLevel(arg_13_0.pos, arg_13_0.timeLevel)
end

function var_0_0.RefreshUI(arg_14_0, arg_14_1)
	arg_14_0.pos = arg_14_1.pos
	arg_14_0.entrust = arg_14_1

	local var_14_0 = string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_ENTRUST, arg_14_0.pos)

	if manager.redPoint:getTipBoolean(var_14_0) then
		manager.redPoint:SetRedPointIndependent(arg_14_0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_14_0.transform_, false)
	end

	if arg_14_1.id < 0 then
		local var_14_1 = GameSetting.dorm_canteen_task_unlock.value[arg_14_0.pos][2]
		local var_14_2
		local var_14_3
		local var_14_4

		if var_14_1 ~= 0 then
			var_14_2, var_14_3, var_14_4 = IsConditionAchieved(var_14_1)
		else
			var_14_2 = true
		end

		if var_14_2 then
			arg_14_0.lockController:SetSelectedState("canUnlock")

			arg_14_0.lockStateText_.text = GetTips("DORM_CANTEEN_TASK_CAN_UNLOCK")
		else
			arg_14_0.lockController:SetSelectedState("lock")

			arg_14_0.lockStateText_.text = GetTips("DORM_CANTEEN_TASK_LOCK")
			arg_14_0.conditionText_.text = string.format(GetTips("DORM_CANTEEN_TASK_UNLOCK_TIPS"), var_14_3, var_14_4)
		end

		return
	end

	arg_14_0.lockController:SetSelectedState("unlock")

	arg_14_0.lockStateText_.text = GetTips("DORM_CANTEEN_TASK_LOCK")
	arg_14_0.type = 1
	arg_14_0.refreshTime = CanteenEntrustData:GetEntrustList()[arg_14_0.pos].refresh_times

	local var_14_5 = BackHomeCanteenTaskCfg[arg_14_1.id]

	arg_14_0.ID = arg_14_1.id
	arg_14_0.tasknameText_.text = GetI18NText(var_14_5.name)
	arg_14_0.characternumText_.text = var_14_5.need[2]
	arg_14_0.destextText_.text = GetI18NText(var_14_5.desc)
	arg_14_0.heroList = arg_14_1.hero_list

	for iter_14_0 = 1, 3 do
		arg_14_0["timeText" .. iter_14_0].text = BackHomeCanteenTaskCfg[arg_14_1.id].time[iter_14_0][1] / 60
		arg_14_0["timeTextH" .. iter_14_0].text = string.format("  (%s)", GetTips("HOUR"))
	end

	if #arg_14_0.heroList > 0 then
		arg_14_0.type = 2

		arg_14_0.timeController:SetSelectedState("on")

		arg_14_0.timeText_.text = CanteenEntrustData:GetEntrustLastTime(arg_14_0.pos)
		arg_14_0.statsDecText_.text = GetTips("CANTEEN_DISPATCHED_HERO")
		arg_14_0.hastasknameText_.text = GetI18NText(var_14_5.name)

		arg_14_0.workController:SetSelectedState("off")

		arg_14_0.workStateText_.text = GetTips("BACKHOME_TASK_CANCEL")

		arg_14_0:SetTimeLevel(arg_14_1.timeLevel)
	else
		arg_14_0.statsDecText_.text = GetTips("CANREEN_RECOMEND_HERO")

		arg_14_0.timeController:SetSelectedState("off")
		arg_14_0.workController:SetSelectedState("on")

		arg_14_0.workStateText_.text = GetTips("BACKHOME_TASK_START")

		if not arg_14_0.timeLevel then
			arg_14_0.timeLevel = CanteenEntrustData:GetTaskTimeLevel(arg_14_0.pos)
		end

		arg_14_0:SetTimeLevel(arg_14_0.timeLevel)
	end

	arg_14_0.totalReText.text = "/" .. GameDisplayCfg.dorm_canteen_refresh_max.value[1]
	arg_14_0.curReText.text = 1 - arg_14_0.refreshTime

	if arg_14_0.refreshTime > 0 then
		arg_14_0.coolController:SetSelectedState("on")
	end

	arg_14_0.levelController:SetSelectedState(var_14_5.task_level)
end

function var_0_0.RefreshTimeMessage(arg_15_0)
	if arg_15_0.type == 2 then
		arg_15_0.timeText_.text = CanteenEntrustData:GetEntrustLastTime(arg_15_0.pos)

		if CanteenEntrustData:GetEntrustLastTime(arg_15_0.pos) == 0 then
			manager.notify:Invoke(CANTEEN_DISPATCH_TIME_OVER)
		end
	end
end

function var_0_0.RefreshRecommendAward(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_0.type == 1 then
		arg_16_0.recommendRoleList_ = {}

		local var_16_0 = CanteenEntrustData:GetEntrustList()[arg_16_2]

		for iter_16_0 = 1, #var_16_0.tags do
			table.insert(arg_16_0.recommendRoleList_, var_16_0.tags[iter_16_0])
		end

		arg_16_0.roleuilistScroll_:StartScroll(#arg_16_0.recommendRoleList_)
	elseif arg_16_0.type == 2 then
		arg_16_0.recommendRoleList_ = arg_16_0.heroList

		arg_16_0.roleuilistScroll_:StartScroll(#arg_16_0.recommendRoleList_)
	end

	arg_16_0.roleuilistUilist_:GetComponent("ScrollRectEx").horizontal = false
	arg_16_0.award_list = {}

	local var_16_1 = BackHomeCanteenTaskCfg[arg_16_1].time[arg_16_3][2] / 100

	for iter_16_1 = 1, #BackHomeCanteenTaskCfg[arg_16_1].reward_list do
		local var_16_2 = {
			id = BackHomeCanteenTaskCfg[arg_16_1].reward_list[iter_16_1][1],
			number = math.floor(BackHomeCanteenTaskCfg[arg_16_1].reward_list[iter_16_1][2] * var_16_1),
			clickFun = function(arg_17_0)
				ShowPopItem(POP_ITEM, {
					arg_17_0.id
				})
			end
		}

		table.insert(arg_16_0.award_list, var_16_2)
	end

	if arg_16_0.oldID ~= arg_16_1 or arg_16_0.oldTimeLevel ~= arg_16_3 then
		arg_16_0.awarduilistScroll_:StartScroll(#arg_16_0.award_list)

		arg_16_0.oldID = arg_16_1
		arg_16_0.oldTimeLevel = arg_16_3
	end
end

function var_0_0.RegisterConfirmCallBack(arg_18_0, arg_18_1)
	if arg_18_1 then
		arg_18_0.confirmCallBack = arg_18_1
	end
end

function var_0_0.RegisterCancelCallBack(arg_19_0, arg_19_1)
	if arg_19_1 then
		arg_19_0.cancelCallBack = arg_19_1
	end
end

function var_0_0.RegisterRefreshCallBack(arg_20_0, arg_20_1)
	if arg_20_1 then
		arg_20_0.refreshCallBack = arg_20_1
	end
end

function var_0_0.indexRecommendRoleItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2:RefreshUI(arg_21_0.recommendRoleList_[arg_21_1], arg_21_0.type)
end

function var_0_0.indexAwardItem(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2:SetData(arg_22_0.award_list[arg_22_1], arg_22_0.type)
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()

	if arg_23_0.roleuilistScroll_ then
		arg_23_0.roleuilistScroll_:Dispose()
	end

	if arg_23_0.awarduilistScroll_ then
		arg_23_0.awarduilistScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
