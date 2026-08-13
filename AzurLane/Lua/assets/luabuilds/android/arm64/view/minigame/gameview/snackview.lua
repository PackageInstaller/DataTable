class = var_0_10000

local var_0_0 = "SnackView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

var_0_1.States_Before = 0
var_0_1.States_Memory = 1
var_0_1.States_Select = 2
var_0_1.States_Finished = 3
var_0_1.Ani_Close_2_Open = true
var_0_1.Ani_Open_2_Close = false
var_0_1.Bubble_Fade_Time = 0.5
var_0_1.Order_Num = 3
var_0_1.Snack_Num = 9

function var_0_1.getUIName(arg_1_0)
	return "Snack"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:initList()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:initTime()
	arg_3_0:updateSDModel()
	arg_3_0:setState(var_0_1.States_Before)

	return
end

function var_0_1.OnGetAwardDone(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.cmd

	MiniGameOPCommand = var_1_10003

	local var_4_1

	if var_4_0 == var_1_10003.CMD_COMPLETE then
		if arg_4_0:GetMGHubData().ultimate == 0 then
			var_4_1 = var_2.usedtime

			local var_4_2 = var_2

			if var_4_1 >= var_2.getConfig(var_4_2, "reward_need") then
				pg = var_4_1

				local var_4_3 = var_4_1.m02

				var_4_1 = var_4_1.sendNotification
				GAME = var_4_2

				local var_4_4 = var_4_2.SEND_MINI_GAME_OP
				local var_4_5 = {
					hubid = var_2.id
				}

				MiniGameOPCommand = var_8
				var_4_5.cmd = var_8.CMD_ULTIMATE
				var_4_5.args1 = {}

				var_4_1(var_4_3, var_4_4, var_4_5)
			end
		end
	else
		local var_4_6 = arg_4_1.cmd

		MiniGameOPCommand = var_4_1

		if var_4_6 == var_4_1.CMD_ULTIMATE then
			-- block empty
		end
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_5_0)
	local var_5_0 = arg_5_0

	arg_5_0.updateCount(var_5_0)

	getProxy = var_1
	MiniGameProxy = var_5_0

	local var_5_1 = var_1(var_5_0)
	local var_5_2 = var_1.GetMiniGameData

	MiniGameDataCreator = var_1_10004

	local var_5_3 = var_5_2(var_5_1, var_1_10004.ShrineGameID)
	local var_5_4

	if not var_1.GetRuntimeData(var_5_3, "count") then
		var_5_4 = 0
	end

	local var_5_5 = var_5_4 + 1

	pg = var_5_3

	local var_5_6 = var_5_3.m02
	local var_5_7 = var_4.sendNotification

	GAME = var_1_10007

	local var_5_8 = var_1_10007.MODIFY_MINI_GAME_DATA
	local var_5_9 = {}

	MiniGameDataCreator = var_1_10009
	var_5_9.id = var_1_10009.ShrineGameID
	var_5_9.map = {
		count = var_5_5
	}

	var_5_7(var_5_6, var_5_8, var_5_9)

	return
end

function var_0_1.onBackPressed(arg_6_0)
	if arg_6_0.state == var_0_1.States_Before then
		arg_6_0:emit(var_0_1.ON_BACK_PRESSED)

		return
	end

	if arg_6_0.timer then
		local var_6_0 = arg_6_0.timer

		var_1.Stop(var_6_0)
	end

	pg = var_1

	local var_6_1 = var_1.MsgboxMgr.GetInstance()
	local var_6_2 = var_1.ShowMsgBox
	local var_6_3 = {}

	i18n = var_1_10005
	var_6_3.content = var_1_10005("tips_summergame_exit")

	function var_6_3.onYes()
		arg_6_0.countTime = 0

		local var_7_0 = arg_6_0.timer

		var_0.Start(var_7_0)

		return
	end

	function var_6_3.onNo()
		local var_8_0 = arg_6_0.timer

		var_0.Start(var_8_0)

		return
	end

	var_6_2(var_6_1, var_6_3)

	return
