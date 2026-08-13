class = var_0_10000

local var_0_0 = var_0_10000("Monopoly3thGame")
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
	arg_2_0.inAnimatedFlag = false
	pg = var_1
	arg_2_0.mapIds = var_1.activity_event_monopoly[arg_2_0._configId].map
	pg = var_1
	arg_2_0.lastBonusTimes = var_1.activity_event_monopoly[arg_2_0._configId].drop_times[1]
	Timer = var_1
	arg_2_0.randomMoveTiemr = var_1.New(function()
		local var_3_0 = arg_2_0

		var_0.checkPlayerRandomMove(var_3_0)

		return
	end, 15, -1)

	return
end

function var_0_0.initUI(arg_4_0)
	findTF = var_1_10001
	arg_4_0.char = var_1_10001(arg_4_0._tf, "map/char")
	setActive = var_1

	var_1(arg_4_0.char, false)

	findTF = var_1
	arg_4_0.btnStart = var_1(arg_4_0._tf, "btnStart")
	findTF = var_1
	arg_4_0.btnHelp = var_1(arg_4_0._tf, "btnHelp")
	findTF = var_1
	arg_4_0.btnRp = var_1(arg_4_0._tf, "btnRp")
	findTF = var_1

	local var_4_0 = var_1(arg_4_0.btnRp, "rpAni")
	local var_4_1 = var_1.GetComponent

	typeof = var_4
	Animator = var_1_10006
	arg_4_0.commonAnim = var_4_1(var_4_0, var_4(var_1_10006))
	findTF = var_1
	arg_4_0.labelLeftCountTip = var_1(arg_4_0._tf, "countTip/labelLeftCountTip")
	findTF = var_1
	arg_4_0.labelLeftCount = var_1(arg_4_0._tf, "countTip/labelLeftCount")
	findTF = var_1
	arg_4_0.labelDropShip = var_1(arg_4_0._tf, "labelDropShip")
	findTF = var_1
	arg_4_0.labelLeftRpCount = var_1(arg_4_0._tf, "labelLeftRpCount")
	findTF = var_1
	arg_4_0.cellPos = var_1(arg_4_0._tf, "map/mask/posCell")
	findTF = var_1
	arg_4_0.tplCell = var_1(arg_4_0._tf, "map/mask/posCell/tplCell")
	arg_4_0.mapCells = {}
	arg_4_0.curCellIndex = nil
	arg_4_0.groundChildsList = {}
	arg_4_0.groundMoveRate = {
		0.1,
		0.3,
		1
	}

	for iter_4_0 = 1, 3 do
		findTF = var_1_10005
		var_1_10005 = var_1_10005(arg_4_0._tf, "map/mask/ground" .. iter_4_0)

		local var_4_2 = {}

		for iter_4_1 = 1, var_1_10005.childCount do
			table = var_1_10011

			var_1_10011.insert(var_4_2, var_1_10005:GetChild(iter_4_1 - 1))
		end

		table = var_7

		var_7.insert(arg_4_0.groundChildsList, var_4_2)
	end

	Ship = var_1

	local var_4_3 = var_1.New({
		configId = var_0_1,
		skin_id = var_0_2
	})
	local var_4_4 = var_1.getPrefab(var_4_3)

	PoolMgr = var_3

	local var_4_5 = var_3.GetInstance()

	var_3.GetSpineChar(var_4_5, var_4_4, true, function(arg_5_0)
		arg_4_0.model = arg_5_0

		local var_5_0 = arg_4_0.model.transform

		Vector3 = var_2_10002
		var_5_0.localScale = var_2_10002.one

		local var_5_1 = arg_4_0.model.transform

		Vector3 = var_2
		var_5_1.localPosition = var_2.zero

		local var_5_2 = arg_4_0.model.transform

		var_1.SetParent(var_5_2, arg_4_0.char, false)

		local var_5_3 = arg_4_0
		local var_5_4 = arg_4_0.model
		local var_5_5 = var_2.GetComponent

		typeof = var_5
		SpineAnimUI = var_2_10007
		var_5_3.anim = var_5_5(var_5_4, var_5(var_2_10007))

		local var_5_6 = arg_4_0

		var_1.changeCharAction(var_5_6, var_0_11, 0, nil)

		local var_5_7 = arg_4_0

		var_1.checkCharActive(var_5_7)

		return
	end)

	local var_4_6 = arg_4_0.randomMoveTiemr

	var_3.Start(var_4_6)

	return
