class = var_0_10000

local var_0_0 = "HololiveMedalCollectionView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "HololiveMedalCollectionUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:InitData()
	arg_2_0:FindUI()
	arg_2_0:AddListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:UpdateView()

	return
end

function var_0_1.InitData(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)

	getProxy = var_1_10002
	TaskProxy = var_1_10003
	arg_4_0.taskProxy = var_1_10002(var_1_10003)

	local var_4_1 = var_4_0
	local var_4_2 = var_4_0.getActivityById

	ActivityConst = var_1_10004
	arg_4_0.actMedal = var_4_2(var_4_1, var_1_10004.HOLOLIVE_MEDAL_COLLECTION)

	local var_4_3 = arg_4_0.actMedal

	arg_4_0.allIDList = var_2.getConfig(var_4_3, "config_data")
	pg = var_2

	local var_4_4 = var_2.activity_template

	ActivityConst = var_4_3
	arg_4_0.taskGroup = var_4_4[var_4_3.HOLOLIVE_MEDAL_COLLECTION_TASK].config_data
	arg_4_0.activatableIDList = arg_4_0.actMedal.data1_list
	arg_4_0.activeIDList = arg_4_0.actMedal.data2_list

	return
end

local var_0_2 = {
	"mio",
	"fubuki",
	"matsuri",
	"sora",
	"shion",
	"aqua",
	"ayame",
	"purer",
	"tnt"
}
local var_0_3 = {
	1,
	2,
	3,
	6,
	9,
	8,
	7,
	4,
	5
}

