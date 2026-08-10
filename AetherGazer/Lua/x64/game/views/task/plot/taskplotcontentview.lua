local var_0_0 = class("TaskPlotContentView", ReduxView)
local var_0_1 = import("game.const.TaskConst")
local var_0_2 = import("game.tools.TaskTools")
local var_0_3 = import("game.const.ActivityPtConst")

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isShow = false

	arg_1_0:InitUI()

	arg_1_0.systemItemList_ = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(var_0_1.TASK_TYPE.PLOT)
	arg_2_0._finishList = var_0_2:GetFinishTaskIds(var_0_1.TASK_TYPE.PLOT)

	arg_2_0:RefreshAllFinish()
	arg_2_0:RefreshRecivedAll()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.scrollHelper_:Dispose()

	if arg_3_0.systemItemList_ then
		for iter_3_0, iter_3_1 in pairs(arg_3_0.systemItemList_) do
			iter_3_1:Dispose()
		end

		arg_3_0.systemItemList_ = nil
	end

	arg_3_0.phaseView_:Dispose()

	arg_3_0.rectTrans = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.scrollView_, TaskPlotItemView)
	arg_4_0.phaseView_ = TaskPlotPhaseView.New(arg_4_0.goPhase_)
	arg_4_0.rectTrans = arg_4_0.scrollView_:GetComponent(typeof(RectTransform))
end

function var_0_0.RefreshScroll(arg_5_0, arg_5_1)
	arg_5_0:UpdateData()

	if arg_5_1 then
		if arg_5_0.lastPosition_ then
			local var_5_0 = clone(arg_5_0.lastPosition_)
			local var_5_1

			var_5_1 = FrameTimer.New(function()
				if isNil(arg_5_0.gameObject_) then
					return
				end

				arg_5_0.scrollHelper_:StartScrollWithoutAnimator(#arg_5_0._taskIDList, var_5_0)
				var_5_1:Stop()

				var_5_1 = nil
			end, 1, 1)

			var_5_1:Start()
		else
			arg_5_0.scrollHelper_:StartScrollWithoutAnimator(#arg_5_0._taskIDList)
		end
	else
		arg_5_0.scrollHelper_:StartScroll(#arg_5_0._taskIDList)
	end
end

function var_0_0.indexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._taskIDList[arg_7_1].id

	arg_7_2:ReEnter(var_7_0)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.isShow = true

	arg_8_0:Init()
	arg_8_0:OnTaskListChange(true)
	SetActive(arg_8_0.gameObject_, true)
	arg_8_0.phaseView_:RefreshUI()
end

function var_0_0.OnExit(arg_9_0, arg_9_1)
	arg_9_0.isShow = false

	if arg_9_0.systemItemList_ then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.systemItemList_) do
			iter_9_1:Dispose()

			arg_9_0.systemItemList_[iter_9_0] = nil
		end
	end

	SetActive(arg_9_0.gameObject_, false)

	if not arg_9_1 then
		arg_9_0.lastPosition_ = arg_9_0.scrollHelper_:GetScrolledPosition()
	end
end

function var_0_0.ClearCache(arg_10_0)
	arg_10_0.lastPosition_ = nil
end

function var_0_0.Show(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.isShow == arg_11_1 then
		return
	end

	arg_11_0.isShow = arg_11_1

	if arg_11_1 and (not arg_11_2 or true) then
		arg_11_0:OnEnter()
	else
		arg_11_0:OnExit(true)
	end
end

function var_0_0.UpdateData(arg_12_0)
	arg_12_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(var_0_1.TASK_TYPE.PLOT)
end

function var_0_0.OnTaskListChange(arg_13_0, arg_13_1)
	if arg_13_0.isShow then
		arg_13_0._finishList = var_0_2:GetFinishTaskIds(var_0_1.TASK_TYPE.PLOT)

		arg_13_0:RefreshRecivedAll()
		arg_13_0.phaseView_:RefreshUI()

		if not arg_13_1 then
			arg_13_0:RefreshScroll(true)
		else
			arg_13_0:RefreshScroll(false)
		end

		arg_13_0.lastPosition_ = nil
	end
end

function var_0_0.RefreshAllFinish(arg_14_0)
	return
end

function var_0_0.RefreshRecivedAll(arg_15_0)
	if #arg_15_0._finishList > 0 then
		arg_15_0:RefreshOnceState(true)
	else
		arg_15_0:RefreshOnceState(false)
	end
end

function var_0_0.RegisterRefreshOnceStateCallback(arg_16_0, arg_16_1)
	arg_16_0.refreshOnceCallback = arg_16_1
end

function var_0_0.RefreshOnceState(arg_17_0, arg_17_1)
	if arg_17_0.refreshOnceCallback then
		arg_17_0.refreshOnceCallback(arg_17_1)
	end

	local var_17_0 = arg_17_0.rectTrans.offsetMin.x

	if arg_17_1 then
		arg_17_0.rectTrans.offsetMin = Vector2.New(var_17_0, 70)
	else
		arg_17_0.rectTrans.offsetMin = Vector2.New(var_17_0, 0)
	end
end

function var_0_0.OnOnceClick(arg_18_0)
	TaskAction:SubmitTaskList(var_0_2:GetFinishTaskIds(var_0_1.TASK_TYPE.PLOT), var_0_1.TASK_TYPE.PLOT)
end

return var_0_0
