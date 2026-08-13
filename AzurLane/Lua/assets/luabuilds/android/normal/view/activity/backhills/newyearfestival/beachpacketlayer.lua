class = var_0_10000

local var_0_0 = "BeachPacketLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BeachPacketUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:updateUI()

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
	local var_5_1 = var_1.getActivityByType

	ActivityConst = var_1_10003
	arg_5_0.activityID = var_5_1(var_5_0, var_1_10003.ACTIVITY_TYPE_RED_PACKET_LOTTER).id
	arg_5_0.awardList = {}
	arg_5_0.awardListMap = {}

	local var_5_2 = var_1

	if var_1.getConfig(var_5_2, "config_client") then
		ipairs = var_5_2

		for iter_5_0, iter_5_1 in var_5_2(var_2) do
			local var_5_3 = iter_5_1[1]
			local var_5_4 = iter_5_1[2][2]
			local var_5_5 = iter_5_1[2][1]
			local var_5_6 = iter_5_1[3]
			local var_5_7 = iter_5_1[4]

			if not arg_5_0.awardListMap[var_5_7] then
				arg_5_0.awardListMap[var_5_7] = {}
			end

			local var_5_8 = {
				id = var_5_4,
				type = var_5_5,
				count = var_5_6,
				awardID = var_5_3
			}

			table = var_1_10014

			var_1_10014.insert(arg_5_0.awardListMap[var_5_7], var_5_8)

			var_1_10014 = arg_5_0.awardList
			var_1_10014[var_5_3] = var_5_8
		end
	end

	arg_5_0:updateActData()

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "Adapt")

	arg_6_0.backBtn = var_1.Find(var_6_1, "BackBtn")
	arg_6_0.homeBtn = var_1:Find("HomeBtn")
	arg_6_0.helpBtn = var_1:Find("HelpBtn")

	local var_6_2 = arg_6_0._tf
	local var_6_3 = var_2.Find(var_6_2, "PacketPanel")

	arg_6_0.countText = var_2.Find(var_6_3, "Count/CountText")
	arg_6_0.packetTFList = {}

	local var_6_4 = var_2:Find("ContainerBehide")

	for iter_6_0 = 1, 5 do
		local var_6_5 = var_6_4
		local var_6_6 = var_6_4.GetChild(var_6_5, iter_6_0 - 1)

		table = var_6_5

		var_6_5.insert(arg_6_0.packetTFList, var_6_6)
	end

	local var_6_7 = var_2:Find("ContainerFront")

	for iter_6_1 = 1, 5 do
		local var_6_8 = var_6_7
		local var_6_9 = var_6_7.GetChild(var_6_8, iter_6_1 - 1)

		table = var_6_8

		var_6_8.insert(arg_6_0.packetTFList, var_6_9)
	end

	local var_6_10 = arg_6_0._tf
	local var_6_11 = var_5.Find(var_6_10, "AwardPanel")

	arg_6_0.awardTpl = var_5.Find(var_6_11, "AwardTpl")

	local var_6_12 = arg_6_0.awardTpl

	arg_6_0.iconTpl = var_6.Find(var_6_12, "Icon/IconTpl")
	arg_6_0.awardTFList = {}

	;(function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_6_0
		local var_7_1 = var_3.getAwardListByLevel(var_7_0, arg_7_0)

		ipairs = var_7_0

		for iter_7_0, iter_7_1 in var_7_0(var_7_1) do
			cloneTplTo = var_2_10009
			var_2_10009 = var_2_10009(arg_7_1, arg_7_2)

			local var_7_2 = iter_7_1.awardID

			arg_6_0.awardTFList[var_7_2] = var_2_10009
		end

		return
	end)(1, arg_6_0.awardTpl, var_5:Find("Container_1"))
	var_6(2, arg_6_0.awardTpl, var_5:Find("Container_2"))
	var_6(3, arg_6_0.awardTpl, var_5:Find("Container_3"))
	var_6(4, arg_6_0.awardTpl, var_5:Find("Container_4"))

	local var_6_13 = arg_6_0._tf

	arg_6_0.aniPanel = var_7.Find(var_6_13, "AniPanel")

	local var_6_14 = arg_6_0.aniPanel

	arg_6_0.aniTF = var_7.Find(var_6_14, "Ani")
	GetComponent = var_7
	arg_6_0.aniSC = var_7(arg_6_0.aniTF, "SpineAnimUI")

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.backBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.homeBtn

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.emit(var_10_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.helpBtn

	local function var_8_8()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_11_2.type = var_2_10003
		pg = var_2_10003
		var_11_2.helps = var_2_10003.gametip.tips_yuandanhuoyue2023.tip

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10005)

	return
