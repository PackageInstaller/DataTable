class = var_0_10000

local var_0_0 = "NewMeixiV4Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewMeixiV4UI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.ani = var_1.Find(var_3_0, "TV01")

	local var_3_1 = arg_3_0._tf

	arg_3_0.progress = var_1.Find(var_3_1, "progress/Text")

	local var_3_2 = arg_3_0._tf

	arg_3_0.nodes = var_1.Find(var_3_2, "nodes")

	local var_3_3 = arg_3_0._tf

	arg_3_0.nodeInfo = var_1.Find(var_3_3, "node_info")

	local var_3_4 = arg_3_0._tf

	arg_3_0.titleTxt = var_1.Find(var_3_4, "progress/title")

	local var_3_5 = arg_3_0._tf

	arg_3_0.titleNum = var_1.Find(var_3_5, "progress/cur")

	local var_3_6 = arg_3_0._tf

	arg_3_0.helpBtn = var_1.Find(var_3_6, "help_btn")

	local var_3_7 = arg_3_0._tf

	arg_3_0.storyTip = var_1.Find(var_3_7, "get_story")
	getProxy = var_1
	TaskProxy = var_3_7
	arg_3_0.taskProxy = var_1(var_3_7)
	pg = var_1

	local var_3_8 = var_1.activity_template

	ActivityConst = var_1_10002
	arg_3_0.storyGroup = var_3_8[var_1_10002.NEWMEIXIV4_SKIRMISH_ID].config_client.storys
	arg_3_0.memoryGroup = var_1.config_client.memoryGroup

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "top/back_btn")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_4.Find(var_4_5, "top/option")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_4_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_4_5)

	onButton = var_1_10001

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0.helpBtn

	local function var_4_10()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		i18n = var_2_10004
		var_7_2.helps = var_2_10004("MeixiV4_help")

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_4_5

	var_1_10001(var_4_8, var_4_9, var_4_10, var_4_5)

	setText = var_1_10001

	local var_4_11 = arg_4_0.storyTip
	local var_4_12 = var_3.Find(var_4_11, "bar/tip")

	i18n = var_4_9

	var_1_10001(var_4_12, var_4_9("world_collection_back"))
	arg_4_0:playAni()
	arg_4_0:updateNodes()

	return
end

function var_0_1.setPlayer(arg_8_0, arg_8_1)
	arg_8_0.player = arg_8_1

	arg_8_0:onUpdateRes(arg_8_1)

	return
end

function var_0_1.onUpdateRes(arg_9_0, arg_9_1)
	arg_9_0.player = arg_9_1

	return
end

function var_0_1.playAni(arg_10_0)
	SetActive = var_1_10001

	var_1_10001(arg_10_0.ani, true)

	local var_10_0 = arg_10_0.ani
	local var_10_1 = var_1.GetComponent(var_10_0, "DftAniEvent")

	var_1.SetEndEvent(var_10_1, function(arg_11_0)
		SetActive = var_2_10001

		var_2_10001(arg_10_0.ani, false)

		return
	end)

	pg = var_2

	local var_10_2 = var_2.CriMgr.GetInstance()
	local var_10_3 = var_2.PlaySoundEffect_V3

	SFX_UI_WARNING = var_5

	var_10_3(var_10_2, var_5)

	return
end

function var_0_1.setCurIndex(arg_12_0)
	arg_12_0.curIndex = 1
	arg_12_0.clearTaskNum = 0
	arg_12_0.clearTaskNum = (function()
		ipairs = var_2_10000

		for iter_13_0, iter_13_1 in var_2_10000(arg_12_0.contextData.taskList) do
			local var_13_0 = arg_12_0.taskProxy
			local var_13_2

			if not var_5.getTaskById(var_13_0, iter_13_1) then
				local var_13_1 = arg_12_0.taskProxy

				var_13_2 = var_5.getFinishTaskById(var_13_1, iter_13_1)
			end

			if var_13_2 then
				return iter_13_0 - 1
			end
		end

		return
	end)()
	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(arg_12_0.contextData.taskList) do
		local var_12_0 = arg_12_0.taskProxy
		local var_12_2

		if not var_7.getTaskById(var_12_0, iter_12_1) then
			local var_12_1 = arg_12_0.taskProxy

			var_12_2 = var_7.getFinishTaskById(var_12_1, iter_12_1)
		end

		local var_12_3 = arg_12_0.contextData.taskList[iter_12_0 + 1]
		local var_12_4 = arg_12_0.taskProxy
		local var_12_6

		if not var_9.getTaskById(var_12_4, var_12_3) then
			local var_12_5 = arg_12_0.taskProxy

			var_12_6 = var_9.getFinishTaskById(var_12_5, var_12_3)
		end

		if var_12_2 and var_12_2:getTaskStatus() == 2 then
			arg_12_0.curIndex = arg_12_0.curIndex + 1

			if not var_12_3 or not var_12_6 then
				arg_12_0.curIndex = arg_12_0.curIndex - 1
			end
		end
	end

	arg_12_0.curIndex = arg_12_0.curIndex + arg_12_0.clearTaskNum

	return
