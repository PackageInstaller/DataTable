local var_0_0 = class("XH1stSealHomeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("UI/VersionUI/XuHeng1stUI/XH1stSealUI/XH1stSealHomeUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.oneclickController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "oneclick")
	arg_3_0.endController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "end")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uilistGo_, XH1stSeamItemView)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.assignmentIdList_[arg_4_1])
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/xH1stSealGame", {
			activityId = ActivityConst.ACTIVITY_2_0_SEAL
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		local var_7_0 = TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_SEAL)
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
			key = "XH1ST_SEAL_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("XH1ST_SEAL_DESC")
		})
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		arg_9_0:UpdateList()
	end)
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.OnBehind(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_13_0)
	local var_13_0 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_13_0[1]
	})
	manager.windowBar:SetBarCanAdd(var_13_0[1], true)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddEventListeners()

	if arg_14_0:IsTimeOver() then
		arg_14_0.uiList_:StartScroll(0)
		arg_14_0.oneclickController_:SetSelectedState("no")
		arg_14_0.endController_:SetSelectedState("on")
	else
		arg_14_0:UpdateList()
		arg_14_0:StartTimer()
		arg_14_0:UpdateTimer()
	end

	arg_14_0.contentText_.text = GetTips("XH1ST_SEAL_CONTENT")
end

function var_0_0.StartTimer(arg_15_0)
	if arg_15_0.timer_ == nil then
		arg_15_0.timer_ = Timer.New(function()
			arg_15_0:UpdateTimer()
		end, 1, -1)
	end

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_18_0)
	local var_18_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime

	arg_18_0.timeText_.text = manager.time:GetLostTimeStr2(var_18_0)
end

function var_0_0.IsTimeOver(arg_19_0)
	if ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime <= manager.time:GetServerTime() then
		return true
	end

	return false
end

function var_0_0.UpdateList(arg_20_0)
	arg_20_0.assignmentIdList_ = {}

	table.insertto(arg_20_0.assignmentIdList_, AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_SEAL], 1)
	table.sort(arg_20_0.assignmentIdList_, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_20_0:GetTaskStatus(arg_21_0)
		local var_21_1 = arg_20_0:GetTaskStatus(arg_21_1)

		if var_21_0 ~= var_21_1 then
			return var_21_0 < var_21_1
		end

		local var_21_2 = AssignmentCfg[arg_21_0]
		local var_21_3 = AssignmentCfg[arg_21_1]

		if var_21_2.type ~= var_21_3.type then
			return var_21_2.type < var_21_3.type
		end

		return var_21_2.id < var_21_3.id
	end)
	arg_20_0.uiList_:StartScroll(#arg_20_0.assignmentIdList_)

	if #TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_SEAL) > 0 then
		arg_20_0.oneclickController_:SetSelectedState("ok")
	else
		arg_20_0.oneclickController_:SetSelectedState("no")
	end
end

function var_0_0.GetTaskStatus(arg_22_0, arg_22_1)
	local var_22_0 = AssignmentCfg[arg_22_1]
	local var_22_1 = TaskData2:GetTask(arg_22_1).progress

	if TaskData2:GetTaskComplete(arg_22_1) then
		return 3
	elseif var_22_1 >= var_22_0.need then
		return 1
	else
		return 2
	end
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	arg_23_0:StopTimer()
end

function var_0_0.Show(arg_24_0, arg_24_1)
	SetActive(arg_24_0.gameObject_, arg_24_1)

	if arg_24_1 then
		arg_24_0:UpdateList()
	end
end

function var_0_0.OnMainHomeViewTop(arg_25_0)
	return
end

function var_0_0.Dispose(arg_26_0)
	if arg_26_0.uiList_ then
		arg_26_0.uiList_:Dispose()

		arg_26_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
