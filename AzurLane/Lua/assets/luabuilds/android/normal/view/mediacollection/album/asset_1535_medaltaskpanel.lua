class = var_0_10000

local var_0_0 = var_0_10000("MedalTaskPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._parent = arg_1_2
	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	findTF = var_3
	arg_1_0._mask = var_3(arg_1_0._tf, "mask")
	findTF = var_3
	arg_1_0._backBtn = var_3(arg_1_0._tf, "btnBack")
	UIItemList = var_3

	local var_1_0 = var_3.New

	findTF = var_4

	local var_1_1 = var_4(arg_1_0._tf, "panel/list")

	findTF = var_5
	arg_1_0.UIlist = var_1_0(var_1_1, var_5(arg_1_0._tf, "panel/list/Tasktpl"))
	onButton = var_3

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0._mask

	local function var_1_4()
		if arg_1_0._parent.TASK_CLOSE_ANIM and arg_1_0._parent.TASK_CLOSE_ANIM_Time then
			quickPlayAnimation = var_0

			var_0(arg_1_0._go, arg_1_0._parent.TASK_CLOSE_ANIM)

			onDelayTick = var_0

			var_0(function()
				local var_3_0 = arg_1_0

				var_0.SetActive(var_3_0, false)

				return
			end, arg_1_0._parent.TASK_CLOSE_ANIM_Time)
		else
			local var_2_0 = arg_1_0

			var_0.SetActive(var_2_0, false)
		end

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_2, var_1_3, var_1_4, var_7)

	onButton = var_3

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0._backBtn

	local function var_1_7()
		if arg_1_0._parent.TASK_CLOSE_ANIM and arg_1_0._parent.TASK_CLOSE_ANIM_Time then
			quickPlayAnimation = var_0

			var_0(arg_1_0._go, arg_1_0._parent.TASK_CLOSE_ANIM)

			onDelayTick = var_0

			var_0(function()
				local var_5_0 = arg_1_0

				var_0.SetActive(var_5_0, false)

				return
			end, arg_1_0._parent.TASK_CLOSE_ANIM_Time)
		else
			local var_4_0 = arg_1_0

			var_0.SetActive(var_4_0, false)
		end

		return
	end

	SFX_CANCEL = var_7

	var_3(var_1_5, var_1_6, var_1_7, var_7)

	return
end

function var_0_0.SetMedalGroup(arg_6_0, arg_6_1)
	arg_6_0._medalGroup = arg_6_1
	arg_6_0._taskList = {}

	local var_6_0 = arg_6_0._medalGroup
	local var_6_1 = var_2.GetMedalGroupActivityConfig(var_6_0)[3]

	ipairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_1) do
		getProxy = var_1_10008
		TaskProxy = var_1_10009
		var_1_10009 = var_1_10008(var_1_10009)

		if not var_1_10008.getTaskById(var_1_10009, iter_6_1) then
			getProxy = var_1_10009
			TaskProxy = var_10

			local var_6_2 = var_1_10009(var_10)

			var_1_10008 = var_1_10009.getFinishTaskById(var_6_2, iter_6_1)
		end

		table = var_1_10009

		var_1_10009.insert(arg_6_0._taskList, var_1_10008)
	end

	return
end

function var_0_0.ShowMedalTask(arg_7_0)
	Canvas = var_1_10001

	var_1_10001.ForceUpdateCanvases()
	arg_7_0:sort(arg_7_0._taskList)
	arg_7_0:UpdateList(arg_7_0._taskList)

	return
end

