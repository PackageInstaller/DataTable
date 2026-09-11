local TaskPlotContentView = class("TaskPlotContentView", ReduxView)
local TaskConst = import("game.const.TaskConst")
local TaskTools = import("game.tools.TaskTools")
local ActivityPtConst = import("game.const.ActivityPtConst")

function TaskPlotContentView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isShow = false

	self:InitUI()

	self.systemItemList_ = {}
end

function TaskPlotContentView:Init()
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.PLOT)
	self._finishList = TaskTools:GetFinishTaskIds(TaskConst.TASK_TYPE.PLOT)

	self:RefreshAllFinish()
	self:RefreshRecivedAll()
end

function TaskPlotContentView:Dispose()
	self.scrollHelper_:Dispose()

	if self.systemItemList_ then
		for iter_3_0, iter_3_1 in pairs(self.systemItemList_) do
			iter_3_1:Dispose()
		end

		self.systemItemList_ = nil
	end

	self.phaseView_:Dispose()

	self.rectTrans = nil

	TaskPlotContentView.super.Dispose(self)
end

function TaskPlotContentView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.scrollView_, TaskPlotItemView)
	self.phaseView_ = TaskPlotPhaseView.New(self.goPhase_)
	self.rectTrans = self.scrollView_:GetComponent(typeof(RectTransform))
end

function TaskPlotContentView:RefreshScroll(arg_5_1)
	self:UpdateData()

	if arg_5_1 then
		if self.lastPosition_ then
			local var_5_0 = clone(self.lastPosition_)
			local var_5_1

			var_5_1 = FrameTimer.New(function()
				if isNil(self.gameObject_) then
					return
				end

				self.scrollHelper_:StartScrollWithoutAnimator(#self._taskIDList, var_5_0)
				var_5_1:Stop()

				var_5_1 = nil
			end, 1, 1)

			;(nil):Start()
		else
			self.scrollHelper_:StartScrollWithoutAnimator(#self._taskIDList)
		end
	else
		self.scrollHelper_:StartScroll(#self._taskIDList)
	end
end

function TaskPlotContentView:indexItem(arg_7_1, arg_7_2)
	arg_7_2:ReEnter(self._taskIDList[arg_7_1].id)
end

function TaskPlotContentView:OnEnter()
	self.isShow = true

	self:Init()
	self:OnTaskListChange(true)
	SetActive(self.gameObject_, true)
	self.phaseView_:RefreshUI()
end

function TaskPlotContentView:OnExit(arg_9_1)
	self.isShow = false

	if self.systemItemList_ then
		for iter_9_0, iter_9_1 in pairs(self.systemItemList_) do
			iter_9_1:Dispose()

			self.systemItemList_[iter_9_0] = nil
		end
	end

	SetActive(self.gameObject_, false)

	if not arg_9_1 then
		self.lastPosition_ = self.scrollHelper_:GetScrolledPosition()
	end
end

function TaskPlotContentView:ClearCache()
	self.lastPosition_ = nil
end

function TaskPlotContentView:Show(arg_11_1, arg_11_2)
	if self.isShow == arg_11_1 then
		return
	end

	self.isShow = arg_11_1

	if arg_11_1 and (not arg_11_2 or true) then
		self:OnEnter()
	else
		self:OnExit(true)
	end
end

function TaskPlotContentView:UpdateData()
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.PLOT)
end

function TaskPlotContentView:OnTaskListChange(arg_13_1)
	if self.isShow then
		self._finishList = TaskTools:GetFinishTaskIds(TaskConst.TASK_TYPE.PLOT)

		self:RefreshRecivedAll()
		self.phaseView_:RefreshUI()

		if not arg_13_1 then
			self:RefreshScroll(true)
		else
			self:RefreshScroll(false)
		end

		self.lastPosition_ = nil
	end
end

function TaskPlotContentView:RefreshAllFinish()
	return
end

function TaskPlotContentView:RefreshRecivedAll()
	if #self._finishList > 0 then
		self:RefreshOnceState(true)
	else
		self:RefreshOnceState(false)
	end
end

function TaskPlotContentView:RegisterRefreshOnceStateCallback(arg_16_1)
	self.refreshOnceCallback = arg_16_1
end

function TaskPlotContentView:RefreshOnceState(arg_17_1)
	if self.refreshOnceCallback then
		self.refreshOnceCallback(arg_17_1)
	end

	local var_17_0 = self.rectTrans.offsetMin.x

	self.rectTrans.offsetMin = arg_17_1 and Vector2.New(var_17_0, 70) or Vector2.New(var_17_0, 0)
end

function TaskPlotContentView:OnOnceClick()
	TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(TaskConst.TASK_TYPE.PLOT), TaskConst.TASK_TYPE.PLOT)
end

return TaskPlotContentView