end

function var_0_1.willExit(arg_9_0)
	if arg_9_0.timer then
		local var_9_0 = arg_9_0.timer

		var_1.Stop(var_9_0)
	end

	if arg_9_0.prefab and arg_9_0.model then
		PoolMgr = var_1

		local var_9_1 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_9_1, arg_9_0.prefab, arg_9_0.model)

		arg_9_0.prefab = nil
		arg_9_0.model = nil
	end

	return
end

function var_0_1.findUI(arg_10_0)
	local var_10_0 = arg_10_0._tf
	local var_10_1 = var_1.Find(var_10_0, "ForNotch")

	arg_10_0.backBtn = var_1.Find(var_10_1, "BackBtn")
	arg_10_0.helpBtn = var_1:Find("HelpBtn")
	arg_10_0.countText = var_1:Find("Count/CountText")

	local var_10_2 = arg_10_0._tf
	local var_10_3 = var_2.Find(var_10_2, "GameContent")

	arg_10_0.startBtn = var_2.Find(var_10_3, "StartBtn")

	local var_10_4 = var_2:Find("Tip")

	arg_10_0.considerTipTF = var_3.Find(var_10_4, "ConsiderTip")

	local var_10_5 = arg_10_0.considerTipTF

	arg_10_0.considerTimeText = var_4.Find(var_10_5, "TimeText")
	arg_10_0.selectTipTF = var_3:Find("SelectTip")

	local var_10_6 = arg_10_0.selectTipTF

	arg_10_0.selectTimeText = var_4.Find(var_10_6, "TimeText")
	arg_10_0.selectedContainer = var_2:Find("SelectedContainer")
	arg_10_0.selectedTpl = var_2:Find("SelectedTpl")
	GetComponent = var_4
	arg_10_0.selectedContainerCG = var_4(arg_10_0.selectedContainer, "CanvasGroup")
	arg_10_0.snackContainer = var_2:Find("SnackContainer")
	GetComponent = var_4
	arg_10_0.animtor = var_4(arg_10_0.snackContainer, "Animator")
	GetComponent = var_4
	arg_10_0.dftAniEvent = var_4(arg_10_0.snackContainer, "DftAniEvent")

	local var_10_7 = arg_10_0.dftAniEvent

	var_4.SetEndEvent(var_10_7, function(arg_11_0)
		local var_11_0 = arg_10_0

		var_1.setState(var_11_0, var_0_1.States_Select)

		return
	end)

	arg_10_0.spineCharContainer = var_2:Find("SpineChar")

	return
end

function var_0_1.initData(arg_12_0)
	arg_12_0.state = nil
	arg_12_0.orderIDList = {}
	arg_12_0.selectedIDList = {}
	arg_12_0.snackIDList = {}
	arg_12_0.score = 0
	arg_12_0.packageData = {}
	arg_12_0.selectedTFList = {}
	arg_12_0.snackTFList = {}
	arg_12_0.selectedSnackTFList = {}

	return
end

function var_0_1.initTime(arg_13_0)
	local var_13_0 = arg_13_0:GetMGData()

	arg_13_0.orginMemoryTime = var_1.getConfig(var_13_0, "simple_config_data").memory_time

	local var_13_1 = arg_13_0:GetMGData()

	arg_13_0.orginSelectTime = var_1.getConfig(var_13_1, "simple_config_data").select_time
	arg_13_0.countTime = nil
	arg_13_0.leftTime = arg_13_0.orginSelectTime

	return
end

function var_0_1.initTimer(arg_14_0, arg_14_1)
	if arg_14_0.state == var_0_1.States_Memory then
		arg_14_0.countTime = arg_14_0.orginMemoryTime
	elseif arg_14_0.state == var_0_1.States_Select then
		arg_14_0.countTime = arg_14_0.leftTime
	end

	Timer = var_2
	arg_14_0.timer = var_2.New(arg_14_1, 1, -1)

	local var_14_0 = arg_14_0.timer

	var_2.Start(var_14_0)

	return
