class = var_0_10000

local var_0_0 = "IdolMedalCollectionView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.FADE_OUT_TIME = 1
var_0_1.PAGE_NUM = 5
var_0_1.MEDAL_NUM_PER_PAGE = 3

function var_0_1.getUIName(arg_1_0)
	return "IdolMedalCollectionUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:checkAward()

	setText = var_1

	local var_3_0 = arg_3_0.progressText

	setColorStr = var_1_10003
	tostring = var_1_10004

	local var_3_1 = var_1_10004(#arg_3_0.activeIDList)

	COLOR_RED = var_5

	var_1(var_3_0, var_1_10003(var_3_1, var_5) .. "/" .. #arg_3_0.allIDList)

	triggerToggle = var_1

	var_1(arg_3_0.switchBtnList[1], true)

	return
end

function var_0_1.willExit(arg_4_0)
	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002
	arg_5_0.activityProxy = var_1_10001(var_1_10002)

	local var_5_0 = arg_5_0.activityProxy
	local var_5_1 = var_1.getActivityById

	ActivityConst = var_1_10003
	arg_5_0.activityData = var_5_1(var_5_0, var_1_10003.IDOL_MEDAL_COLLECTION)

	local var_5_2 = arg_5_0.activityData

	arg_5_0.allIDList = var_1.GetPicturePuzzleIds(var_5_2)
	arg_5_0.pageIDList = {}

	for iter_5_0 = 1, var_0_1.PAGE_NUM do
		arg_5_0.pageIDList[iter_5_0] = {}

		for iter_5_1 = 1, var_0_1.MEDAL_NUM_PER_PAGE do
			arg_5_0.pageIDList[iter_5_0][iter_5_1] = arg_5_0.allIDList[(iter_5_0 - 1) * var_0_1.MEDAL_NUM_PER_PAGE + iter_5_1]
		end
	end

	arg_5_0.activatableIDList = arg_5_0.activityData.data1_list
	arg_5_0.activeIDList = arg_5_0.activityData.data2_list
	arg_5_0.curPage = nil
	arg_5_0.newMedalID = nil

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_1.Find(var_6_1, "NotchAdapt")

	arg_6_0.backBtn = var_1.Find(var_6_2, "BackBtn")
	arg_6_0.progressText = var_1:Find("ProgressImg/ProgressText")
	arg_6_0.helpBtn = var_1:Find("HelpBtn")

	local var_6_3 = arg_6_0._tf
	local var_6_4 = var_2.Find(var_6_3, "MedalContainer")

	arg_6_0.medalItemList = {}
	arg_6_0.medalItemList[1] = var_6_4:Find("Medal1")
	arg_6_0.medalItemList[2] = var_6_4:Find("Medal2")
	arg_6_0.medalItemList[3] = var_6_4:Find("Medal3")

	local var_6_5 = var_1:Find("SwitchBtnList")

	arg_6_0.switchBtnList = {}

	for iter_6_0 = 1, 5 do
		arg_6_0.switchBtnList[iter_6_0] = var_6_5:Find("Button" .. iter_6_0)
	end

	return
end

function var_0_1.addListener(arg_7_0)
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

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.helpBtn

	local function var_7_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		pg = var_2_10003
		var_9_2.helps = var_2_10003.gametip.music_collection.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.switchBtnList) do
		onToggle = var_1_10006

		local var_7_6 = arg_7_0
		local var_7_7 = iter_7_1

		local function var_7_8(arg_10_0)
			if arg_10_0 == true then
				arg_7_0.curPage = iter_7_0

				local var_10_0 = arg_7_0

				var_1.updateSwitchBtnTF(var_10_0)

				local var_10_1 = arg_7_0

				var_1.updateMedalContainerView(var_10_1, iter_7_0)
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_7_6, var_7_7, var_7_8, var_1_10010)
	end

	addSlip = var_1
	SLIP_TYPE_HRZ = var_2

	var_1(var_2, arg_7_0.bg, function()
		if arg_7_0.curPage > 1 then
			triggerToggle = var_0

			var_0(arg_7_0.switchBtnList[arg_7_0.curPage - 1], true)
		else
			return
		end

		return
	end, function()
		if arg_7_0.curPage < var_0_1.PAGE_NUM then
			triggerToggle = var_0

			var_0(arg_7_0.switchBtnList[arg_7_0.curPage + 1], true)
		else
			return
		end

		return
	end)

	return
end

