local SummerChessBoardActivityTaskView = class("SummerChessBoardActivityTaskView", ReduxView)

function SummerChessBoardActivityTaskView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2.prefab_path), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.receiceAllController_ = self.controllerEx_:GetController("receiveAll")
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, SummerChessBoardActivityTaskItem)
	self.taskChangedHandler_ = handler(self, self.OnTaskChanged)

	self:OnEnter()
end

function SummerChessBoardActivityTaskView:OnEnter()
	manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, self.taskChangedHandler_)
end

function SummerChessBoardActivityTaskView:OnExit()
	manager.notify:RemoveListener(TASK_LIST_CHANGE_NOTIFY, self.taskChangedHandler_)

	for iter_3_0, iter_3_1 in ipairs(self.uiList_:GetItemList()) do
		iter_3_1:OnExit()
	end
end

function SummerChessBoardActivityTaskView:Dispose()
	self.taskChangedHandler_ = nil

	self.uiList_:Dispose()

	self.uiList_ = nil

	SummerChessBoardActivityTaskView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SummerChessBoardActivityTaskView:AddListeners()
	self:AddBtnListener(self.receiveAllBtn_, nil, function()
		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIDList(self.taskIDList_), nil, function()
			return
		end)
	end)
end

function SummerChessBoardActivityTaskView:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function SummerChessBoardActivityTaskView:SetData(arg_9_1)
	self.cfg_ = arg_9_1
	self.taskIDList_, self.needReorderTask_ = SummerChessBoardData:CallFun("GetTaskIDList", arg_9_1.main_activity_id, arg_9_1.activity_id), SummerChessBoardData:CallFun("GetNeedReorderTask", arg_9_1.main_activity_id, arg_9_1.activity_id)

	self:OnTaskChanged()
end

function SummerChessBoardActivityTaskView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.taskIDList_[arg_10_1], self.cfg_.is_activity == 1)
end

function SummerChessBoardActivityTaskView:OnTaskChanged()
	if self.needReorderTask_ then
		self.taskIDList_ = TaskTools:SortTaskList(self.taskIDList_)
	end

	self.uiList_:StartScroll(#self.taskIDList_)
	self:RefreshReceiveAll()
end

function SummerChessBoardActivityTaskView:RefreshReceiveAll()
	if #TaskTools:GetFinishTaskIDList(self.taskIDList_) > 0 then
		self.receiceAllController_:SetSelectedState("true")
	else
		self.receiceAllController_:SetSelectedState("false")
	end
end

return SummerChessBoardActivityTaskView
