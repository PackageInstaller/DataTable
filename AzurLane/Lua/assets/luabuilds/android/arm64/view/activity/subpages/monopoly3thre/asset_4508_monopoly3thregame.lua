class = var_0_10000

local var_0_0 = var_0_10000("Monopoly3thReGame")
local var_0_1 = 25
local var_0_2 = 25
local var_0_3
local var_0_4
local var_0_5 = 0.6
local var_0_6 = 100
local var_0_7 = "dafuweng_gold"
local var_0_8 = "dafuweng_oil"
local var_0_9 = "dafuweng_event"
local var_0_10 = "dafuweng_walk"
local var_0_11 = "stand"
local var_0_12 = "dafuweng_stand"
local var_0_13 = "dafuweng_jump"
local var_0_14 = "dafuweng_run"
local var_0_15 = "dafuweng_touch"
local var_0_16 = 35

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0._configId = arg_1_4

	arg_1_0:initData()
	arg_1_0:initUI()
	arg_1_0:initEvent()

	return
end

function var_0_0.initData(arg_2_0)
	arg_2_0.leftCount = 0
	pg = var_1
	arg_2_0.mapIds = var_1.activity_event_monopoly[arg_2_0._configId].map
	arg_2_0.inAnimatedFlag = false
	pg = var_1
	arg_2_0.lastBonusTimes = var_1.activity_event_monopoly[arg_2_0._configId].drop_times[1]
	Timer = var_1
	arg_2_0.randomMoveTiemr = var_1.New(function()
		local var_3_0 = arg_2_0

		var_0.checkPlayerRandomMove(var_3_0)

		return
	end, 15, -1)
	Timer = var_1
	arg_2_0.awardsTimer = var_1.New(function()
		if arg_2_0.awardTfs and #arg_2_0.awardTfs > 0 then
			for iter_4_0 = #arg_2_0.awardTfs, 1, -1 do
				var_5.y = arg_2_0.awardTfs[iter_4_0].anchoredPosition.y + 3

				if var_5.y >= 150 then
					Destroy = var_6
					table = var_2_10008

					var_6(var_2_10008.remove(arg_2_0.awardTfs, iter_4_0))
				else
					var_4.anchoredPosition = var_5
				end
			end
		end

		return
	end, 0.03333333333333333, -1)

	local var_2_0 = arg_2_0.awardsTimer

	var_1.Start(var_2_0)

	return
end