end

function var_0_1.updateActData(arg_12_0)
	local var_12_0 = arg_12_0.activityProxy
	local var_12_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_12_2 = var_12_1(var_12_0, var_1_10003.ACTIVITY_TYPE_RED_PACKET_LOTTER)

	pg = var_12_0

	local var_12_3 = var_12_0.TimeMgr.GetInstance()
	local var_12_4 = var_12_2.data1
	local var_12_5 = var_12_2.data2
	local var_12_6 = var_12_3
	local var_12_7 = var_12_3.GetServerTime(var_12_6)

	math = var_12_6
	arg_12_0.curCount = var_12_6.min(10, var_12_3:DiffDay(var_12_5, var_12_7) + 1) - var_12_4
	arg_12_0.gotIndexList = {}
	pairs = var_7

	for iter_12_0, iter_12_1 in var_7(var_12_2.data2_list) do
		table = var_1_10012

		if not var_1_10012.contains(arg_12_0.gotIndexList, iter_12_1) then
			table = var_1_10012

			var_1_10012.insert(arg_12_0.gotIndexList, iter_12_1)
		end
	end

	arg_12_0.gotIDList = {}
	pairs = var_7

	for iter_12_2, iter_12_3 in var_7(var_12_2.data1_list) do
		table = var_1_10012

		if not var_1_10012.contains(arg_12_0.gotIDList, iter_12_3) then
			table = var_1_10012

			var_1_10012.insert(arg_12_0.gotIDList, iter_12_3)
		end
	end

	return
end

function var_0_1.updatePacketTpl(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2:Find("Normal")
	local var_13_1 = arg_13_2:Find("Got")
	local var_13_2 = arg_13_2:Find("Selected")
	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.isPacketIndexGot(var_13_3, arg_13_1)

	setActive = var_13_3

	var_13_3(var_13_1, var_13_4)

	setActive = var_13_3

	var_13_3(var_13_0, not var_13_4)

	onButton = var_13_3

	local var_13_5 = arg_13_0
	local var_13_6 = arg_13_2

	local function var_13_7()
		if not var_13_4 and arg_13_0.curCount > 0 then
			pg = var_0

			local var_14_0 = var_0.m02
			local var_14_1 = var_0.sendNotification

			GAME = var_2_10002

			var_14_1(var_14_0, var_2_10002.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = arg_13_0.activityID,
				arg1 = arg_13_1
			})
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_13_3(var_13_5, var_13_6, var_13_7, var_1_10011)

	return
end

function var_0_1.updatePacketList(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.packetTFList) do
		arg_15_0:updatePacketTpl(iter_15_0, iter_15_1)
	end

	return
end

