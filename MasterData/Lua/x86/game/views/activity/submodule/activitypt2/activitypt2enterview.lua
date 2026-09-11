ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityPt2EnterView = class("ActivityPt2EnterView", ActivityMainBasePanel)

function ActivityPt2EnterView:GetUIName()
	return ActivityPt2Tools.GetEnterUIName(self.activityID_)
end

function ActivityPt2EnterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPt2EnterView:InitUI()
	self:BindCfgUI()
	self:RefreshShop()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.clearCon_ = ControllerUtil.GetController(self.transform_, "clear")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityPt2TaskItem)
end

function ActivityPt2EnterView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:Refresh(self.list_[arg_4_1], self.activityID_)
end

function ActivityPt2EnterView:AddUIListeners()
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityShopCfg[self.activityID_].activity_theme]) do
			local var_6_1 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[iter_6_1].shop_id].activity_id)

			if var_6_1 and var_6_1:IsActivitying() then
				table.insert(var_6_0, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_2, var_6_3 = ShopTools.IsShopOpen(ActivityShopCfg[self.activityID_].shop_id)

		if var_6_2 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = ActivityShopCfg[self.activityID_].shop_id,
				showShops = var_6_0
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityPt2", {
			mainActivityId = self.activityID_
		})
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		local var_8_0 = {}
		local var_8_1 = ActivityPt2Tools:GetTaskActivityID(self.activityID_)

		for iter_8_0, iter_8_1 in ipairs(self.list_) do
			local var_8_2 = TaskData2:GetTask(iter_8_1)

			if var_8_2.complete_flag < 1 and var_8_2.progress >= AssignmentCfg[iter_8_1].need then
				table.insert(var_8_0, iter_8_1)
			end
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
	self:AddBtnListener(self.tipBtn_, nil, function()
		local var_9_0 = ActivityPt2Tools.GetHelpKey(self.activityID_)

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

function ActivityPt2EnterView:OnEnter()
	self:RefreshUI()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshTask))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. self.activityID_, 0)
	saveData(RedPointConst.ACTIVITY_PT_2_OPEN, tostring(self.activityID_), true)
end

function ActivityPt2EnterView:RefreshUI()
	self:RefreshActivityData()
	self:RefreshTime()
	self:RefreshTask()
end

function ActivityPt2EnterView:RefreshActivityData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.lock_.text = type(ActivityCfg[self.activityID_].unlock_condition) ~= "table" and "" or string.format(GetTips("ACTIVITY_XUHENG_PT_LOCK"), ChapterCfg[ActivityCfg[self.activityID_].unlock_condition[2][1]].subhead)
	self.isLock_ = not ActivityTools.IsUnlockActivity(self.activityID_)
	self.challengeCurrencyID_ = ActivityPt2Tools.GetChallengeCurrencyID(self.activityID_)
end