function var_0_0.initUI(arg_5_0)
	findTF = var_1_10001
	arg_5_0.char = var_1_10001(arg_5_0._tf, "map/char")
	setActive = var_1

	var_1(arg_5_0.char, false)

	setText = var_1
	findTF = var_3

	local var_5_0 = var_3(arg_5_0._tf, "desc")

	i18n = var_4

	var_1(var_5_0, var_4("monopoly3thre_tip"))

	findTF = var_1
	arg_5_0.btnStart = var_1(arg_5_0._tf, "btnStart")
	findTF = var_1
	arg_5_0.btnAutoStart = var_1(arg_5_0._tf, "btnAutoStart")
	setActive = var_1

	var_1(arg_5_0.btnStart, true)

	setActive = var_1

	var_1(arg_5_0.btnAutoStart, true)

	findTF = var_1
	arg_5_0.btnCancelAuto = var_1(arg_5_0._tf, "btnCancelAuto")
	setActive = var_1

	var_1(arg_5_0.btnCancelAuto, false)

	findTF = var_1
	arg_5_0.btnHelp = var_1(arg_5_0._tf, "btnHelp")
	findTF = var_1
	arg_5_0.btnRp = var_1(arg_5_0._tf, "btnRp")
	findTF = var_1

	local var_5_1 = var_1(arg_5_0.btnRp, "rpAni")
	local var_5_2 = var_1.GetComponent

	typeof = var_4
	Animator = var_6
	arg_5_0.commonAnim = var_5_2(var_5_1, var_4(var_6))
	findTF = var_1
	arg_5_0.labelLeftCountTip = var_1(arg_5_0._tf, "countTip/labelLeftCountTip")
	findTF = var_1
	arg_5_0.labelLeftCount = var_1(arg_5_0._tf, "countTip/labelLeftCount")
	findTF = var_1
	arg_5_0.labelDropShip = var_1(arg_5_0._tf, "labelDropShip")
	findTF = var_1
	arg_5_0.labelLeftRpCount = var_1(arg_5_0._tf, "labelLeftRpCount")
	findTF = var_1
	arg_5_0.cellPos = var_1(arg_5_0._tf, "map/mask/posCell")
	findTF = var_1
	arg_5_0.tplCell = var_1(arg_5_0._tf, "map/mask/posCell/tplCell")
	arg_5_0.mapCells = {}
	arg_5_0.curCellIndex = nil
	arg_5_0.groundChildsList = {}
	arg_5_0.groundMoveRate = {
		0.1,
		0.3,
		1
	}
	findTF = var_1
	arg_5_0.awardTf = var_1(arg_5_0._tf, "awardTpl")
	findTF = var_1
	arg_5_0.awardParent = var_1(arg_5_0.char, "award")

	for iter_5_0 = 1, 3 do
		findTF = var_5_3

		local var_5_3 = var_5_3(arg_5_0._tf, "map/mask/ground" .. iter_5_0)
		local var_5_4 = {}

		for iter_5_1 = 1, var_5_3.childCount do
			table = var_1_10011

			var_1_10011.insert(var_5_4, var_5_3:GetChild(iter_5_1 - 1))
		end

		table = var_7

		var_7.insert(arg_5_0.groundChildsList, var_5_4)
	end

	Ship = var_1

	local var_5_5 = var_1.New({
		configId = var_0_1,
		skin_id = var_0_2
	})
	local var_5_6 = var_1.getPrefab(var_5_5)

	PoolMgr = var_3

	local var_5_7 = var_3.GetInstance()

	var_3.GetSpineChar(var_5_7, var_5_6, true, function(arg_6_0)
		arg_5_0.model = arg_6_0

		local var_6_0 = arg_5_0.model.transform

		Vector3 = var_2_10002
		var_6_0.localScale = var_2_10002.one

		local var_6_1 = arg_5_0.model.transform

		Vector3 = var_2
		var_6_1.localPosition = var_2.zero

		local var_6_2 = arg_5_0.model.transform

		var_1.SetParent(var_6_2, arg_5_0.char, false)

		local var_6_3 = arg_5_0
		local var_6_4 = arg_5_0.model
		local var_6_5 = var_2.GetComponent

		typeof = var_5
		SpineAnimUI = var_2_10007
		var_6_3.anim = var_6_5(var_6_4, var_5(var_2_10007))

		local var_6_6 = arg_5_0

		var_1.changeCharAction(var_6_6, var_0_11, 0, nil)

		local var_6_7 = arg_5_0

		var_1.checkCharActive(var_6_7)

		return
	end)

	local var_5_8 = arg_5_0.randomMoveTiemr

	var_3.Start(var_5_8)

	return
end

function var_0_0.initEvent(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0._binder
	local var_7_1 = arg_7_0.btnAutoStart

	local function var_7_2()
		setActive = var_2_10000

		var_2_10000(arg_7_0.btnCancelAuto, true)

		arg_7_0.autoFlag = true

		local var_8_0 = arg_7_0

		var_0.start(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10001

	local var_7_3 = arg_7_0._binder
	local var_7_4 = arg_7_0.btnCancelAuto

	local function var_7_5()
		setActive = var_2_10000

		var_2_10000(arg_7_0.btnCancelAuto, false)

		arg_7_0.autoFlag = false

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10006)

	onButton = var_1_10001

	local var_7_6 = arg_7_0._binder
	local var_7_7 = arg_7_0.btnStart

	local function var_7_8()
		local var_10_0 = arg_7_0

		var_0.start(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10006)

	onButton = var_1_10001

	local var_7_9 = arg_7_0._binder
	local var_7_10 = arg_7_0.btnHelp

	local function var_7_11()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_11_2.type = var_2_10004
		pg = var_2_10004
		var_11_2.helps = var_2_10004.gametip.help_monopoly_3th.tip

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10006)

	onButton = var_1_10001

	local var_7_12 = arg_7_0._binder
	local var_7_13 = arg_7_0.char

	local function var_7_14()
		if not arg_7_0.model or arg_7_0.inAnimatedFlag then
			return
		end

		LeanTween = var_0

		local var_12_0 = var_0.isTweening

		go = var_2_10002

		if var_12_0(var_2_10002(arg_7_0.cellPos)) then
			LeanTween = var_0

			local var_12_1 = var_0.cancel

			go = var_2

			var_12_1(var_2(arg_7_0.cellPos))
		end

		local var_12_2 = arg_7_0

		var_0.changeCharAction(var_12_2, var_0_15, 1, function()
			local var_13_0 = arg_7_0

			var_0.changeCharAction(var_13_0, var_0_11)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_12, var_7_13, var_7_14, var_1_10006)

	onButton = var_1_10001

	local var_7_15 = arg_7_0._binder
	local var_7_16 = arg_7_0.btnRp

	local function var_7_17()
		if arg_7_0.leftAwardCnt > 0 then
			local var_14_0 = arg_7_0._event
			local var_14_1 = var_0.emit

			Monopoly3thRePage = var_2_10003

			var_14_1(var_14_0, var_2_10003.ON_AWARD)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_15, var_7_16, var_7_17, var_1_10006)

	return
