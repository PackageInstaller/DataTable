class = var_0_10000

local var_0_0 = "HoloLiveLinkLinkSelectScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.HOLOLIVE_LINKGAME_HUB_ID = 3
var_0_1.HOLOLIVE_LINKGAME_ID = 7

function var_0_1.getUIName(arg_1_0)
	return "HoloLiveLinkGameSelectUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:initUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:updateProgressBar()
	arg_3_0:updateAwardPanel()
	arg_3_0:updateEntranceList()

	return
end

function var_0_1.willExit(arg_4_0)
	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.lightPointTFList = {}
	arg_5_0.lightLineTFList = {}
	arg_5_0.entranceTFList = {}

	arg_5_0:updateData()

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.forNotchPanel = var_1.Find(var_6_0, "ForNotchPanel")

	local var_6_1 = arg_6_0.forNotchPanel

	arg_6_0.backBtn = var_1.Find(var_6_1, "BackBtn")

	local var_6_2 = arg_6_0.forNotchPanel

	arg_6_0.helpBtn = var_1.Find(var_6_2, "HelpBtn")

	local var_6_3 = arg_6_0.forNotchPanel

	arg_6_0.awardMask = var_1.Find(var_6_3, "AwardImg/Mask")

	local var_6_4 = arg_6_0.forNotchPanel

	arg_6_0.progressText = var_1.Find(var_6_4, "AwardImg/ProgressText")

	local var_6_5 = arg_6_0.forNotchPanel

	arg_6_0.getAwardBtn = var_1.Find(var_6_5, "AwardImg/GetBtn")

	local var_6_6 = arg_6_0.forNotchPanel

	arg_6_0.gotAwardBtn = var_1.Find(var_6_6, "AwardImg/GotBtn")

	local var_6_7 = arg_6_0.forNotchPanel

	arg_6_0.progressPanel = var_1.Find(var_6_7, "Progress")

	local var_6_8 = arg_6_0.progressPanel

	arg_6_0.lightPointContainer = var_1.Find(var_6_8, "Light")

	local var_6_9 = arg_6_0.progressPanel

	arg_6_0.lightLineContainer = var_1.Find(var_6_9, "LightLine")

	local var_6_10 = arg_6_0._tf

	arg_6_0.entranceContainer = var_1.Find(var_6_10, "EntranceContainer")

	return
end

function var_0_1.initUI(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0.getAwardBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_7_0.gotAwardBtn, false)

	eachChild = var_1_10001

	var_1_10001(arg_7_0.lightPointContainer, function(arg_8_0)
		table = var_2_10001

		var_2_10001.insert(arg_7_0.lightPointTFList, 1, arg_8_0)

		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.Find(var_8_0, "Point")

		setActive = var_8_0

		var_8_0(arg_8_0, false)

		setActive = var_8_0

		var_8_0(var_8_1, false)

		return
	end)

	eachChild = var_1_10001

	var_1_10001(arg_7_0.lightLineContainer, function(arg_9_0)
		table = var_2_10001

		var_2_10001.insert(arg_7_0.lightLineTFList, 1, arg_9_0)

		setActive = var_1

		var_1(arg_9_0, false)

		return
	end)

	for iter_7_0 = 0, 7 do
		local var_7_0 = arg_7_0.entranceContainer
		local var_7_1 = var_5.GetChild(var_7_0, iter_7_0)

		table = var_7_0

		var_7_0.insert(arg_7_0.entranceTFList, var_7_1)

		local var_7_2 = var_7_1:Find("Mask")
		local var_7_3 = var_7_1:Find("GotImg")
		local var_7_4 = var_7_1
		local var_7_5 = var_7_1.Find(var_7_4, "LockText")

		setActive = var_7_4

		var_7_4(var_7_2, true)

		setActive = var_7_4

		var_7_4(var_7_3, false)

		setActive = var_7_4

		var_7_4(var_7_5, true)
	end

	return
end

function var_0_1.addListener(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.backBtn

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.closeView(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10005)

	onButton = var_1_10001

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.helpBtn

	local function var_10_5()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_12_2.type = var_2_10003
		pg = var_2_10003
		var_12_2.helps = var_2_10003.gametip.hololive_lianliankan.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_10_3, var_10_4, var_10_5, var_1_10005)

	ipairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.entranceTFList) do
		local var_10_6 = iter_10_1
		local var_10_7 = iter_10_1.Find(var_10_6, "EntranceBtn")

		onButton = var_10_6

		local var_10_8 = arg_10_0
		local var_10_9 = var_10_7

		local function var_10_10()
			local var_13_0 = arg_10_0.linkGameData

			var_0.SetRuntimeData(var_13_0, "curLinkGameID", iter_10_0)

			pg = var_0

			local var_13_1 = var_0.m02
			local var_13_2 = var_0.sendNotification

			GAME = var_2

			var_13_2(var_13_1, var_2.GO_MINI_GAME, var_0_1.HOLOLIVE_LINKGAME_ID)

			return
		end

		SFX_PANEL = var_1_10011

		var_10_6(var_10_8, var_10_9, var_10_10, var_1_10011)
	end

	return
end