end

function var_0_1.initList(arg_15_0)
	for iter_15_0 = 1, var_0_1.Order_Num do
		local var_15_0 = arg_15_0.selectedContainer
		local var_15_1 = var_5.GetChild(var_15_0, iter_15_0 - 1)

		arg_15_0.selectedTFList[iter_15_0] = var_15_1
	end

	for iter_15_1 = 1, var_0_1.Snack_Num do
		local var_15_2 = arg_15_0.snackContainer
		local var_15_3 = var_5.GetChild(var_15_2, iter_15_1 - 1)

		arg_15_0.snackTFList[iter_15_1] = var_15_3
	end

	return
end

function var_0_1.addListener(arg_16_0)
	onButton = var_1_10001

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.backBtn

	local function var_16_2()
		local var_17_0 = arg_16_0

		var_0.onBackPressed(var_17_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_16_0, var_16_1, var_16_2, var_1_10006)

	onButton = var_1_10001

	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_0.helpBtn

	local function var_16_5()
		pg = var_2_10000

		local var_18_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_18_1 = var_0.ShowMsgBox
		local var_18_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_18_2.type = var_2_10004
		pg = var_2_10004
		var_18_2.helps = var_2_10004.gametip.help_summer_food.tip

		var_18_1(var_18_0, var_18_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_16_3, var_16_4, var_16_5, var_1_10006)

	onButton = var_1_10001

	local var_16_6 = arg_16_0
	local var_16_7 = arg_16_0.startBtn

	local function var_16_8()
		local var_19_0 = arg_16_0

		var_0.setState(var_19_0, var_0_1.States_Memory)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_16_6, var_16_7, var_16_8, var_1_10006)

	for iter_16_0 = 1, var_0_1.Snack_Num do
		local var_16_9 = arg_16_0.snackContainer
		local var_16_10 = var_5.GetChild(var_16_9, iter_16_0 - 1)

		onButton = var_1_10006

		local var_16_11 = arg_16_0
		local var_16_12 = var_16_10

		local function var_16_13()
			local var_20_0 = arg_16_0.snackIDList[iter_16_0]
			local var_20_1 = var_16_10
			local var_20_2 = var_1.Find(var_20_1, "SelectedTag")

			isActive = var_2_10002

			if var_2_10002(var_20_2) == true then
				table = var_20_1

				var_20_1.removebyvalue(arg_16_0.selectedIDList, var_20_0)

				local var_20_3 = arg_16_0

				var_20_1.updateSelectedList(var_20_3, arg_16_0.selectedIDList)

				var_20_1 = arg_16_0.selectedSnackTFList
				var_20_1[var_20_0] = nil
				setActive = var_20_1

				var_20_1(var_20_2, false)

				local var_20_4 = arg_16_0

				var_20_1.updateSelectedOrderTag(var_20_4)
			else
				table = var_20_1

				var_20_1.insert(arg_16_0.selectedIDList, var_20_0)

				local var_20_5 = arg_16_0

				var_3.updateSelectedList(var_20_5, arg_16_0.selectedIDList)

				local var_20_6 = arg_16_0.selectedSnackTFList

				var_20_6[var_20_0] = var_16_10
				setActive = var_20_6

				var_20_6(var_20_2, true)

				local var_20_7 = arg_16_0

				var_3.updateSelectedOrderTag(var_20_7)

				if #arg_16_0.selectedIDList == var_0_1.Order_Num then
					local var_20_8 = arg_16_0.timer

					var_3.Stop(var_20_8)

					local var_20_9 = arg_16_0

					var_3.setState(var_20_9, var_0_1.States_Finished)
				end
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_16_11, var_16_12, var_16_13, var_1_10011)
	end

	return
end