end

function var_0_0.addAwards(arg_15_0, arg_15_1)
	if not arg_15_0.awardTfs then
		arg_15_0.awardTfs = {}
	end

	for iter_15_0 = 1, #arg_15_1 do
		local var_15_0 = arg_15_1[iter_15_0]

		tf = var_1_10007
		instantiate = var_1_10009
		go = var_1_10011
		var_1_10007 = var_1_10007(var_1_10009(var_1_10011(arg_15_0.awardTf)))
		setParent = var_1_10008

		var_1_10008(var_1_10007, arg_15_0.awardParent)

		updateDrop = var_1_10008

		var_1_10008(var_1_10007, var_15_0)

		Vector2 = var_1_10008
		var_1_10007.anchoredPosition = var_1_10008(0, 0)
		setActive = var_1_10008

		var_1_10008(var_1_10007, true)

		table = var_1_10008

		var_1_10008.insert(arg_15_0.awardTfs, var_1_10007)
	end

	return
end

function var_0_0.start(arg_16_0)
	if arg_16_0.inAnimatedFlag then
		return
	end

	if arg_16_0.leftCount and arg_16_0.leftCount <= 0 then
		pg = var_1

		local var_16_0 = var_1.TipsMgr.GetInstance()
		local var_16_1 = var_1.ShowTips

		i18n = var_1_10004

		var_16_1(var_16_0, var_1_10004("common_count_noenough"))

		if arg_16_0.autoFlag and not arg_16_0:checkLastBonus() then
			arg_16_0.autoFlag = false
			setActive = var_1

			var_1(arg_16_0.btnCancelAuto, false)
			arg_16_0:changeAnimeState(false, true)
		end

		return
	end

	arg_16_0:changeAnimeState(true)

	local var_16_2 = arg_16_0._event
	local var_16_3 = var_1.emit

	Monopoly3thRePage = var_4

	var_16_3(var_16_2, var_4.ON_START, arg_16_0.activity.id, function(arg_17_0)
		if arg_17_0 and arg_17_0 > 0 then
			arg_16_0.step = arg_17_0

			local var_17_0 = arg_16_0

			var_1.updataUI(var_17_0)

			local var_17_1 = arg_16_0

			var_1.checkCharActive(var_17_1)
		end

		return
	end)

	return
end

function var_0_0.checkPlayerRandomMove(arg_18_0)
	if not arg_18_0.model or arg_18_0.inAnimatedFlag then
		return
	end

	math = var_1

	if var_1.random() > 0.5 then
		math = var_1

		local var_18_0 = 300 * var_1.random(2, 4)
		local var_18_1 = var_1 * 2
		local var_18_2 = 0
		local var_18_3 = arg_18_0

		arg_18_0.changeCharAction(var_18_3, var_0_10, 0, nil)

		LeanTween = var_5

		local var_18_4 = var_5.value

		go = var_18_3

		local var_18_5 = var_18_4(var_18_3(arg_18_0.cellPos), 0, var_18_0, var_18_1)
		local var_18_6 = var_5.setEase

		LeanTweenType = var_8

		local var_18_7 = var_18_6(var_18_5, var_8.linear)
		local var_18_8 = var_5.setOnUpdate

		System = var_8

		local var_18_9 = var_18_8(var_18_7, var_8.Action_float(function(arg_19_0)
			local var_19_0 = arg_18_0

			var_1.updateMap(var_19_0, arg_19_0 - var_18_2)

			var_18_2 = arg_19_0

			return
		end))
		local var_18_10 = var_5.setOnComplete

		System = var_8

		var_18_10(var_18_9, var_8.Action(function()
			local var_20_0 = arg_18_0

			var_0.changeCharAction(var_20_0, var_0_11, 0, nil)

			return
		end))
	else
		arg_18_0:changeCharAction(var_0_12, 1, function()
			local var_21_0 = arg_18_0

			var_0.changeCharAction(var_21_0, var_0_11)

			return
		end)
	end

	return
end

