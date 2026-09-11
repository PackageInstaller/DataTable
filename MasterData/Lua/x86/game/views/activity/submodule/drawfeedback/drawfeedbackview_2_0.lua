ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local DrawFeedbackView_2_0 = class("DrawFeedbackView_2_0", ActivityMainBasePanel)

function DrawFeedbackView_2_0:GetUIName()
	return "UI/VersionUI/XuHeng1stUI/XH1stRaffleFeedbackUI/XH1stRaffleFeedbackUI"
end

function DrawFeedbackView_2_0:Init()
	DrawFeedbackView_2_0.super.Init(self)

	self.taskUpdateHandler_ = handler(self, self.TaskUpdate)
	self.scrollHelper_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, DrawFeedbackItem)
	self.receiveAllController_ = ControllerUtil.GetController(self.transform_, "clear")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "state")
end

function DrawFeedbackView_2_0:OnEnter()
	DrawFeedbackView_2_0.super.OnEnter(self)
	self:RefreshReceiveAllBtn()
	self:AddShopTimer()
	self:AddTaskTimer()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	manager.redPoint:bindUIandKey(self.shopBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP))
end

function DrawFeedbackView_2_0:OnExit()
	DrawFeedbackView_2_0.super.OnExit(self)
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	manager.redPoint:unbindUIandKey(self.shopBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP))
	self:StopShopTimer()
	self:StopTaskTimer()
end

function DrawFeedbackView_2_0:Dispose()
	self.taskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()
	DrawFeedbackView_2_0.super.Dispose(self)
end

function DrawFeedbackView_2_0:AddListeners()
	self:AddBtnListener(self.tipBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "DRAW_FEEDBACK_INFO",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("DRAW_FEEDBACK_INFO")
		})
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		local var_8_0 = TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK)
		local var_8_1 = {}

		if #var_8_0 > 0 then
			for iter_8_0, iter_8_1 in ipairs(var_8_0) do
				table.insert(var_8_1, iter_8_1.id)
			end
		end

		TaskAction:SubmitTaskList(var_8_1)
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP), 0)

		local var_9_0, var_9_1 = ShopTools.IsShopOpen(ActivityShopCfg[ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP].shop_id)

		if var_9_0 then
			JumpTools.GoToSystem("/shop", {
				shopId = ActivityShopCfg[ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP].shop_id,
				showShops = {
					ActivityShopCfg[ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP].shop_id
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_9_1 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_9_1 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function DrawFeedbackView_2_0:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DRAW_FEEDBACK_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DRAW_FEEDBACK_COIN, true)
end

function DrawFeedbackView_2_0:Show(arg_12_1)
	DrawFeedbackView_2_0.super.Show(self, arg_12_1)

	if arg_12_1 then
		self.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK))
	end
end

function DrawFeedbackView_2_0:TaskUpdate()
	self.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK))
	self:RefreshReceiveAllBtn()
end

function DrawFeedbackView_2_0:RefreshItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK)[arg_14_1].id)
end

function DrawFeedbackView_2_0:RefreshReceiveAllBtn()
	if #TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK) > 0 then
		self.receiveAllController_:SetSelectedState("true")
	else
		self.receiveAllController_:SetSelectedState("false")
	end
end

function DrawFeedbackView_2_0:RefreshShopTime()
	local var_16_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_SHOP)

	self.shopTimeText_.text = manager.time:GetLostTimeStrWith2Unit(var_16_0.stopTime)

	if manager.time:GetServerTime() + 604800 >= var_16_0.stopTime then
		if self.shopTimeGo_.activeSelf == false then
			SetActive(self.shopTimeGo_, true)
		end
	elseif self.shopTimeGo_.activeSelf == true then
		SetActive(self.shopTimeGo_, false)
	end
end

function DrawFeedbackView_2_0:AddShopTimer()
	self:StopShopTimer()
	self:RefreshShopTime()

	self.shopTimer_ = Timer.New(function()
		self:RefreshShopTime()
	end, 1, -1)

	self.shopTimer_:Start()
end

function DrawFeedbackView_2_0:StopShopTimer()
	if self.shopTimer_ then
		self.shopTimer_:Stop()

		self.shopTimer_ = nil
	end
end

function DrawFeedbackView_2_0:RefreshTaskPanel()
	local var_20_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_DRAW_FEEDBACK_TASK)
	local var_20_1 = manager.time:GetServerTime()

	if var_20_1 > var_20_0.stopTime then
		self.lockController_:SetSelectedState("onlyShop")
	elseif var_20_1 < var_20_0.startTime then
		self.lockController_:SetSelectedState("lock")
	else
		self.lockController_:SetSelectedState("unlock")
	end
end

function DrawFeedbackView_2_0:AddTaskTimer()
	self:StopTaskTimer()
	self:RefreshTaskPanel()

	self.taskTimer_ = Timer.New(function()
		self:RefreshTaskPanel()
	end, 1, -1)

	self.taskTimer_:Start()
end

function DrawFeedbackView_2_0:StopTaskTimer()
	if self.taskTimer_ then
		self.taskTimer_:Stop()

		self.taskTimer_ = nil
	end
end

return DrawFeedbackView_2_0
