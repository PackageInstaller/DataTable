local StrongholdOperateTaskPage = class("StrongholdOperateTaskPage", StrongholdOperateBasePage)

function StrongholdOperateTaskPage:OnCtor(arg_1_1, arg_1_2)
	self.hander_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdNoteUI"), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StrongholdOperateTaskPage:Init()
	self:InitUI()
	self:Refresh()
end

function StrongholdOperateTaskPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdOperateTaskPage:InitUI()
	self:BindCfgUI()

	self.tabController = ControllerUtil.GetController(self.transform_, "tab")
	self.rewardController = ControllerUtil.GetController(self.transform_, "reward")
	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.m_taskList, StrongholdOperateTaskItem)
end

function StrongholdOperateTaskPage:AddUIListener()
	self:AddBtnListener(nil, self.m_type1Btn, function()
		if self:SelectTab(1) then
			self.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	self:AddBtnListener(nil, self.m_type2Btn, function()
		if self:SelectTab(2) then
			self.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	self:AddBtnListener(nil, self.m_type3Btn, function()
		if self:SelectTab(3) then
			self.m_animator:Play("Fx_messagebg_qiehuan", 0, 0)
		end
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		TaskAction:SubmitTaskList(self._finishList)
	end)
end

function StrongholdOperateTaskPage:UpdateTaskData()
	self._taskIDList, self._finishList = self:GetTaskData(self.selectIndex)
end

function StrongholdOperateTaskPage:UpdateTaskRed()
	local var_11_0, var_11_1 = self:GetTaskData(1)
	local var_11_2, var_11_3 = self:GetTaskData(2)
	local var_11_4, var_11_5 = self:GetTaskData(3)

	manager.redPoint:SetRedPointIndependent(self.m_type1Btn.transform, #var_11_1 > 0)
	manager.redPoint:SetRedPointIndependent(self.m_type2Btn.transform, #var_11_3 > 0)
	manager.redPoint:SetRedPointIndependent(self.m_type3Btn.transform, #var_11_5 > 0)
end

function StrongholdOperateTaskPage:GetTaskData(arg_12_1)
	local var_12_0
	local var_12_2

	if arg_12_1 == 1 then
		var_12_0 = 711
		var_12_2 = 712
	elseif arg_12_1 == 2 then
		var_12_0 = 721
		var_12_2 = 722
	else
		var_12_0 = 731
		var_12_2 = 732
	end

	local var_12_3 = TaskTools:GetActivityTaskList(self.task_activity_id) or {}
	local var_12_4 = clone(TaskTools.GetTaskList(var_12_3, var_12_0))

	table.insertto(var_12_4, TaskTools.GetTaskList(var_12_3, var_12_2))
	table.sort(var_12_4, function(arg_13_0, arg_13_1)
		local var_13_0 = TaskData2:GetTask(arg_13_0)
		local var_13_1 = TaskData2:GetTask(arg_13_1)
		local var_13_2 = var_13_1.complete_flag >= 1
		local var_13_3 = var_13_0.progress >= AssignmentCfg[arg_13_0].need

		if var_13_0.complete_flag >= 1 == (var_13_1.complete_flag >= 1) then
			if var_13_3 == (var_13_1.progress >= AssignmentCfg[arg_13_1].need) then
				return arg_13_0 < arg_13_1
			else
				return var_13_3
			end
		else
			return var_13_2
		end
	end)

	local var_12_5 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_4) do
		local var_12_6 = TaskData2:GetTask(iter_12_1)

		if var_12_6.complete_flag == 0 and var_12_6.progress >= AssignmentCfg[iter_12_1].need then
			table.insert(var_12_5, iter_12_1)
		end
	end

	return var_12_4, var_12_5
end

function StrongholdOperateTaskPage:SelectTab(arg_14_1, arg_14_2)
	if self.selectIndex == arg_14_1 and not arg_14_2 then
		return false
	end

	self.tabController:SetSelectedIndex(arg_14_1 - 1)

	self.selectIndex = arg_14_1

	self:UpdateTaskData()
	self.scrollHelper_:StartScroll(#self._taskIDList)
	self:RefreshRecivedAll()
	self:RefreshUI()

	return true
end

function StrongholdOperateTaskPage:RefreshUI()
	local var_15_0, var_15_1, var_15_2, var_15_3 = StrongholdData:GetStrongholdLevel(self.selectIndex)

	self.m_lvname.text = ActivityStrongholdLevelCfg[var_15_0].level_des
	self.m_typeName.text = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. self.selectIndex) .. " Lv." .. var_15_1

	if ActivityStrongholdLevelCfg[var_15_0 + 1] then
		self.m_expSlider.value = var_15_2 / (ActivityStrongholdLevelCfg[var_15_0 + 1].exp - ActivityStrongholdLevelCfg[var_15_0].exp)
		self.m_expLab.text = var_15_2 .. "/" .. ActivityStrongholdLevelCfg[var_15_0 + 1].exp - ActivityStrongholdLevelCfg[var_15_0].exp
		self.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_COIN_WEEK_CEIL") .. StrongholdData:GetWeeklyExp(self.activity_id, self.selectIndex) .. "/" .. StrongholdData:GetWeeklyMaxExp(self.activity_id, self.selectIndex)
	else
		self.m_expSlider.value = 1
		self.m_expLab.text = ActivityStrongholdLevelCfg[var_15_0].exp .. "/" .. ActivityStrongholdLevelCfg[var_15_0].exp
		self.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
	end
end

function StrongholdOperateTaskPage:Refresh(arg_16_1)
	self.activity_id = arg_16_1
	self.task_activity_id = 0

	for iter_16_0, iter_16_1 in ipairs(ActivityCfg[arg_16_1].sub_activity_list) do
		if ActivityTemplateConst.TASK == ActivityCfg[iter_16_1].activity_template then
			self.task_activity_id = iter_16_1

			break
		end
	end

	if self.selectIndex == nil then
		self:SelectTab(1, true)
	else
		self:UpdateTaskData()
		self.scrollHelper_:Refresh()
		self:RefreshRecivedAll()
	end

	self:UpdateTaskRed()
end

function StrongholdOperateTaskPage:RefreshRecivedAll()
	if #self._finishList > 0 then
		self.rewardController:SetSelectedIndex(1)
	else
		self.rewardController:SetSelectedIndex(0)
	end
end

function StrongholdOperateTaskPage:OnTaskListChange()
	self:UpdateTaskData()
	self.scrollHelper_:StartScrollWithoutAnimator(#self._taskIDList, (self.scrollHelper_:GetScrolledPosition()))
	self:RefreshRecivedAll()
	self:UpdateTaskRed()
end

function StrongholdOperateTaskPage:Dispose()
	self.scrollHelper_:Dispose()
	StrongholdOperateTaskPage.super.Dispose(self)
end

function StrongholdOperateTaskPage:indexItem(arg_20_1, arg_20_2)
	arg_20_2:SetData(self.task_activity_id, self._taskIDList[arg_20_1])
end

function StrongholdOperateTaskPage:OnCurrencyChange()
	self:RefreshUI()
end

return StrongholdOperateTaskPage
