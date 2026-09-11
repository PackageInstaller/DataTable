local RegressionTaskNewPage = class("RegressionTaskNewPage", (import("game.views.regression.pages.RegressionTaskPage")))

function RegressionTaskNewPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnTwo/RT2stReturnMissionUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionTaskNewPage:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.scrollView_, RegressionTaskNewItem)
	self.allReceiveBtnState_ = ControllerUtil.GetController(self.transform_, "allReceive")
end

function RegressionTaskNewPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RegressionTaskNewPage:SetData(arg_4_1)
	if arg_4_1 == nil then
		return
	end

	self.taskType_ = arg_4_1
	self._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(self.taskType_)
	self._finishList = TaskTools:GetFinishTaskIds(self.taskType_)
	self.maxRewardNum_ = 0

	for iter_4_0, iter_4_1 in ipairs(self._taskIDList) do
		local var_4_0 = iter_4_1.id

		if not AssignmentCfg[iter_4_1.id] then
			print(var_4_0)
		else
			self.maxRewardNum_ = #AssignmentCfg[var_4_0].reward > self.maxRewardNum_ and #AssignmentCfg[var_4_0].reward or self.maxRewardNum_
		end
	end

	self.scrollHelper_:StartScroll(#self._taskIDList)
	self:RefreshRecivedAll()
end

function RegressionTaskNewPage:RefreshRecivedAll()
	self.allReceiveBtnState_:SetSelectedState(#self._finishList > 0 and "true" or "false")
end

function RegressionTaskNewPage:indexItem(arg_6_1, arg_6_2)
	arg_6_2:ReEnter(self._taskIDList[arg_6_1].id, self.maxRewardNum_)
end

return RegressionTaskNewPage
