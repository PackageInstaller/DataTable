local var_0_0 = class("ActivityNewbieDailyView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load(arg_1_0:GetUIName())

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.scrollHelper_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshItem), arg_1_0.uiList_, ActivityNewbieDailyItem)
	arg_1_0.itemList_ = {}

	arg_1_0:AddListeners()

	arg_1_0.newbieDailyUpdateHandler_ = handler(arg_1_0, arg_1_0.NewbieDailyUpdate)

	manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, arg_1_0.newbieDailyUpdateHandler_)

	arg_1_0.newbieDailySubmitHandler_ = handler(arg_1_0, arg_1_0.RefreshUI)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_1_0.newbieDailySubmitHandler_)
end

function var_0_0.GetUIName(arg_2_0)
	return "Widget/System/Activitynewbie/NewbieDailyUI"
end

function var_0_0.Dispose(arg_3_0)
	manager.notify:RemoveListener(TASK_LIST_CHANGE_NOTIFY, arg_3_0.newbieDailyUpdateHandler_)

	arg_3_0.newbieDailyUpdateHandler_ = nil

	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_3_0.newbieDailySubmitHandler_)

	arg_3_0.newbieDailySubmitHandler_ = nil

	var_0_0.super.Dispose(arg_3_0)
	arg_3_0.scrollView_.onValueChanged:RemoveAllListeners()

	arg_3_0.scrollView_ = nil
	arg_3_0.itemList_ = nil

	arg_3_0.scrollHelper_:Dispose()

	arg_3_0.scrollHelper_ = nil

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0.scrollHelper_:SetPageChangeHandler(handler(arg_4_0, arg_4_0.OnPageChange))
	arg_4_0:AddBtnListener(arg_4_0.buttonPrev_, nil, function()
		arg_4_0.scrollHelper_:SwitchToPage(arg_4_0.pageIndex_ - 1)
	end)
	arg_4_0:AddBtnListener(arg_4_0.buttonNext_, nil, function()
		arg_4_0.scrollHelper_:SwitchToPage(arg_4_0.pageIndex_ + 1)
	end)
	arg_4_0.scrollView_.onValueChanged:AddListener(function()
		arg_4_0:RefreshItemAlpha()
	end)
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.SetData(arg_9_0)
	arg_9_0:NewbieDailyUpdate()
end

function var_0_0.RefreshItem(arg_10_0, arg_10_1, arg_10_2)
	if not table.keyof(arg_10_0.itemList, arg_10_2) then
		table.insert(arg_10_0.itemList_, arg_10_2)
	end

	arg_10_2:RefreshUI(arg_10_1)
	arg_10_2:RegistListener(function()
		arg_10_0.scrollHelper_:Refresh()
	end)
end

function var_0_0.OnPageChange(arg_12_0, arg_12_1)
	if arg_12_1 == 0 then
		arg_12_1 = 1
	end

	arg_12_0.pageIndex_ = arg_12_1

	SetActive(arg_12_0.goPrev_, arg_12_1 > 1)
	SetActive(arg_12_0.goNext_, arg_12_1 < #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER])
end

function var_0_0.RefreshItemAlpha(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.itemList_) do
		iter_13_1:RefreshAlpha()
	end
end

function var_0_0.RefreshUI(arg_14_0)
	local var_14_0 = #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER]
	local var_14_1 = TaskTools:GetNewbieDailyTaskFinishCnt()

	arg_14_0.slider_.value = var_14_1 / var_14_0
	arg_14_0.textCurCnt_.text = string.format("%s<size=30>/%s</size>", var_14_1, var_14_0)
end

function var_0_0.NewbieDailyUpdate(arg_15_0, arg_15_1)
	local var_15_0 = false

	if not arg_15_1 then
		var_15_0 = true
	else
		for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
			local var_15_1 = AssignmentCfg[iter_15_1.id]

			if var_15_1 and var_15_1.type == TaskConst.TASK_TYPE.DAILY_OFFER then
				var_15_0 = true

				break
			end
		end
	end

	if var_15_0 then
		local var_15_2 = #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER]
		local var_15_3 = TaskTools:GetTaskCountByType(TaskConst.TASK_TYPE.DAILY_OFFER)

		arg_15_0.scrollHelper_:StartScroll(var_15_2, var_15_3, true, false)
		arg_15_0:OnPageChange(var_15_3)
		arg_15_0:RefreshUI()
		arg_15_0:RefreshItemAlpha()
	end
end

return var_0_0
