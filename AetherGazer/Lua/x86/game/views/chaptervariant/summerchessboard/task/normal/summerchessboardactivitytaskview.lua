local var_0_0 = class("SummerChessBoardActivityTaskView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2.prefab_path), arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.receiceAllController_ = arg_1_0.controllerEx_:GetController("receiveAll")
	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.uiListGo_, SummerChessBoardActivityTaskItem)
	arg_1_0.taskChangedHandler_ = handler(arg_1_0, arg_1_0.OnTaskChanged)

	arg_1_0:OnEnter()
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, arg_2_0.taskChangedHandler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(TASK_LIST_CHANGE_NOTIFY, arg_3_0.taskChangedHandler_)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.uiList_:GetItemList()) do
		iter_3_1:OnExit()
	end
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.taskChangedHandler_ = nil

	arg_4_0.uiList_:Dispose()

	arg_4_0.uiList_ = nil

	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveAllBtn_, nil, function()
		local var_6_0 = TaskTools:GetFinishTaskIDList(arg_5_0.taskIDList_)

		TaskAction:SubmitTaskList(var_6_0, nil, function()
			return
		end)
	end)
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.main_activity_id
	local var_9_1 = arg_9_1.activity_id

	arg_9_0.cfg_ = arg_9_1
	arg_9_0.taskIDList_, arg_9_0.needReorderTask_ = SummerChessBoardData:CallFun("GetTaskIDList", var_9_0, var_9_1), SummerChessBoardData:CallFun("GetNeedReorderTask", var_9_0, var_9_1)

	arg_9_0:OnTaskChanged()
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.taskIDList_[arg_10_1], arg_10_0.cfg_.is_activity == 1)
end

function var_0_0.OnTaskChanged(arg_11_0)
	if arg_11_0.needReorderTask_ then
		arg_11_0.taskIDList_ = TaskTools:SortTaskList(arg_11_0.taskIDList_)
	end

	arg_11_0.uiList_:StartScroll(#arg_11_0.taskIDList_)
	arg_11_0:RefreshReceiveAll()
end

function var_0_0.RefreshReceiveAll(arg_12_0)
	if #TaskTools:GetFinishTaskIDList(arg_12_0.taskIDList_) > 0 then
		arg_12_0.receiceAllController_:SetSelectedState("true")
	else
		arg_12_0.receiceAllController_:SetSelectedState("false")
	end
end

return var_0_0
