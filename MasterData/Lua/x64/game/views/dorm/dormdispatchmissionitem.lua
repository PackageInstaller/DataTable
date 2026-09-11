local DormDispatchMissionItem = class("DormDispatchMissionItem", ReduxView)

function DormDispatchMissionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormDispatchMissionItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormDispatchMissionItem:InitUI()
	self:BindCfgUI()

	self.timeController = ControllerUtil.GetController(self.transform_, "task")
	self.workController = ControllerUtil.GetController(self.transform_, "workbtn")
	self.refreshController = ControllerUtil.GetController(self.transform_, "refresh")
	self.coolController = ControllerUtil.GetController(self.transform_, "cooling")
	self.levelController = ControllerUtil.GetController(self.transform_, "level")
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
	self.roleuilistScroll_ = LuaList.New(handler(self, self.indexRecommendRoleItem), self.roleuilistUilist_, DormRecommendRoleItem)
	self.awarduilistScroll_ = LuaList.New(handler(self, self.indexAwardItem), self.awarduilistUilist_, CommonItemView)
end

function DormDispatchMissionItem:AddUIListener()
	self:AddBtnListener(self.dispatchbtnBtn_, nil, function()
		if #self.heroList == 0 then
			if self.confirmCallBack then
				self.confirmCallBack(self.ID, self.pos, self.timeLevel)
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_TAKS_CANCEL"),
				OkCallback = function()
					if self.cancelCallBack then
						self.cancelCallBack(self.ID, self.pos, self.timeLevel)
					end
				end,
				CancelCallback = function()
					return
				end
			})
		end
	end)
	self:AddBtnListener(self.refreshbtnBtn_, nil, function()
		if self.refreshTime > 0 then
			ShowTips(string.format(GetTips("CANTEEN_TASK_REFRESH_COOLDOWN"), manager.time:DescCDTime(manager.time:GetNextFreshTime() - manager.time:GetServerTime())))

			return
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_REFRESH_CONFIRM"),
				OkCallback = function()
					if self.refreshCallBack then
						self.refreshCallBack(self.pos)
					end
				end,
				CancelCallback = function()
					return
				end
			})
		end
	end)
	self:AddBtnListener(self.unLockBtn_, nil, function()
		if GameSetting.dorm_canteen_task_unlock.value[self.pos][2] ~= 0 then
			if IsConditionAchieved(GameSetting.dorm_canteen_task_unlock.value[self.pos][2]) then
				CanteenAction:UnLockEntrust(self.pos)
			else
				ShowTips("NO_REACH_UNLOCK")
			end
		else
			CanteenAction:UnLockEntrust(self.pos)
		end
	end)

	for iter_4_0 = 1, 3 do
		self:AddToggleListener(self["level_" .. iter_4_0 .. "Tgl_"], function(arg_12_0)
			if arg_12_0 then
				if self.heroList and #self.heroList > 0 then
					return
				end

				self:SetTimeLevel(iter_4_0)
			end
		end)
	end
end

function DormDispatchMissionItem:SetTimeLevel(arg_13_1)
	local var_13_1 = BackHomeCanteenTaskCfg[self.entrust.id]

	self.timeLevel = (arg_13_1 == nil or tostring(arg_13_1) == "userdata: NULL" or type(arg_13_1) ~= "number") and 1 or arg_13_1
	self["level_" .. self.timeLevel .. "Tgl_"].isOn = true

	self:RefreshRecommendAward(self.entrust.id, self.entrust.pos, self.timeLevel)

	self.tasktimeText_.text = DormTools:MinSwitchTime(var_13_1.time[self.timeLevel][1])

	CanteenEntrustData:SetTaskTimeLevel(self.pos, self.timeLevel)
end