end

function var_0_1.updateNodes(arg_14_0)
	arg_14_0:setCurIndex()

	setText = var_1

	local var_14_0 = arg_14_0.titleTxt
	local var_14_1 = "POSITION "

	string = var_1_10005

	var_1(var_14_0, var_14_1 .. var_1_10005.format("%02d", arg_14_0.curIndex))

	setText = var_1

	local var_14_2 = arg_14_0.titleNum

	string = var_4

	var_1(var_14_2, var_4.format("%02d", arg_14_0.curIndex))

	eachChild = var_1

	var_1(arg_14_0.nodes, function(arg_15_0)
		tonumber = var_2_10001

		local var_15_0 = var_2_10001(arg_15_0.name)
		local var_15_1 = arg_14_0.contextData.taskList[var_15_0]
		local var_15_2 = arg_14_0.taskProxy

		if not var_3.getTaskById(var_15_2, var_15_1) then
			local var_15_3 = arg_14_0.taskProxy
			local var_15_4 = var_3.getFinishTaskById(var_15_3, var_15_1)
		end

		setActive = var_2_10004

		var_2_10004(arg_15_0, var_15_0 <= arg_14_0.curIndex)

		onButton = var_2_10004

		local var_15_5 = arg_14_0
		local var_15_6 = arg_15_0

		local function var_15_7()
			local var_16_0 = arg_14_0

			var_0.updateNodeInfo(var_16_0, var_15_0)

			return
		end

		SFX_PANEL = var_2_10009

		var_2_10004(var_15_5, var_15_6, var_15_7, var_2_10009)

		return
	end)
	arg_14_0:updateNodeInfo(arg_14_0.curIndex)

	return
end

function var_0_1.nodeInfoTween(arg_17_0, arg_17_1)
	tf = var_1_10002

	local var_17_0 = arg_17_0._tf
	local var_17_1 = var_4.Find

	tostring = var_1_10007

	local var_17_2 = var_1_10002(var_17_1(var_17_0, var_1_10007(arg_17_1), arg_17_0.nodes)).localPosition

	if arg_17_1 == 9 then
		var_17_2.x = var_17_2.x - 80
	end

	if arg_17_1 == 7 then
		var_17_2.y = var_17_2.y - 20
	end

	local function var_17_3()
		setLocalPosition = var_2_10000

		local var_18_0 = arg_17_0.nodeInfo

		Vector3 = var_2_10003

		var_2_10000(var_18_0, var_2_10003(var_17_2.x, var_17_2.y + 120, 0))

		setLocalScale = var_2_10000

		local var_18_1 = arg_17_0.nodeInfo

		Vector3 = var_3

		var_2_10000(var_18_1, var_3(0, 0, 0))

		LeanTween = var_2_10000

		local var_18_2 = var_2_10000.scale

		tf = var_18_1

		local var_18_3 = var_18_1(arg_17_0.nodeInfo)

		Vector3 = var_3

		var_18_2(var_18_3, var_3.one, 0.1)

		return
	end

	local function var_17_4(arg_19_0)
		setLocalScale = var_2_10001

		local var_19_0 = arg_17_0.nodeInfo

		Vector3 = var_2_10004

		var_2_10001(var_19_0, var_2_10004(1, 1, 1))

		LeanTween = var_2_10001

		local var_19_1 = var_2_10001.scale

		tf = var_19_0

		local var_19_2 = var_19_0(arg_17_0.nodeInfo)

		Vector3 = var_4

		local var_19_3 = var_19_1(var_19_2, var_4.zero, 0.1)
		local var_19_4 = var_1.setOnComplete

		System = var_4

		var_19_4(var_19_3, var_4.Action(function()
			if arg_19_0 then
				arg_19_0()
			end

			return
		end))

		return
	end

	isActive = var_1_10005

	if not var_1_10005(arg_17_0.nodeInfo) then
		setActive = var_5

		var_5(arg_17_0.nodeInfo, true)
		var_17_3()
	else
		var_17_4(var_17_3)
	end

	return
