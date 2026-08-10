local var_0_0 = class("CombineGamePoolTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
	arg_3_0.typeController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "type")
	arg_3_0.list = LuaList.New(handler(arg_3_0, arg_3_0.SetItem), arg_3_0.listGo_, CommonItem)
end

function var_0_0.SetItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshData({
		id = arg_4_0.cfg.reward[arg_4_1][1],
		number = arg_4_0.cfg.reward[arg_4_1][2]
	})
	arg_4_2:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_5_0.id,
			arg_5_0.number
		})
	end)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.getBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_6_0.activityId) then
			return
		end

		TaskAction:SubmitTask(arg_6_0.taskId)
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index = arg_8_1
	arg_8_0.taskId = arg_8_2
	arg_8_0.cfg = AssignmentCfg[arg_8_2]
	arg_8_0.activityId = arg_8_3
	arg_8_0.showBar = true

	arg_8_0:UpdateView()
end

function var_0_0.HideBar(arg_9_0)
	arg_9_0.showBar = false

	SetActive(arg_9_0.barGo_, arg_9_0.showBar)
	SetActive(arg_9_0.processTxt_.gameObject, arg_9_0.showBar)
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = TaskData2:GetTask(arg_10_0.taskId)
	local var_10_1 = 0

	arg_10_0.controller:SetSelectedState("cannotGet")

	if var_10_0 then
		var_10_1 = var_10_0.progress
	end

	if var_10_1 >= arg_10_0.cfg.need then
		var_10_1 = arg_10_0.cfg.need

		arg_10_0.controller:SetSelectedState("get")
	end

	if var_10_0 ~= nil and TaskData2:GetTaskComplete(arg_10_0.taskId) then
		arg_10_0.controller:SetSelectedState("getted")
	end

	arg_10_0.typeController:SetSelectedState(arg_10_0.cfg.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY and "false" or "true")
	arg_10_0.list:StartScroll(#arg_10_0.cfg.reward)

	arg_10_0.descTxt_.text = GetI18NText(arg_10_0.cfg.desc)
	arg_10_0.processTxt_.text = var_10_1 .. "/" .. arg_10_0.cfg.need
	arg_10_0.barImg_.fillAmount = var_10_1 / arg_10_0.cfg.need

	SetActive(arg_10_0.barGo_, arg_10_0.showBar)
	SetActive(arg_10_0.processTxt_.gameObject, arg_10_0.showBar)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:UpdateView()
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.list then
		arg_12_0.list:Dispose()

		arg_12_0.list = nil
	end

	var_0_0.super.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)
end

return var_0_0