function var_0_0.checkCountStory(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.useCount
	local var_22_1 = arg_22_0.activity
	local var_22_2

	if not var_3.getDataConfig(var_22_1, "story") then
		var_22_2 = {}
	end

	_ = var_1_10005

	if var_1_10005.detect(var_22_2, function(arg_23_0)
		return arg_23_0[1] == var_22_0
	end) then
		pg = var_22_1

		local var_22_3 = var_22_1.NewStoryMgr.GetInstance()

		var_6.Play(var_22_3, var_5[2], arg_22_1)
	else
		arg_22_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 then
		local var_24_0 = arg_24_0.btnStart

		var_1_10003 = var_1_10003.GetComponent
		typeof = var_1_10006
		Image = var_1_10008
		var_1_10003 = var_1_10003(var_24_0, var_1_10006(var_1_10008))
		var_1_10003.raycastTarget = false

		local var_24_1 = arg_24_0.btnAutoStart

		var_1_10003 = var_1_10003.GetComponent
		typeof = var_1_10006
		Image = var_1_10008
		var_1_10003 = var_1_10003(var_24_1, var_1_10006(var_1_10008))
		var_1_10003.raycastTarget = false
		arg_24_0.inAnimatedFlag = true
	else
		arg_24_0.inAnimatedFlag = false

		local var_24_2 = arg_24_0.btnStart

		var_1_10003 = var_1_10003.GetComponent
		typeof = var_1_10006
		Image = var_1_10008
		var_1_10003 = var_1_10003(var_24_2, var_1_10006(var_1_10008))
		var_1_10003.raycastTarget = true

		local var_24_3 = arg_24_0.btnAutoStart

		var_1_10003 = var_1_10003.GetComponent
		typeof = var_1_10006
		Image = var_1_10008
		var_1_10003 = var_1_10003(var_24_3, var_1_10006(var_1_10008))
		var_1_10003.raycastTarget = true
	end

	if not arg_24_1 and arg_24_0.autoFlag then
		arg_24_0:start()

		setActive = var_1_10003

		var_1_10003(arg_24_0.btnStart, false)

		setActive = var_1_10003

		var_1_10003(arg_24_0.btnAutoStart, false)
	else
		setActive = var_1_10003

		var_1_10003(arg_24_0.btnStart, not arg_24_1)

		setActive = var_1_10003

		var_1_10003(arg_24_0.btnAutoStart, not arg_24_1)
	end

	if not arg_24_1 and not arg_24_0.autoFlag and arg_24_2 then
		local var_24_4 = arg_24_0._event
		local var_24_5 = var_3.emit

		Monopoly3thRePage = var_1_10006

		var_24_5(var_24_4, var_1_10006.ON_STOP, nil, function()
			return
		end)
	end

	return
end

function var_0_0.checkCharActive(arg_26_0)
	if arg_26_0.anim then
		if arg_26_0.effectId and arg_26_0.effectId > 0 then
			arg_26_0:changeAnimeState(true)
			arg_26_0:checkEffect(function()
				local var_27_0 = arg_26_0

				var_0.changeAnimeState(var_27_0, false)

				local var_27_1 = arg_26_0

				var_0.checkCharActive(var_27_1)

				return
			end)
		elseif arg_26_0.step and arg_26_0.step > 0 then
			arg_26_0:changeAnimeState(true)
			arg_26_0:checkStep(function()
				local var_28_0 = arg_26_0

				var_0.changeAnimeState(var_28_0, false)

				local var_28_1 = arg_26_0

				var_0.checkCharActive(var_28_1)

				return
			end)
		else
			arg_26_0:checkLastBonus()
		end
	end

	return
end

function var_0_0.firstUpdata(arg_29_0, arg_29_1)
	arg_29_0:activityDataUpdata(arg_29_1)
	arg_29_0:updataUI()
	arg_29_0:updataChar()
	arg_29_0:checkCharActive()
	arg_29_0:checkLastBonus()

	if arg_29_0.pos and arg_29_0.pos > 0 then
		arg_29_0:updateMap(arg_29_0.pos * 1100 % 2500)
	end

	return
end

function var_0_0.updataActivity(arg_30_0, arg_30_1)
	arg_30_0:activityDataUpdata(arg_30_1)
	arg_30_0:updataUI()

	return
end

function var_0_0.checkLastBonus(arg_31_0)
	if (not arg_31_0.lastBonusFlag or arg_31_0.lastBonusFlag == 0) and arg_31_0.useCount and arg_31_0.useCount >= arg_31_0.lastBonusTimes then
		var_1_10003 = arg_31_0._event

		local var_31_0 = var_1.emit

		Monopoly3thRePage = var_1_10004

		var_31_0(var_1_10003, var_1_10004.MONOPOLY_OP_LAST, arg_31_0.activity.id, function(arg_32_0)
			local var_32_0 = arg_31_0

			var_32_0.lastBonusFlag = 1
			setActive = var_32_0
			findTF = var_2_10003

			var_32_0(var_2_10003(arg_31_0.labelDropShip, "get"), false)

			setActive = var_32_0
			findTF = var_3

			var_32_0(var_3(arg_31_0.labelDropShip, "got"), true)

			setActive = var_32_0
			findTF = var_3

			var_32_0(var_3(arg_31_0.labelDropShip, "text"), false)

			if arg_31_0.autoFlag then
				local var_32_1 = arg_31_0

				var_1.start(var_32_1)
			end

			return
		end)

		return true
	end

	if arg_31_0.lastBonusFlag == 1 then
		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_31_0.labelDropShip, "get"), false)

		setActive = var_1
		findTF = var_3

		var_1(var_3(arg_31_0.labelDropShip, "got"), true)

		setActive = var_1
		findTF = var_3

		var_1(var_3(arg_31_0.labelDropShip, "text"), false)
	end

	return false
