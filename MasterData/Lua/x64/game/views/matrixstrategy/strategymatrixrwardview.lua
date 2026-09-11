local StrategyMatrixRwardView = class("StrategyMatrixRwardView", ReduxView)

function StrategyMatrixRwardView:UIName()
	return "Widget/System/MatrixlUI/StrategyMatriReward01UI"
end

function StrategyMatrixRwardView:UIParent()
	return manager.ui.uiMain.transform
end

function StrategyMatrixRwardView:Init()
	self:InitUI()
	self:AddUIListener()

	self.taskUpdateHandler_ = handler(self, self.RefreshScroll)
end

function StrategyMatrixRwardView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.indexItem), self.uiList_, StrategyMatrixRwardItem)
end

function StrategyMatrixRwardView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function StrategyMatrixRwardView:OnTop()
	manager.windowBar:SwitchBar({})
end

function StrategyMatrixRwardView:OnEnter()
	self.taskType_ = TaskConst.TASK_TYPE.STRATEGY_MATRIX
	self.activity_id = self.params_.task_activity_id
	self._taskIDList = TaskData2:GetActivityTaskSortList(self.activity_id)

	self.list:StartScroll(#self._taskIDList)
	self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
end

function StrategyMatrixRwardView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function StrategyMatrixRwardView:RefreshScroll()
	self._taskIDList = TaskData2:GetActivityTaskSortList(self.activity_id)

	self.list:StartScrollWithoutAnimator(#self._taskIDList, (self.list:GetScrolledPosition()))
end

function StrategyMatrixRwardView:indexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self._taskIDList[arg_11_1])
end

function StrategyMatrixRwardView:Dispose()
	self.list:Dispose()

	self.taskUpdateHandler_ = nil

	StrategyMatrixRwardView.super.Dispose(self)
end

function StrategyMatrixRwardView:OnTaskListChange()
	self:RefreshScroll()
end

return StrategyMatrixRwardView