function ActivityPt2EnterView:RefreshTime()
	local var_13_0
	local var_13_1 = manager.time:GetServerTime()
	local var_13_2
	local var_13_3 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[self.activityID_].shop_id].activity_id).stopTime

	self:StopTimer()

	if var_13_1 < self.startTime_ then
		self.stateCon_:SetSelectedState("close")

		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_13_0 = self.startTime_ - manager.time:GetServerTime()

			if var_13_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_13_1 < self.stopTime_ or var_13_1 < var_13_3 then
		self.timeLable_.text = var_13_1 < self.stopTime_ and manager.time:GetLostTimeStrWith2Unit(self.stopTime_) or GetTips("TIME_OVER")
		var_13_2 = var_13_3 - var_13_1

		if var_13_3 - var_13_1 < GameSetting.time_remaining_show.value[1] * 86400 then
			self.shopTimeLable_.text = manager.time:GetLostTimeStrWith2Unit(var_13_3)

			SetActive(self.shopTimeGo_, true)
		else
			SetActive(self.shopTimeGo_, false)
		end

		if var_13_1 >= self.stopTime_ then
			if var_13_2 > 0 then
				self.stateCon_:SetSelectedState("onlyShop")
			else
				self.stateCon_:SetSelectedState("close")
			end
		elseif self.isLock_ then
			self.stateCon_:SetSelectedState("lock")
		else
			self.stateCon_:SetSelectedState("unlock")
		end

		self.timer_ = Timer.New(function()
			var_13_1 = manager.time:GetServerTime()
			var_13_0 = self.startTime_ - var_13_1
			var_13_2 = var_13_3 - var_13_1

			if var_13_0 <= 0 and var_13_2 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeLable_.text = var_13_1 < self.stopTime_ and manager.time:GetLostTimeStrWith2Unit(self.stopTime_) or GetTips("TIME_OVER")
			var_13_2 = var_13_3 - var_13_1

			if var_13_2 < GameSetting.time_remaining_show.value[1] * 86400 then
				self.shopTimeLable_.text = manager.time:GetLostTimeStrWith2Unit(var_13_3)

				SetActive(self.shopTimeGo_, true)
			else
				SetActive(self.shopTimeGo_, false)
			end

			if var_13_1 >= self.stopTime_ then
				if var_13_2 > 0 then
					self.stateCon_:SetSelectedState("onlyShop")
				else
					self.stateCon_:SetSelectedState("close")
				end
			elseif self.isLock_ then
				self.stateCon_:SetSelectedState("lock")
			else
				self.stateCon_:SetSelectedState("unlock")
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLable_.text = GetTips("TIME_OVER")
		self.shopTimeLable_.text = GetTips("TIME_OVER")

		self.stateCon_:SetSelectedState("close")
	end
end

function ActivityPt2EnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPt2EnterView:RefreshTask()
	local var_17_0 = ActivityPt2Tools:GetTaskActivityID(self.activityID_)

	self.list_ = {}

	local function var_17_1(arg_18_0, arg_18_1)
		if AssignmentCfg[arg_18_0].type ~= AssignmentCfg[arg_18_1].type then
			return AssignmentCfg[arg_18_0].type < AssignmentCfg[arg_18_1].type
		end

		return arg_18_0 < arg_18_1
	end

	local var_17_2 = {}
	local var_17_3 = {}
	local var_17_4 = {}

	for iter_17_0, iter_17_1 in pairs(TaskTools:GetActivityTaskList(var_17_0) or {}) do
		if AssignmentCfg[iter_17_1.id].activity_id == var_17_0 then
			if iter_17_1.complete_flag >= 1 then
				table.insert(var_17_4, iter_17_1.id)
			elseif iter_17_1.progress >= AssignmentCfg[iter_17_1.id].need then
				table.insert(var_17_2, iter_17_1.id)
			else
				table.insert(var_17_3, iter_17_1.id)
			end
		end
	end

	table.sort(var_17_2, var_17_1)
	table.sort(var_17_3, var_17_1)
	table.sort(var_17_4, var_17_1)
	table.insertto(self.list_, var_17_2)
	table.insertto(self.list_, var_17_3)
	table.insertto(self.list_, var_17_4)
	self.scrollHelper_:StartScroll(#self.list_)

	if #var_17_2 > 0 then
		self.clearCon_:SetSelectedState("true")
	else
		self.clearCon_:SetSelectedState("false")
	end
end

function ActivityPt2EnterView:RefreshShop()
	self.shopName_.text = ShopListCfg[ActivityShopCfg[self.activityID_].shop_id].remark
end

function ActivityPt2EnterView:Show(arg_20_1)
	ActivityPt2EnterView.super.Show(self, arg_20_1)

	if arg_20_1 then
		self:RefreshTask()
	end
end

function ActivityPt2EnterView:UpdateBar()
	local var_21_0 = ActivityPt2Tools.GetChallengeCurrencyID(self.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_21_0
	})
	manager.windowBar:SetBarCanAdd(var_21_0, true)
end

function ActivityPt2EnterView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:StopTimer()
end

function ActivityPt2EnterView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityPt2EnterView
