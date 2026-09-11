ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local XH3rdWaterMainView = class("XH3rdWaterMainView", ActivityMainBasePanel)
local var_0_1 = 44

function XH3rdWaterMainView:Ctor(arg_1_1, arg_1_2)
	self.activityID_ = arg_1_2
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWaterparkUI"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function XH3rdWaterMainView:Init()
	self.taskActivityId_ = self:GetTaskActivityId()

	self:InitUI()
	self:AddUIListener()
end

function XH3rdWaterMainView:InitUI()
	self:BindCfgUI()

	self.oneclickController_ = ControllerUtil.GetController(self.gameObject_.transform, "oneclick")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistUilist_, XH3rdWaterMainItemView)
end

function XH3rdWaterMainView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.assignmentIdList_[arg_4_1], self:GetTaskActivityId())
end

function XH3rdWaterMainView:AddUIListener()
	self:AddBtnListener(self.btnstartBtn_, nil, function()
		JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_7_0 = TaskTools:GetCanGetActivityTaskList(self.taskActivityId_)
		local var_7_1 = {}

		if #var_7_0 > 0 then
			for iter_7_0, iter_7_1 in ipairs(var_7_0) do
				table.insert(var_7_1, iter_7_1.id)
			end
		end

		TaskAction:SubmitTaskList(var_7_1)
	end)
	self:AddBtnListener(self.tipBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_WATER_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_WATER_DESC")
		})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		JumpTools.GoToSystem("/activityShop", {
			shopId = var_0_1,
			showShops = {
				var_0_1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.reviewBtn_, nil, function()
		JumpTools.OpenPageByJump("/xH3rdWaterReview", {
			activityID = self.activityID_
		})
	end)
end

function XH3rdWaterMainView:AddEventListeners()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		self:UpdateList()
	end)
end

function XH3rdWaterMainView:OnTop()
	self:UpdateBar()
end

function XH3rdWaterMainView:OnBehind()
	manager.windowBar:HideBar()
end

function XH3rdWaterMainView:UpdateBar()
	if ActivityWaterData:GetCurrentSchedule(self.activityID_) then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			ShopListCfg[var_0_1].cost_id[1]
		})
		manager.windowBar:SetBarCanAdd(ShopListCfg[var_0_1].cost_id[1], true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function XH3rdWaterMainView:OnEnter()
	ActivityWaterAction.ReadActivityOpen()
	self:AddEventListeners()
	self:UpdateList()
	self:StartTimer()
	self:UpdateTimer()
	manager.redPoint:bindUIandKey(self.btnstartBtn_.transform, RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
	manager.redPoint:bindUIandKey(self.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)

	local var_16_0 = manager.redPoint:getTipValue(RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
end

function XH3rdWaterMainView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function XH3rdWaterMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function XH3rdWaterMainView:UpdateTimer()
	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(self.activityID_).stopTime)

	if ActivityData:GetActivityIsOpen(self:GetTaskActivityId()) then
		if ActivityWaterData:IsAllScheduleOver(self.activityID_) then
			self.statusController_:SetSelectedState("scheduleOver")
			SetActive(self.btnstartBtn_.gameObject, false)
		else
			self.statusController_:SetSelectedState("open")
		end
	else
		self.statusController_:SetSelectedState("taskOver")
		SetActive(self.btnstartBtn_.gameObject, false)
	end

	if ShopListCfg[var_0_1] then
		local var_20_0 = ActivityData:GetActivityData(ShopListCfg[var_0_1].activity_id).stopTime

		self.shopTimeText_.text = manager.time:GetLostTimeStrWith2Unit(var_20_0)

		if var_20_0 < manager.time:GetServerTime() then
			SetActive(self.shopBtn_.gameObject, false)
		else
			SetActive(self.shopBtn_.gameObject, true)
		end
	end
end

function XH3rdWaterMainView:IsTimeOver()
	if ActivityData:GetActivityData(self.activityID_).stopTime <= manager.time:GetServerTime() then
		return true
	end

	return false
end

function XH3rdWaterMainView:UpdateList()
	if self:IsTimeOver() or not ActivityData:GetActivityIsOpen(self:GetTaskActivityId()) then
		self.uiList_:StartScroll(0)
		self.oneclickController_:SetSelectedState("no")

		return
	end

	self.assignmentIdList_ = {}

	table.insertto(self.assignmentIdList_, AssignmentCfg.get_id_list_by_activity_id[self.taskActivityId_], 1)
	table.sort(self.assignmentIdList_, function(arg_23_0, arg_23_1)
		local var_23_0 = self:GetTaskStatus(arg_23_0)
		local var_23_1 = self:GetTaskStatus(arg_23_1)

		if var_23_0 ~= var_23_1 then
			return var_23_0 < var_23_1
		end

		local var_23_2 = AssignmentCfg[arg_23_0]
		local var_23_3 = AssignmentCfg[arg_23_1]

		if AssignmentCfg[arg_23_0].type ~= AssignmentCfg[arg_23_1].type then
			return var_23_2.type < var_23_3.type
		end

		return var_23_2.id < var_23_3.id
	end)
	self.uiList_:StartScroll(#self.assignmentIdList_)

	if #TaskTools:GetCanGetActivityTaskList(self.taskActivityId_) > 0 then
		self.oneclickController_:SetSelectedState("on")
	else
		self.oneclickController_:SetSelectedState("off")
	end
end

function XH3rdWaterMainView:GetTaskStatus(arg_24_1)
	local var_24_0 = TaskData2:GetTask(arg_24_1)

	if not var_24_0 then
		return 0
	end

	local var_24_1 = var_24_0.progress

	if var_24_0 ~= nil and TaskData2:GetTaskComplete(arg_24_1) then
		return 3
	elseif var_24_1 >= AssignmentCfg[arg_24_1].need then
		return 1
	else
		return 2
	end
end

function XH3rdWaterMainView:GetTaskActivityId()
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
		if ActivityCfg[iter_25_1].activity_template == ActivityTemplateConst.TASK then
			var_25_0 = iter_25_1

			break
		end
	end

	return var_25_0
end

function XH3rdWaterMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.btnstartBtn_.transform, RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
	manager.redPoint:unbindUIandKey(self.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function XH3rdWaterMainView:Show(arg_27_1)
	SetActive(self.gameObject_, arg_27_1)

	if arg_27_1 then
		self:UpdateList()
	end
end

function XH3rdWaterMainView:OnMainHomeViewTop()
	return
end

function XH3rdWaterMainView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	XH3rdWaterMainView.super.Dispose(self)
end

return XH3rdWaterMainView
