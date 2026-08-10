ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("DrawFeedbackView_2_0", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng1stUI/XH1stRaffleFeedbackUI/XH1stRaffleFeedbackUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.taskUpdateHandler_ = handler(arg_2_0, arg_2_0.TaskUpdate)
	arg_2_0.scrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.RefreshItem), arg_2_0.uiList_, DrawFeedbackItem)
	arg_2_0.receiveAllController_ = ControllerUtil.GetController(arg_2_0.transform_, "clear")
	arg_2_0.lockController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0:RefreshReceiveAllBtn()
	arg_3_0:AddShopTimer()
	arg_3_0:AddTaskTimer()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, arg_3_0.taskUpdateHandler_)
	manager.redPoint:bindUIandKey(arg_3_0.shopBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP))
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, arg_4_0.taskUpdateHandler_)
	manager.redPoint:unbindUIandKey(arg_4_0.shopBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP))
	arg_4_0:StopShopTimer()
	arg_4_0:StopTaskTimer()
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.taskUpdateHandler_ = nil

	arg_5_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.tipBtn_, nil, function()
		local var_7_0 = GetTips("DRAW_FEEDBACK_INFO")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "DRAW_FEEDBACK_INFO",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_7_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.allReceiveBtn_, nil, function()
		local var_8_0 = TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK)
		local var_8_1 = {}

		if #var_8_0 > 0 then
			for iter_8_0, iter_8_1 in ipairs(var_8_0) do
				table.insert(var_8_1, iter_8_1.id)
			end
		end

		TaskAction:SubmitTaskList(var_8_1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.shopBtn_, nil, function()
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP), 0)

		local var_9_0 = ActivityShopCfg[ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP]
		local var_9_1, var_9_2 = ShopTools.IsShopOpen(var_9_0.shop_id)

		if var_9_1 then
			JumpTools.GoToSystem("/shop", {
				shopId = var_9_0.shop_id,
				showShops = {
					var_9_0.shop_id
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_9_2 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_9_2 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function var_0_0.UpdateBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DRAW_FEEDBACK_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DRAW_FEEDBACK_COIN, true)
end

function var_0_0.Show(arg_12_0, arg_12_1)
	var_0_0.super.Show(arg_12_0, arg_12_1)

	if arg_12_1 then
		arg_12_0.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK))
	end
end

function var_0_0.TaskUpdate(arg_13_0)
	arg_13_0.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK))
	arg_13_0:RefreshReceiveAllBtn()
end

function var_0_0.RefreshItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK)[arg_14_1].id

	arg_14_2:SetData(var_14_0)
end

function var_0_0.RefreshReceiveAllBtn(arg_15_0)
	if #TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK) > 0 then
		arg_15_0.receiveAllController_:SetSelectedState("true")
	else
		arg_15_0.receiveAllController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshShopTime(arg_16_0)
	local var_16_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP)
	local var_16_1 = manager.time:GetServerTime()

	arg_16_0.shopTimeText_.text = manager.time:GetLostTimeStrWith2Unit(var_16_0.stopTime)

	if var_16_1 + 604800 >= var_16_0.stopTime then
		if arg_16_0.shopTimeGo_.activeSelf == false then
			SetActive(arg_16_0.shopTimeGo_, true)
		end
	elseif arg_16_0.shopTimeGo_.activeSelf == true then
		SetActive(arg_16_0.shopTimeGo_, false)
	end
end

function var_0_0.AddShopTimer(arg_17_0)
	arg_17_0:StopShopTimer()
	arg_17_0:RefreshShopTime()

	arg_17_0.shopTimer_ = Timer.New(function()
		arg_17_0:RefreshShopTime()
	end, 1, -1)

	arg_17_0.shopTimer_:Start()
end

function var_0_0.StopShopTimer(arg_19_0)
	if arg_19_0.shopTimer_ then
		arg_19_0.shopTimer_:Stop()

		arg_19_0.shopTimer_ = nil
	end
end

function var_0_0.RefreshTaskPanel(arg_20_0)
	local var_20_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK)
	local var_20_1 = manager.time:GetServerTime()

	if var_20_1 > var_20_0.stopTime then
		arg_20_0.lockController_:SetSelectedState("onlyShop")
	elseif var_20_1 < var_20_0.startTime then
		arg_20_0.lockController_:SetSelectedState("lock")
	else
		arg_20_0.lockController_:SetSelectedState("unlock")
	end
end

function var_0_0.AddTaskTimer(arg_21_0)
	arg_21_0:StopTaskTimer()
	arg_21_0:RefreshTaskPanel()

	arg_21_0.taskTimer_ = Timer.New(function()
		arg_21_0:RefreshTaskPanel()
	end, 1, -1)

	arg_21_0.taskTimer_:Start()
end

function var_0_0.StopTaskTimer(arg_23_0)
	if arg_23_0.taskTimer_ then
		arg_23_0.taskTimer_:Stop()

		arg_23_0.taskTimer_ = nil
	end
end

return var_0_0