function var_0_1.updateMedalContainerView(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.pageIDList[arg_13_1]

	ipairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(var_13_0) do
		arg_13_0:updateMedalView(var_13_0, iter_13_1)
	end

	return
end

function var_0_1.updateMedalView(arg_14_0, arg_14_1, arg_14_2)
	table = var_1_10003

	local var_14_0 = var_1_10003.indexof(arg_14_1, arg_14_2, 1)

	table = var_4

	local var_14_1 = var_4.contains(arg_14_0.activeIDList, arg_14_2)

	table = var_5

	local var_14_2

	if var_5.contains(arg_14_0.activatableIDList, arg_14_2) then
		var_14_2 = not var_14_1
	end

	local var_14_3 = not var_14_1 and not var_14_2
	local var_14_4 = arg_14_0.medalItemList[var_14_0]
	local var_14_5 = var_7.Find(var_14_4, "Active")
	local var_14_6 = var_7:Find("Activable")
	local var_14_7 = var_7
	local var_14_8 = var_7.Find(var_14_7, "DisActive")

	setActive = var_14_7

	var_14_7(var_14_5, var_14_1)

	setActive = var_14_7

	var_14_7(var_14_6, var_14_2)

	setActive = var_14_7

	var_14_7(var_14_8, var_14_3)

	if var_14_5 then
		setImageSprite = var_14_7

		local var_14_9 = var_14_5

		GetSpriteFromAtlas = var_13

		local var_14_10 = "ui/musicfestivalmedalcollectionui_atlas"

		tostring = var_1_10015

		var_14_7(var_14_9, var_13(var_14_10, var_1_10015(arg_14_2)))
	end

	if var_14_2 then
		onButton = var_14_7

		local var_14_11 = arg_14_0
		local var_14_12 = var_14_6

		local function var_14_13()
			pg = var_2_10000

			local var_15_0 = var_2_10000.m02
			local var_15_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_15_2 = var_2_10002.MEMORYBOOK_UNLOCK
			local var_15_3 = {
				id = arg_14_2
			}

			ActivityConst = var_4
			var_15_3.actId = var_4.IDOL_MEDAL_COLLECTION

			var_15_1(var_15_0, var_15_2, var_15_3)

			return
		end

		SFX_PANEL = var_1_10015

		var_14_7(var_14_11, var_14_12, var_14_13, var_1_10015)
	end

	if var_14_3 then
		table = var_14_7

		local var_14_14 = var_14_7.indexof(arg_14_0.allIDList, arg_14_2, 1)
		local var_14_15 = arg_14_0.activityData
		local var_14_16 = var_12.getConfig(var_14_15, "config_client").unlock_desc[var_14_14]

		setText = var_14_15

		var_14_15(var_14_8, var_14_16)
	end

	return
end

function var_0_1.updateSwitchBtnTF(arg_16_0)
	ipairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.switchBtnList) do
		local var_16_0 = iter_16_1:Find("Tip")
		local var_16_1 = var_6.Find(var_16_0, "Text")
		local var_16_2 = arg_16_0

		if arg_16_0.caculateActivatable(var_16_2, iter_16_0) == 0 or iter_16_0 == arg_16_0.curPage then
			setActive = var_16_2

			var_16_2(var_6, false)
		end

		if var_8 > 0 and iter_16_0 ~= arg_16_0.curPage then
			setActive = var_9

			var_9(var_6, true)

			setText = var_9

			var_9(var_16_1, var_8)
		end
	end

	return
end

function var_0_1.updateAfterSubmit(arg_17_0, arg_17_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003
	arg_17_0.activityProxy = var_1_10002(var_1_10003)

	local var_17_0 = arg_17_0.activityProxy
	local var_17_1 = var_2.getActivityById

	ActivityConst = var_1_10004
	arg_17_0.activityData = var_17_1(var_17_0, var_1_10004.IDOL_MEDAL_COLLECTION)
	arg_17_0.activatableIDList = arg_17_0.activityData.data1_list
	arg_17_0.activeIDList = arg_17_0.activityData.data2_list
	arg_17_0.newMedalID = arg_17_1
	triggerToggle = var_2

	var_2(arg_17_0.switchBtnList[arg_17_0.curPage], true)

	setText = var_2

	local var_17_2 = arg_17_0.progressText

	setColorStr = var_4
	tostring = var_1_10005

	local var_17_3 = var_1_10005(#arg_17_0.activeIDList)

	COLOR_RED = var_6

	var_2(var_17_2, var_4(var_17_3, var_6) .. "/" .. #arg_17_0.allIDList)
	arg_17_0:checkAward()

	return
end

function var_0_1.UpdateActivity(arg_18_0)
	return
end

function var_0_1.caculateActivatable(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.pageIDList[arg_19_1]
	local var_19_1 = 0

	ipairs = var_1_10004

	for iter_19_0, iter_19_1 in var_1_10004(var_19_0) do
		table = var_1_10009
		var_1_10009 = var_1_10009.contains(arg_19_0.activeIDList, iter_19_1)
		table = var_10

		local var_19_2 = var_10.contains(arg_19_0.activatableIDList, iter_19_1)

		if not var_1_10009 and var_19_2 then
			var_19_1 = var_19_1 + 1
		end
	end

	return var_19_1
end

function var_0_1.checkAward(arg_20_0)
	if #arg_20_0.activeIDList == #arg_20_0.allIDList and arg_20_0.activityData.data1 ~= 1 then
		pg = var_1

		local var_20_0 = var_1.m02
		local var_20_1 = var_1.sendNotification

		GAME = var_1_10003

		local var_20_2 = var_1_10003.ACTIVITY_OPERATION
		local var_20_3 = {
			cmd = 1
		}

		ActivityConst = var_1_10005
		var_20_3.activity_id = var_1_10005.IDOL_MEDAL_COLLECTION

		var_20_1(var_20_0, var_20_2, var_20_3)
	end

	return
end

return var_0_1
