class = var_0_10000

local var_0_0 = "ToLoveCollabMedalView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.MedalCollectionTemplateView"))

function var_0_1.getUIName(arg_1_0)
	return "ToLoveCollabMedalPage"
end

function var_0_1.init(arg_2_0)
	arg_2_0:FindUI()

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.FindUI(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "Top")
	local var_3_2 = arg_3_0._tf

	arg_3_0.bg = var_2.Find(var_3_2, "mask")
	arg_3_0.backBtn = var_3_1:Find("BackBtn")
	arg_3_0.slots = {}

	for iter_3_0 = 1, 6 do
		local var_3_3 = arg_3_0.slots
		local var_3_4 = {}
		local var_3_5 = arg_3_0._tf

		var_3_4.char = var_8.Find(var_3_5, "Desk/Slot" .. iter_3_0 .. "/Char")

		local var_3_6 = arg_3_0._tf

		var_3_4.selected = var_8.Find(var_3_6, "Desk/Slot" .. iter_3_0 .. "/Selected")

		local var_3_7 = arg_3_0._tf

		var_3_4.tips = var_8.Find(var_3_7, "Desk/Slot" .. iter_3_0 .. "/reddot")
		var_3_3[iter_3_0] = var_3_4
	end

	local var_3_8 = arg_3_0._tf

	arg_3_0.medalTF = var_2.Find(var_3_8, "Desk/trophy")

	local var_3_9 = arg_3_0._tf

	arg_3_0.syncBtn = var_2.Find(var_3_9, "Desk/syncBtn")

	local var_3_10 = arg_3_0._tf

	arg_3_0.task = var_2.Find(var_3_10, "Desk/task")

	local var_3_11 = arg_3_0.task

	arg_3_0.taskBGGo = var_2.Find(var_3_11, "bg_go")

	local var_3_12 = arg_3_0.task

	arg_3_0.taskBGGot = var_2.Find(var_3_12, "bg_got")

	local var_3_13 = arg_3_0.task

	arg_3_0.taskBtnGo = var_2.Find(var_3_13, "go_btn")

	local var_3_14 = arg_3_0.task

	arg_3_0.taskBtnGot = var_2.Find(var_3_14, "got_btn")

	local var_3_15 = arg_3_0.task

	arg_3_0.taskBtnGet = var_2.Find(var_3_15, "get_btn")

	local var_3_16 = arg_3_0.task

	arg_3_0.taskDesc = var_2.Find(var_3_16, "desc")

	local var_3_17 = arg_3_0.task

	arg_3_0.taskReward = var_2.Find(var_3_17, "award/mask")

	local var_3_18 = arg_3_0.task

	arg_3_0.taskRewardName = var_2.Find(var_3_18, "name")

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0.taskList, arg_4_0.dropInfoList = {}, {}

	local var_4_0 = arg_4_0.activityData
	local var_4_1 = var_1.getConfig(var_4_0, "config_client").item_task

	for iter_4_0 = 1, 6 do
		local var_4_2 = arg_4_0.taskList

		Task = var_1_10007
		var_4_2[iter_4_0] = var_1_10007.New({
			id = var_4_1[iter_4_0][2]
		})

		local var_4_3 = arg_4_0.dropInfoList

		var_1_10007 = {}
		DROP_TYPE_VITEM = var_1_10008
		var_1_10007.type = var_1_10008
		var_1_10007.id = var_4_1[iter_4_0][1]
		var_4_3[iter_4_0] = var_1_10007
	end

	arg_4_0:AddListener()

	local var_4_4 = arg_4_0.contextData
	local var_4_5

	if not arg_4_0.contextData.ChipIndex then
		var_4_5 = 1
	end

	var_4_4.ChipIndex = var_4_5

	arg_4_0:UpdateView()

	pg = var_2

	local var_4_6 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_4_6, arg_4_0._tf)

	return
end

