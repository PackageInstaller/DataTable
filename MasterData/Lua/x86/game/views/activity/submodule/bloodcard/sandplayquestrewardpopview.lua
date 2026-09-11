local SandPlayQuestRewardPopView = class("SandPlayQuestRewardPopView", ReduxView)

function SandPlayQuestRewardPopView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI"
end

function SandPlayQuestRewardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SandPlayQuestRewardPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SandPlayQuestRewardPopView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.taskList_, SandPlayQuestRewardItem)
	self.oneClickController_ = self.controllers_:GetController("oneclick")
end

function SandPlayQuestRewardPopView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.taskIDList_[arg_5_1])
end

function SandPlayQuestRewardPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.oneClickBtn_, nil, function()
		TaskAction:SubmitTaskList((self:GetCanRewardTask()))
	end)
end

function SandPlayQuestRewardPopView:OnEnter()
	self.taskIDList_ = self.params_.taskIDList

	self:RefreshUI()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshUI))
end

function SandPlayQuestRewardPopView:RefreshUI()
	table.sort(self.taskIDList_, function(arg_11_0, arg_11_1)
		local var_11_0 = TaskData2:GetTaskComplete(arg_11_1)
		local var_11_1 = TaskData2:GetTaskProgress(arg_11_0) >= AssignmentCfg[arg_11_0].need
		local var_11_2 = TaskData2:GetTaskProgress(arg_11_1) >= AssignmentCfg[arg_11_1].need

		if TaskData2:GetTaskComplete(arg_11_0) ~= var_11_0 then
			return var_11_0
		end

		if var_11_1 ~= var_11_2 then
			return var_11_1
		end

		return arg_11_0 < arg_11_1
	end)
	self.uiList_:StartScroll(#self.taskIDList_)
	self.oneClickController_:SetSelectedState(tostring(not table.isEmpty(self:GetCanRewardTask())))
end

function SandPlayQuestRewardPopView:OnExit()
	self:RemoveAllEventListener()
end

function SandPlayQuestRewardPopView:GetCanRewardTask()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self.taskIDList_) do
		if iter_13_1 then
			if TaskData2:GetTaskProgress(iter_13_1) >= AssignmentCfg[iter_13_1].need and not TaskData2:GetTaskComplete(iter_13_1) then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	return var_13_0
end

function SandPlayQuestRewardPopView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	SandPlayQuestRewardPopView.super.Dispose(self)
end

return SandPlayQuestRewardPopView
