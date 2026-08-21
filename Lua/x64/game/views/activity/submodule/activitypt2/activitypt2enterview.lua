ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityPt2EnterView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return ActivityPt2Tools.GetEnterUIName(arg_1_0.activityID_)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:RefreshShop()

	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.clearCon_ = ControllerUtil.GetController(arg_3_0.transform_, "clear")
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, ActivityPt2TaskItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:Refresh(arg_4_0.list_[arg_4_1], arg_4_0.activityID_)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.exchangeBtn_, nil, function()
		local var_6_0 = ActivityShopCfg[arg_5_0.activityID_]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_0.activity_theme]) do
			local var_6_2 = ActivityShopCfg[iter_6_1].shop_id
			local var_6_3 = ActivityData:GetActivityData(ShopListCfg[var_6_2].activity_id)

			if var_6_3 and var_6_3:IsActivitying() then
				table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_4, var_6_5 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_4 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_5 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_5 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityPt2", {
			mainActivityId = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.allReceiveBtn_, nil, function()
		local var_8_0 = {}
		local var_8_1 = ActivityPt2Tools:GetTaskActivityID(arg_5_0.activityID_)

		for iter_8_0, iter_8_1 in ipairs(arg_5_0.list_) do
			local var_8_2 = AssignmentCfg[iter_8_1]
			local var_8_3 = TaskData2:GetTask(iter_8_1)

			if var_8_3.complete_flag < 1 and var_8_3.progress >= var_8_2.need then
				table.insert(var_8_0, iter_8_1)
			end
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipBtn_, nil, function()
		local var_9_0 = ActivityPt2Tools.GetHelpKey(arg_5_0.activityID_)

		if var_9_0 ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(var_9_0),
				key = var_9_0
			})
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:RefreshUI()
	arg_10_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_10_0, arg_10_0.RefreshTask))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. arg_10_0.activityID_, 0)
	saveData(RedPointConst.ACTIVITY_PT_2_OPEN, tostring(arg_10_0.activityID_), true)
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshActivityData()
	arg_11_0:RefreshTime()
	arg_11_0:RefreshTask()
end

function var_0_0.RefreshActivityData(arg_12_0)
	arg_12_0.activityData_ = ActivityData:GetActivityData(arg_12_0.activityID_)
	arg_12_0.startTime_ = arg_12_0.activityData_.startTime
	arg_12_0.stopTime_ = arg_12_0.activityData_.stopTime

	local var_12_0 = ActivityCfg[arg_12_0.activityID_].unlock_condition

	if type(var_12_0) ~= "table" then
		arg_12_0.lock_.text = ""
	else
		local var_12_1 = ChapterCfg[var_12_0[2][1]]

		arg_12_0.lock_.text = string.format(GetTips("ACTIVITY_XUHENG_PT_LOCK"), var_12_1.subhead)
	end

	arg_12_0.isLock_ = not ActivityTools.IsUnlockActivity(arg_12_0.activityID_)
	arg_12_0.challengeCurrencyID_ = ActivityPt2Tools.GetChallengeCurrencyID(arg_12_0.activityID_)
end

