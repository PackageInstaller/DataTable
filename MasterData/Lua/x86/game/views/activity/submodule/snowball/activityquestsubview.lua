local ActivityQuestSubView = class("ActivityQuestSubView", BaseView)
local var_0_1 = {
	inProgress = 1,
	done = 0,
	complete = 2
}

local function var_0_2()
	return true
end

function ActivityQuestSubView:Ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	ActivityQuestSubView.super.Ctor(self, arg_2_1)

	self.gameObject_ = arg_2_1
	self.transform_ = arg_2_1.transform
	self.itemCls = arg_2_4
	self.activity = arg_2_2
	self.taskFilter = arg_2_3 or var_0_2
	self.showSubmitAll = arg_2_5

	self:Init()
end

function ActivityQuestSubView:Init()
	self:BindCfgUI()

	self.questList = LuaList.New(handler(self, self.UpdateQuestItem), self.questList_, self.itemCls)

	if self.showSubmitAll then
		self.clearController = ControllerUtil.GetController(self.transform_, "clear")

		self:AddBtnListenerScale(self.receiveBtn_, nil, function()
			local var_4_0 = {}

			for iter_4_0, iter_4_1 in ipairs(self.quests) do
				if iter_4_1.status == var_0_1.complete then
					table.insert(var_4_0, iter_4_1.id)
				end
			end

			TaskAction:SubmitTaskList(var_4_0)
		end)
	end
end

function ActivityQuestSubView:UpdateQuestItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.quests[arg_5_1].id, self.quests[arg_5_1].activityID)

	if self.OnQuestItemRender then
		self:OnQuestItemRender(self.quests[arg_5_1].id, arg_5_2, arg_5_1)
	end
end

function ActivityQuestSubView:RefreshAllTask()
	self.quests = {}

	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs((TaskData2:GetActivityTaskSortList(self.activity))) do
		if self.taskFilter(iter_6_1) then
			local var_6_1 = var_0_1.inProgress

			if iter_6_1.complete_flag >= 1 then
				var_6_1 = var_0_1.done
			elseif iter_6_1.progress >= AssignmentCfg[iter_6_1.id].need then
				var_6_1 = var_0_1.complete
				var_6_0 = var_6_0 + 1
			end

			table.insert(self.quests, {
				id = iter_6_1.id,
				activityID = AssignmentCfg[iter_6_1.id].activity_id,
				status = var_6_1
			})
		end
	end

	self.completeQuest = var_6_0

	if self.showSubmitAll then
		if var_6_0 > 0 then
			self.clearController:SetSelectedState("true")
		else
			self.clearController:SetSelectedState("false")
		end
	end

	self.questList:StartScroll(#self.quests)
end

function ActivityQuestSubView:OnEnter()
	self:RefreshAllTask()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshAllTask))
end

function ActivityQuestSubView:OnExit()
	self:RemoveAllEventListener()
end

function ActivityQuestSubView:Dispose()
	if self.questList then
		self.questList:Dispose()

		self.questList = nil
	end

	self.quests = nil

	ActivityQuestSubView.super.Dispose(self)
end

return ActivityQuestSubView
