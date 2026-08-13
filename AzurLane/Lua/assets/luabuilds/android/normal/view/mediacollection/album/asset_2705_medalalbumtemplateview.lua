class = var_0_10000

local var_0_0 = "StarLightMedalAlbumView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.ICON_SCALE = 1.35
var_0_1.MEDAL_COUNT = 8

function var_0_1.SetMedalGroupData(arg_1_0, arg_1_1)
	arg_1_0.medalGroupList = arg_1_1

	local var_1_0

	if not arg_1_0.medalGroupList[arg_1_0.GROUP_ID] then
		ActivityMedalGroup = var_1_0
		var_1_0 = var_1_0.New(arg_1_0.GROUP_ID)
	end

	arg_1_0.currentMedalGroup = var_1_0

	local var_1_1 = arg_1_0.currentMedalGroup
	local var_1_2 = var_2.GetMedalGroupState(var_1_1)

	ActivityMedalGroup = var_1_1

	if var_1_2 == var_1_1.STATE_ACTIVE then
		local var_1_3 = arg_1_0.medalTaskView

		var_2.SetMedalGroup(var_1_3, arg_1_0.currentMedalGroup)
	end

	local var_1_4 = arg_1_0.medalDetailView

	var_2.SetMedalGroup(var_1_4, arg_1_0.currentMedalGroup)

	local var_1_5 = arg_1_0.currentMedalGroup
	local var_1_6 = var_2.GetMedalIds(var_1_5)

	for iter_1_0 = 1, arg_1_0.MEDAL_COUNT do
		local var_1_7 = var_1_6[iter_1_0]

		LoadImageSpriteAsync = var_1_10008

		var_1_10008("activitymedal/" .. var_1_7 .. "_l", arg_1_0.slots[iter_1_0].slot, true)

		LoadImageSpriteAsync = var_1_10008

		var_1_10008("activitymedal/" .. var_1_7, arg_1_0.slots[iter_1_0].active, true)
	end

	return
end

function var_0_1.ShowPageBtn(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0.prevBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_2_0.nextBtn, false)

	return
end

function var_0_1.UpdateMedalList(arg_3_0)
	return
end

function var_0_1.init(arg_4_0)
	arg_4_0:FindUI()

	AutoLoader = var_1
	arg_4_0.loader = var_1.New()

	return
end

function var_0_1.FindUI(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.Find(var_5_0, "Top")
	local var_5_2 = arg_5_0._tf

	arg_5_0.bg = var_2.Find(var_5_2, "mask")
	arg_5_0.backBtn = var_5_1:Find("BackBtn")
	arg_5_0.helpBtn = var_5_1:Find("InfoBtn")

	local var_5_3 = arg_5_0._tf

	arg_5_0.taskBtn = var_2.Find(var_5_3, "Desk/taskBtn")

	local var_5_4 = arg_5_0._tf

	arg_5_0.prevBtn = var_2.Find(var_5_4, "Desk/prevBtn")

	local var_5_5 = arg_5_0._tf

	arg_5_0.nextBtn = var_2.Find(var_5_5, "Desk/nextBtn")
	arg_5_0.slots = {}

	for iter_5_0 = 1, arg_5_0.MEDAL_COUNT do
		local var_5_6 = arg_5_0.slots
		local var_5_7 = {}
		local var_5_8 = arg_5_0._tf

		var_5_7.slot = var_8.Find(var_5_8, "Desk/Slot" .. iter_5_0)

		local var_5_9 = arg_5_0._tf

		var_5_7.active = var_8.Find(var_5_9, "Desk/Slot" .. iter_5_0 .. "/active")

		local var_5_10 = arg_5_0._tf

		var_5_7.tips = var_8.Find(var_5_10, "Desk/Slot" .. iter_5_0 .. "/reddot")

		local var_5_11 = arg_5_0._tf

		var_5_7.click = var_8.Find(var_5_11, "Desk/Slot" .. iter_5_0 .. "/Click")
		var_5_6[iter_5_0] = var_5_7
	end

	local var_5_12 = arg_5_0._tf

	arg_5_0.medalLock = var_2.Find(var_5_12, "Desk/medal")

	local var_5_13 = arg_5_0._tf

	arg_5_0.trophyLock = var_2.Find(var_5_13, "Desk/trophy")
	MedalDetailPanel = var_2

	local var_5_14 = var_2.New
	local var_5_15 = arg_5_0._tf

	arg_5_0.medalDetailView = var_5_14(var_3.Find(var_5_15, "DetailView"), arg_5_0)

	local var_5_16 = arg_5_0.medalDetailView

	var_2.SetIconScale(var_5_16, arg_5_0.ICON_SCALE)

	MedalTaskPanel = var_2

	local var_5_17 = var_2.New
	local var_5_18 = arg_5_0._tf

	arg_5_0.medalTaskView = var_5_17(var_3.Find(var_5_18, "TaskView"), arg_5_0)

	return
end

function var_0_1.didEnter(arg_6_0)
	var_0_1.super.didEnter(arg_6_0)
	arg_6_0:AddListener()
	arg_6_0:UpdateView()

	pg = var_1

	local var_6_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_6_0, arg_6_0._tf)

	return