end

function var_0_0.activityDataUpdata(arg_33_0, arg_33_1)
	arg_33_0.activity = arg_33_1
	pg = var_1_10002

	local var_33_0 = var_1_10002.TimeMgr.GetInstance()
	local var_33_1 = var_2.GetServerTime(var_33_0)
	local var_33_2 = arg_33_0.activity.data1

	math = var_33_0

	local var_33_3 = var_33_0.ceil((var_33_1 - var_33_2) / 0)
	local var_33_4 = arg_33_0.activity

	arg_33_0.totalCnt = var_33_3 * var_5.getDataConfig(var_33_4, "daily_time") + arg_33_0.activity.data1_list[1]
	arg_33_0.useCount = arg_33_0.activity.data1_list[2]
	arg_33_0.leftCount = arg_33_0.totalCnt - arg_33_0.useCount
	arg_33_0.turnCnt = arg_33_0.activity.data1_list[3] - 1
	arg_33_0.leftDropShipCnt = 8 - arg_33_0.turnCnt

	local var_33_5 = arg_33_0.activity.data2_list[2]
	local var_33_6 = arg_33_1

	arg_33_0.advanceTotalCnt = #arg_33_1.getDataConfig(var_33_6, "reward")
	arg_33_0.isAdvanceRp = arg_33_0.advanceTotalCnt - var_33_5 > 0
	arg_33_0.leftAwardCnt = arg_33_0.activity.data2_list[1] - var_33_5
	math = var_10

	local var_33_7 = var_10.max
	local var_33_8 = 0

	math = var_1_10013
	arg_33_0.advanceRpCount = var_33_7(var_33_8, var_1_10013.min(var_9, arg_33_0.advanceTotalCnt) - var_33_5)
	math = var_10

	local var_33_9 = var_10.max(0, var_9 - arg_33_0.advanceTotalCnt)

	math = var_33_6
	arg_33_0.commonRpCount = var_33_9 - var_33_6.max(0, var_33_5 - arg_33_0.advanceTotalCnt)
	arg_33_0.nextredPacketStep = arg_33_1:getDataConfig("reward_time") - arg_33_0.useCount % var_10

	if arg_33_0.useCount >= var_0_16 then
		arg_33_0.nextredPacketStep = nil
	end

	arg_33_0.pos = arg_33_0.activity.data2

	local var_33_10

	if not arg_33_0.activity.data3 then
		var_33_10 = 0
	end

	arg_33_0.step = var_33_10

	local var_33_11

	if not arg_33_0.activity.data4 then
		var_33_11 = 0
	end

	arg_33_0.effectId = var_33_11
	arg_33_0.lastBonusFlag = arg_33_0.activity.data2_list[3]

	return
end