function var_0_1.updateAwardTpl(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._tf
	local var_16_1 = var_3.Find(var_16_0, "Icon/IconTpl(Clone)", arg_16_2)
	local var_16_2 = arg_16_2:Find("Got")
	local var_16_3 = arg_16_0.awardList[arg_16_1]

	updateDrop = var_6

	var_6(var_16_1, var_16_3)

	local var_16_4 = arg_16_0
	local var_16_5 = arg_16_0.isAwardGot(var_16_4, arg_16_1)

	setActive = var_16_4

	var_16_4(var_16_2, var_16_5)

	onButton = var_16_4

	local var_16_6 = arg_16_0
	local var_16_7 = arg_16_2

	local function var_16_8()
		if not var_16_5 then
			pg = var_0

			local var_17_0 = var_0.MsgboxMgr.GetInstance()
			local var_17_1 = var_0.ShowMsgBox
			local var_17_2 = {}

			MSGBOX_TYPE_SINGLE_ITEM = var_2_10003
			var_17_2.type = var_2_10003
			var_17_2.drop = var_16_3

			var_17_1(var_17_0, var_17_2)
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_16_4(var_16_6, var_16_7, var_16_8, var_1_10011)

	return
end

function var_0_1.updateAwardList(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.awardTFList) do
		arg_18_0:updateAwardTpl(iter_18_0, iter_18_1)
	end

	return
end

function var_0_1.updateUI(arg_19_0)
	arg_19_0:updatePacketList()
	arg_19_0:updateAwardList()

	setText = var_1

	var_1(arg_19_0.countText, arg_19_0.curCount)

	return
end

function var_0_1.playAni(arg_20_0, arg_20_1)
	arg_20_0.isPlaying = true
	setActive = var_2

	var_2(arg_20_0.aniPanel, true)

	local var_20_0 = arg_20_0.aniSC

	var_2.SetActionCallBack(var_20_0, nil)

	local var_20_1 = 0
	local var_20_2 = arg_20_0.aniSC

	var_3.SetActionCallBack(var_20_2, function(arg_21_0)
		if arg_21_0 == "action" then
			var_20_1 = var_20_1 + 1

			if var_20_1 == 2 then
				local var_21_0 = arg_20_0.aniSC

				var_1.SetActionCallBack(var_21_0, nil)

				setActive = var_1

				var_1(arg_20_0.aniPanel, false)

				arg_20_0.isPlaying = false

				if arg_20_1 then
					arg_20_1()
				end

				var_20_1 = 0
			end
		end

		return
	end)

	local var_20_3 = arg_20_0.aniSC

	var_3.SetAction(var_20_3, "4", 0)

	return
end

function var_0_1.isPacketIndexGot(arg_22_0, arg_22_1)
	table = var_1_10002

	return var_1_10002.contains(arg_22_0.gotIndexList, arg_22_1)
end

function var_0_1.isAwardGot(arg_23_0, arg_23_1)
	table = var_1_10002

	return var_1_10002.contains(arg_23_0.gotIDList, arg_23_1)
end

function var_0_1.getAwardCountByLevel(arg_24_0, arg_24_1)
	return #arg_24_0:getAwardListByLevel(arg_24_1)
end

function var_0_1.getAwardListByLevel(arg_25_0, arg_25_1)
	return arg_25_0.awardListMap[arg_25_1]
end

function var_0_1.onSubmitFinished(arg_26_0)
	arg_26_0:updateActData()
	arg_26_0:updateUI()

	return
end

function var_0_1.isShowRedPoint()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_27_0 = var_1_10000(var_1_10001)
	local var_27_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	local var_27_2 = var_27_1(var_27_0, var_1_10002.ACTIVITY_TYPE_RED_PACKET_LOTTER)

	pg = var_27_0

	local var_27_3 = var_27_0.TimeMgr.GetInstance()
	local var_27_4 = var_27_2.data1
	local var_27_5 = var_27_2.data2
	local var_27_6 = var_27_3:GetServerTime()
	local var_27_7 = var_27_3
	local var_27_8 = var_27_3.DiffDay(var_27_7, var_27_5, var_27_6) + 1

	math = var_27_7

	return var_27_7.min(10, var_27_3:DiffDay(var_27_5, var_27_6) + 1) - var_27_4 > 0
end

return var_0_1