function var_0_1.AddListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.backBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.taskBtnGet

	local function var_5_5()
		local var_7_0 = arg_5_0.allIDList[arg_5_0.contextData.ChipIndex]

		table = var_1

		local var_7_1

		if not var_1.contains(arg_5_0.activeIDList, var_7_0) then
			table = var_2_10002
			var_7_1 = var_2_10002.contains(arg_5_0.activatableIDList, var_7_0)
		else
			var_7_1 = false
		end

		if false then
			var_7_1 = true
		end

		if var_7_1 then
			local var_7_2 = arg_5_0
			local var_7_3 = var_3.emit

			MedalCollectionTemplateMediator = var_2_10006

			var_7_3(var_7_2, var_2_10006.MEMORYBOOK_UNLOCK, {
				id = var_7_0,
				actId = arg_5_0.activityData.id
			})
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.taskBtnGo

	local function var_5_8()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_8_0 = var_2_10000(var_2_10002)
		local var_8_1 = var_0.getActivityById

		ActivityConst = var_2_10003

		if var_8_1(var_8_0, var_2_10003.TOLOVE_TASK_ID) and not var_0:isEnd() then
			var_2_10001 = arg_5_0.taskList[arg_5_0.contextData.ChipIndex]
			var_2_10004 = arg_5_0

			local var_8_2 = var_2.emit

			MedalCollectionTemplateMediator = var_2_10005

			var_8_2(var_2_10004, var_2_10005.MEMORYBOOK_GO, var_2_10001)
		else
			pg = var_2_10001

			local var_8_3 = var_2_10001.TipsMgr.GetInstance()
			local var_8_4 = var_1.ShowTips

			i18n = var_2_10004

			var_8_4(var_8_3, var_2_10004("common_activity_end"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10006)

	for iter_5_0 = 1, 6 do
		onButton = var_5_8

		local var_5_9 = arg_5_0
		local var_5_10 = arg_5_0._tf
		local var_5_11 = var_8.Find(var_5_10, "Desk/Slot" .. iter_5_0 .. "/Click")

		local function var_5_12()
			arg_5_0.contextData.ChipIndex = iter_5_0

			local var_9_0 = arg_5_0

			var_0.UpdateView(var_9_0)

			return
		end

		SFX_PANEL = var_5_10

		var_5_8(var_5_9, var_5_11, var_5_12, var_5_10)
	end

	onButton = var_1

	local var_5_13 = arg_5_0
	local var_5_14 = arg_5_0.syncBtn

	local function var_5_15()
		local var_10_0 = arg_5_0

		var_0.CheckAward(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_13, var_5_14, var_5_15, var_1_10006)

	onButton = var_1

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.bg

	local function var_5_18()
		local var_11_0 = arg_5_0

		var_0.closeView(var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_16, var_5_17, var_5_18, var_1_10006)

	return
end

function var_0_1.UpdateAfterSubmit(arg_12_0, arg_12_1)
	arg_12_0:UpdateView()

	return
end

function var_0_1.UpdateAfterFinalMedal(arg_13_0)
	var_0_1.super.UpdateAfterFinalMedal(arg_13_0)
	arg_13_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_14_0)
	for iter_14_0 = 1, 6 do
		local var_14_0 = 0
		local var_14_1 = false

		for iter_14_1 = 1, #arg_14_0.slots do
			table = var_1_10011
			var_1_10011 = var_1_10011.contains(arg_14_0.activeIDList, arg_14_0.allIDList[iter_14_1])
			setActive = var_1_10012

			var_1_10012(arg_14_0.slots[iter_14_1].char, var_1_10011)

			setActive = var_1_10012

			local var_14_2 = arg_14_0.slots[iter_14_1].tips

			table = var_15

			local var_14_3

			if var_15.contains(arg_14_0.activatableIDList, arg_14_0.allIDList[iter_14_1]) then
				var_14_3 = not var_1_10011
			end

			var_1_10012(var_14_2, var_14_3)
		end

		setActive = var_7

		var_7(arg_14_0.slots[iter_14_0].selected, iter_14_0 == arg_14_0.contextData.ChipIndex)
	end

	local var_14_4 = #arg_14_0.activeIDList == #arg_14_0.allIDList and arg_14_0.activityData.data1 == 1

	setActive = var_3

	local var_14_5 = arg_14_0.medalTF

	var_3(var_5.Find(var_14_5, "Lock"), not var_14_4)

	setActive = var_3

	local var_14_6 = arg_14_0.medalTF

	var_3(var_5.Find(var_14_6, "Unlock"), var_14_4)

	setActive = var_3

	local var_14_7 = arg_14_0.syncBtn

	var_3(var_5.Find(var_14_7, "notSync"), not var_1)

	setActive = var_3

	local var_14_8 = arg_14_0.syncBtn

	var_3(var_5.Find(var_14_8, "synced"), var_14_4)

	local var_14_9 = arg_14_0.syncBtn
	local var_14_10 = var_3.GetComponent

	typeof = var_6
	Image = var_8

	local var_14_11 = var_14_10(var_14_9, var_6(var_8))

	var_14_11.enabled = var_1 and not var_14_4
	setActive = var_14_11

	local var_14_12 = arg_14_0.syncBtn

	var_14_11(var_5.Find(var_14_12, "reddot"), var_1 and not var_14_4)
	arg_14_0:UpdateInfo()

	return
end

function var_0_1.UpdateInfo(arg_15_0)
	local var_15_0 = arg_15_0.allIDList[arg_15_0.contextData.ChipIndex]

	table = var_2

	local var_15_1

	if not var_2.contains(arg_15_0.activeIDList, var_15_0) then
		table = var_1_10003
		var_15_1 = var_1_10003.contains(arg_15_0.activatableIDList, var_15_0)
	else
		var_15_1 = false
	end

	if false then
		var_15_1 = true
	end

	setActive = var_4

	var_4(arg_15_0.taskBGGo, not var_2)

	setActive = var_4

	var_4(arg_15_0.taskBGGot, var_2)

	setActive = var_4

	var_4(arg_15_0.taskBtnGot, var_2)

	setActive = var_4

	var_4(arg_15_0.taskBtnGet, var_15_1)

	setActive = var_4

	var_4(arg_15_0.taskBtnGo, not var_15_1)

	setText = var_4

	local var_15_2 = arg_15_0.taskDesc
	local var_15_3 = arg_15_0.taskList[arg_15_0.contextData.ChipIndex]

	var_4(var_15_2, var_7.getConfig(var_15_3, "desc"))

	updateDrop = var_4

	var_4(arg_15_0.taskReward, arg_15_0.dropInfoList[arg_15_0.contextData.ChipIndex])

	setText = var_4

	local var_15_4 = arg_15_0.taskRewardName

	pg = var_7

	var_4(var_15_4, var_7.item_virtual_data_statistics[arg_15_0.dropInfoList[arg_15_0.contextData.ChipIndex].id].name)

	return
end

function var_0_1.willExit(arg_16_0)
	local var_16_0 = arg_16_0.loader

	var_1.Clear(var_16_0)

	return
end

return var_0_1