function var_0_0.checkStep(arg_34_0, arg_34_1)
	if arg_34_0.step > 0 then
		local var_34_0 = arg_34_0._event
		local var_34_1 = var_2.emit

		Monopoly3thRePage = var_1_10005

		var_34_1(var_34_0, var_1_10005.ON_MOVE, arg_34_0.activity.id, function(arg_35_0, arg_35_1, arg_35_2)
			arg_34_0.step = arg_35_0
			arg_34_0.pos = arg_35_1[#arg_35_1]

			local var_35_0 = arg_34_0

			var_35_0.effectId = arg_35_2
			seriesAsync = var_35_0

			var_35_0({
				function(arg_36_0)
					local var_36_0 = var_0_14
					local var_36_1 = arg_34_0

					var_2.moveCharWithPaths(var_36_1, arg_35_1, var_36_0, arg_36_0)

					return
				end,
				function(arg_37_0)
					local var_37_0 = arg_34_0

					var_1.checkEffect(var_37_0, arg_37_0)

					return
				end
			}, function()
				if arg_34_1 then
					arg_34_1()
				end

				return
			end)

			return
		end)
	elseif arg_34_1 then
		arg_34_1()
	end

	return
end

function var_0_0.updataUI(arg_39_0)
	setText = var_1_10001

	var_1_10001(arg_39_0.labelLeftRpCount, "" .. arg_39_0.leftAwardCnt)

	LeanTween = var_1_10001

	local var_39_0 = var_1_10001.isTweening

	go = var_3

	local var_39_1

	if var_39_0(var_3(arg_39_0.btnRp)) then
		LeanTween = var_39_1
		var_39_1 = var_39_1.cancel
		go = var_3

		var_39_1(var_3(arg_39_0.btnRp))
	end

	LeanTween = var_39_1

	local var_39_2 = var_39_1.delayedCall

	go = var_3

	local var_39_3 = var_3(arg_39_0.btnRp)
	local var_39_4 = 1

	System = var_5

	var_39_2(var_39_3, var_39_4, var_5.Action(function()
		if arg_39_0.commonAnim.isActiveAndEnabled then
			local var_40_0 = arg_39_0.commonAnim

			var_0.SetInteger(var_40_0, "count", arg_39_0.leftAwardCnt)
		end

		return
	end))

	local var_39_5 = arg_39_0.lastBonusTimes - arg_39_0.useCount

	if 0 < var_39_5 then
		setText = var_2
		findTF = var_39_4

		var_2(var_39_4(arg_39_0.labelDropShip, "text"), "" .. var_39_5)
	end

	if arg_39_0.nextredPacketStep and arg_39_0.nextredPacketStep ~= 0 then
		setText = var_2

		var_2(arg_39_0.labelLeftCountTip, arg_39_0.nextredPacketStep)

		setActive = var_2

		var_2(arg_39_0.labelLeftCountTip, true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_39_0._tf, "countTip/ad"), true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_39_0._tf, "countTip/adB"), false)
	else
		setText = var_2

		var_2(arg_39_0.labelLeftCountTip, "")

		setActive = var_2

		var_2(arg_39_0.labelLeftCountTip, false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_39_0._tf, "countTip/ad"), false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_39_0._tf, "countTip/adB"), true)
	end

	setText = var_2

	var_2(arg_39_0.labelLeftCount, arg_39_0.leftCount)

	return
end

function var_0_0.updataChar(arg_41_0)
	isActive = var_1_10001

	if not var_1_10001(arg_41_0.char) then
		SetActive = var_1

		var_1(arg_41_0.char, true)

		local var_41_0 = arg_41_0.char

		var_1.SetAsLastSibling(var_41_0)
	end

	return
end

function var_0_0.checkEffect(arg_42_0, arg_42_1)
	if arg_42_0.effectId > 0 then
		pg = var_2

		local var_42_0 = var_2.activity_event_monopoly_event[arg_42_0.effectId].story
		local var_42_1 = arg_42_0:getActionName(arg_42_0.pos)

		seriesAsync = var_1_10004

		var_1_10004({
			function(arg_43_0)
				if var_42_1 then
					local var_43_0 = arg_42_0

					var_1.changeCharAction(var_43_0, var_42_1, 1, function()
						local var_44_0 = arg_42_0

						var_0.changeCharAction(var_44_0, var_0_11, 0, nil)
						arg_43_0()

						return
					end)
				else
					arg_43_0()
				end

				return
			end,
			function(arg_45_0)
				if var_42_0 then
					tonumber = var_1

					if var_1(var_42_0) ~= 0 then
						pg = var_1

						local var_45_0 = var_1.NewStoryMgr.GetInstance()

						var_1.Play(var_45_0, var_42_0, arg_45_0, true, true)

						goto label_45_0
					end
				end

				arg_45_0()

				::label_45_0::

				return
			end,
			function(arg_46_0)
				local var_46_0 = arg_42_0

				var_1.triggerEfect(var_46_0, arg_46_0)

				return
			end,
			function(arg_47_0)
				local var_47_0 = arg_42_0

				var_1.checkCountStory(var_47_0, arg_47_0)

				return
			end
		}, arg_42_1)
	elseif arg_42_1 then
		arg_42_1()
	end

	return
end

