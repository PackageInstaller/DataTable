local var_0_0 = class("EducateTargetPanel", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "EducateTargetPanel"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.contentTF = arg_2_0._tf:Find("content")

	onButton(arg_2_0, arg_2_0.contentTF, function()
		arg_2_0:emit(EducateBaseUI.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateTargetMediator,
			viewComponent = EducateTargetLayer
		}))

		return
	end, SFX_PANEL)

	arg_2_0.taskTpl = arg_2_0.contentTF:Find("tpl")

	setActive(arg_2_0.taskTpl, false)

	arg_2_0.listBg = arg_2_0.contentTF:Find("task_list/bg")
	arg_2_0.lineTF = arg_2_0.contentTF:Find("task_list/line")
	arg_2_0.mainTF = arg_2_0.contentTF:Find("task_list/main")

	setText(arg_2_0.mainTF:Find("title/Image/Text"), i18n("child_task_system_type3"))

	arg_2_0.mainTaskUIList = UIItemList.New(arg_2_0.mainTF:Find("list"), arg_2_0.taskTpl)

	arg_2_0.mainTaskUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_2_0:updateTaskItem(arg_4_1, arg_4_2, "main")
		end

		return
	end)

	arg_2_0.otherTF = arg_2_0.contentTF:Find("task_list/other")

	setText(arg_2_0.otherTF:Find("title/Image/Text"), i18n("child_task_system_type2"))

	arg_2_0.otherTaskUIList = UIItemList.New(arg_2_0.otherTF:Find("list"), arg_2_0.taskTpl)

	arg_2_0.otherTaskUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_2_0:updateTaskItem(arg_5_1, arg_5_2, "other")
		end

		return
	end)
	arg_2_0:Flush()

	return
end

function var_0_0.updateTaskItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 == "main" then
		local var_6_1 = string.format("(%s)", var_6_0:GetProgress() .. "/" .. var_6_0:GetFinishNum())

		setText(arg_6_2:Find("progress"), var_6_1)

		local var_6_2 = GetPerceptualSize(var_6_1)

		if PLATFORM_CODE == PLATFORM_JP then
			var_6_2 = var_6_2 + 2
		end

		setText(arg_6_2:Find("desc"), shortenString(var_6_0:getConfig("name"), 11 - var_6_2))

		return
	end
end

function var_0_0.Flush(arg_7_0)
	if not arg_7_0:GetLoaded() then
		return
	end

	arg_7_0.taskProxy = getProxy(EducateProxy):GetTaskProxy()

	setActive(arg_7_0.contentTF:Find("target_btn/tip"), arg_7_0.taskProxy:IsShowOtherTasksTip())

	arg_7_0.mainTaskVOs = arg_7_0.taskProxy:FilterByGroup(arg_7_0.taskProxy:GetMainTasksForShow())
	arg_7_0.otherTaskVOs = not arg_7_0.taskProxy:CanGetTargetAward() and {} or arg_7_0.taskProxy:FilterByGroup(arg_7_0.taskProxy:GetTargetTasksForShow(), true)

	setActive(arg_7_0.mainTF, #arg_7_0.mainTaskVOs > 0)
	arg_7_0.mainTaskUIList:align(#arg_7_0.mainTaskVOs)

	local var_7_0 = #arg_7_0.mainTaskVOs
	local var_7_1 = 3 - #arg_7_0.mainTaskVOs

	setActive(arg_7_0.otherTF, #arg_7_0.otherTaskVOs > 0)

	local var_7_2 = var_7_1 < #arg_7_0.otherTaskVOs and var_7_1 or #arg_7_0.otherTaskVOs

	arg_7_0.otherTaskUIList:align(var_7_1 < #arg_7_0.otherTaskVOs and var_7_1 or #arg_7_0.otherTaskVOs)
	setActive(arg_7_0.listBg, var_7_0 > 0 or var_7_2 > 0)
	setActive(arg_7_0.lineTF, var_7_0 > 0 and var_7_2 > 0)

	return
end

function var_0_0.SetPosLeft(arg_8_0)
	setLocalPosition(arg_8_0.contentTF, Vector2(-650, 0))

	return
end

function var_0_0.SetPosRight(arg_9_0)
	setLocalPosition(arg_9_0.contentTF, Vector2(0, 0))

	return
end

function var_0_0.OnDestroy(arg_10_0)
	return
end

return var_0_0
