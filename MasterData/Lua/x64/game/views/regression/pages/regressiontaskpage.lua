local RegressionNewPage = class("RegressionNewPage", ReduxView)

function RegressionNewPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("UI/ReturnUI/RegressionTaskUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionNewPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionNewPage:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.scrollView_, TaskDailyItemView)
end

function RegressionNewPage:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(self.taskType_), self.taskType_)
	end)
end

function RegressionNewPage:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function RegressionNewPage:SetData(arg_7_1)
	if arg_7_1 == nil then
		return
	end

	self.taskType_ = arg_7_1
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)
	self._finishList = TaskTools:GetFinishTaskIds(self.taskType_)

	self.scrollHelper_:StartScroll(#self._taskIDList)
	self:RefreshRecivedAll()
end

function RegressionNewPage:Refresh()
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)
	self._finishList = TaskTools:GetFinishTaskIds(self.taskType_)

	self.scrollHelper_:Refresh()
	self:RefreshRecivedAll()
end

function RegressionNewPage:RefreshRecivedAll()
	if #self._finishList > 0 then
		SetActive(self.goAllAccept_, true)
	else
		SetActive(self.goAllAccept_, false)
	end
end

function RegressionNewPage:indexItem(arg_10_1, arg_10_2)
	arg_10_2:ReEnter(self._taskIDList[arg_10_1].id)
end

function RegressionNewPage:Dispose()
	self.scrollHelper_:Dispose()
	RegressionNewPage.super.Dispose(self)
end

function RegressionNewPage:RefreshScroll()
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)

	self.scrollHelper_:StartScrollWithoutAnimator(#self._taskIDList, (self.scrollHelper_:GetScrolledPosition()))
end

function RegressionNewPage:OnTaskListChange()
	self:RefreshScroll()

	self._finishList = TaskTools:GetFinishTaskIds(self.taskType_)

	self:RefreshRecivedAll()
end

return RegressionNewPage