function var_0_1.updateSDModel(arg_21_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)
	local var_21_1 = var_1.getData(var_21_0)

	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_21_2 = var_1_10003(var_1_10005)
	local var_21_3 = var_3.getShipById(var_21_2, var_21_1.character)
	local var_21_4 = var_4.getPrefab(var_21_3)

	pg = var_21_2

	local var_21_5 = var_21_2.UIMgr.GetInstance()

	var_6.LoadingOn(var_21_5)

	PoolMgr = var_6

	local var_21_6 = var_6.GetInstance()

	var_6.GetSpineChar(var_21_6, var_21_4, true, function(arg_22_0)
		pg = var_2_10001

		local var_22_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_22_0)

		arg_21_0.prefab = var_21_4

		local var_22_1 = arg_21_0

		var_22_1.model = arg_22_0
		tf = var_22_1

		local var_22_2 = var_22_1(arg_22_0)

		Vector3 = var_2
		var_22_2.localScale = var_2(1, 1, 1)

		local var_22_3 = arg_22_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_22_3, "stand", 0)

		setParent = var_1

		var_1(arg_22_0, arg_21_0.spineCharContainer)

		return
	end)

	return
end

function var_0_1.updateSelectedList(arg_23_0, arg_23_1)
	arg_23_1 = arg_23_1 or {}

	for iter_23_0 = 1, var_0_1.Order_Num do
		local var_23_0 = arg_23_0.selectedContainer
		local var_23_1 = var_6.GetChild(var_23_0, iter_23_0 - 1)
		local var_23_2 = var_6.Find(var_23_1, "Empty")
		local var_23_3 = var_6:Find("Full")
		local var_23_4 = var_8.Find(var_23_3, "SnackImg")

		arg_23_0.selectedTFList[iter_23_0] = var_6

		local var_23_5 = arg_23_1[iter_23_0]

		setActive = var_23_3

		var_23_3(var_8, var_23_5)

		setActive = var_23_3

		var_23_3(var_23_2, not var_23_5)

		if var_23_5 then
			setImageSprite = var_23_3

			local var_23_6 = var_23_4

			GetSpriteFromAtlas = var_14

			var_23_3(var_23_6, var_14("ui/snackui_atlas", "snack_" .. var_23_5))
		end
	end

	return
end

function var_0_1.updateSnackList(arg_24_0, arg_24_1)
	for iter_24_0 = 1, var_0_1.Snack_Num do
		local var_24_0 = arg_24_0.snackContainer
		local var_24_1 = var_6.GetChild(var_24_0, iter_24_0 - 1)
		local var_24_2 = var_6.Find(var_24_1, "SnackImg")
		local var_24_3 = arg_24_1[iter_24_0]

		setImageSprite = var_24_1

		local var_24_4 = var_24_2

		GetSpriteFromAtlas = var_1_10012

		var_24_1(var_24_4, var_1_10012("ui/snackui_atlas", "snack_" .. var_24_3))

		local var_24_5 = var_6:Find("SelectedTag")

		setActive = var_10

		var_10(var_24_5, false)

		arg_24_0.snackTFList[iter_24_0] = var_6
		iter_24_0 = iter_24_0 + 1
	end

	return
end

function var_0_1.updateCount(arg_25_0)
	setText = var_1_10001

	var_1_10001(arg_25_0.countText, arg_25_0:GetMGHubData().count)

	return
end

function var_0_1.updateSelectedOrderTag(arg_26_0, arg_26_1)
	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.selectedSnackTFList) do
		local var_26_0 = iter_26_1
		local var_26_1 = iter_26_1.Find(var_26_0, "SelectedTag")

		if arg_26_1 then
			setActive = var_1_10008

			var_1_10008(var_26_1, false)
		else
			table = var_1_10008
			var_1_10008 = var_1_10008.indexof(arg_26_0.selectedIDList, iter_26_0, 1)
			setImageSprite = var_26_0

			local var_26_2 = var_26_1

			GetSpriteFromAtlas = var_12

			var_26_0(var_26_2, var_12("ui/snackui_atlas", "order_" .. var_1_10008))
		end
	end

	return
end

function var_0_1.updateSnackInteractable(arg_27_0, arg_27_1)
	ipairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0.snackTFList) do
		setButtonEnabled = var_1_10007

		var_1_10007(iter_27_1, arg_27_1)
	end

	return