end

function var_0_1.AddListener(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.backBtn

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	for iter_7_0 = 1, arg_7_0.MEDAL_COUNT do
		onButton = var_1_10005

		var_1_10005(arg_7_0, arg_7_0.slots[iter_7_0].click, function()
			local var_9_0 = arg_7_0

			var_0.showMedalView(var_9_0, iter_7_0)

			return
		end)
	end

	onButton = var_1

	var_1(arg_7_0, arg_7_0.taskBtn, function()
		local var_10_0 = arg_7_0

		var_0.showTaskView(var_10_0)

		return
	end)

	onButton = var_1

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.bg

	local function var_7_5()
		local var_11_0 = arg_7_0

		var_0.closeView(var_11_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1

	var_1(arg_7_0, arg_7_0.helpBtn, function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_12_2.type = var_2_10003
		pg = var_2_10003
		var_12_2.helps = var_2_10003.gametip[arg_7_0.HELP_TIPS].tip

		var_12_1(var_12_0, var_12_2)

		return
	end)

	onButton = var_1

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.medalLock

	local function var_7_8()
		local var_13_0 = arg_7_0.currentMedalGroup
		local var_13_1 = var_0.getConfig(var_13_0, "item_show")[2]
		local var_13_2 = {
			type = var_13_1[1],
			id = var_13_1[2],
			count = var_13_1[3]
		}
		local var_13_3 = arg_7_0
		local var_13_4 = var_2.emit

		BaseUI = var_2_10004

		var_13_4(var_13_3, var_2_10004.ON_DROP, var_13_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_6, var_7_7, var_7_8, var_1_10005)

	if arg_7_0.trophyLock then
		onButton = var_1

		local var_7_9 = arg_7_0
		local var_7_10 = arg_7_0.trophyLock

		local function var_7_11()
			local var_14_0 = arg_7_0.currentMedalGroup
			local var_14_1 = var_0.getConfig(var_14_0, "item_show")[1]
			local var_14_2 = {
				type = var_14_1[1],
				id = var_14_1[2],
				count = var_14_1[3]
			}
			local var_14_3 = arg_7_0
			local var_14_4 = var_2.emit

			BaseUI = var_2_10004

			var_14_4(var_14_3, var_2_10004.ON_DROP, var_14_2)

			return
		end

		SFX_PANEL = var_1_10005

		var_1(var_7_9, var_7_10, var_7_11, var_1_10005)
	end

	return
end

function var_0_1.showMedalView(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.medalDetailView

	var_2.SetCurrentIndex(var_15_0, arg_15_1)

	local var_15_1 = arg_15_0.medalDetailView

	var_2.UpdateMedal(var_15_1)

	local var_15_2 = arg_15_0.medalDetailView

	var_2.SetActive(var_15_2, true)

	return
end

function var_0_1.showTaskView(arg_16_0)
	local var_16_0 = arg_16_0.medalTaskView

	var_1.ShowMedalTask(var_16_0)

	local var_16_1 = arg_16_0.medalTaskView

	var_1.SetActive(var_16_1, true)

	return
end

function var_0_1.UpdateView(arg_17_0)
	local var_17_0 = arg_17_0.currentMedalGroup
	local var_17_1 = var_1.GetMedalIds(var_17_0)
	local var_17_2 = arg_17_0.currentMedalGroup
	local var_17_3 = var_2.GetMedalList(var_17_2)

	for iter_17_0 = 1, arg_17_0.MEDAL_COUNT do
		local var_17_4 = var_17_1[iter_17_0]
		local var_17_5 = arg_17_0.slots[iter_17_0]

		if var_17_3[var_17_4].timeStamp then
			setActive = var_9

			var_9(var_17_5.active, true)
		else
			setActive = var_9

			var_9(var_17_5.active, false)
		end
	end

	local var_17_9

	if arg_17_0.trophyLock then
		local var_17_6 = arg_17_0.trophyLock
		local var_17_7 = var_3.GetComponent

		typeof = var_17_9
		Image = iter_17_0

		local var_17_8 = var_17_7(var_17_6, var_17_9(iter_17_0))

		var_17_9 = arg_17_0
		var_17_8.enabled = not arg_17_0.OwnTrophy(var_17_9)
	end

	local var_17_10 = arg_17_0.medalLock
	local var_17_11 = var_3.GetComponent

	typeof = var_17_9
	Image = iter_17_0

	local var_17_12 = var_17_11(var_17_10, var_17_9(iter_17_0))

	var_17_12.enabled = not arg_17_0:OwnMedal()
	setActive = var_17_12

	local var_17_13 = arg_17_0.taskBtn
	local var_17_14 = arg_17_0.currentMedalGroup
	local var_17_15 = var_5.GetMedalGroupState(var_17_14)

	ActivityMedalGroup = var_17_14

	var_17_12(var_17_13, var_17_15 == var_17_14.STATE_ACTIVE)

	return
end

function var_0_1.OwnTrophy(arg_18_0)
	local var_18_0 = arg_18_0.currentMedalGroup
	local var_18_1 = var_1.getConfig(var_18_0, "task_show")
	local var_18_2 = -1

	if var_18_1 then
		type = var_3

		if var_3(var_18_1) == "table" then
			var_18_2 = var_18_1[1]
		end
	end

	if var_18_2 <= 0 then
		return false
	end

	pg = var_3

	local var_18_3 = var_3.task_data_template[var_18_2].award_display[1]

	Task = var_1_10004

	return var_1_10004.OwnSpAward(var_18_3)
end

function var_0_1.OwnMedal(arg_19_0)
	local var_19_0 = arg_19_0.currentMedalGroup
	local var_19_1 = var_1.getConfig(var_19_0, "task_show")
	local var_19_2 = -1

	if var_19_1 then
		type = var_3

		if var_3(var_19_1) == "table" then
			var_19_2 = var_19_1[2]
		end
	end

	if var_19_2 <= 0 then
		return false
	end

	pg = var_3

	local var_19_3 = var_3[#var_3.task_data_template[var_19_2].award_display]

	Task = var_1_10005

	return var_1_10005.OwnSpAward(var_19_3)
end

function var_0_1.FlushTaskPanel(arg_20_0)
	local var_20_0 = arg_20_0.medalTaskView

	var_1.SetMedalGroup(var_20_0, arg_20_0.currentMedalGroup)

	local var_20_1 = arg_20_0.medalTaskView

	var_1.ShowMedalTask(var_20_1)

	return
end

function var_0_1.willExit(arg_21_0)
	local var_21_0 = arg_21_0.medalDetailView

	var_1.SetActive(var_21_0, false)

	local var_21_1 = arg_21_0.medalTaskView

	var_1.SetActive(var_21_1, false)

	local var_21_2 = arg_21_0.medalDetailView

	var_1.Dispose(var_21_2)

	local var_21_3 = arg_21_0.medalTaskView

	var_1.Dispose(var_21_3)

	pg = var_1

	local var_21_4 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_4, arg_21_0._tf)

	local var_21_5 = arg_21_0.loader

	var_1.Clear(var_21_5)

	return
end

return var_0_1
