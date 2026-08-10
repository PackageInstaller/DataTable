local var_0_0 = class("SummerChessBoardExloreNoteToggle", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.index_ = arg_1_3
	arg_1_0.text_.text = arg_1_3

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.taskUpdateHandler_ = handler(arg_1_0, arg_1_0.TaskUpdate)
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.taskUpdateHandler_ = nil

	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddToggleListener(arg_3_0.toggle_, function(arg_4_0)
		manager.notify:Invoke(SUMMER_CHESS_BOARD_EXPLORE_NOTE_SWITCH, arg_3_0.index_)
		ActivitySummerChessBoardAction.ReadExploreNoteNewText(arg_3_0.taskIDList_)
	end)
end

function var_0_0.IsOn(arg_5_0, arg_5_1)
	arg_5_0.toggle_.isOn = arg_5_1

	if arg_5_1 then
		ActivitySummerChessBoardAction.ReadExploreNoteNewText(arg_5_0.taskIDList_)
		arg_5_0:RefreshRedPoint()
	end
end

function var_0_0.OnEnter(arg_6_0, arg_6_1)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_6_0.taskUpdateHandler_)

	arg_6_0.taskIDList_ = arg_6_1

	arg_6_0:RefreshRedPoint()
end

function var_0_0.OnExit(arg_7_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_7_0.taskUpdateHandler_)

	arg_7_0.taskIDList_ = {}
end

function var_0_0.TaskUpdate(arg_8_0)
	arg_8_0:RefreshRedPoint()
end

function var_0_0.NeedRedPoint(arg_9_0)
	local var_9_0 = arg_9_0.taskIDList_

	if arg_9_0.toggle_.isOn then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1 == 1 then
			if manager.redPoint:getTipValue(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO) > 0 then
				return true
			end
		else
			local var_9_1 = string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE, iter_9_1)

			if manager.redPoint:getTipValue(var_9_1) > 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.RefreshRedPoint(arg_10_0)
	if arg_10_0:NeedRedPoint() then
		SetActive(arg_10_0.noticeGo_, true)
	else
		SetActive(arg_10_0.noticeGo_, false)
	end
end

return var_0_0
