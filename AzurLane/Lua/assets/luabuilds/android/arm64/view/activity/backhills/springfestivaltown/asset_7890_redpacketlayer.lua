class = var_0_10000

local var_0_0 = "RedPacketLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CHT = var_1_10002

	if var_1_10001 == var_1_10002 then
		return "RedPacket2023UI"
	else
		return "RedPacket2023UI"
	end

	return
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:updateUI()

	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003
	arg_5_0.activityProxy = var_1_10001(var_1_10003)

	local var_5_0 = arg_5_0.activityProxy
	local var_5_1 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_5_0.activityID = var_5_1(var_5_0, var_1_10004.ACTIVITY_TYPE_RED_PACKETS).id
	arg_5_0.countToStory = {}

	if var_1:getConfig("config_client").story then
		ipairs = var_5_0

		for iter_5_0, iter_5_1 in var_5_0(var_2) do
			arg_5_0.countToStory[iter_5_1[1]] = iter_5_1[2]
		end
	end

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.packetBtn = var_1.Find(var_6_0, "Container/PacketBtn")

	local var_6_1 = arg_6_0._tf

	arg_6_0.packetMask = var_1.Find(var_6_1, "Container/PacketBtnMask")

	local var_6_2 = arg_6_0._tf

	arg_6_0.helpBtn = var_1.Find(var_6_2, "Container/HelpBtn")

	local var_6_3 = arg_6_0.packetBtn

	arg_6_0.tagTF = var_1.Find(var_6_3, "tag")

	local var_6_4 = arg_6_0._tf

	arg_6_0.countTF = var_1.Find(var_6_4, "Container/Count")

	local var_6_5 = arg_6_0._tf

	arg_6_0.specialTF = var_1.Find(var_6_5, "Container/Count/Special")

	local var_6_6 = arg_6_0.specialTF

	arg_6_0.specialCountText = var_1.Find(var_6_6, "Text")

	local var_6_7 = arg_6_0._tf

	arg_6_0.normalTF = var_1.Find(var_6_7, "Container/Count/Normal")

	local var_6_8 = arg_6_0.normalTF

	arg_6_0.normalCountText = var_1.Find(var_6_8, "Text")
	arg_6_0.awardBtnList = {}
	table = var_1

	local var_6_9 = var_1.insert
	local var_6_10 = arg_6_0.awardBtnList
	local var_6_11 = arg_6_0._tf

	var_6_9(var_6_10, var_4.Find(var_6_11, "Container/Award"))

	table = var_6_9

	local var_6_12 = var_6_9.insert
	local var_6_13 = arg_6_0.awardBtnList
	local var_6_14 = arg_6_0._tf

	var_6_12(var_6_13, var_4.Find(var_6_14, "Container/Award2"))

	local var_6_15 = arg_6_0._tf

	arg_6_0.countText = var_1.Find(var_6_15, "Container/CountText")

	local var_6_16 = arg_6_0._tf

	arg_6_0.backBtn = var_1.Find(var_6_16, "Top/BackBtn")

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

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.packetBtn

	local function var_7_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02
		local var_9_1 = var_0.sendNotification

		GAME = var_2_10003

		var_9_1(var_9_0, var_2_10003.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_7_0.activityID
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10006)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.helpBtn

	local function var_7_8()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		pg = var_2_10004
		var_10_2.helps = var_2_10004.gametip.help_chunjie_jiulou.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10006)

	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.awardBtnList) do
		if iter_7_1 then
			onButton = var_1_10006

			local var_7_9 = arg_7_0
			local var_7_10 = iter_7_1

			local function var_7_11()
				pg = var_2_10000

				local var_11_0 = var_2_10000.m02
				local var_11_1 = var_0.sendNotification

				GAME = var_2_10003

				local var_11_2 = var_2_10003.GO_SCENE

				SCENE = var_2_10004

				var_11_1(var_11_0, var_11_2, var_2_10004.SKINSHOP)

				return
			end

			SFX_PANEL = var_1_10011

			var_1_10006(var_7_9, var_7_10, var_7_11, var_1_10011)
		end
	end

	return
end

function var_0_1.updateUI(arg_12_0)
	local var_12_0 = arg_12_0.activityProxy
	local var_12_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_12_2 = var_12_1(var_12_0, var_1_10004.ACTIVITY_TYPE_RED_PACKETS).data3
	local var_12_3 = var_1.data1

	math = var_4

	local var_12_4 = var_12_3 - var_4.min(var_1.data1, var_1.data2)

	print = var_6

	var_6(var_12_4, var_4, var_12_3)

	setActive = var_6

	var_6(arg_12_0.tagTF, var_4 > 0)

	setActive = var_6

	var_6(arg_12_0.normalTF, var_12_4 > 0)

	setActive = var_6

	var_6(arg_12_0.specialTF, var_4 > 0)

	setActive = var_6

	var_6(arg_12_0.countTF, var_12_3 > 0)

	setText = var_6

	var_6(arg_12_0.normalCountText, var_12_4)

	setText = var_6

	var_6(arg_12_0.specialCountText, var_4)

	setActive = var_6

	var_6(arg_12_0.packetBtn, var_12_3 > 0)

	setActive = var_6

	var_6(arg_12_0.packetMask, not (var_12_3 > 0))

	local var_12_5 = var_1.data1_list[2]
	local var_12_6 = var_1.data1_list[1]

	setText = var_8

	var_8(arg_12_0.countText, var_12_5 .. "/" .. var_12_6)

	return
end

function var_0_1.tryPlayStory(arg_13_0)
	local var_13_0 = arg_13_0.activityProxy
	local var_13_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_13_2 = var_13_1(var_13_0, var_1_10004.ACTIVITY_TYPE_RED_PACKETS).data3
	local var_13_3 = var_1.data1

	math = var_4

	local var_13_4 = var_13_3 - var_4.min(var_1.data1, var_1.data2)
	local var_13_5 = var_13_2 - var_1.data2

	if arg_13_0.countToStory[var_13_5] then
		pg = var_1_10008

		local var_13_6 = var_1_10008.NewStoryMgr.GetInstance()

		var_8.Play(var_13_6, var_7)
	end

	return
end

function var_0_1.onSubmitFinished(arg_14_0)
	arg_14_0:updateUI()
	arg_14_0:tryPlayStory()

	return
end

function var_0_1.isShowRedPoint()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_15_0 = var_1_10000(var_1_10002)
	local var_15_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	return var_15_1(var_15_0, var_1_10003.ACTIVITY_TYPE_RED_PACKETS).data1 > 0
end

return var_0_1
