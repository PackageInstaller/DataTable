local SwimsuitVoteQuestPopView = class("SwimsuitVoteQuestPopView", ReduxView)

function SwimsuitVoteQuestPopView:UIName()
	return "Widget/Version/SummerUI_Com/SummerUI_3_4_SwimsuitQuestUI_new"
end

function SwimsuitVoteQuestPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SwimsuitVoteQuestPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SwimsuitVoteQuestPopView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, SwimsuitVoteQuestPopItem)
	self.onClickController_ = self.controller_:GetController("oneclick")
end

function SwimsuitVoteQuestPopView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1)
end

function SwimsuitVoteQuestPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.onClickBtn_, nil, function()
		TaskAction:SubmitTaskList((self:GetCanRewardTask()))
	end)
end

function SwimsuitVoteQuestPopView:OnEnter()
	self.activityIds_ = SwimsuitBattleData:GetTaskIdByRound()

	self:RefreshUI()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshUI))
	self:RegistEventListener(SWIMSUIT_BATTLE_VOTE_UPDATE, handler(self, self.RefreshUI))
end

function SwimsuitVoteQuestPopView:RefreshUI()
	self.uiList_:StartScroll(4)
	self.onClickController_:SetSelectedState(tostring(not table.isEmpty(self:GetCanRewardTask())))
end

function SwimsuitVoteQuestPopView:OnExit()
	self:RemoveAllEventListener()
end

function SwimsuitVoteQuestPopView:GetCanRewardTask()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.activityIds_) do
		if iter_12_1 then
			if TaskData2:GetTaskProgress(iter_12_1) >= AssignmentCfg[iter_12_1].need and not TaskData2:GetTaskComplete(iter_12_1) then
				table.insert(var_12_0, iter_12_1)
			end
		end
	end

	return var_12_0
end

function SwimsuitVoteQuestPopView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	SwimsuitVoteQuestPopView.super.Dispose(self)
end

return SwimsuitVoteQuestPopView