end

function var_0_1.onStateChange(arg_28_0)
	if arg_28_0.state == var_0_1.States_Before then
		setActive = var_1

		var_1(arg_28_0.selectedContainer, false)

		setActive = var_1

		var_1(arg_28_0.startBtn, true)

		setActive = var_1

		var_1(arg_28_0.considerTipTF, false)

		setActive = var_1

		var_1(arg_28_0.selectTipTF, false)
		arg_28_0:updateCount()
		arg_28_0:updateSnackInteractable(false)
	elseif arg_28_0.state == var_0_1.States_Memory then
		setActive = var_1

		var_1(arg_28_0.selectedContainer, true)

		setActive = var_1

		var_1(arg_28_0.startBtn, false)

		arg_28_0.orderIDList = arg_28_0:randFetch(3, 9)

		arg_28_0:updateSelectedList(arg_28_0.orderIDList)

		arg_28_0.snackIDList = arg_28_0:randFetch(9, 9)

		arg_28_0:updateSnackList(arg_28_0.snackIDList)
		arg_28_0:updateSnackInteractable(false)

		local function var_28_0()
			local var_29_0 = arg_28_0

			var_29_0.countTime = arg_28_0.countTime - 1
			setText = var_29_0

			var_29_0(arg_28_0.considerTimeText, arg_28_0.countTime)

			if arg_28_0.countTime == 0 then
				local var_29_1 = arg_28_0.timer

				var_0.Stop(var_29_1)

				local var_29_2 = arg_28_0.animtor

				var_0.SetBool(var_29_2, "AniSwitch", var_0_1.Ani_Close_2_Open)
			end

			return
		end

		LeanTween = var_2

		local var_28_1 = var_2.value

		go = var_4

		local var_28_2 = var_28_1(var_4(arg_28_0.selectedContainer), 0, 1, var_0_1.Bubble_Fade_Time)
		local var_28_3 = var_2.setOnUpdate

		System = var_5

		local var_28_4 = var_28_3(var_28_2, var_5.Action_float(function(arg_30_0)
			arg_28_0.selectedContainerCG.alpha = arg_30_0

			return
		end))
		local var_28_5 = var_2.setOnComplete

		System = var_5

		var_28_5(var_28_4, var_5.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_28_0.considerTipTF, true)

			setActive = var_2_10000

			var_2_10000(arg_28_0.selectTipTF, false)

			local var_31_0 = arg_28_0

			var_0.initTimer(var_31_0, var_28_0)

			setText = var_0

			var_0(arg_28_0.considerTimeText, arg_28_0.countTime)

			return
		end))
	elseif arg_28_0.state == var_0_1.States_Select then
		setActive = var_1

		var_1(arg_28_0.considerTipTF, false)

		setActive = var_1

		var_1(arg_28_0.selectTipTF, true)
		arg_28_0:updateSelectedList()
		arg_28_0:updateSnackInteractable(true)

		local function var_28_6()
			local var_32_0 = arg_28_0

			var_32_0.countTime = arg_28_0.countTime - 1
			setText = var_32_0

			var_32_0(arg_28_0.selectTimeText, arg_28_0.countTime)

			if arg_28_0.countTime == 0 then
				local var_32_1 = arg_28_0.timer

				var_0.Stop(var_32_1)

				local var_32_2 = arg_28_0

				var_0.setState(var_32_2, var_0_1.States_Finished)
			end

			return
		end

		arg_28_0:initTimer(var_28_6)

		setText = var_2

		var_2(arg_28_0.selectTimeText, arg_28_0.countTime)
	elseif arg_28_0.state == var_0_1.States_Finished then
		local var_28_7 = arg_28_0

		arg_28_0.updateSnackInteractable(var_28_7, false)

		LeanTween = var_1

		local var_28_8 = var_1.value

		go = var_28_7

		local var_28_9 = var_28_8(var_28_7(arg_28_0.selectedContainer), 1, 0, var_0_1.Bubble_Fade_Time)
		local var_28_10 = var_1.setOnUpdate

		System = var_4

		local var_28_11 = var_28_10(var_28_9, var_4.Action_float(function(arg_33_0)
			arg_28_0.selectedContainerCG.alpha = arg_33_0

			return
		end))
		local var_28_12 = var_1.setOnComplete

		System = var_4

		var_28_12(var_28_11, var_4.Action(function()
			local var_34_0 = arg_28_0

			var_0.openResultView(var_34_0)

			return
		end))
	end

	return
