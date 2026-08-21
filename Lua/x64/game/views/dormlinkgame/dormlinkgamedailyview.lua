local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("DormLinkGameDailyView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return DormLinkGameTools.GetMainUIName(arg_1_0.activityID_)
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.openController = arg_3_0.controllers_:GetController("open")
	arg_3_0.taskList = CommonActivityTaskListModule.New(arg_3_0.questListGo_)
end

function var_0_1.indexDailyItemList(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(arg_4_0.list_[arg_4_1], arg_4_0.activityID_)
end

function var_0_1.AddListeners(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.goBtn_, nil, function()
		if arg_5_0.isAdvanceActivity_ then
			return
		end

		JumpTools.OpenPageByJump("/dormLinkGameLevelView", {
			activityID_ = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.tipBtn_, nil, DormLinkGameTools.OpenGameTips)
end

function var_0_1.HideRedPoint(arg_7_0)
	return
end

function var_0_1.OnEnter(arg_8_0)
	var_0_1.super.OnEnter(arg_8_0)
	arg_8_0:RefreshView()

	if not arg_8_0.isAdvanceActivity_ then
		arg_8_0:RegisterEvents()
		manager.redPoint:bindUIandKey(arg_8_0.goBtn_.transform, DormLinkGameData:RedPointKey(DormLinkGameData.LIANLIANKAN_IN_GAME))
	end
end

function var_0_1.UpdateBar(arg_9_0)
	local var_9_0 = DormLinkGameTools:GetCurrencyID(arg_9_0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_9_0
	})
	manager.windowBar:SetBarCanClick(var_9_0, true)
end

function var_0_1.RegisterEvents(arg_10_0)
	arg_10_0:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		arg_10_0:RefreshTask()
	end)
end

function var_0_1.RefreshView(arg_12_0)
	arg_12_0:RefreshTask()

	arg_12_0.uiCharacterImage_.sprite = getSpriteWithoutAtlas(DormLinkGameTools.GetVersionCharaImgPath(arg_12_0.activityID_))
end

function var_0_1.RefreshAcvanceStatus(arg_13_0, arg_13_1)
	if arg_13_0.isAdvanceActivity_ then
		arg_13_1 = false
	end

	arg_13_0.openController:SetSelectedState(arg_13_1 and "true" or "false")
end

function var_0_1.RefreshTask(arg_14_0)
	if arg_14_0.isAdvanceActivity_ then
		return
	end

	local var_14_0 = DormLinkGameTools:GetTaskActivityID(arg_14_0.activityID_)

	arg_14_0.taskList:RenderView(var_14_0)
end

local function var_0_2(arg_15_0)
	local var_15_0
	local var_15_1 = manager.time:GetServerTime()
	local var_15_2 = ActivityData:GetActivityData(arg_15_0)
	local var_15_3 = var_15_2.startTime
	local var_15_4 = var_15_2.stopTime

	if var_15_1 < var_15_3 then
		return GetTips("SOLO_NOT_OPEN")
	elseif var_15_4 < var_15_1 then
		return GetTips("TIME_OVER")
	else
		return manager.time:GetLostTimeStrWith2Unit(var_15_4), true
	end
end

function var_0_1.RefreshTimeText(arg_16_0)
	var_0_1.super.RefreshTimeText(arg_16_0)
end

function var_0_1.OnExit(arg_17_0)
	if not arg_17_0.isAdvanceActivity_ then
		manager.redPoint:unbindUIandKey(arg_17_0.goBtn_.transform, DormLinkGameData:RedPointKey(DormLinkGameData.LIANLIANKAN_IN_GAME))
	end

	arg_17_0:RemoveAllEventListener()
	var_0_1.super.OnExit(arg_17_0)
end

function var_0_1.Dispose(arg_18_0)
	if arg_18_0.scrollHelper_ then
		arg_18_0.scrollHelper_:Dispose()

		arg_18_0.scrollHelper_ = nil
	end

	arg_18_0.taskList:Dispose()
	var_0_1.super.Dispose(arg_18_0)
end

return var_0_1