function var_0_1.updateProgressBar(arg_14_0)
	local var_14_0 = arg_14_0.linkGameHub.usedtime

	math = var_1_10002

	if var_1_10002.min(var_14_0, 7) > 0 then
		for iter_14_0 = 1, var_1 do
			local var_14_1 = arg_14_0.lightPointTFList[iter_14_0]

			setActive = var_1_10007

			var_1_10007(var_14_1, true)
		end

		local var_14_2 = arg_14_0.lightPointTFList[var_1]
		local var_14_3 = var_2.Find(var_14_2, "Point")

		setActive = var_14_2

		var_14_2(var_14_3, true)
	end

	if var_1 > 1 then
		local var_14_4 = var_1 - 1

		for iter_14_1 = 1, var_14_4 do
			local var_14_5 = arg_14_0.lightLineTFList[iter_14_1]

			setActive = var_1_10008

			var_1_10008(var_14_5, true)
		end
	end

	return
end

function var_0_1.updateAwardPanel(arg_15_0)
	local var_15_0 = arg_15_0.linkGameHub.usedtime

	setText = var_1_10002

	var_1_10002(arg_15_0.progressText, var_15_0 > 7 and 7 or var_15_0)

	local var_15_1 = arg_15_0.linkGameHub.ultimate

	if 0 < var_15_1 then
		setActive = var_3

		var_3(arg_15_0.getAwardBtn, false)

		setActive = var_3

		var_3(arg_15_0.gotAwardBtn, true)

		setActive = var_3

		var_3(arg_15_0.awardMask, true)
	else
		local var_15_2 = arg_15_0.linkGameHub

		if var_3.getConfig(var_15_2, "reward_need") <= var_15_0 then
			setActive = var_3

			var_3(arg_15_0.getAwardBtn, true)

			setActive = var_3

			var_3(arg_15_0.gotAwardBtn, false)

			setActive = var_3

			var_3(arg_15_0.awardMask, true)

			onButton = var_3

			local var_15_3 = arg_15_0
			local var_15_4 = arg_15_0.getAwardBtn

			local function var_15_5()
				pg = var_2_10000

				local var_16_0 = var_2_10000.m02
				local var_16_1 = var_0.sendNotification

				GAME = var_2_10002

				local var_16_2 = var_2_10002.SEND_MINI_GAME_OP
				local var_16_3 = {
					hubid = arg_15_0.linkGameHub.id
				}

				MiniGameOPCommand = var_4
				var_16_3.cmd = var_4.CMD_ULTIMATE
				var_16_3.args1 = {}

				var_16_1(var_16_0, var_16_2, var_16_3)

				return
			end

			SFX_PANEL = var_1_10007

			var_3(var_15_3, var_15_4, var_15_5, var_1_10007)
		else
			setActive = var_3

			var_3(arg_15_0.getAwardBtn, false)

			setActive = var_3

			var_3(arg_15_0.gotAwardBtn, false)

			setActive = var_3

			var_3(arg_15_0.awardMask, false)
		end
	end

	return
end

function var_0_1.updateEntranceList(arg_17_0)
	local var_17_0 = arg_17_0.linkGameHub.usedtime

	for iter_17_0 = 1, 8 do
		local var_17_1 = arg_17_0.entranceTFList[iter_17_0]
		local var_17_2 = var_6.Find(var_17_1, "Mask")
		local var_17_3 = var_6:Find("GotImg")
		local var_17_4 = var_6:Find("LockText")
		local var_17_5 = arg_17_0.linkGameData
		local var_17_6 = var_10.GetConfigCsvLine(var_17_5, iter_17_0).unlock_txt

		setText = var_17_5

		var_17_5(var_17_4, var_17_6)

		if iter_17_0 <= var_17_0 then
			setActive = var_17_5

			var_17_5(var_17_2, false)

			setActive = var_17_5

			var_17_5(var_17_3, true)

			setActive = var_17_5

			var_17_5(var_17_4, false)
		elseif iter_17_0 == var_17_0 + 1 then
			if arg_17_0.linkGameHub.count == 0 then
				setActive = var_12

				var_12(var_17_2, true)

				setActive = var_12

				var_12(var_17_3, false)

				setActive = var_12

				var_12(var_17_4, true)
			elseif 0 < var_11 then
				setActive = var_12

				var_12(var_17_2, false)

				setActive = var_12

				var_12(var_17_3, false)

				setActive = var_12

				var_12(var_17_4, false)
			end
		elseif var_17_0 + 1 < iter_17_0 then
			setActive = var_11

			var_11(var_17_2, true)

			setActive = var_11

			var_11(var_17_3, false)

			setActive = var_11

			var_11(var_17_4, true)
		end
	end

	return
end

function var_0_1.updateData(arg_18_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002
	arg_18_0.miniGameProxy = var_1_10001(var_1_10002)

	local var_18_0 = arg_18_0.miniGameProxy

	arg_18_0.linkGameHub = var_1.GetHubByHubId(var_18_0, var_0_1.HOLOLIVE_LINKGAME_HUB_ID)

	local var_18_1 = arg_18_0.miniGameProxy

	arg_18_0.linkGameData = var_1.GetMiniGameData(var_18_1, var_0_1.HOLOLIVE_LINKGAME_ID)

	return
end

function var_0_1.updateUI(arg_19_0)
	arg_19_0:updateProgressBar()
	arg_19_0:updateAwardPanel()
	arg_19_0:updateEntranceList()

	return
end

function var_0_1.isTip()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10001

	local var_20_0 = var_1_10000(var_1_10001)

	if var_0.GetHubByHubId(var_20_0, var_0_1.HOLOLIVE_LINKGAME_HUB_ID).ultimate == 0 and var_1.usedtime >= 7 then
		return true
	elseif var_1.count > 0 then
		return true
	end

	return
end

return var_0_1