function var_0_0.RefreshTime(arg_13_0)
	local var_13_0
	local var_13_1 = manager.time:GetServerTime()
	local var_13_2
	local var_13_3 = ActivityShopCfg[arg_13_0.activityID_].shop_id
	local var_13_4 = ActivityData:GetActivityData(ShopListCfg[var_13_3].activity_id).stopTime

	arg_13_0:StopTimer()

	if var_13_1 < arg_13_0.startTime_ then
		arg_13_0.stateCon_:SetSelectedState("close")

		arg_13_0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		arg_13_0.timer_ = Timer.New(function()
			var_13_0 = arg_13_0.startTime_ - manager.time:GetServerTime()

			if var_13_0 <= 0 then
				arg_13_0:StopTimer()
				arg_13_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_13_0.timer_:Start()
	elseif var_13_1 < arg_13_0.stopTime_ or var_13_1 < var_13_4 then
		if var_13_1 < arg_13_0.stopTime_ then
			arg_13_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_13_0.stopTime_)
		else
			arg_13_0.timeLable_.text = GetTips("TIME_OVER")
		end

		var_13_2 = var_13_4 - var_13_1

		if var_13_2 < GameSetting.time_remaining_show.value[1] * 86400 then
			arg_13_0.shopTimeLable_.text = manager.time:GetLostTimeStrWith2Unit(var_13_4)

			SetActive(arg_13_0.shopTimeGo_, true)
		else
			SetActive(arg_13_0.shopTimeGo_, false)
		end

		if var_13_1 >= arg_13_0.stopTime_ then
			if var_13_2 > 0 then
				arg_13_0.stateCon_:SetSelectedState("onlyShop")
			else
				arg_13_0.stateCon_:SetSelectedState("close")
			end
		elseif arg_13_0.isLock_ then
			arg_13_0.stateCon_:SetSelectedState("lock")
		else
			arg_13_0.stateCon_:SetSelectedState("unlock")
		end

		arg_13_0.timer_ = Timer.New(function()
			var_13_1 = manager.time:GetServerTime()
			var_13_0 = arg_13_0.startTime_ - var_13_1
			var_13_2 = var_13_4 - var_13_1

			if var_13_0 <= 0 and var_13_2 <= 0 then
				arg_13_0:StopTimer()
				arg_13_0:RefreshTime()

				return
			end

			if var_13_1 < arg_13_0.stopTime_ then
				arg_13_0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(arg_13_0.stopTime_)
			else
				arg_13_0.timeLable_.text = GetTips("TIME_OVER")
			end

			var_13_2 = var_13_4 - var_13_1

			if var_13_2 < GameSetting.time_remaining_show.value[1] * 86400 then
				arg_13_0.shopTimeLable_.text = manager.time:GetLostTimeStrWith2Unit(var_13_4)

				SetActive(arg_13_0.shopTimeGo_, true)
			else
				SetActive(arg_13_0.shopTimeGo_, false)
			end

			if var_13_1 >= arg_13_0.stopTime_ then
				if var_13_2 > 0 then
					arg_13_0.stateCon_:SetSelectedState("onlyShop")
				else
					arg_13_0.stateCon_:SetSelectedState("close")
				end
			elseif arg_13_0.isLock_ then
				arg_13_0.stateCon_:SetSelectedState("lock")
			else
				arg_13_0.stateCon_:SetSelectedState("unlock")
			end
		end, 1, -1)

		arg_13_0.timer_:Start()
	else
		arg_13_0.timeLable_.text = GetTips("TIME_OVER")
		arg_13_0.shopTimeLable_.text = GetTips("TIME_OVER")

		arg_13_0.stateCon_:SetSelectedState("close")
	end
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

function var_0_0.RefreshTask(arg_17_0)
	local var_17_0 = ActivityPt2Tools:GetTaskActivityID(arg_17_0.activityID_)

	arg_17_0.list_ = {}

	local var_17_1 = TaskTools:GetActivityTaskList(var_17_0) or {}

	local function var_17_2(arg_18_0, arg_18_1)
		local var_18_0 = AssignmentCfg[arg_18_0]
		local var_18_1 = AssignmentCfg[arg_18_1]

		if var_18_0.type ~= var_18_1.type then
			return var_18_0.type < var_18_1.type
		end

		return arg_18_0 < arg_18_1
	end

	local var_17_3 = {}
	local var_17_4 = {}
	local var_17_5 = {}

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		local var_17_6 = iter_17_1.id
		local var_17_7 = AssignmentCfg[var_17_6]

		if var_17_7.activity_id == var_17_0 then
			if iter_17_1.complete_flag >= 1 then
				table.insert(var_17_5, var_17_6)
			elseif iter_17_1.progress >= var_17_7.need then
				table.insert(var_17_3, var_17_6)
			else
				table.insert(var_17_4, var_17_6)
			end
		end
	end

	table.sort(var_17_3, var_17_2)
	table.sort(var_17_4, var_17_2)
	table.sort(var_17_5, var_17_2)
	table.insertto(arg_17_0.list_, var_17_3)
	table.insertto(arg_17_0.list_, var_17_4)
	table.insertto(arg_17_0.list_, var_17_5)
	arg_17_0.scrollHelper_:StartScroll(#arg_17_0.list_)

	if #var_17_3 > 0 then
		arg_17_0.clearCon_:SetSelectedState("true")
	else
		arg_17_0.clearCon_:SetSelectedState("false")
	end
end

function var_0_0.RefreshShop(arg_19_0)
	local var_19_0 = ActivityShopCfg[arg_19_0.activityID_].shop_id

	arg_19_0.shopName_.text = ShopListCfg[var_19_0].remark
end

function var_0_0.Show(arg_20_0, arg_20_1)
	var_0_0.super.Show(arg_20_0, arg_20_1)

	if arg_20_1 then
		arg_20_0:RefreshTask()
	end
end

function var_0_0.UpdateBar(arg_21_0)
	local var_21_0 = ActivityPt2Tools.GetChallengeCurrencyID(arg_21_0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_21_0
	})
	manager.windowBar:SetBarCanAdd(var_21_0, true)
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
	arg_22_0:RemoveAllEventListener()
	arg_22_0:StopTimer()
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	arg_23_0.scrollHelper_:Dispose()
	arg_23_0.super.Dispose(arg_23_0)
end

return var_0_0
