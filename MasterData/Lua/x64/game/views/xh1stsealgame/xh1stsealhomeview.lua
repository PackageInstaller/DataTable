local XH1stSealHomeView = class("XH1stSealHomeView", ReduxView)

function XH1stSealHomeView:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng1stUI/XH1stSealUI/XH1stSealHomeUI"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function XH1stSealHomeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH1stSealHomeView:InitUI()
	self:BindCfgUI()

	self.oneclickController_ = ControllerUtil.GetController(self.gameObject_.transform, "oneclick")
	self.endController_ = ControllerUtil.GetController(self.gameObject_.transform, "end")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, XH1stSeamItemView)
end

function XH1stSealHomeView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.assignmentIdList_[arg_4_1])
end

function XH1stSealHomeView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/xH1stSealGame", {
			activityId = ActivityConst.ACTIVITY_2_0_SEAL
		})
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_7_0 = TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_SEAL)
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
			key = "XH1ST_SEAL_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("XH1ST_SEAL_DESC")
		})
	end)
end

function XH1stSealHomeView:AddEventListeners()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		self:UpdateList()
	end)
end

function XH1stSealHomeView:OnTop()
	self:UpdateBar()
end

function XH1stSealHomeView:OnBehind()
	manager.windowBar:HideBar()
end

function XH1stSealHomeView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[1]
	})
	manager.windowBar:SetBarCanAdd(ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[1], true)
end

function XH1stSealHomeView:OnEnter()
	self:AddEventListeners()

	if self:IsTimeOver() then
		self.uiList_:StartScroll(0)
		self.oneclickController_:SetSelectedState("no")
		self.endController_:SetSelectedState("on")
	else
		self:UpdateList()
		self:StartTimer()
		self:UpdateTimer()
	end

	self.contentText_.text = GetTips("XH1ST_SEAL_CONTENT")
end

function XH1stSealHomeView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function XH1stSealHomeView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function XH1stSealHomeView:UpdateTimer()
	self.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime)
end

function XH1stSealHomeView:IsTimeOver()
	if ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime <= manager.time:GetServerTime() then
		return true
	end

	return false
end

function XH1stSealHomeView:UpdateList()
	self.assignmentIdList_ = {}

	table.insertto(self.assignmentIdList_, AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_SEAL], 1)
	table.sort(self.assignmentIdList_, function(arg_21_0, arg_21_1)
		local var_21_0 = self:GetTaskStatus(arg_21_0)
		local var_21_1 = self:GetTaskStatus(arg_21_1)

		if var_21_0 ~= var_21_1 then
			return var_21_0 < var_21_1
		end

		local var_21_2 = AssignmentCfg[arg_21_0]
		local var_21_3 = AssignmentCfg[arg_21_1]

		if AssignmentCfg[arg_21_0].type ~= AssignmentCfg[arg_21_1].type then
			return var_21_2.type < var_21_3.type
		end

		return var_21_2.id < var_21_3.id
	end)
	self.uiList_:StartScroll(#self.assignmentIdList_)

	if #TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_SEAL) > 0 then
		self.oneclickController_:SetSelectedState("ok")
	else
		self.oneclickController_:SetSelectedState("no")
	end
end

function XH1stSealHomeView:GetTaskStatus(arg_22_1)
	if TaskData2:GetTaskComplete(arg_22_1) then
		return 3
	elseif TaskData2:GetTask(arg_22_1).progress >= AssignmentCfg[arg_22_1].need then
		return 1
	else
		return 2
	end
end

function XH1stSealHomeView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function XH1stSealHomeView:Show(arg_24_1)
	SetActive(self.gameObject_, arg_24_1)

	if arg_24_1 then
		self:UpdateList()
	end
end

function XH1stSealHomeView:OnMainHomeViewTop()
	return
end

function XH1stSealHomeView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	XH1stSealHomeView.super.Dispose(self)
end

return XH1stSealHomeView