end

function var_0_1.openResultView(arg_35_0)
	local var_35_0 = {
		orderIDList = arg_35_0.orderIDList,
		selectedIDList = arg_35_0.selectedIDList,
		countTime = arg_35_0.countTime,
		score = arg_35_0.score
	}
	local var_35_1 = arg_35_0:GetMGData()

	var_35_0.correctNumToEXValue = var_2.getConfig(var_35_1, "simple_config_data").correct_value

	local var_35_2 = arg_35_0:GetMGData()

	var_35_0.scoreLevel = var_2.getConfig(var_35_2, "simple_config_data").score_level

	function var_35_0.onSubmit(arg_36_0)
		local var_36_0 = arg_35_0

		if var_1.GetMGHubData(var_36_0).count > 0 then
			local var_36_1 = arg_35_0

			var_1.SendSuccess(var_36_1, arg_36_0)
		end

		arg_35_0.score = 0
		arg_35_0.countTime = nil
		arg_35_0.leftTime = arg_35_0.orginSelectTime
		arg_35_0.orderIDList = {}
		arg_35_0.selectedIDList = {}
		arg_35_0.snackIDList = {}

		local var_36_2 = arg_35_0

		var_1.updateSelectedOrderTag(var_36_2, true)

		arg_35_0.selectedSnackTFList = {}

		local var_36_3 = arg_35_0.animtor

		var_1.SetBool(var_36_3, "AniSwitch", var_0_1.Ani_Open_2_Close)

		local var_36_4 = arg_35_0

		var_1.setState(var_36_4, var_0_1.States_Before)

		return
	end

	function var_35_0.onContinue()
		arg_35_0.score = arg_35_0.packageData.score
		arg_35_0.leftTime = arg_35_0.packageData.countTime
		arg_35_0.orderIDList = {}
		arg_35_0.selectedIDList = {}
		arg_35_0.snackIDList = {}
		arg_35_0.selectedSnackTFList = {}

		local var_37_0 = arg_35_0.animtor

		var_0.SetBool(var_37_0, "AniSwitch", var_0_1.Ani_Open_2_Close)

		local var_37_1 = arg_35_0

		var_0.setState(var_37_1, var_0_1.States_Memory)

		return
	end

	arg_35_0.packageData = var_35_0
	SnackResultView = var_35_0
	arg_35_0.snackResultView = var_35_0.New(arg_35_0._tf, arg_35_0.event, arg_35_0.packageData)

	local var_35_3 = arg_35_0.snackResultView

	var_1.Reset(var_35_3)

	local var_35_4 = arg_35_0.snackResultView

	var_1.Load(var_35_4)

	return
end

function var_0_1.randFetch(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {}
	local var_38_1 = {}

	for iter_38_0 = 1, arg_38_1 do
		math = var_1_10009

		local var_38_2

		if not var_38_1[var_1_10009.random(iter_38_0, arg_38_2)] then
			var_38_2 = var_1_10009
		end

		local var_38_3

		if not var_38_1[iter_38_0] then
			var_38_3 = iter_38_0
		end

		var_38_1[var_1_10009] = var_38_3
		var_38_1[iter_38_0] = var_38_2
		table = var_38_3

		var_38_3.insert(var_38_0, var_38_2)
	end

	return var_38_0
end

function var_0_1.setState(arg_39_0, arg_39_1)
	if arg_39_0.state == arg_39_1 then
		return
	end

	arg_39_0.state = arg_39_1

	arg_39_0:onStateChange()

	return
end

return var_0_1