function var_0_1.FindUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.bg = var_1.Find(var_5_0, "bg")

	local var_5_1 = arg_5_0._tf

	arg_5_0.top = var_1.Find(var_5_1, "top")

	local var_5_2 = arg_5_0.top

	arg_5_0.backBtn = var_1.Find(var_5_2, "back")

	local var_5_3 = arg_5_0.top

	arg_5_0.helpBtn = var_1.Find(var_5_3, "help")

	local var_5_4 = arg_5_0._tf

	arg_5_0.progressText = var_1.Find(var_5_4, "middle/board/progress")

	local var_5_5 = arg_5_0._tf

	arg_5_0.taskScroll = var_1.Find(var_5_5, "middle/board/Scroll View")

	local var_5_6 = arg_5_0._tf

	arg_5_0.taskScrollBar = var_1.Find(var_5_6, "middle/board/Scrollbar")
	CustomIndexLayer = var_1

	local var_5_7 = var_1.Clone2Full
	local var_5_8 = arg_5_0.taskScroll

	arg_5_0.taskListItems = var_5_7(var_2.Find(var_5_8, "Content"), #arg_5_0.taskGroup)
	CustomIndexLayer = var_1

	local var_5_9 = var_1.Clone2Full
	local var_5_10 = arg_5_0._tf

	arg_5_0.medalListItems = var_5_9(var_2.Find(var_5_10, "middle/console/grid"), 9)

	local var_5_11 = arg_5_0._tf
	local var_5_12 = var_1.Find(var_5_11, "middle/console/slot")
	local var_5_13 = var_1.GetComponent

	typeof = var_3
	Image = var_4
	arg_5_0.medalImg = var_5_13(var_5_12, var_3(var_4))

	local var_5_14 = arg_5_0._tf

	arg_5_0.medalGet = var_1.Find(var_5_14, "middle/console/get")

	local var_5_15 = arg_5_0._tf

	arg_5_0.medalGot = var_1.Find(var_5_15, "middle/console/got")

	for iter_5_0 = 1, #arg_5_0.taskGroup do
		LoadSprite = var_1_10005
		var_1_10005 = var_1_10005("ui/HololiveMedalCollectionUI_atlas", var_0_2[iter_5_0])

		local var_5_16 = arg_5_0.taskListItems[iter_5_0]
		local var_5_17 = var_6.Find(var_5_16, "icon")
		local var_5_18 = var_6.GetComponent

		typeof = var_8
		Image = var_1_10009

		local var_5_19 = var_5_18(var_5_17, var_8(var_1_10009))

		var_5_19.sprite = var_1_10005
		var_5_19.enabled = true

		local var_5_20 = arg_5_0.medalListItems[var_0_3[iter_5_0]]
		local var_5_21 = var_7.Find(var_5_20, "icon")
		local var_5_22 = var_7.GetComponent

		typeof = var_1_10009
		Image = var_1_10010

		local var_5_23 = var_5_22(var_5_21, var_1_10009(var_1_10010))

		var_5_23.sprite = var_1_10005
		var_5_23.enabled = true
	end

	LoadAny = var_1
	arg_5_0.materialGray = var_1("ui/HololiveMedalCollectionUI_atlas", "gray.mat")

	return
end

function var_0_1.AddListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.backBtn

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.helpBtn

	local function var_6_5()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		pg = var_2_10003
		var_8_2.helps = var_2_10003.gametip.hololive_dalaozhang.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	local var_6_6 = arg_6_0._tf
	local var_6_7 = var_1.Find(var_6_6, "middle/board/arrow")

	onScroll = var_6_6

	var_6_6(arg_6_0, arg_6_0.taskScroll, function(arg_9_0)
		setActive = var_2_10001

		var_2_10001(var_6_7, arg_9_0.y > 0.001)

		return
	end)

	onButton = var_6_6

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.medalGet

	local function var_6_10()
		local var_10_0 = arg_6_0

		var_0.GetFinal(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_6_6(var_6_8, var_6_9, var_6_10, var_1_10006)

	return
end

function var_0_1.DataSetting(arg_11_0)
	if #arg_11_0.activatableIDList > 0 then
		local var_11_0 = 1
		local var_11_1

		::label_11_0::

		local var_11_2 = #arg_11_0.activatableIDList

		if 1 <= var_11_2 then
			repeat
				var_11_2 = arg_11_0.activatableIDList[var_11_0]
				table = var_4

				if not var_4.contains(arg_11_0.activeIDList, var_11_2) then
					var_11_1 = var_11_2

					break
				end

				var_11_0 = var_11_0 + 1

				goto label_11_0
			until true
		end

		if var_11_1 then
			pg = var_11_2

			local var_11_3 = var_11_2.m02
			local var_11_4 = var_3.sendNotification

			GAME = var_1_10005

			local var_11_5 = var_1_10005.MEMORYBOOK_UNLOCK
			local var_11_6 = {
				id = var_11_1
			}

			ActivityConst = var_1_10007
			var_11_6.actId = var_1_10007.HOLOLIVE_MEDAL_COLLECTION

			var_11_4(var_11_3, var_11_5, var_11_6)

			return true
		end
	end

	return
end

function var_0_1.UpdateView(arg_12_0)
	arg_12_0:InitData()

	if arg_12_0:DataSetting() then
		return
	end

	local var_12_0 = #arg_12_0.activeIDList == #arg_12_0.allIDList and arg_12_0.actMedal.data1 ~= 1
	local var_12_1 = arg_12_0.actMedal.data1 == 1
	local var_12_2 = 0

	for iter_12_0 = 1, #arg_12_0.taskGroup do
		local var_12_3 = arg_12_0.taskListItems[iter_12_0]
		local var_12_4 = arg_12_0.taskGroup[iter_12_0]
		local var_12_5 = arg_12_0.taskProxy
		local var_12_6 = var_10.getTaskVO(var_12_5, var_12_4)
		local var_12_7 = var_12_3:Find("btn_go")
		local var_12_8 = var_12_3:Find("btn_get")
		local var_12_9 = var_12_3
		local var_12_10 = var_12_3.Find(var_12_9, "btn_got")

		table = var_12_9

		local var_12_11 = var_12_9.contains(arg_12_0.activeIDList, arg_12_0.allIDList[iter_12_0])
		local var_12_12
		local var_12_13 = 0

		if var_12_6 then
			var_1_10017 = var_12_6:getProgress()
			var_1_10019 = var_12_6

			local var_12_14 = var_12_6.getConfig(var_1_10019, "target_num")

			var_1_10020 = var_12_6
			var_1_10019 = var_12_6.getConfig(var_1_10020, "desc")
			string = var_1_10020
			var_1_10019 = var_1_10020.gsub(var_1_10019, "$1", var_1_10017)
			string = var_1_10020
			var_1_10019 = var_1_10020.gsub(var_1_10019, "$2", var_12_14)
			setText = var_1_10020

			var_1_10020(var_12_3:Find("desc"), var_1_10019)

			var_1_10021 = var_12_6
			var_12_12 = var_12_6.getTaskStatus(var_1_10021) == 2 and arg_12_0.materialGray or nil
			onButton = var_1_10020
			var_1_10021 = arg_12_0

			local var_12_15 = var_12_7

			local function var_12_16()
				local var_13_0 = arg_12_0
				local var_13_1 = var_0.emit

				ActivityMediator = var_2_10002

				var_13_1(var_13_0, var_2_10002.ON_TASK_GO, var_12_6)

				return
			end

			SFX_PANEL = var_1_10024

			var_1_10020(var_1_10021, var_12_15, var_12_16, var_1_10024)

			onButton = var_1_10020
			var_1_10021 = arg_12_0

			local var_12_17 = var_12_8

			local function var_12_18()
				local var_14_0 = arg_12_0
				local var_14_1 = var_0.emit

				ActivityMediator = var_2_10002

				var_14_1(var_14_0, var_2_10002.ON_TASK_SUBMIT, var_12_6)

				return
			end

			SFX_PANEL = var_1_10024

			var_1_10020(var_1_10021, var_12_17, var_12_18, var_1_10024)
		else
			pg = var_1_10017
			var_1_10017 = var_1_10017.task_data_template[var_12_4].target_num

			local var_12_19 = var_12_11 and var_1_10017 or 0

			pg = var_1_10019
			var_1_10019 = var_1_10019.task_data_template[var_12_4].desc
			string = var_1_10020
			var_1_10019 = var_1_10020.gsub(var_1_10019, "$1", var_12_19)
			string = var_1_10020
			var_1_10019 = var_1_10020.gsub(var_1_10019, "$2", var_1_10017)
			setText = var_1_10020

			var_1_10020(var_12_3:Find("desc"), var_1_10019)

			var_12_13 = var_12_11 and 2 or 0
			var_12_12 = arg_12_0.materialGray
			onButton = var_1_10020
			var_1_10021 = arg_12_0

			local var_12_20 = var_12_7

			local function var_12_21()
				pg = var_2_10000

				local var_15_0 = var_2_10000.TipsMgr.GetInstance()
				local var_15_1 = var_0.ShowTips

				i18n = var_2_10002

				var_15_1(var_15_0, var_2_10002("common_activity_end"))

				return
			end

			SFX_PANEL = var_1_10024

			var_1_10020(var_1_10021, var_12_20, var_12_21, var_1_10024)
		end

		setActive = var_1_10017

		local var_12_22 = var_12_7

		var_1_10019 = var_12_13 == 0

		var_1_10017(var_12_22, var_1_10019)

		setActive = var_1_10017

		local var_12_23 = var_12_8

		var_1_10019 = var_12_13 == 1

		var_1_10017(var_12_23, var_1_10019)

		setActive = var_1_10017

		local var_12_24 = var_12_10

		var_1_10019 = var_12_13 == 2

		var_1_10017(var_12_24, var_1_10019)

		local var_12_25 = var_12_3

		var_1_10017 = var_12_3.GetComponent
		typeof = var_1_10019
		Image = var_1_10020
		var_1_10017 = var_1_10017(var_12_25, var_1_10019(var_1_10020))
		var_1_10017.material = var_12_12

		local var_12_26 = var_12_3:Find("icon")

		var_1_10017 = var_1_10017.GetComponent
		typeof = var_1_10019
		Image = var_1_10020
		var_1_10017 = var_1_10017(var_12_26, var_1_10019(var_1_10020))
		var_1_10017.material = var_12_12
		var_1_10019 = arg_12_0.medalListItems[var_0_3[iter_12_0]]
		var_1_10019 = var_1_10017.Find(var_1_10019, "icon")

		local var_12_27 = var_18.GetComponent

		typeof = var_1_10020
		Image = var_1_10021

		local var_12_28 = var_12_27(var_1_10019, var_1_10020(var_1_10021))

		var_12_28.enabled = var_12_11

		if not var_12_1 or not arg_12_0.materialGray then
			var_1_10019 = nil
		end

		var_12_28.material = var_1_10019
		var_1_10019 = var_12_13 == 2 and 1 or 0
		var_12_2 = var_12_2 + var_1_10019
	end

	setText = var_4

	var_4(arg_12_0.progressText, var_12_2 .. "/9")

	local var_12_29 = arg_12_0.medalImg

	var_12_29.material = not var_12_0 and not var_12_1 and arg_12_0.materialGray
	setActive = var_12_29

	var_12_29(arg_12_0.medalGet, var_12_0)

	setActive = var_12_29

	var_12_29(arg_12_0.medalGot, var_12_1)

	return
end

function var_0_1.GetFinal(arg_16_0)
	if #arg_16_0.activeIDList == #arg_16_0.allIDList and arg_16_0.actMedal.data1 ~= 1 then
		pg = var_1

		local var_16_0 = var_1.m02
		local var_16_1 = var_1.sendNotification

		GAME = var_1_10003

		local var_16_2 = var_1_10003.ACTIVITY_OPERATION
		local var_16_3 = {
			cmd = 1
		}

		ActivityConst = var_1_10005
		var_16_3.activity_id = var_1_10005.HOLOLIVE_MEDAL_COLLECTION

		var_16_1(var_16_0, var_16_2, var_16_3)
	end

	return
end

function var_0_1.PlayStory(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.actMedal

	if var_2.getConfig(var_17_0, "config_client").story then
		pg = var_17_0

		local var_17_1 = var_17_0.NewStoryMgr.GetInstance()

		var_3.Play(var_17_1, var_2, arg_17_1)
	else
		arg_17_1()
	end

	return
end

function var_0_1.IsTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_18_0 = var_1_10000(var_1_10001)

	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_18_1 = var_1_10001(var_1_10002)
	local var_18_2 = var_18_0
	local var_18_3 = var_18_0.getActivityById

	ActivityConst = var_1_10004

	if var_18_3(var_18_2, var_1_10004.HOLOLIVE_MEDAL_COLLECTION) and not var_2:isEnd() then
		local var_18_4 = var_2
		local var_18_5 = var_2.getConfig(var_18_4, "config_data")

		pg = var_18_4

		local var_18_6 = var_18_4.activity_template

		ActivityConst = var_5

		local var_18_7 = var_18_6[var_5.HOLOLIVE_MEDAL_COLLECTION_TASK].config_data
		local var_18_8 = var_2.data1_list
		local var_18_9 = var_2.data2_list

		ipairs = var_1_10007

		for iter_18_0, iter_18_1 in var_1_10007(var_18_7) do
			var_1_10012 = var_18_7[iter_18_0]

			if var_18_1:getTaskVO(var_1_10012) and var_13:getTaskStatus() == 1 then
				return true
			end
		end

		ipairs = var_7

		for iter_18_2, iter_18_3 in var_7(var_18_8) do
			table = var_1_10012

			if not var_1_10012.contains(var_18_9, iter_18_3) then
				return true
			end
		end

		if #var_18_9 == #var_18_5 and var_2.data1 ~= 1 then
			return true
		end
	end

	return
end

return var_0_1