end

function var_0_1.updateNodeInfo(arg_21_0, arg_21_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_21_0 = var_1_10002(var_1_10004)
	local var_21_1 = var_2.getActivityById

	ActivityConst = var_1_10005

	local var_21_2 = var_21_1(var_21_0, var_1_10005.NEWMEIXIV4_SKIRMISH_ID)

	updateActivityTaskStatus = var_1_10003

	var_1_10003(var_21_2)

	local var_21_3 = arg_21_0.contextData.taskList[arg_21_1]
	local var_21_4 = arg_21_0.taskProxy
	local var_21_6

	if not var_4.getTaskById(var_21_4, var_21_3) then
		local var_21_5 = arg_21_0.taskProxy

		var_21_6 = var_4.getFinishTaskById(var_21_5, var_21_3)
	end

	pg = var_5

	local var_21_7 = var_5.task_data_template[var_21_3]
	local var_21_8

	if not var_21_6 or not var_21_6:getProgress() then
		var_21_8 = var_21_7.target_num
	end

	local var_21_9

	if not var_21_6 or not var_21_6:getConfig("target_num") then
		var_21_9 = var_21_7.target_num
	end

	if var_21_6 then
		var_1_10010 = var_21_6

		local var_21_10

		if not var_21_6.getTaskStatus(var_1_10010) then
			var_21_10 = 2
		end

		local var_21_11

		if not var_21_6 or not var_21_6:getConfig("desc") then
			var_21_11 = var_21_7.desc
		end

		setSlider = var_1_10010

		local var_21_12 = arg_21_0.nodeInfo

		var_1_10010(var_12.Find(var_21_12, "progress"), 0, var_21_9, var_21_8)

		setText = var_1_10010

		local var_21_13 = arg_21_0.nodeInfo

		var_1_10010(var_12.Find(var_21_13, "step"), var_21_8 .. "/" .. var_21_9)

		setText = var_1_10010

		local var_21_14 = arg_21_0.nodeInfo

		var_1_10010(var_12.Find(var_21_14, "content"), var_21_11)

		setText = var_1_10010

		local var_21_15 = arg_21_0.nodeInfo
		local var_21_16 = var_12.Find(var_21_15, "title")

		string = var_13

		var_1_10010(var_21_16, var_13.format("%02d", arg_21_1))

		local var_21_17 = arg_21_0.nodeInfo
		local var_21_18 = var_10.Find(var_21_17, "go_btn")
		local var_21_19 = arg_21_0.nodeInfo
		local var_21_20 = var_11.Find(var_21_19, "get_btn")
		local var_21_21 = arg_21_0.nodeInfo
		local var_21_22 = var_12.Find(var_21_21, "step/finish")

		setActive = var_21_19

		var_21_19(var_21_18, var_21_10 == 0)

		setActive = var_21_19

		var_21_19(var_21_20, var_21_10 == 1)

		setActive = var_21_19

		var_21_19(var_21_22, var_21_10 == 2)

		onButton = var_21_19

		local var_21_23 = arg_21_0
		local var_21_24 = var_21_18

		local function var_21_25()
			local var_22_0 = arg_21_0
			local var_22_1 = var_0.emit

			NewMeixiV4Mediator = var_2_10003

			var_22_1(var_22_0, var_2_10003.ON_TASK_GO, var_21_6)

			return
		end

		SFX_PANEL = var_1_10018

		var_21_19(var_21_23, var_21_24, var_21_25, var_1_10018)

		onButton = var_21_19

		local var_21_26 = arg_21_0
		local var_21_27 = var_21_20

		local function var_21_28()
			local var_23_0 = arg_21_0
			local var_23_1 = var_0.emit

			NewMeixiV4Mediator = var_2_10003

			var_23_1(var_23_0, var_2_10003.ON_TASK_SUBMIT, var_21_6)

			return
		end

		SFX_PANEL = var_1_10018

		var_21_19(var_21_26, var_21_27, var_21_28, var_1_10018)

		eachChild = var_21_19

		var_21_19(arg_21_0.nodes, function(arg_24_0)
			local var_24_0 = arg_24_0:Find("arrow")

			LeanTween = var_2_10002

			var_2_10002.cancel(var_24_0.gameObject)

			setLocalPosition = var_2

			local var_24_1 = var_24_0

			Vector3 = var_2_10005

			var_2(var_24_1, var_2_10005(0, 27, 0))

			tonumber = var_2

			local var_24_3

			if var_2(arg_24_0.name) == arg_21_1 then
				setActive = var_24_3

				var_24_3(var_24_0, true)

				LeanTween = var_24_3

				local var_24_2 = var_24_3.moveY(var_24_0, 40, 0.5)

				var_24_3 = var_24_3.setEase
				LeanTweenType = var_6

				local var_24_4 = var_24_3(var_24_2, var_6.easeInOutSine)

				var_24_3.setLoopPingPong(var_24_4)
			else
				setActive = var_24_3

				var_24_3(var_24_0, false)
			end

			return
		end)
		arg_21_0:nodeInfoTween(arg_21_1)

		return
	end
end

function var_0_1.onUpdateTask(arg_25_0)
	local var_25_0 = arg_25_0.contextData.taskList[arg_25_0.curIndex]

	pairs = var_2

	for iter_25_0, iter_25_1 in var_2(arg_25_0.storyGroup) do
		if var_25_0 == iter_25_1[1] then
			arg_25_0:getStory(iter_25_1[2], iter_25_1[3])
		end
	end

	arg_25_0:updateNodes()

	return
end

function var_0_1.getStory(arg_26_0, arg_26_1, arg_26_2)
	setActive = var_1_10003

	var_1_10003(arg_26_0.storyTip, true)

	pg = var_1_10003

	local var_26_0 = var_1_10003.memory_template[arg_26_1].title

	pg = var_1_10004

	local var_26_1 = var_1_10004.NewStoryMgr.GetInstance()

	var_4.SetPlayedFlag(var_26_1, arg_26_2)

	setText = var_4

	local var_26_2 = arg_26_0.storyTip

	var_4(var_6.Find(var_26_2, "bar/Anim/Frame/Mask/Name"), var_26_0)

	removeOnButton = var_4

	var_4(arg_26_0.storyTip)

	removeOnButton = var_4

	local var_26_3 = arg_26_0.storyTip

	var_4(var_6.Find(var_26_3, "bar/Button"))

	pg = var_4

	local var_26_4 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_26_4, arg_26_0.storyTip)

	local var_26_5 = arg_26_0.storyTip
	local var_26_6 = var_4.Find(var_26_5, "bar")
	local var_26_7 = var_4.GetComponent

	typeof = var_7
	DftAniEvent = var_9

	local var_26_8 = var_26_7(var_26_6, var_7(var_9))

	local function var_26_9()
		onButton = var_2_10000

		var_2_10000(arg_26_0, arg_26_0.storyTip, function()
			pg = var_3_10000

			local var_28_0 = var_3_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_28_0, arg_26_0.storyTip)

			setActive = var_0

			var_0(arg_26_0.storyTip, false)

			return
		end)

		onButton = var_2_10000

		local var_27_0 = arg_26_0
		local var_27_1 = arg_26_0.storyTip
		local var_27_2 = var_3.Find(var_27_1, "bar/Button")

		local function var_27_3()
			local var_29_0 = arg_26_0
			local var_29_1 = var_0.emit

			NewMeixiV4Mediator = var_3_10003

			var_29_1(var_29_0, var_3_10003.GO_STORY, arg_26_0.memoryGroup)

			triggerButton = var_29_1

			var_29_1(arg_26_0.storyTip)

			return
		end

		SFX_PANEL = var_27_1

		var_2_10000(var_27_0, var_27_2, var_27_3, var_27_1)

		return
	end

	var_26_8:SetEndEvent(var_26_9)

	return
end

function var_0_1.willExit(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.storyTip, false)

	pg = var_1_10001

	local var_30_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_30_0, arg_30_0.storyTip)

	return
end

return var_0_1
