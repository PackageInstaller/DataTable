class = var_0_10000

local var_0_0 = "EducateTargetPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EducateTargetPanel"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.contentTF = var_1.Find(var_2_0, "content")
	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.contentTF

	local function var_2_3()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		EducateBaseUI = var_2_10003

		local var_3_2 = var_2_10003.EDUCATE_GO_SUBLAYER

		Context = var_2_10004

		local var_3_3 = var_2_10004.New
		local var_3_4 = {}

		EducateTargetMediator = var_2_10007
		var_3_4.mediator = var_2_10007
		EducateTargetLayer = var_2_10007
		var_3_4.viewComponent = var_2_10007

		var_3_1(var_3_0, var_3_2, var_3_3(var_3_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

	local var_2_4 = arg_2_0.contentTF

	arg_2_0.taskTpl = var_1.Find(var_2_4, "tpl")
	setActive = var_1

	var_1(arg_2_0.taskTpl, false)

	local var_2_5 = arg_2_0.contentTF

	arg_2_0.listBg = var_1.Find(var_2_5, "task_list/bg")

	local var_2_6 = arg_2_0.contentTF

	arg_2_0.lineTF = var_1.Find(var_2_6, "task_list/line")

	local var_2_7 = arg_2_0.contentTF

	arg_2_0.mainTF = var_1.Find(var_2_7, "task_list/main")
	setText = var_1

	local var_2_8 = arg_2_0.mainTF
	local var_2_9 = var_3.Find(var_2_8, "title/Image/Text")

	i18n = var_4

	var_1(var_2_9, var_4("child_task_system_type3"))

	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0.mainTF

	arg_2_0.mainTaskUIList = var_2_10(var_3.Find(var_2_11, "list"), arg_2_0.taskTpl)

	local var_2_12 = arg_2_0.mainTaskUIList

	var_1.make(var_2_12, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0

			var_3.updateTaskItem(var_4_0, arg_4_1, arg_4_2, "main")
		end

		return
	end)

	local var_2_13 = arg_2_0.contentTF

	arg_2_0.otherTF = var_1.Find(var_2_13, "task_list/other")
	setText = var_1

	local var_2_14 = arg_2_0.otherTF
	local var_2_15 = var_3.Find(var_2_14, "title/Image/Text")

	i18n = var_4

	var_1(var_2_15, var_4("child_task_system_type2"))

	UIItemList = var_1

	local var_2_16 = var_1.New
	local var_2_17 = arg_2_0.otherTF

	arg_2_0.otherTaskUIList = var_2_16(var_3.Find(var_2_17, "list"), arg_2_0.taskTpl)

	local var_2_18 = arg_2_0.otherTaskUIList

	var_1.make(var_2_18, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_2_0

			var_3.updateTaskItem(var_5_0, arg_5_1, arg_5_2, "other")
		end

		return
	end)
	arg_2_0:Flush()

	return
end

function var_0_1.updateTaskItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0

	if arg_6_3 ~= "main" or not arg_6_0.mainTaskVOs[arg_6_1 + 1] then
		var_6_0 = arg_6_0.otherTaskVOs[arg_6_1 + 1]
	end

	string = var_1_10005

	local var_6_1 = var_1_10005.format("(%s)", var_6_0:GetProgress() .. "/" .. var_6_0:GetFinishNum())

	setText = var_1_10006

	local var_6_2 = arg_6_2

	var_1_10006(arg_6_2.Find(var_6_2, "progress"), var_6_1)

	GetPerceptualSize = var_1_10006

	local var_6_3 = var_1_10006(var_6_1)

	PLATFORM_CODE = var_7
	PLATFORM_JP = var_8

	if var_7 == var_8 then
		var_6_3 = var_6_3 + 2
	end

	setText = var_7

	local var_6_4 = arg_6_2:Find("desc")

	shortenString = var_6_2

	var_7(var_6_4, var_6_2(var_6_0:getConfig("name"), 11 - var_6_3))

	return
end

function var_0_1.Flush(arg_7_0)
	local var_7_0 = arg_7_0

	if not arg_7_0.GetLoaded(var_7_0) then
		return
	end

	getProxy = var_1
	EducateProxy = var_7_0

	local var_7_1 = var_1(var_7_0)

	arg_7_0.taskProxy = var_1.GetTaskProxy(var_7_1)
	setActive = var_1

	local var_7_2 = arg_7_0.contentTF
	local var_7_3 = var_3.Find(var_7_2, "target_btn/tip")
	local var_7_4 = arg_7_0.taskProxy

	var_1(var_7_3, var_4.IsShowOtherTasksTip(var_7_4))

	local var_7_5 = arg_7_0.taskProxy
	local var_7_6 = var_1.FilterByGroup
	local var_7_7 = arg_7_0.taskProxy

	arg_7_0.mainTaskVOs = var_7_6(var_7_5, var_4.GetMainTasksForShow(var_7_7))

	local var_7_8 = arg_7_0.taskProxy
	local var_7_10

	if not var_1.CanGetTargetAward(var_7_8) then
		arg_7_0.otherTaskVOs = {}
	else
		local var_7_9 = arg_7_0.taskProxy

		var_7_10 = var_7_10.FilterByGroup

		local var_7_11 = arg_7_0.taskProxy

		arg_7_0.otherTaskVOs = var_7_10(var_7_9, var_4.GetTargetTasksForShow(var_7_11), true)
	end

	setActive = var_7_10

	var_7_10(arg_7_0.mainTF, #arg_7_0.mainTaskVOs > 0)

	local var_7_12 = arg_7_0.mainTaskUIList

	var_1.align(var_7_12, #arg_7_0.mainTaskVOs)

	local var_7_13 = 3 - #arg_7_0.mainTaskVOs

	setActive = var_7_12

	var_7_12(arg_7_0.otherTF, #arg_7_0.otherTaskVOs > 0)

	local var_7_14 = var_7_13 < #arg_7_0.otherTaskVOs and var_7_13 or #arg_7_0.otherTaskVOs
	local var_7_15 = arg_7_0.otherTaskUIList

	var_4.align(var_7_15, var_7_14)

	setActive = var_4

	var_4(arg_7_0.listBg, var_1 > 0 or var_7_14 > 0)

	setActive = var_4

	var_4(arg_7_0.lineTF, var_1 > 0 and var_7_14 > 0)

	return
end

function var_0_1.SetPosLeft(arg_8_0)
	setLocalPosition = var_1_10001

	local var_8_0 = arg_8_0.contentTF

	Vector2 = var_1_10004

	var_1_10001(var_8_0, var_1_10004(-650, 0))

	return
end

function var_0_1.SetPosRight(arg_9_0)
	setLocalPosition = var_1_10001

	local var_9_0 = arg_9_0.contentTF

	Vector2 = var_1_10004

	var_1_10001(var_9_0, var_1_10004(0, 0))

	return
end

function var_0_1.OnDestroy(arg_10_0)
	return
end

return var_0_1
