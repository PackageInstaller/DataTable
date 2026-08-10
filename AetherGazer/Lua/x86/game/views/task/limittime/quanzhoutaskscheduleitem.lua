local var_0_0 = class("QuanZhouTaskScheduleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.item_ = CommonItemView.New(arg_3_0.itemGo_, true)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.taskID_ = arg_4_1
	arg_4_0.callback_ = arg_4_2

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	local var_5_0 = AssignmentCfg[arg_5_0.taskID_]
	local var_5_1 = clone(ItemTemplateData)
	local var_5_2 = var_5_0.reward

	var_5_1.id = var_5_2[1][1]
	var_5_1.number = var_5_2[1][2]
	var_5_1.pointRewardData = var_5_2
	var_5_1.taskID = arg_5_0.taskID_
	var_5_1.clickFun = arg_5_0.callback_

	arg_5_0.item_:SetData(var_5_1)

	arg_5_0.numText_.text = tostring(var_5_0.need)
end

function var_0_0.GetTaskID(arg_6_0)
	return arg_6_0.taskID_
end

function var_0_0.RefreshSlider(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.slider_.value = arg_7_1 / arg_7_2

	if arg_7_2 <= arg_7_1 then
		SetActive(arg_7_0.pointGo_, true)
	else
		SetActive(arg_7_0.pointGo_, false)
	end
end

function var_0_0.RefreshCompleted(arg_8_0, arg_8_1)
	arg_8_0.item_:RefreshCompleted(arg_8_1)
end

function var_0_0.RefreshHighLight(arg_9_0, arg_9_1)
	arg_9_0.item_:RefreshHighLight(arg_9_1)
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)

	if arg_10_1 then
		-- block empty
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.item_:Dispose()
	var_0_0.super.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)
end

return var_0_0