function var_0_0.triggerEfect(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0._event
	local var_48_1 = var_2.emit

	Monopoly3thRePage = var_1_10005

	var_48_1(var_48_0, var_1_10005.ON_TRIGGER, arg_48_0.activity.id, function(arg_49_0, arg_49_1)
		if arg_49_0 and #arg_49_0 >= 0 then
			arg_48_0.effectId = arg_49_1

			local var_49_0 = arg_48_0

			var_49_0.pos = arg_49_0[#arg_49_0]
			seriesAsync = var_49_0

			var_49_0({
				function(arg_50_0)
					local var_50_0 = arg_48_0

					var_1.moveCharWithPaths(var_50_0, arg_49_0, var_0_10, arg_50_0)

					return
				end
			}, function()
				arg_48_1()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.moveCharWithPaths(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if not arg_52_1 or #arg_52_1 <= 0 then
		if arg_52_3 then
			arg_52_3()
		end

		return
	end

	local var_52_0 = {}

	table = var_1_10005

	var_1_10005.insert(var_52_0, function(arg_53_0)
		local var_53_0 = arg_52_2 ~= var_0_14 and 4 or 2
		local var_53_1 = 1100
		local var_53_2 = 0
		local var_53_3 = arg_52_0

		var_4.createCell(var_53_3, var_53_1)

		local var_53_4 = arg_52_0

		var_4.changeCharAction(var_53_4, arg_52_2, 0, nil)

		local var_53_5 = var_53_1 / (var_53_0 / 0.6)
		local var_53_6 = 0

		LeanTween = var_53_4

		local var_53_7 = var_53_4.isTweening

		go = var_8

		local var_53_8

		if var_53_7(var_8(arg_52_0.cellPos)) then
			LeanTween = var_53_8
			var_53_8 = var_53_8.cancel
			go = var_8

			var_53_8(var_8(arg_52_0.cellPos))
		end

		LeanTween = var_53_8

		local var_53_9 = var_53_8.value

		go = var_8

		local var_53_10 = var_53_9(var_8(arg_52_0.cellPos), 0, var_53_1, var_53_0)
		local var_53_11 = var_6.setEase

		LeanTweenType = var_9

		local var_53_12 = var_53_11(var_53_10, var_9.linear)
		local var_53_13 = var_6.setOnUpdate

		System = var_9

		local var_53_14 = var_53_13(var_53_12, var_9.Action_float(function(arg_54_0)
			local var_54_0 = arg_52_0

			var_1.updateMap(var_54_0, arg_54_0 - var_53_2)

			var_53_2 = arg_54_0

			return
		end))
		local var_53_15 = var_6.setOnComplete

		System = var_9

		var_53_15(var_53_14, var_9.Action(function()
			arg_53_0()

			return
		end))

		return
	end)

	table = var_5

	var_5.insert(var_52_0, function(arg_56_0)
		local var_56_0 = arg_52_0

		var_1.changeCharAction(var_56_0, var_0_11, 0, nil)
		arg_56_0()

		return
	end)

	seriesAsync = var_5

	var_5(var_52_0, arg_52_3)

	return
end

function var_0_0.createCell(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.mapIds[arg_57_0.pos]

	pg = var_3

	local var_57_1 = var_3.activity_event_monopoly_map[var_57_0].icon

	tf = var_1_10004
	instantiate = var_1_10006
	go = var_1_10008

	local var_57_2 = var_1_10004(var_1_10006(var_1_10008(arg_57_0.tplCell)))

	Vector3 = var_1_10005
	var_57_2.localPosition = var_1_10005(arg_57_1, 0, 0)
	GetSpriteFromAtlas = var_5

	local var_57_3 = var_5("ui/activityuipage/monopoly3thre_atlas", var_57_1)

	findTF = var_6

	local var_57_4 = var_6(var_57_2, "icon")
	local var_57_5 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	local var_57_6 = var_57_5(var_57_4, var_9(var_1_10011))

	var_57_6.sprite = var_57_3
	findTF = var_57_6

	local var_57_7 = var_57_6(var_57_2, "icon")
	local var_57_8 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	local var_57_9 = var_57_8(var_57_7, var_9(var_1_10011))

	var_6.SetNativeSize(var_57_9)

	setActive = var_6

	var_6(var_57_2, true)

	setParent = var_6

	var_6(var_57_2, arg_57_0.cellPos)

	table = var_6

	var_6.insert(arg_57_0.mapCells, var_57_2)

	return
end

function var_0_0.updateMap(arg_58_0, arg_58_1)
	for iter_58_0 = 1, #arg_58_0.mapCells do
		var_6.x = arg_58_0.mapCells[iter_58_0].anchoredPosition.x - arg_58_1
		arg_58_0.mapCells[iter_58_0].anchoredPosition = var_6
	end

	if #arg_58_0.mapCells > 0 and arg_58_0.mapCells[1].anchoredPosition.x < -1000 then
		table = var_2

		local var_58_0 = var_2.remove(arg_58_0.mapCells, 1)

		Destroy = var_3

		var_3(var_58_0)
	end

	for iter_58_1 = 1, #arg_58_0.groundChildsList do
		local var_58_1 = arg_58_0.groundMoveRate[iter_58_1]

		for iter_58_2 = #arg_58_0.groundChildsList[iter_58_1], 1, -1 do
			local var_58_2 = var_7[iter_58_2]

			Vector3 = var_1_10013
			var_58_2.anchoredPosition = var_1_10013(var_58_2.anchoredPosition.x - arg_58_1 * var_58_1, var_58_2.anchoredPosition.y, var_58_2.anchoredPosition.z)
		end
	end

	for iter_58_3 = 1, #arg_58_0.groundChildsList do
		for iter_58_4 = #arg_58_0.groundChildsList[iter_58_3], 1, -1 do
			if var_6[iter_58_4].anchoredPosition.x <= -var_11.sizeDelta.x then
				local var_58_3 = #var_6

				if 1 < var_58_3 then
					table = var_58_3

					local var_58_4 = var_58_3.remove(var_6, iter_58_4)

					Vector3 = var_13
					var_58_4.anchoredPosition = var_13(var_6[#var_6].anchoredPosition.x + var_6[#var_6].sizeDelta.x, var_11.anchoredPosition.y, var_11.anchoredPosition.z)
					table = var_13

					var_13.insert(var_6, var_58_4)
				end
			end
		end
	end

	return
end

function var_0_0.changeCharAction(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	if arg_59_0.actionName == arg_59_1 and arg_59_0.actionName ~= var_0_13 then
		return
	end

	arg_59_0.actionName = arg_59_1

	local var_59_0 = arg_59_0.anim

	var_4.SetActionCallBack(var_59_0, nil)

	local var_59_1 = arg_59_0.anim

	var_4.SetAction(var_59_1, arg_59_1, 0)

	local var_59_2 = arg_59_0.anim

	var_4.SetActionCallBack(var_59_2, function(arg_60_0)
		if arg_60_0 == "finish" then
			if arg_59_2 == 1 then
				local var_60_0 = arg_59_0.anim

				var_1.SetActionCallBack(var_60_0, nil)

				local var_60_1 = arg_59_0.anim

				var_1.SetAction(var_60_1, var_0_11, 0)
			end

			if arg_59_3 then
				arg_59_3()
			end
		end

		return
	end)

	if arg_59_2 ~= 1 and arg_59_3 then
		arg_59_3()
	end

	return
end

function var_0_0.getActionName(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.mapIds[arg_61_1]

	pg = var_1_10003

	if var_1_10003.activity_event_monopoly_map[var_61_0].icon == "icon_1" then
		return var_0_9
	elseif var_3 == "icon_2" then
		return var_0_7
	elseif var_3 == "icon_3" then
		return nil
	elseif var_3 == "icon_4" then
		return var_0_9
	elseif var_3 == "icon_5" then
		return var_0_8
	elseif var_3 == "icon_6" then
		return var_0_9
	end

	return var_0_9
end

function var_0_0.onHide(arg_62_0)
	return
end

function var_0_0.dispose(arg_63_0)
	if arg_63_0.model then
		PoolMgr = var_1

		local var_63_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_63_0, var_0_1, arg_63_0.model)
	end

	for iter_63_0 = #arg_63_0.mapCells, 1, -1 do
		Destroy = var_1_10005

		var_1_10005(arg_63_0.mapCells[iter_63_0])
	end

	arg_63_0.mapCells = {}

	local var_63_1

	if arg_63_0.randomMoveTiemr then
		if arg_63_0.randomMoveTiemr.running then
			var_63_1 = arg_63_0.randomMoveTiemr

			var_1.Stop(var_63_1)
		end

		arg_63_0.randomMoveTiemr = nil
	end

	LeanTween = var_1

	local var_63_2 = var_1.isTweening

	go = var_63_1

	local var_63_3

	if var_63_2(var_63_1(arg_63_0.btnRp)) then
		LeanTween = var_63_3
		var_63_3 = var_63_3.cancel
		go = var_3

		var_63_3(var_3(arg_63_0.btnRp))
	end

	LeanTween = var_63_3

	local var_63_4 = var_63_3.isTweening

	go = var_3

	if var_63_4(var_3(arg_63_0.cellPos)) then
		LeanTween = var_1

		local var_63_5 = var_1.cancel

		go = var_3

		var_63_5(var_3(arg_63_0.cellPos))
	end

	if arg_63_0.awardsTimer then
		if arg_63_0.awardsTimer.running then
			local var_63_6 = arg_63_0.awardsTimer

			var_1.Stop(var_63_6)
		end

		arg_63_0.awardsTimer = nil
	end

	if arg_63_0.awardTfs and #arg_63_0.awardTfs > 0 then
		for iter_63_1 = #arg_63_0.awardTfs, 1, -1 do
			Destroy = var_5
			table = var_1_10007

			var_5(var_1_10007.remove(arg_63_0.awardTfs, iter_63_1))
		end
	end

	return
end

return var_0_0
