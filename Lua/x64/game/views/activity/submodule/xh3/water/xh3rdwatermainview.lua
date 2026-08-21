ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("XH3rdWaterMainView", ActivityMainBasePanel)
local var_0_1 = 44

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityID_ = arg_1_2

	local var_1_0 = Asset.Load("UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWaterparkUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.taskActivityId_ = arg_2_0:GetTaskActivityId()

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.oneclickController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "oneclick")
	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uilistUilist_, XH3rdWaterMainItemView)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.assignmentIdList_[arg_4_1], arg_4_0:GetTaskActivityId())
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnstartBtn_, nil, function()
		JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		local var_7_0 = TaskTools:GetCanGetActivityTaskList(arg_5_0.taskActivityId_)
		local var_7_1 = {}

		if #var_7_0 > 0 then
			for iter_7_0, iter_7_1 in ipairs(var_7_0) do
				table.insert(var_7_1, iter_7_1.id)
			end
		end

		TaskAction:SubmitTaskList(var_7_1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_WATER_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_WATER_DESC")
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/activityShop", {
			shopId = var_0_1,
			showShops = {
				var_0_1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.reviewBtn_, nil, function()
		JumpTools.OpenPageByJump("/xH3rdWaterReview", {
			activityID = arg_5_0.activityID_
		})
	end)
end

function var_0_0.AddEventListeners(arg_11_0)
	arg_11_0:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		arg_11_0:UpdateList()
	end)
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0:UpdateBar()
end

function var_0_0.OnBehind(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_15_0)
	if ActivityWaterData:GetCurrentSchedule(arg_15_0.activityID_) then
		local var_15_0 = ShopListCfg[var_0_1].cost_id[1]

		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			var_15_0
		})
		manager.windowBar:SetBarCanAdd(var_15_0, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function var_0_0.OnEnter(arg_16_0)
	ActivityWaterAction.ReadActivityOpen()
	arg_16_0:AddEventListeners()
	arg_16_0:UpdateList()
	arg_16_0:StartTimer()
	arg_16_0:UpdateTimer()
	manager.redPoint:bindUIandKey(arg_16_0.btnstartBtn_.transform, RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
	manager.redPoint:bindUIandKey(arg_16_0.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)

	local var_16_0 = manager.redPoint:getTipValue(RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
end

function var_0_0.StartTimer(arg_17_0)
	if arg_17_0.timer_ == nil then
		arg_17_0.timer_ = Timer.New(function()
			arg_17_0:UpdateTimer()
		end, 1, -1)
	end

	arg_17_0.timer_:Start()
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_20_0)
	local var_20_0 = ActivityData:GetActivityData(arg_20_0.activityID_).stopTime

	arg_20_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_20_0)

	if ActivityData:GetActivityIsOpen(arg_20_0:GetTaskActivityId()) then
		if ActivityWaterData:IsAllScheduleOver(arg_20_0.activityID_) then
			arg_20_0.statusController_:SetSelectedState("scheduleOver")
			SetActive(arg_20_0.btnstartBtn_.gameObject, false)
		else
			arg_20_0.statusController_:SetSelectedState("open")
		end
	else
		arg_20_0.statusController_:SetSelectedState("taskOver")
		SetActive(arg_20_0.btnstartBtn_.gameObject, false)
	end

	local var_20_1 = ShopListCfg[var_0_1]

	if var_20_1 then
		local var_20_2 = var_20_1.activity_id
		local var_20_3 = ActivityData:GetActivityData(var_20_2).stopTime

		arg_20_0.shopTimeText_.text = manager.time:GetLostTimeStrWith2Unit(var_20_3)

		if var_20_3 < manager.time:GetServerTime() then
			SetActive(arg_20_0.shopBtn_.gameObject, false)
		else
			SetActive(arg_20_0.shopBtn_.gameObject, true)
		end
	end
end

function var_0_0.IsTimeOver(arg_21_0)
	if ActivityData:GetActivityData(arg_21_0.activityID_).stopTime <= manager.time:GetServerTime() then
		return true
	end

	return false
end

function var_0_0.UpdateList(arg_22_0)
	if arg_22_0:IsTimeOver() or not ActivityData:GetActivityIsOpen(arg_22_0:GetTaskActivityId()) then
		arg_22_0.uiList_:StartScroll(0)
		arg_22_0.oneclickController_:SetSelectedState("no")

		return
	end

	arg_22_0.assignmentIdList_ = {}

	table.insertto(arg_22_0.assignmentIdList_, AssignmentCfg.get_id_list_by_activity_id[arg_22_0.taskActivityId_], 1)
	table.sort(arg_22_0.assignmentIdList_, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_22_0:GetTaskStatus(arg_23_0)
		local var_23_1 = arg_22_0:GetTaskStatus(arg_23_1)

		if var_23_0 ~= var_23_1 then
			return var_23_0 < var_23_1
		end

		local var_23_2 = AssignmentCfg[arg_23_0]
		local var_23_3 = AssignmentCfg[arg_23_1]

		if var_23_2.type ~= var_23_3.type then
			return var_23_2.type < var_23_3.type
		end

		return var_23_2.id < var_23_3.id
	end)
	arg_22_0.uiList_:StartScroll(#arg_22_0.assignmentIdList_)

	if #TaskTools:GetCanGetActivityTaskList(arg_22_0.taskActivityId_) > 0 then
		arg_22_0.oneclickController_:SetSelectedState("on")
	else
		arg_22_0.oneclickController_:SetSelectedState("off")
	end
end

function var_0_0.GetTaskStatus(arg_24_0, arg_24_1)
	local var_24_0 = AssignmentCfg[arg_24_1]
	local var_24_1 = TaskData2:GetTask(arg_24_1)

	if not var_24_1 then
		return 0
	end

	local var_24_2 = var_24_1.progress

	if var_24_1 ~= nil and TaskData2:GetTaskComplete(arg_24_1) then
		return 3
	elseif var_24_2 >= var_24_0.need then
		return 1
	else
		return 2
	end
end

function var_0_0.GetTaskActivityId(arg_25_0)
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs(ActivityCfg[arg_25_0.activityID_].sub_activity_list) do
		if ActivityCfg[iter_25_1].activity_template == ActivityTemplateConst.TASK then
			var_25_0 = iter_25_1

			break
		end
	end

	return var_25_0
end

function var_0_0.OnExit(arg_26_0)
	manager.redPoint:unbindUIandKey(arg_26_0.btnstartBtn_.transform, RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
	manager.redPoint:unbindUIandKey(arg_26_0.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)
	arg_26_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	arg_26_0:StopTimer()
end

function var_0_0.Show(arg_27_0, arg_27_1)
	SetActive(arg_27_0.gameObject_, arg_27_1)

	if arg_27_1 then
		arg_27_0:UpdateList()
	end
end

function var_0_0.OnMainHomeViewTop(arg_28_0)
	return
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.uiList_ then
		arg_29_0.uiList_:Dispose()

		arg_29_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
