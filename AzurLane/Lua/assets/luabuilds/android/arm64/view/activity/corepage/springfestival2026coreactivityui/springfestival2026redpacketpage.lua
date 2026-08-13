class = var_0_10000

local var_0_0 = "SpringFestival2026RedPacketPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0:findUI()

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	arg_2_0:updateUI()

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003
	arg_3_0.activityProxy = var_1_10001(var_1_10003)
	arg_3_0.activityID = arg_3_0.activity.id
	arg_3_0.countToStory = {}

	local var_3_0 = arg_3_0.activity

	if var_1.getConfig(var_3_0, "config_client").story then
		ipairs = var_1_10002

		for iter_3_0, iter_3_1 in var_1_10002(var_1) do
			arg_3_0.countToStory[iter_3_1[1]] = iter_3_1[2]
		end
	end

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.packetBtn = var_1.Find(var_4_0, "BG/Container/PacketBtn")

	local var_4_1 = arg_4_0._tf

	arg_4_0.packetMask = var_1.Find(var_4_1, "BG/Container/PacketBtnMask")

	local var_4_2 = arg_4_0._tf

	arg_4_0.helpBtn = var_1.Find(var_4_2, "BG/Container/HelpBtn")

	local var_4_3 = arg_4_0.packetBtn

	arg_4_0.tagTF = var_1.Find(var_4_3, "tag")

	local var_4_4 = arg_4_0._tf

	arg_4_0.countTF = var_1.Find(var_4_4, "BG/Container/Count")

	local var_4_5 = arg_4_0._tf

	arg_4_0.specialTF = var_1.Find(var_4_5, "BG/Container/Count/Special")

	local var_4_6 = arg_4_0.specialTF

	arg_4_0.specialCountText = var_1.Find(var_4_6, "Text")

	local var_4_7 = arg_4_0._tf

	arg_4_0.normalTF = var_1.Find(var_4_7, "BG/Container/Count/Normal")

	local var_4_8 = arg_4_0.normalTF

	arg_4_0.normalCountText = var_1.Find(var_4_8, "Text")
	arg_4_0.awardBtnList = {}
	table = var_1

	local var_4_9 = var_1.insert
	local var_4_10 = arg_4_0.awardBtnList
	local var_4_11 = arg_4_0._tf

	var_4_9(var_4_10, var_4.Find(var_4_11, "BG/Container/Award"))

	table = var_4_9

	local var_4_12 = var_4_9.insert
	local var_4_13 = arg_4_0.awardBtnList
	local var_4_14 = arg_4_0._tf

	var_4_12(var_4_13, var_4.Find(var_4_14, "BG/Container/Award2"))

	local var_4_15 = arg_4_0._tf

	arg_4_0.countText = var_1.Find(var_4_15, "BG/Container/CountText")

	return
end

function var_0_1.OnFirstFlush(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.packetBtn

	local function var_5_2()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_5_0.activity.id
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.helpBtn

	local function var_5_5()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.help_chunjie_jiulou_2026.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.awardBtnList) do
		if iter_5_1 then
			onButton = var_1_10006

			local var_5_6 = arg_5_0
			local var_5_7 = iter_5_1

			local function var_5_8()
				pg = var_2_10000

				local var_8_0 = var_2_10000.m02
				local var_8_1 = var_0.sendNotification

				GAME = var_2_10003

				local var_8_2 = var_2_10003.GO_SCENE

				SCENE = var_2_10004

				var_8_1(var_8_0, var_8_2, var_2_10004.SKINSHOP)

				return
			end

			SFX_PANEL = var_1_10011

			var_1_10006(var_5_6, var_5_7, var_5_8, var_1_10011)
		end
	end

	return
end

function var_0_1.updateUI(arg_9_0)
	local var_9_0 = arg_9_0.activity.data3
	local var_9_1 = arg_9_0.activity.data1

	math = var_1_10003

	local var_9_2 = var_9_1 - var_1_10003.min(arg_9_0.activity.data1, arg_9_0.activity.data2)

	setActive = var_5

	var_5(arg_9_0.tagTF, var_3 > 0)

	setActive = var_5

	var_5(arg_9_0.normalTF, var_9_2 > 0)

	setActive = var_5

	var_5(arg_9_0.specialTF, var_3 > 0)

	setActive = var_5

	var_5(arg_9_0.countTF, var_9_1 > 0)

	setText = var_5

	var_5(arg_9_0.normalCountText, var_9_2)

	setText = var_5

	var_5(arg_9_0.specialCountText, var_3)

	setActive = var_5

	var_5(arg_9_0.packetBtn, var_9_1 > 0)

	setActive = var_5

	var_5(arg_9_0.packetMask, not (var_9_1 > 0))

	local var_9_3 = arg_9_0.activity.data1_list[2]
	local var_9_4 = arg_9_0.activity.data1_list[1]

	setText = var_7

	var_7(arg_9_0.countText, var_9_3 .. "/" .. var_9_4)

	return
end

function var_0_1.tryPlayStory(arg_10_0)
	local var_10_0 = arg_10_0.activity.data3
	local var_10_1 = arg_10_0.activity.data1

	math = var_1_10003

	local var_10_2 = var_10_1 - var_1_10003.min(arg_10_0.activity.data1, arg_10_0.activity.data2)
	local var_10_3 = var_10_0 - arg_10_0.activity.data2

	if arg_10_0.countToStory[var_10_3] then
		pg = var_1_10007

		local var_10_4 = var_1_10007.NewStoryMgr.GetInstance()

		var_7.Play(var_10_4, var_6)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	arg_11_0:updateUI()
	arg_11_0:tryPlayStory()

	return
end

return var_0_1
