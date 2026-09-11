local SummerQuestRewardPopView = class("SummerQuestRewardPopView", ReduxView)

function SummerQuestRewardPopView:UIName()
	return "Widget/Version/SummerUI_Com/SummerUI_3_4_SwimsuitQuestUI"
end

function SummerQuestRewardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerQuestRewardPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SummerQuestRewardPopView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, SummeQuestRewardItem)
	self.onClickController_ = self.controller_:GetController("oneclick")
end

function SummerQuestRewardPopView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.activityIds_[arg_5_1])
end

function SummerQuestRewardPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.onClickBtn_, nil, function()
		TaskAction:SubmitTaskList((self:GetCanRewardTask()))
	end)
end

function SummerQuestRewardPopView:OnEnter()
	self.activityIds_ = self.params_.activityIDList

	self:RefreshUI()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshUI))
end

function SummerQuestRewardPopView:OnWaterResult()
	if self.activityIds_[1] and AssignmentCfg[self.activityIds_[1]] and AssignmentCfg[self.activityIds_[1]].type == TaskConst.TASK_TYPE.SUMMER_WATER_WEEKLY then
		local var_10_0 = {}
		local var_10_1 = ActivitySummerWaterData:GetActivityID()

		if not var_10_1 then
			ShowTips("TIME_OVER")
			ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)

			return
		end

		for iter_10_0, iter_10_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[var_10_1]) do
			if not table.indexof(var_10_0, iter_10_1) then
				table.insert(var_10_0, iter_10_1)
			end
		end

		self.activityIds_ = var_10_0

		self:RefreshUI()
	end
end

function SummerQuestRewardPopView:RefreshUI()
	table.sort(self.activityIds_, function(arg_12_0, arg_12_1)
		local var_12_0 = TaskData2:GetTaskComplete(arg_12_1)
		local var_12_1 = TaskData2:GetTaskProgress(arg_12_0) >= AssignmentCfg[arg_12_0].need
		local var_12_2 = TaskData2:GetTaskProgress(arg_12_1) >= AssignmentCfg[arg_12_1].need

		if TaskData2:GetTaskComplete(arg_12_0) ~= var_12_0 then
			return var_12_0
		end

		if var_12_1 ~= var_12_2 then
			return var_12_1
		end

		return arg_12_0 < arg_12_1
	end)
	self.uiList_:StartScroll(#self.activityIds_)
	self.onClickController_:SetSelectedState(tostring(not table.isEmpty(self:GetCanRewardTask())))
end

function SummerQuestRewardPopView:OnExit()
	self:RemoveAllEventListener()
end

function SummerQuestRewardPopView:GetCanRewardTask()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(self.activityIds_) do
		if iter_14_1 then
			if TaskData2:GetTaskProgress(iter_14_1) >= AssignmentCfg[iter_14_1].need and not TaskData2:GetTaskComplete(iter_14_1) then
				table.insert(var_14_0, iter_14_1)
			end
		end
	end

	return var_14_0
end

function SummerQuestRewardPopView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	SummerQuestRewardPopView.super.Dispose(self)
end

return SummerQuestRewardPopView
