local SummerChessBoardChessTaskPanel = class("SummerChessBoardChessTaskPanel", ReduxView)

function SummerChessBoardChessTaskPanel:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.mainActivityID_ = arg_1_3
	self.taskActivityID_ = arg_1_4

	self:BindCfgUI()
	self:AddListeners()

	self.taskItemList_ = {}
	self.titleText_.text = ActivityCfg[arg_1_4].remark
	self.taskChangedHandler_ = handler(self, self.OnTaskChanged)

	self:OnEnter()
end

function SummerChessBoardChessTaskPanel:OnEnter()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, self.taskChangedHandler_)
end

function SummerChessBoardChessTaskPanel:OnExit()
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, self.taskChangedHandler_)
end

function SummerChessBoardChessTaskPanel:Dispose()
	self.taskChangedHandler_ = nil

	for iter_4_0, iter_4_1 in ipairs(self.taskItemList_) do
		iter_4_1:Dispose()
	end

	self.taskItemList_ = nil

	SummerChessBoardChessTaskPanel.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform = nil
	self.gameObject_ = nil
end

function SummerChessBoardChessTaskPanel:AddListeners()
	return
end

function SummerChessBoardChessTaskPanel:RefreshUI()
	local var_6_0 = TaskTools:SortTaskList((SummerChessBoardData:CallFun("GetTaskIDList", self.mainActivityID_, self.taskActivityID_)))

	for iter_6_0 = 1, #var_6_0 do
		if self.taskItemList_[iter_6_0] == nil then
			self.taskItemList_[iter_6_0] = SummerChessBoardChessTaskItem.New(self.item_, self.transform_, var_6_0[iter_6_0])

			SetActive(self.taskItemList_[iter_6_0].gameObject_, true)
		end

		self.taskItemList_[iter_6_0]:SetData(var_6_0[iter_6_0])
	end

	SetActive(self.gameObject_, #var_6_0 > 0)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function SummerChessBoardChessTaskPanel:OnTaskChanged()
	self:RefreshUI()
end

function SummerChessBoardChessTaskPanel:GetLocalPosition()
	return self.transform_.localPosition
end

function SummerChessBoardChessTaskPanel:GetHeight()
	return self.rectTf_.rect.height
end

return SummerChessBoardChessTaskPanel