end

function var_0_0.initEvent(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0._binder
	local var_6_1 = arg_6_0.btnStart

	local function var_6_2()
		if arg_6_0.inAnimatedFlag then
			return
		end

		if arg_6_0.leftCount and arg_6_0.leftCount <= 0 then
			pg = var_0

			local var_7_0 = var_0.TipsMgr.GetInstance()
			local var_7_1 = var_0.ShowTips

			i18n = var_2_10003

			var_7_1(var_7_0, var_2_10003("common_count_noenough"))

			return
		end

		local var_7_2 = arg_6_0

		var_0.changeAnimeState(var_7_2, true)

		local var_7_3 = arg_6_0._event
		local var_7_4 = var_0.emit

		Monopoly3thPage = var_3

		var_7_4(var_7_3, var_3.ON_START, arg_6_0.activity.id, function(arg_8_0)
			if arg_8_0 and arg_8_0 > 0 then
				arg_6_0.step = arg_8_0

				local var_8_0 = arg_6_0

				var_1.updataUI(var_8_0)

				local var_8_1 = arg_6_0

				var_1.checkCharActive(var_8_1)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0._binder
	local var_6_4 = arg_6_0.btnHelp

	local function var_6_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_9_2.type = var_2_10004
		pg = var_2_10004
		var_9_2.helps = var_2_10004.gametip.help_monopoly_3th.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	onButton = var_1_10001

	local var_6_6 = arg_6_0._binder
	local var_6_7 = arg_6_0.char

	local function var_6_8()
		if not arg_6_0.model or arg_6_0.inAnimatedFlag then
			return
		end

		LeanTween = var_0

		local var_10_0 = var_0.isTweening

		go = var_2_10002

		if var_10_0(var_2_10002(arg_6_0.cellPos)) then
			LeanTween = var_0

			local var_10_1 = var_0.cancel

			go = var_2

			var_10_1(var_2(arg_6_0.cellPos))
		end

		local var_10_2 = arg_6_0

		var_0.changeCharAction(var_10_2, var_0_15, 1, function()
			local var_11_0 = arg_6_0

			var_0.changeCharAction(var_11_0, var_0_11)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10006)

	onButton = var_1_10001

	local var_6_9 = arg_6_0._binder
	local var_6_10 = arg_6_0.btnRp

	local function var_6_11()
		if arg_6_0.leftAwardCnt > 0 then
			local var_12_0 = arg_6_0._event
			local var_12_1 = var_0.emit

			Monopoly3thPage = var_2_10003

			var_12_1(var_12_0, var_2_10003.ON_AWARD)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_9, var_6_10, var_6_11, var_1_10006)

	return
end

function var_0_0.checkPlayerRandomMove(arg_13_0)
	if not arg_13_0.model or arg_13_0.inAnimatedFlag then
		return
	end

	math = var_1

	if var_1.random() > 0.5 then
		math = var_1

		local var_13_0 = 300 * var_1.random(2, 4)
		local var_13_1 = var_1 * 2
		local var_13_2 = 0
		local var_13_3 = arg_13_0

		arg_13_0.changeCharAction(var_13_3, var_0_10, 0, nil)

		LeanTween = var_5

		local var_13_4 = var_5.value

		go = var_13_3

		local var_13_5 = var_13_4(var_13_3(arg_13_0.cellPos), 0, var_13_0, var_13_1)
		local var_13_6 = var_5.setEase

		LeanTweenType = var_8

		local var_13_7 = var_13_6(var_13_5, var_8.linear)
		local var_13_8 = var_5.setOnUpdate

		System = var_8

		local var_13_9 = var_13_8(var_13_7, var_8.Action_float(function(arg_14_0)
			local var_14_0 = arg_13_0

			var_1.updateMap(var_14_0, arg_14_0 - var_13_2)

			var_13_2 = arg_14_0

			return
		end))
		local var_13_10 = var_5.setOnComplete

		System = var_8

		var_13_10(var_13_9, var_8.Action(function()
			local var_15_0 = arg_13_0

			var_0.changeCharAction(var_15_0, var_0_11, 0, nil)

			return
		end))
	else
		arg_13_0:changeCharAction(var_0_12, 1, function()
			local var_16_0 = arg_13_0

			var_0.changeCharAction(var_16_0, var_0_11)

			return
		end)
	end

	return
end

function var_0_0.checkCountStory(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.useCount
	local var_17_1 = arg_17_0.activity
	local var_17_2

	if not var_3.getDataConfig(var_17_1, "story") then
		var_17_2 = {}
	end

	_ = var_1_10005

	if var_1_10005.detect(var_17_2, function(arg_18_0)
		return arg_18_0[1] == var_17_0
	end) then
		pg = var_17_1

		local var_17_3 = var_17_1.NewStoryMgr.GetInstance()

		var_6.Play(var_17_3, var_5[2], arg_17_1)
	else
		arg_17_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_19_0, arg_19_1)
	if arg_19_1 then
		local var_19_0 = arg_19_0.btnStart

		var_1_10002 = var_1_10002.GetComponent
		typeof = var_1_10005
		Image = var_1_10007
		var_1_10002 = var_1_10002(var_19_0, var_1_10005(var_1_10007))
		var_1_10002.raycastTarget = false
		arg_19_0.inAnimatedFlag = true

		local var_19_1 = arg_19_0._event

		var_1_10002 = var_1_10002.emit
		ActivityMainScene = var_1_10005

		var_1_10002(var_19_1, var_1_10005.LOCK_ACT_MAIN, true)
	else
		arg_19_0.inAnimatedFlag = false

		local var_19_2 = arg_19_0.btnStart

		var_1_10002 = var_1_10002.GetComponent
		typeof = var_1_10005
		Image = var_1_10007
		var_1_10002 = var_1_10002(var_19_2, var_1_10005(var_1_10007))
		var_1_10002.raycastTarget = true

		local var_19_3 = arg_19_0._event

		var_1_10002 = var_1_10002.emit
		ActivityMainScene = var_5

		var_1_10002(var_19_3, var_5.LOCK_ACT_MAIN, false)
	end

	setActive = var_1_10002

	var_1_10002(arg_19_0.btnStart, not arg_19_1)

	return
end

function var_0_0.checkCharActive(arg_20_0)
	if arg_20_0.anim then
		if arg_20_0.effectId and arg_20_0.effectId > 0 then
			arg_20_0:changeAnimeState(true)
			arg_20_0:checkEffect(function()
				local var_21_0 = arg_20_0

				var_0.changeAnimeState(var_21_0, false)

				local var_21_1 = arg_20_0

				var_0.checkCharActive(var_21_1)

				return
			end)
		elseif arg_20_0.step and arg_20_0.step > 0 then
			arg_20_0:changeAnimeState(true)
			arg_20_0:checkStep(function()
				local var_22_0 = arg_20_0

				var_0.changeAnimeState(var_22_0, false)

				local var_22_1 = arg_20_0

				var_0.checkCharActive(var_22_1)

				return
			end)
		else
			arg_20_0:checkLastBonus()
		end
	end

	return
end

function var_0_0.firstUpdata(arg_23_0, arg_23_1)
	arg_23_0:activityDataUpdata(arg_23_1)
	arg_23_0:updataUI()
	arg_23_0:updataChar()
	arg_23_0:checkCharActive()
	arg_23_0:checkLastBonus()

	if arg_23_0.pos and arg_23_0.pos > 0 then
		arg_23_0:updateMap(arg_23_0.pos * 1100 % 2500)
	end

	return
end

function var_0_0.updataActivity(arg_24_0, arg_24_1)
	arg_24_0:activityDataUpdata(arg_24_1)
	arg_24_0:updataUI()

	return
end

function var_0_0.checkLastBonus(arg_25_0)
	if (not arg_25_0.lastBonusFlag or arg_25_0.lastBonusFlag == 0) and arg_25_0.useCount and arg_25_0.useCount >= arg_25_0.lastBonusTimes then
		var_1_10003 = arg_25_0._event

		local var_25_0 = var_1.emit

		Monopoly3thPage = var_1_10004

		var_25_0(var_1_10003, var_1_10004.MONOPOLY_OP_LAST, arg_25_0.activity.id, function(arg_26_0)
			local var_26_0 = arg_25_0

			var_26_0.lastBonusFlag = 1
			setActive = var_26_0
			findTF = var_2_10003

			var_26_0(var_2_10003(arg_25_0.labelDropShip, "get"), false)

			setActive = var_26_0
			findTF = var_3

			var_26_0(var_3(arg_25_0.labelDropShip, "got"), true)

			setActive = var_26_0
			findTF = var_3

			var_26_0(var_3(arg_25_0.labelDropShip, "text"), false)

			return
		end)
	end

	if arg_25_0.lastBonusFlag == 1 then
		setActive = var_1
		findTF = var_1_10003

		var_1(var_1_10003(arg_25_0.labelDropShip, "get"), false)

		setActive = var_1
		findTF = var_3

		var_1(var_3(arg_25_0.labelDropShip, "got"), true)

		setActive = var_1
		findTF = var_3

		var_1(var_3(arg_25_0.labelDropShip, "text"), false)
	end

	return
end

function var_0_0.activityDataUpdata(arg_27_0, arg_27_1)
	arg_27_0.activity = arg_27_1
	pg = var_1_10002

	local var_27_0 = var_1_10002.TimeMgr.GetInstance()
	local var_27_1 = var_2.GetServerTime(var_27_0)
	local var_27_2 = arg_27_0.activity.data1

	math = var_27_0

	local var_27_3 = var_27_0.ceil((var_27_1 - var_27_2) / 0)
	local var_27_4 = arg_27_0.activity

	arg_27_0.totalCnt = var_27_3 * var_5.getDataConfig(var_27_4, "daily_time") + arg_27_0.activity.data1_list[1]
	arg_27_0.useCount = arg_27_0.activity.data1_list[2]
	arg_27_0.leftCount = arg_27_0.totalCnt - arg_27_0.useCount
	arg_27_0.turnCnt = arg_27_0.activity.data1_list[3] - 1
	arg_27_0.leftDropShipCnt = 8 - arg_27_0.turnCnt

	local var_27_5 = arg_27_0.activity.data2_list[2]
	local var_27_6 = arg_27_1

	arg_27_0.advanceTotalCnt = #arg_27_1.getDataConfig(var_27_6, "reward")
	arg_27_0.isAdvanceRp = arg_27_0.advanceTotalCnt - var_27_5 > 0
	arg_27_0.leftAwardCnt = arg_27_0.activity.data2_list[1] - var_27_5
	math = var_10

	local var_27_7 = var_10.max
	local var_27_8 = 0

	math = var_1_10013
	arg_27_0.advanceRpCount = var_27_7(var_27_8, var_1_10013.min(var_9, arg_27_0.advanceTotalCnt) - var_27_5)
	math = var_10

	local var_27_9 = var_10.max(0, var_9 - arg_27_0.advanceTotalCnt)

	math = var_27_6
	arg_27_0.commonRpCount = var_27_9 - var_27_6.max(0, var_27_5 - arg_27_0.advanceTotalCnt)
	arg_27_0.nextredPacketStep = arg_27_1:getDataConfig("reward_time") - arg_27_0.useCount % var_10
	arg_27_0.pos = arg_27_0.activity.data2

	local var_27_10

	if not arg_27_0.activity.data3 then
		var_27_10 = 0
	end

	arg_27_0.step = var_27_10

	local var_27_11

	if not arg_27_0.activity.data4 then
		var_27_11 = 0
	end

	arg_27_0.effectId = var_27_11
	arg_27_0.lastBonusFlag = arg_27_0.activity.data2_list[3]

	return
end

function var_0_0.checkStep(arg_28_0, arg_28_1)
	if arg_28_0.step > 0 then
		local var_28_0 = arg_28_0._event
		local var_28_1 = var_2.emit

		Monopoly3thPage = var_1_10005

		var_28_1(var_28_0, var_1_10005.ON_MOVE, arg_28_0.activity.id, function(arg_29_0, arg_29_1, arg_29_2)
			arg_28_0.step = arg_29_0
			arg_28_0.pos = arg_29_1[#arg_29_1]

			local var_29_0 = arg_28_0

			var_29_0.effectId = arg_29_2
			seriesAsync = var_29_0

			var_29_0({
				function(arg_30_0)
					local var_30_0 = var_0_14
					local var_30_1 = arg_28_0

					var_2.moveCharWithPaths(var_30_1, arg_29_1, var_30_0, arg_30_0)

					return
				end,
				function(arg_31_0)
					local var_31_0 = arg_28_0

					var_1.checkEffect(var_31_0, arg_31_0)

					return
				end
			}, function()
				if arg_28_1 then
					arg_28_1()
				end

				return
			end)

			return
		end)
	elseif arg_28_1 then
		arg_28_1()
	end

	return
end

function var_0_0.updataUI(arg_33_0)
	setText = var_1_10001

	var_1_10001(arg_33_0.labelLeftRpCount, "" .. arg_33_0.leftAwardCnt)

	LeanTween = var_1_10001

	local var_33_0 = var_1_10001.delayedCall

	go = var_3

	local var_33_1 = var_3(arg_33_0.btnRp)
	local var_33_2 = 1

	System = var_5

	var_33_0(var_33_1, var_33_2, var_5.Action(function()
		if arg_33_0.commonAnim.isActiveAndEnabled then
			local var_34_0 = arg_33_0.commonAnim

			var_0.SetInteger(var_34_0, "count", arg_33_0.leftAwardCnt)
		end

		return
	end))

	local var_33_3 = arg_33_0.lastBonusTimes - arg_33_0.useCount

	if 0 < var_33_3 then
		setText = var_2
		findTF = var_33_2

		var_2(var_33_2(arg_33_0.labelDropShip, "text"), "" .. var_33_3)
	end

	setText = var_2

	var_2(arg_33_0.labelLeftCountTip, arg_33_0.nextredPacketStep)

	setText = var_2

	var_2(arg_33_0.labelLeftCount, arg_33_0.leftCount)

	return
end

function var_0_0.updataChar(arg_35_0)
	isActive = var_1_10001

	if not var_1_10001(arg_35_0.char) then
		SetActive = var_1

		var_1(arg_35_0.char, true)

		local var_35_0 = arg_35_0.char

		var_1.SetAsLastSibling(var_35_0)
	end

	return
end

function var_0_0.checkEffect(arg_36_0, arg_36_1)
	if arg_36_0.effectId > 0 then
		pg = var_2

		local var_36_0 = var_2.activity_event_monopoly_event[arg_36_0.effectId].story
		local var_36_1 = arg_36_0:getActionName(arg_36_0.pos)

		seriesAsync = var_1_10004

		var_1_10004({
			function(arg_37_0)
				if var_36_1 then
					local var_37_0 = arg_36_0

					var_1.changeCharAction(var_37_0, var_36_1, 1, function()
						local var_38_0 = arg_36_0

						var_0.changeCharAction(var_38_0, var_0_11, 0, nil)
						arg_37_0()

						return
					end)
				else
					arg_37_0()
				end

				return
			end,
			function(arg_39_0)
				if var_36_0 then
					tonumber = var_1

					if var_1(var_36_0) ~= 0 then
						pg = var_1

						local var_39_0 = var_1.NewStoryMgr.GetInstance()

						var_1.Play(var_39_0, var_36_0, arg_39_0, true, true)

						goto label_39_0
					end
				end

				arg_39_0()

				::label_39_0::

				return
			end,
			function(arg_40_0)
				local var_40_0 = arg_36_0

				var_1.triggerEfect(var_40_0, arg_40_0)

				return
			end,
			function(arg_41_0)
				local var_41_0 = arg_36_0

				var_1.checkCountStory(var_41_0, arg_41_0)

				return
			end
		}, arg_36_1)
	elseif arg_36_1 then
		arg_36_1()
	end

	return
end

function var_0_0.triggerEfect(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0._event
	local var_42_1 = var_2.emit

	Monopoly3thPage = var_1_10005

	var_42_1(var_42_0, var_1_10005.ON_TRIGGER, arg_42_0.activity.id, function(arg_43_0, arg_43_1)
		if arg_43_0 and #arg_43_0 >= 0 then
			arg_42_0.effectId = arg_43_1

			local var_43_0 = arg_42_0

			var_43_0.pos = arg_43_0[#arg_43_0]
			seriesAsync = var_43_0

			var_43_0({
				function(arg_44_0)
					local var_44_0 = arg_42_0

					var_1.moveCharWithPaths(var_44_0, arg_43_0, var_0_10, arg_44_0)

					return
				end
			}, function()
				arg_42_1()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.moveCharWithPaths(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	if not arg_46_1 or #arg_46_1 <= 0 then
		if arg_46_3 then
			arg_46_3()
		end

		return
	end

	local var_46_0 = {}

	table = var_1_10005

	var_1_10005.insert(var_46_0, function(arg_47_0)
		local var_47_0 = arg_46_2 ~= var_0_14 and 4 or 2
		local var_47_1 = 1100
		local var_47_2 = 0
		local var_47_3 = arg_46_0

		var_4.createCell(var_47_3, var_47_1)

		local var_47_4 = arg_46_0

		var_4.changeCharAction(var_47_4, arg_46_2, 0, nil)

		local var_47_5 = var_47_1 / (var_47_0 / 0.6)
		local var_47_6 = 0

		LeanTween = var_47_4

		local var_47_7 = var_47_4.isTweening

		go = var_8

		local var_47_8

		if var_47_7(var_8(arg_46_0.cellPos)) then
			LeanTween = var_47_8
			var_47_8 = var_47_8.cancel
			go = var_8

			var_47_8(var_8(arg_46_0.cellPos))
		end

		LeanTween = var_47_8

		local var_47_9 = var_47_8.value

		go = var_8

		local var_47_10 = var_47_9(var_8(arg_46_0.cellPos), 0, var_47_1, var_47_0)
		local var_47_11 = var_6.setEase

		LeanTweenType = var_9

		local var_47_12 = var_47_11(var_47_10, var_9.linear)
		local var_47_13 = var_6.setOnUpdate

		System = var_9

		local var_47_14 = var_47_13(var_47_12, var_9.Action_float(function(arg_48_0)
			local var_48_0 = arg_46_0

			var_1.updateMap(var_48_0, arg_48_0 - var_47_2)

			var_47_2 = arg_48_0

			return
		end))
		local var_47_15 = var_6.setOnComplete

		System = var_9

		var_47_15(var_47_14, var_9.Action(function()
			arg_47_0()

			return
		end))

		return
	end)

	table = var_5

	var_5.insert(var_46_0, function(arg_50_0)
		local var_50_0 = arg_46_0

		var_1.changeCharAction(var_50_0, var_0_11, 0, nil)
		arg_50_0()

		return
	end)

	seriesAsync = var_5

	var_5(var_46_0, arg_46_3)

	return
end

function var_0_0.createCell(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0.mapIds[arg_51_0.pos]

	pg = var_3

	local var_51_1 = var_3.activity_event_monopoly_map[var_51_0].icon

	tf = var_1_10004
	instantiate = var_1_10006
	go = var_1_10008

	local var_51_2 = var_1_10004(var_1_10006(var_1_10008(arg_51_0.tplCell)))

	Vector3 = var_1_10005
	var_51_2.localPosition = var_1_10005(arg_51_1, 0, 0)
	GetSpriteFromAtlas = var_5

	local var_51_3 = var_5("ui/activityuipage/monopoly3th_atlas", var_51_1)

	findTF = var_6

	local var_51_4 = var_6(var_51_2, "icon")
	local var_51_5 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	local var_51_6 = var_51_5(var_51_4, var_9(var_1_10011))

	var_51_6.sprite = var_51_3
	findTF = var_51_6

	local var_51_7 = var_51_6(var_51_2, "icon")
	local var_51_8 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	local var_51_9 = var_51_8(var_51_7, var_9(var_1_10011))

	var_6.SetNativeSize(var_51_9)

	setActive = var_6

	var_6(var_51_2, true)

	setParent = var_6

	var_6(var_51_2, arg_51_0.cellPos)

	table = var_6

	var_6.insert(arg_51_0.mapCells, var_51_2)

	return
end

function var_0_0.updateMap(arg_52_0, arg_52_1)
	for iter_52_0 = 1, #arg_52_0.mapCells do
		var_6.x = arg_52_0.mapCells[iter_52_0].anchoredPosition.x - arg_52_1
		arg_52_0.mapCells[iter_52_0].anchoredPosition = var_6
	end

	if #arg_52_0.mapCells > 0 and arg_52_0.mapCells[1].anchoredPosition.x < -1000 then
		table = var_2

		local var_52_0 = var_2.remove(arg_52_0.mapCells, 1)

		Destroy = var_3

		var_3(var_52_0)
	end

	for iter_52_1 = 1, #arg_52_0.groundChildsList do
		local var_52_1 = arg_52_0.groundMoveRate[iter_52_1]

		for iter_52_2 = #arg_52_0.groundChildsList[iter_52_1], 1, -1 do
			local var_52_2 = var_7[iter_52_2]

			Vector3 = var_1_10013
			var_52_2.anchoredPosition = var_1_10013(var_52_2.anchoredPosition.x - arg_52_1 * var_52_1, var_52_2.anchoredPosition.y, var_52_2.anchoredPosition.z)
		end
	end

	for iter_52_3 = 1, #arg_52_0.groundChildsList do
		for iter_52_4 = #arg_52_0.groundChildsList[iter_52_3], 1, -1 do
			if var_6[iter_52_4].anchoredPosition.x <= -var_11.sizeDelta.x then
				local var_52_3 = #var_6

				if 1 < var_52_3 then
					table = var_52_3

					local var_52_4 = var_52_3.remove(var_6, iter_52_4)

					Vector3 = var_13
					var_52_4.anchoredPosition = var_13(var_6[#var_6].anchoredPosition.x + var_6[#var_6].sizeDelta.x, var_11.anchoredPosition.y, var_11.anchoredPosition.z)
					table = var_13

					var_13.insert(var_6, var_52_4)
				end
			end
		end
	end

	return
end

function var_0_0.changeCharAction(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	if arg_53_0.actionName == arg_53_1 and arg_53_0.actionName ~= var_0_13 then
		return
	end

	arg_53_0.actionName = arg_53_1

	local var_53_0 = arg_53_0.anim

	var_4.SetActionCallBack(var_53_0, nil)

	local var_53_1 = arg_53_0.anim

	var_4.SetAction(var_53_1, arg_53_1, 0)

	local var_53_2 = arg_53_0.anim

	var_4.SetActionCallBack(var_53_2, function(arg_54_0)
		if arg_54_0 == "finish" then
			if arg_53_2 == 1 then
				local var_54_0 = arg_53_0.anim

				var_1.SetActionCallBack(var_54_0, nil)

				local var_54_1 = arg_53_0.anim

				var_1.SetAction(var_54_1, var_0_11, 0)
			end

			if arg_53_3 then
				arg_53_3()
			end
		end

		return
	end)

	if arg_53_2 ~= 1 and arg_53_3 then
		arg_53_3()
	end

	return
end

function var_0_0.getActionName(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0.mapIds[arg_55_1]

	pg = var_1_10003

	if var_1_10003.activity_event_monopoly_map[var_55_0].icon == "icon_1" then
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

function var_0_0.dispose(arg_56_0)
	if arg_56_0.model then
		PoolMgr = var_1
		var_1_10003 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_1_10003, var_0_1, arg_56_0.model)
	end

	if arg_56_0.randomMoveTiemr then
		if arg_56_0.randomMoveTiemr.running then
			var_1_10003 = arg_56_0.randomMoveTiemr

			var_1.Stop(var_1_10003)
		end

		arg_56_0.randomMoveTiemr = nil
	end

	LeanTween = var_1

	local var_56_0 = var_1.isTweening

	go = var_1_10003

	local var_56_1

	if var_56_0(var_1_10003(arg_56_0.btnRp)) then
		LeanTween = var_56_1
		var_56_1 = var_56_1.cancel
		go = var_3

		var_56_1(var_3(arg_56_0.btnRp))
	end

	LeanTween = var_56_1

	local var_56_2 = var_56_1.isTweening

	go = var_3

	if var_56_2(var_3(arg_56_0.cellPos)) then
		LeanTween = var_1

		local var_56_3 = var_1.cancel

		go = var_3

		var_56_3(var_3(arg_56_0.cellPos))
	end

	return
end

return var_0_0