function DormDispatchMissionItem:RefreshUI(arg_14_1)
	self.pos = arg_14_1.pos
	self.entrust = arg_14_1

	if manager.redPoint:getTipBoolean((string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_ENTRUST, self.pos))) then
		manager.redPoint:SetRedPointIndependent(self.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end

	if arg_14_1.id < 0 then
		local var_14_0
		local var_14_1
		local var_14_2

		if GameSetting.dorm_canteen_task_unlock.value[self.pos][2] ~= 0 then
			var_14_0, var_14_1, var_14_2 = IsConditionAchieved(GameSetting.dorm_canteen_task_unlock.value[self.pos][2])
		else
			var_14_0 = true
		end

		if var_14_0 then
			self.lockController:SetSelectedState("canUnlock")

			self.lockStateText_.text = GetTips("DORM_CANTEEN_TASK_CAN_UNLOCK")
		else
			self.lockController:SetSelectedState("lock")

			self.lockStateText_.text = GetTips("DORM_CANTEEN_TASK_LOCK")
			self.conditionText_.text = string.format(GetTips("DORM_CANTEEN_TASK_UNLOCK_TIPS"), var_14_1, var_14_2)
		end

		return
	end

	self.lockController:SetSelectedState("unlock")

	self.lockStateText_.text = GetTips("DORM_CANTEEN_TASK_LOCK")
	self.type = 1
	self.refreshTime = CanteenEntrustData:GetEntrustList()[self.pos].refresh_times

	local var_14_3 = BackHomeCanteenTaskCfg[arg_14_1.id]

	self.ID = arg_14_1.id
	self.tasknameText_.text = GetI18NText(var_14_3.name)
	self.characternumText_.text = var_14_3.need[2]
	self.destextText_.text = GetI18NText(var_14_3.desc)
	self.heroList = arg_14_1.hero_list

	for iter_14_0 = 1, 3 do
		self["timeText" .. iter_14_0].text = BackHomeCanteenTaskCfg[arg_14_1.id].time[iter_14_0][1] / 60
		self["timeTextH" .. iter_14_0].text = string.format("  (%s)", GetTips("HOUR"))
	end

	if #self.heroList > 0 then
		self.type = 2

		self.timeController:SetSelectedState("on")

		self.timeText_.text = CanteenEntrustData:GetEntrustLastTime(self.pos)
		self.statsDecText_.text = GetTips("CANTEEN_DISPATCHED_HERO")
		self.hastasknameText_.text = GetI18NText(var_14_3.name)

		self.workController:SetSelectedState("off")

		self.workStateText_.text = GetTips("BACKHOME_TASK_CANCEL")

		self:SetTimeLevel(arg_14_1.timeLevel)
	else
		self.statsDecText_.text = GetTips("CANREEN_RECOMEND_HERO")

		self.timeController:SetSelectedState("off")
		self.workController:SetSelectedState("on")

		self.workStateText_.text = GetTips("BACKHOME_TASK_START")
		self.timeLevel = self.timeLevel or CanteenEntrustData:GetTaskTimeLevel(self.pos)

		self:SetTimeLevel(self.timeLevel)
	end

	self.totalReText.text = "/" .. GameDisplayCfg.dorm_canteen_refresh_max.value[1]
	self.curReText.text = 1 - self.refreshTime

	if self.refreshTime > 0 then
		self.coolController:SetSelectedState("on")
	end

	self.levelController:SetSelectedState(var_14_3.task_level)
end

function DormDispatchMissionItem:RefreshTimeMessage()
	if self.type == 2 then
		self.timeText_.text = CanteenEntrustData:GetEntrustLastTime(self.pos)

		if CanteenEntrustData:GetEntrustLastTime(self.pos) == 0 then
			manager.notify:Invoke(CANTEEN_DISPATCH_TIME_OVER)
		end
	end
end

function DormDispatchMissionItem:RefreshRecommendAward(arg_16_1, arg_16_2, arg_16_3)
	if self.type == 1 then
		self.recommendRoleList_ = {}

		local var_16_0 = CanteenEntrustData:GetEntrustList()[arg_16_2]

		for iter_16_0 = 1, #var_16_0.tags do
			table.insert(self.recommendRoleList_, var_16_0.tags[iter_16_0])
		end

		self.roleuilistScroll_:StartScroll(#self.recommendRoleList_)
	elseif self.type == 2 then
		self.recommendRoleList_ = self.heroList

		self.roleuilistScroll_:StartScroll(#self.recommendRoleList_)
	end

	self.roleuilistUilist_:GetComponent("ScrollRectEx").horizontal = false
	self.award_list = {}

	for iter_16_1 = 1, #BackHomeCanteenTaskCfg[arg_16_1].reward_list do
		table.insert(self.award_list, {
			id = BackHomeCanteenTaskCfg[arg_16_1].reward_list[iter_16_1][1],
			number = math.floor(BackHomeCanteenTaskCfg[arg_16_1].reward_list[iter_16_1][2] * (BackHomeCanteenTaskCfg[arg_16_1].time[arg_16_3][2] / 100)),
			clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id
				})
			end
		})
	end

	if self.oldID ~= arg_16_1 or self.oldTimeLevel ~= arg_16_3 then
		self.awarduilistScroll_:StartScroll(#self.award_list)

		self.oldID = arg_16_1
		self.oldTimeLevel = arg_16_3
	end
end

function DormDispatchMissionItem:RegisterConfirmCallBack(arg_18_1)
	if arg_18_1 then
		self.confirmCallBack = arg_18_1
	end
end

function DormDispatchMissionItem:RegisterCancelCallBack(arg_19_1)
	if arg_19_1 then
		self.cancelCallBack = arg_19_1
	end
end

function DormDispatchMissionItem:RegisterRefreshCallBack(arg_20_1)
	if arg_20_1 then
		self.refreshCallBack = arg_20_1
	end
end

function DormDispatchMissionItem:indexRecommendRoleItem(arg_21_1, arg_21_2)
	arg_21_2:RefreshUI(self.recommendRoleList_[arg_21_1], self.type)
end

function DormDispatchMissionItem:indexAwardItem(arg_22_1, arg_22_2)
	arg_22_2:SetData(self.award_list[arg_22_1], self.type)
end

function DormDispatchMissionItem:Dispose()
	self:RemoveAllListeners()

	if self.roleuilistScroll_ then
		self.roleuilistScroll_:Dispose()
	end

	if self.awarduilistScroll_ then
		self.awarduilistScroll_:Dispose()
	end

	DormDispatchMissionItem.super.Dispose(self)
end

return DormDispatchMissionItem