function var_0_0.getTaskProgress(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getProgress(var_8_0)

	tostring = var_8_0

	local var_8_2 = var_8_0(arg_8_1:getProgress())
end

function var_0_0.getTaskTarget(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getConfig(var_9_0, "target_num")

	tostring = var_9_0

	local var_9_2 = var_9_0(arg_9_1:getConfig("target_num"))
end

function var_0_0.UpdateList(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.UIlist

	var_2.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_1[arg_11_1 + 1]
			local var_11_1 = arg_11_2:Find("frame/slider")
			local var_11_2 = var_4.GetComponent

			typeof = var_6
			Slider = var_2_10007

			local var_11_3 = var_11_2(var_11_1, var_6(var_2_10007))
			local var_11_4 = arg_11_2:Find("frame/progress")
			local var_11_5 = arg_11_2:Find("frame/progress_1")
			local var_11_6 = arg_11_2:Find("frame/awards")
			local var_11_7 = arg_11_2:Find("frame/desc")
			local var_11_8 = arg_11_2:Find("frame/get_btn")
			local var_11_9 = arg_11_2:Find("frame/got_btn")
			local var_11_10 = arg_11_2
			local var_11_11 = arg_11_2.Find(var_11_10, "frame/go_btn")

			setText = var_11_10

			var_11_10(var_11_7, var_11_0:getConfig("desc"))

			local var_11_12 = arg_10_0
			local var_11_13, var_11_14 = var_12.getTaskProgress(var_11_12, var_11_0)
			local var_11_15 = arg_10_0
			local var_11_16, var_11_17 = var_14.getTaskTarget(var_11_15, var_11_0)

			var_11_3.value = var_11_13 / var_11_16
			setText = var_16

			var_16(var_11_4, var_11_14)

			setText = var_16

			var_16(var_11_5, "/" .. var_11_17)

			local var_11_18 = var_11_6:GetChild(0)
			local var_11_19 = arg_10_0

			var_17.updateAwards(var_11_19, var_11_0:getConfig("award_display"), var_11_6, var_11_18)

			setActive = var_17

			var_17(var_11_9, var_11_0:getTaskStatus() == 2)

			setActive = var_17

			var_17(var_11_8, var_11_0:getTaskStatus() == 1)

			setActive = var_17

			var_17(var_11_11, var_11_0:getTaskStatus() == 0)

			onButton = var_17

			local var_11_20 = arg_10_0
			local var_11_21 = var_11_11

			local function var_11_22()
				local var_12_0 = arg_10_0._parent
				local var_12_1 = var_0.emit

				MedalAlbumTemplateMediator = var_3_10002

				var_12_1(var_12_0, var_3_10002.ON_TASK_GO, var_11_0)

				return
			end

			SFX_PANEL = var_21

			var_17(var_11_20, var_11_21, var_11_22, var_21)

			onButton = var_17

			local var_11_23 = arg_10_0
			local var_11_24 = var_11_8

			local function var_11_25()
				local var_13_0 = arg_10_0._parent
				local var_13_1 = var_0.emit

				MedalAlbumTemplateMediator = var_3_10002

				var_13_1(var_13_0, var_3_10002.ON_TASK_SUBMIT, var_11_0)

				return
			end

			SFX_PANEL = var_21

			var_17(var_11_23, var_11_24, var_11_25, var_21)
		end

		return
	end)

	local var_10_1 = arg_10_0.UIlist

	var_2.align(var_10_1, #arg_10_1)

	if arg_10_0._parent.TASK_ANIM and arg_10_0._parent.TASK_ENTER_ANIM_Time and arg_10_0._parent.TASK_Time then
		findTF = var_2

		local var_10_2 = var_2(arg_10_0._tf, "panel/list").transform.childCount

		onDelayTick = var_3

		var_3(function()
			for iter_14_0 = 0, var_10_2 - 1 do
				findTF = var_2_10004

				local var_14_0 = var_2_10004(arg_10_0._tf, "panel/list")

				var_2_10004 = var_2_10004.GetChild(var_14_0, iter_14_0)
				onDelayTick = var_14_0

				var_14_0(function()
					if arg_10_0._parent.exited then
						return
					end

					quickPlayAnimation = var_0

					var_0(var_2_10004, arg_10_0._parent.TASK_ANIM)

					return
				end, arg_10_0._parent.TASK_Time * (iter_14_0 + 1))
			end

			return
		end, arg_10_0._parent.TASK_ENTER_ANIM_Time)
	end

	return
end

function var_0_0.updateAwards(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	_ = var_1_10004

	local var_16_0 = var_1_10004.slice(arg_16_1, 1, 3)

	for iter_16_0 = arg_16_2.childCount, #var_16_0 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_16_3, arg_16_2)
	end

	local var_16_1 = arg_16_2.childCount

	for iter_16_1 = 1, var_16_1 do
		local var_16_2 = arg_16_2:GetChild(iter_16_1 - 1)
		local var_16_3 = iter_16_1 <= #var_16_0

		setActive = var_12

		var_12(var_16_2, var_16_3)

		if var_16_3 then
			local var_16_4 = var_16_0[iter_16_1]
			local var_16_5 = {
				type = var_16_4[1],
				id = var_16_4[2],
				count = var_16_4[3]
			}

			updateDrop = var_14
			findTF = var_1_10015

			var_14(var_1_10015(var_16_2, "mask"), var_16_5)

			local var_16_6 = var_16_5.type

			DROP_TYPE_EQUIPMENT_SKIN = var_1_10015

			if var_16_6 == var_1_10015 then
				setActive = var_16_6
				findTF = var_1_10015

				var_16_6(var_1_10015(var_16_2, "specialFrame"), true)
			else
				setActive = var_16_6
				findTF = var_1_10015

				var_16_6(var_1_10015(var_16_2, "specialFrame"), false)
			end

			onButton = var_16_6
			var_1_10015 = arg_16_0

			local var_16_7 = var_16_2

			local function var_16_8()
				local var_17_0 = arg_16_0._parent
				local var_17_1 = var_0.emit

				BaseUI = var_2_10002

				var_17_1(var_17_0, var_2_10002.ON_DROP, var_16_5)

				return
			end

			SFX_PANEL = var_1_10018

			var_16_6(var_1_10015, var_16_7, var_16_8, var_1_10018)

			setActive = var_16_6
			findTF = var_1_10015
			var_1_10015 = var_1_10015(var_16_2, "got")
			Task = var_16

			var_16_6(var_1_10015, var_16.OwnSpAward(var_16_4))
		end
	end

	return
end

function var_0_0.sort(arg_18_0, arg_18_1)
	local var_18_0 = {}

	pairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(arg_18_1) do
		if iter_18_1:getTaskStatus() == 1 then
			table = var_8

			var_8.insert(var_18_0, iter_18_1)
		end
	end

	pairs = var_3

	for iter_18_2, iter_18_3 in var_3(arg_18_1) do
		if iter_18_3:getTaskStatus() == 0 then
			table = var_8

			var_8.insert(var_18_0, iter_18_3)
		end
	end

	pairs = var_3

	for iter_18_4, iter_18_5 in var_3(arg_18_1) do
		if iter_18_5:getTaskStatus() == 2 then
			table = var_8

			var_8.insert(var_18_0, iter_18_5)
		end
	end

	arg_18_0._taskList = var_18_0

	return
end

function var_0_0.SetActive(arg_19_0, arg_19_1)
	SetActive = var_1_10002

	var_1_10002(arg_19_0._go, arg_19_1)

	arg_19_0._active = arg_19_1

	if arg_19_1 then
		pg = var_1_10002

		local var_19_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_19_0, arg_19_0._go)
	else
		pg = var_1_10002

		local var_19_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_19_1, arg_19_0._go, arg_19_0._parent._tf)

		if arg_19_0._parent.TASK_ANIM and arg_19_0._parent.TASK_ENTER_ANIM_Time and arg_19_0._parent.TASK_Time then
			findTF = var_2

			local var_19_2 = var_2(arg_19_0._tf, "panel/list").transform.childCount

			for iter_19_0 = 0, var_19_2 - 1 do
				findTF = var_1_10007

				local var_19_3 = var_1_10007(arg_19_0._tf, "panel/list")

				var_1_10007 = var_1_10007.GetChild(var_19_3, iter_19_0)
				setCanvasGroupAlpha = var_19_3

				var_19_3(var_1_10007, 0)
			end
		end
	end

	return
end

function var_0_0.IsActive(arg_20_0)
	return arg_20_0._active
end

function var_0_0.Dispose(arg_21_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_21_0)

	return
end

return var_0_0
