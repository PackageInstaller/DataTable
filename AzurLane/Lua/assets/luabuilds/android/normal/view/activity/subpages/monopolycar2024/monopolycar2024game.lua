class = var_0_10000

local var_0_0 = var_0_10000("MonopolyCar2024Game")
local var_0_1 = 88
local var_0_2 = 43
local var_0_3 = "redcar"

MonopolyCar2024Const = var_0_10004

local var_0_4 = var_0_10004.map_dic
local var_0_5 = 0.6
local var_0_6 = {
	"sitelasibao_2",
	"u96_4",
	"xiafei_4"
}
local var_0_7 = {}

Vector3 = var_0_10008
var_0_7[1] = var_0_10008(56, 121, 0)
Vector3 = var_8
var_0_7[2] = var_8(-557, -447, 0)
Vector3 = var_8
var_0_7[3] = var_8(590, -344, 0)

local var_0_8 = "B-stand"
local var_0_9 = "F-stand"
local var_0_10 = "B-walk"
local var_0_11 = "F-walk"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_2
	arg_1_0._event = arg_1_3
	pg = var_1_10004

	var_1_10004.DelegateInfo.New(arg_1_0)

	GetOrAddComponent = var_4

	local var_1_0 = arg_1_0._tf

	typeof = var_1_10006
	CanvasGroup = var_1_10007
	arg_1_0.cg = var_4(var_1_0, var_1_10006(var_1_10007))
	MonopolyCar2024PickPage = var_4
	arg_1_0.pickPage = var_4.New(arg_1_2, arg_1_3)
	MonopolyCar2024BubblePage = var_4
	arg_1_0.bubblePage = var_4.New(arg_1_2:Find("bubble"), arg_1_3)
	AwardWindow = var_4
	arg_1_0.awardWindow = var_4.New(arg_1_2, arg_1_3)
	MonopolyCar2024TotalRewardPanel = var_4
	arg_1_0.resultPage = var_4.New(arg_1_2, arg_1_3)
	MonopolyCar2024GameAwardCollector = var_4
	arg_1_0.awardCollector = var_4.New()

	arg_1_0:UpdateActData(arg_1_1)
	arg_1_0:Setup()

	return
end

function var_0_0.emit(arg_2_0, ...)
	local var_2_0 = arg_2_0._event

	var_1.emit(var_2_0, ...)

	return
end

function var_0_0.UpdateActData(arg_3_0, arg_3_1)
	arg_3_0.actId = arg_3_1.id
	pg = var_2

	local var_3_0 = var_2.TimeMgr.GetInstance()
	local var_3_1 = var_2.GetServerTime(var_3_0)
	local var_3_2 = arg_3_1.data1

	math = var_1_10004

	local var_3_3 = var_1_10004.ceil((var_3_1 - var_3_2) / 0) * arg_3_1:getDataConfig("daily_time")
	local var_3_4

	if not arg_3_1.data1_list[1] then
		var_3_4 = 0
	end

	arg_3_0.totalCnt = var_3_3 + var_3_4

	local var_3_5

	if not arg_3_1.data1_list[2] then
		var_3_5 = 0
	end

	arg_3_0.useCount = var_3_5
	arg_3_0.leftCount = arg_3_0.totalCnt - arg_3_0.useCount
	arg_3_0.dialogRecorder = arg_3_1.data4_list
	arg_3_0.pickCharList = arg_3_1.data3_list
	math = var_7
	arg_3_0.pos = var_7.max(arg_3_1.data2, 1)

	local var_3_6

	if not arg_3_1.data3 then
		var_3_6 = 0
	end

	arg_3_0.step = var_3_6

	local var_3_7

	if not arg_3_1.data4 then
		var_3_7 = 0
	end

	arg_3_0.effectId = var_3_7

	local var_3_8

	if not arg_3_1.data1_list[3] then
		var_3_8 = 0
	end

	arg_3_0.turnCnt = var_3_8

	local var_3_9

	if not arg_3_1.data1_list[4] then
		var_3_9 = 0
	end

	arg_3_0.selectedShipId = var_3_9

	local var_3_10

	if not arg_3_1:getDataConfig("story") then
		var_3_10 = {}
	end

	arg_3_0.storys = var_3_10

	local var_3_11 = arg_3_1
	local var_3_12

	if not arg_3_1.getDataConfig(var_3_11, "sum_lap_reward_show") then
		var_3_12 = {}
	end

	arg_3_0.lapReward = var_3_12

	local var_3_13 = {}

	i18n = var_3_11
	var_3_13[1] = var_3_11("MonopolyCar2024Game_title1")
	i18n = var_8
	var_3_13[2] = var_8("MonopolyCar2024Game_title2")
	arg_3_0.titles = var_3_13
	_ = var_3_13
	arg_3_0.pickableShipId = var_3_13.map(arg_3_1:getDataConfig("ship_reward"), function(arg_4_0)
		return arg_4_0[1]
	end)
	arg_3_0.spEvents = {}
	ipairs = var_7

	local var_3_14

	if not arg_3_1:getDataConfig("ship_dialog") then
		var_3_14 = {}
	end

	for iter_3_0, iter_3_1 in var_7(var_3_14) do
		arg_3_0.spEvents[iter_3_1[1]] = iter_3_1[2]
	end

	arg_3_0.cacheTurnCnt = arg_3_0.turnCnt

	return
end

function var_0_0.Setup(arg_5_0)
	local var_5_0 = arg_5_0.cg

	var_5_0.blocksRaycasts = false
	seriesAsync = var_5_0

	var_5_0({
		function(arg_6_0)
			local var_6_0 = arg_5_0

			var_1.InitUI(var_6_0)

			local var_6_1 = arg_5_0

			var_1.InitMap(var_6_1)

			local var_6_2 = arg_5_0

			var_1.InitCar(var_6_2, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_5_0

			var_1.InitCheerLeaders(var_7_0, arg_7_0)

			return
		end,
		function(arg_8_0)
			local var_8_0 = arg_5_0

			var_1.RegisterUI(var_8_0)

			local var_8_1 = arg_5_0

			var_1.UpdateUI(var_8_1)

			local var_8_2 = arg_5_0

			var_1.SetUpMainLoop(var_8_2)

			local var_8_3 = arg_5_0

			var_1.CheckEventAndMove(var_8_3, arg_8_0)

			return
		end,
		function(arg_9_0)
			local var_9_0 = arg_5_0

			var_1.CheckSpEvent(var_9_0, {
				finished = true,
				shipId = arg_5_0.selectedShipId
			}, arg_9_0)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_5_0

			var_1.CheckPickCharacter(var_10_0, arg_10_0)

			return
		end
	}, function()
		arg_5_0.cg.blocksRaycasts = true

		return
	end)

	return
end

function var_0_0.InitCheerLeaders(arg_12_0, arg_12_1)
	local var_12_0 = {}

	arg_12_0.cheerLeaders = {}
	ipairs = var_3

	for iter_12_0, iter_12_1 in var_3(var_0_6) do
		table = var_1_10008

		var_1_10008.insert(var_12_0, function(arg_13_0)
			PoolMgr = var_2_10001

			local var_13_0 = var_2_10001.GetInstance()

			var_1.GetSpineChar(var_13_0, iter_12_1, true, function(arg_14_0)
				local var_14_0 = arg_14_0.transform

				Vector3 = var_3_10003
				var_14_0.localScale = var_3_10003(0.6, 0.6, 1)
				var_1.transform.localPosition = var_0_7[iter_12_0]

				local var_14_1 = var_1.transform

				var_2.SetParent(var_14_1, arg_12_0._tf, false)

				local var_14_2 = var_1
				local var_14_3 = var_1.GetComponent

				typeof = var_4
				SpineAnimUI = var_5

				local var_14_4 = var_14_3(var_14_2, var_4(var_5))

				var_2.SetAction(var_14_4, "stand", 0)

				arg_12_0.cheerLeaders[iter_12_1] = arg_14_0

				arg_13_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_12_0, arg_12_1)

	return
end

function var_0_0.SetUpMainLoop(arg_15_0)
	if not arg_15_0.handle then
		UpdateBeat = var_1
		arg_15_0.handle = var_1:CreateListener(arg_15_0.Update, arg_15_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_15_0.handle)

	return
end

function var_0_0.Update(arg_16_0)
	arg_16_0:MoveCar()

	return
end

function var_0_0.InitUI(arg_17_0)
	findTF = var_1_10001
	arg_17_0.tplMapCell = var_1_10001(arg_17_0._tf, "mapContainer/tplMapCell")
	findTF = var_1
	arg_17_0.mapContainer = var_1(arg_17_0._tf, "mapContainer")
	findTF = var_1
	arg_17_0.car = var_1(arg_17_0._tf, "mapContainer/char")
	findTF = var_1
	arg_17_0.btnStart = var_1(arg_17_0._tf, "btnStart")
	findTF = var_1
	arg_17_0.btnHelp = var_1(arg_17_0._tf, "btnHelp")

	local var_17_0 = arg_17_0._tf.parent

	arg_17_0.topTr = var_1.Find(var_17_0, "top")
	findTF = var_1
	arg_17_0.btnAuto = var_1(arg_17_0.topTr, "btnAuto")
	findTF = var_1

	local var_17_1 = var_1(arg_17_0.topTr, "btnAuto")
	local var_17_2 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_17_0.btnAutoImg = var_17_2(var_17_1, var_3(var_1_10004))
	findTF = var_1
	arg_17_0.btnAutoSel = var_1(arg_17_0.topTr, "btnAuto/Text")
	findTF = var_1
	arg_17_0.btnAutoAct = var_1(arg_17_0.topTr, "btnAuto/actvie")
	findTF = var_1
	arg_17_0.btnBack = var_1(arg_17_0._tf, "btnBack")
	findTF = var_1
	arg_17_0.labelLeftCount = var_1(arg_17_0.btnStart, "Text")
	findTF = var_1
	arg_17_0.register = var_1(arg_17_0._tf, "register")
	findTF = var_1
	arg_17_0.registerTxt = var_1(arg_17_0._tf, "register/Text")
	findTF = var_1
	arg_17_0.rollStep = var_1(arg_17_0._tf, "step")
	arg_17_0.hideList = {
		arg_17_0.btnStart,
		arg_17_0.btnHelp,
		arg_17_0.btnBack,
		arg_17_0.btnAuto,
		arg_17_0.register
	}
	setActive = var_1

	var_1(arg_17_0.rollStep, false)

	return
end

function var_0_0.RegisterUI(arg_18_0)
	onButton = var_1_10001

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.btnStart

	local function var_18_2()
		if arg_18_0.leftCount and arg_18_0.leftCount <= 0 then
			pg = var_0

			local var_19_0 = var_0.TipsMgr.GetInstance()
			local var_19_1 = var_0.ShowTips

			i18n = var_2_10002

			var_19_1(var_19_0, var_2_10002("common_count_noenough"))

			return
		end

		local var_19_2 = arg_18_0

		var_0.Roll(var_19_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_18_0, var_18_1, var_18_2, var_1_10005)

	onButton = var_1_10001

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.btnHelp

	local function var_18_5()
		pg = var_2_10000

		local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_20_1 = var_0.ShowMsgBox
		local var_20_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_20_2.type = var_2_10003
		pg = var_2_10003
		var_20_2.helps = var_2_10003.gametip.help_monopoly_car2024.tip

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_18_3, var_18_4, var_18_5, var_1_10005)

	onButton = var_1_10001

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0.btnAuto

	local function var_18_8()
		if arg_18_0.autoFlag then
			local var_21_0 = arg_18_0

			var_0.DisableAuto(var_21_0)
		else
			local var_21_1 = arg_18_0

			var_0.EnableAuto(var_21_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_18_6, var_18_7, var_18_8, var_1_10005)

	onButton = var_1_10001

	local var_18_9 = arg_18_0
	local var_18_10 = arg_18_0.btnBack

	local function var_18_11()
		local var_22_0 = arg_18_0
		local var_22_1 = var_0.emit

		BaseUI = var_2_10002

		var_22_1(var_22_0, var_2_10002.ON_CLOSE)

		return
	end

	SFX_BACK = var_1_10005

	var_1_10001(var_18_9, var_18_10, var_18_11, var_1_10005)

	onButton = var_1_10001

	local var_18_12 = arg_18_0
	local var_18_13 = arg_18_0.register

	local function var_18_14()
		local var_23_0 = arg_18_0.turnCnt - 1
		local var_23_1 = arg_18_0.awardWindow

		var_1.ExecuteAction(var_23_1, "Flush", arg_18_0.lapReward, var_23_0, arg_18_0.titles)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_18_12, var_18_13, var_18_14, var_1_10005)
	arg_18_0:UpdateAutoBtn()

	return
end

function var_0_0.DisableAuto(arg_24_0)
	arg_24_0.autoFlag = false

	arg_24_0:DisplayResult()
	arg_24_0:UpdateAutoBtn()

	return
end

function var_0_0.EnableAuto(arg_25_0)
	if arg_25_0.rolling then
		return
	end

	if arg_25_0.leftCount <= 0 then
		pg = var_1

		local var_25_0 = var_1.TipsMgr.GetInstance()
		local var_25_1 = var_1.ShowTips

		i18n = var_1_10003

		var_25_1(var_25_0, var_1_10003("common_count_noenough"))

		return
	end

	if arg_25_0.useCount < 10 then
		pg = var_1

		local var_25_2 = var_1.TipsMgr.GetInstance()
		local var_25_3 = var_1.ShowTips

		i18n = var_1_10003

		var_25_3(var_25_2, var_1_10003("MonopolyCar2024Game_lock_auto_tip", arg_25_0.useCount))

		return
	end

	local var_25_4 = arg_25_0.awardCollector

	var_1.SetUp(var_25_4)

	arg_25_0.autoFlag = true

	arg_25_0:RollAuto()
	arg_25_0:UpdateAutoBtn()

	pg = var_1

	local var_25_5 = var_1.TipsMgr.GetInstance()
	local var_25_6 = var_1.ShowTips

	i18n = var_1_10003

	var_25_6(var_25_5, var_1_10003("MonopolyCar2024Game_open_auto_tip"))

	return
end

function var_0_0.UpdateAutoBtn(arg_26_0)
	local var_26_0 = arg_26_0.useCount
	local var_26_1 = 10 <= var_26_0

	setActive = var_2

	var_2(arg_26_0.btnAutoSel, var_26_1)

	local var_26_2 = arg_26_0.btnAutoImg

	var_26_2.enabled = not var_26_1
	setActive = var_26_2

	var_26_2(arg_26_0.btnAutoAct, arg_26_0.autoFlag)

	return
end

function var_0_0.DisplayResult(arg_27_0)
	local var_27_0 = arg_27_0.awardCollector

	if #var_1.Fetch(var_27_0) <= 0 then
		return
	end

	local var_27_1 = arg_27_0.resultPage

	var_2.ExecuteAction(var_27_1, "Show", var_1)

	return
end

function var_0_0.RollAuto(arg_28_0)
	if not arg_28_0.autoFlag then
		return
	end

	if arg_28_0.leftCount <= 0 then
		arg_28_0.autoFlag = false

		arg_28_0:DisplayResult()

		return
	end

	arg_28_0:Roll(function()
		local var_29_0 = arg_28_0

		var_0.RollAuto(var_29_0)

		return
	end)

	return
end

function var_0_0.Roll(arg_30_0, arg_30_1)
	local var_30_0 = 0

	arg_30_0.cg.blocksRaycasts = false
	arg_30_0.rolling = true
	seriesAsync = var_3

	var_3({
		function(arg_31_0)
			local var_31_0 = arg_30_0
			local var_31_1 = var_1.emit

			MonopolyCar2024Mediator = var_2_10003

			var_31_1(var_31_0, var_2_10003.ON_START, arg_30_0.actId, function(arg_32_0)
				if arg_32_0 and arg_32_0 > 0 then
					var_30_0 = arg_32_0

					arg_31_0()
				end

				return
			end)

			return
		end,
		function(arg_33_0)
			local var_33_0 = arg_30_0

			var_1.PlayRollAnimation(var_33_0, var_30_0, arg_33_0)

			return
		end,
		function(arg_34_0)
			local var_34_0 = arg_30_0

			var_1.CheckSpEvent(var_34_0, {
				result = var_30_0,
				shipId = arg_30_0.selectedShipId
			}, arg_34_0)

			return
		end,
		function(arg_35_0)
			local var_35_0 = arg_30_0

			var_1.CheckEventAndMove(var_35_0, arg_35_0)

			return
		end,
		function(arg_36_0)
			local var_36_0 = arg_30_0

			var_1.CheckSpStory(var_36_0, arg_30_0.selectedShipId, arg_36_0)

			return
		end,
		function(arg_37_0)
			local var_37_0 = arg_30_0

			var_1.CheckSpEvent(var_37_0, {
				finished = true,
				shipId = arg_30_0.selectedShipId
			}, arg_37_0)

			return
		end
	}, function()
		local var_38_0 = arg_30_0

		var_0.UpdateAutoBtn(var_38_0)

		arg_30_0.cg.blocksRaycasts = true
		arg_30_0.rolling = false

		if arg_30_1 then
			arg_30_1()
		end

		return
	end)

	return
end

function var_0_0.CheckSpStory(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_0.mapCells[arg_39_0.pos] then
		arg_39_2()

		return
	end

	local var_39_0 = var_3.mapId

	pg = var_1_10005

	local var_39_1 = var_1_10005.activity_event_monopoly_map[var_39_0].ship_event

	_ = var_1_10007

	if not var_1_10007.detect(var_39_1, function(arg_40_0)
		return arg_40_0[1] == arg_39_1
	end) then
		arg_39_2()

		return
	end

	local var_39_2

	if not var_7[2] then
		var_39_2 = {}
	end

	if #var_39_2 <= 0 then
		arg_39_2()

		return
	end

	math = var_9

	local var_39_3 = var_39_2[var_9.random(1, #var_39_2)]

	arg_39_0:HideOrShowUI(false)

	local function var_39_4()
		local var_41_0 = arg_39_0

		var_0.HideOrShowUI(var_41_0, true)
		arg_39_2()

		return
	end

	if arg_39_0.autoFlag then
		pg = var_12

		local var_39_5 = var_12.NewStoryMgr.GetInstance()

		var_12.ForceAutoPlay(var_39_5, var_39_3, var_39_4, true, true)
	else
		pg = var_12

		local var_39_6 = var_12.NewStoryMgr.GetInstance()

		var_12.Play(var_39_6, var_39_3, var_39_4, true)
	end

	return
end

function var_0_0.PlayRollAnimation(arg_42_0, arg_42_1, arg_42_2)
	setText = var_1_10003
	findTF = var_1_10004

	var_1_10003(var_1_10004(arg_42_0.rollStep, "animroot/Image/Text"), "00")

	local var_42_0 = arg_42_0.btnStart
	local var_42_1 = var_3.GetComponent

	typeof = var_5
	Animation = var_6

	local var_42_2 = var_42_1(var_42_0, var_5(var_6))
	local var_42_3 = var_3.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10007

	local var_42_4 = var_42_3(var_42_2, var_6(var_1_10007))

	findTF = var_42_2

	local var_42_5 = var_42_2(arg_42_0.rollStep, "animroot")
	local var_42_6 = var_5.GetComponent

	typeof = var_7
	Animation = var_1_10008

	local var_42_7 = var_42_6(var_42_5, var_7(var_1_10008))
	local var_42_8 = var_5.GetComponent

	typeof = var_1_10008
	DftAniEvent = var_1_10009

	local var_42_9 = var_42_8(var_42_7, var_1_10008(var_1_10009))

	var_6.SetTriggerEvent(var_42_9, function()
		setText = var_2_10000
		findTF = var_2_10001

		var_2_10000(var_2_10001(arg_42_0.rollStep, "animroot/Image/Text"), "0" .. arg_42_1)

		return
	end)

	seriesAsync = var_7

	var_7({
		function(arg_44_0)
			local var_44_0 = var_42_4

			var_1.SetEndEvent(var_44_0, function()
				setActive = var_3_10000

				var_3_10000(arg_42_0.btnStart, false)
				arg_44_0()

				return
			end)

			local var_44_1 = var_0

			var_1.Play(var_44_1, "anim_monopolycar_mainui_btn_hide")

			return
		end,
		function(arg_46_0)
			setActive = var_2_10001

			var_2_10001(arg_42_0.rollStep, true)
			arg_46_0()

			return
		end,
		function(arg_47_0)
			local var_47_0 = var_0

			var_1.SetEndEvent(var_47_0, function()
				arg_47_0()

				return
			end)

			local var_47_1 = var_0

			var_1.Play(var_47_1, "anim_monopolycar_mainui_step_0" .. arg_42_1)

			return
		end,
		function(arg_49_0)
			local var_49_0 = var_0

			var_1.SetEndEvent(var_49_0, function()
				setActive = var_3_10000

				var_3_10000(arg_42_0.rollStep, false)
				arg_49_0()

				return
			end)

			local var_49_1 = var_0

			var_1.Play(var_49_1, "anim_monopolycar_mainui_step_hide")

			return
		end
	}, function()
		setActive = var_2_10000

		var_2_10000(arg_42_0.btnStart, true)

		local var_51_0 = var_0

		var_0.Play(var_51_0, "anim_monopolycar_mainui_btn_show")
		arg_42_2()

		return
	end)

	return
end

function var_0_0.CheckEventAndMove(arg_52_0, arg_52_1)
	local function var_52_0()
		local var_53_0 = arg_52_0

		var_0.CheckEventAndMove(var_53_0, arg_52_1)

		return
	end

	if arg_52_0.selectedShipId == 0 then
		arg_52_0:CheckPickCharacter(var_52_0)
	elseif arg_52_0.effectId and arg_52_0.effectId > 0 then
		arg_52_0:CheckEvent(var_52_0)
	elseif arg_52_0.step and arg_52_0.step > 0 then
		arg_52_0:CheckMove(var_52_0)
	else
		arg_52_1()
	end

	return
end

function var_0_0.CheckEvent(arg_54_0, arg_54_1)
	if not arg_54_0.effectId or arg_54_0.effectId <= 0 then
		if arg_54_1 then
			arg_54_1()
		end

		return
	end

	local var_54_0 = arg_54_0.mapCells[arg_54_0.pos]
	local var_54_1 = {}

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_55_0)
			pg = var_2_10001

			if var_2_10001.activity_event_monopoly_event[arg_54_0.effectId].story then
				tonumber = var_2

				if var_2(var_1) == 0 then
					arg_55_0()

					return
				end

				local var_55_0 = arg_54_0

				var_2.HideOrShowUI(var_55_0, false)

				if arg_54_0.autoFlag then
					pg = var_2

					local var_55_1 = var_2.NewStoryMgr.GetInstance()

					var_2.ForceAutoPlay(var_55_1, var_1, arg_55_0, true, true)
				else
					pg = var_2

					local var_55_2 = var_2.NewStoryMgr.GetInstance()

					var_2.Play(var_55_2, var_1, arg_55_0, true, true)
				end

				return
			end
		end,
		function(arg_56_0)
			local var_56_0 = arg_54_0

			var_1.HideOrShowUI(var_56_0, true)

			local var_56_1 = arg_54_0

			var_1.TriggerEvent(var_56_1, function(arg_57_0)
				var_54_1 = arg_57_0

				arg_56_0()

				return
			end)

			return
		end,
		function(arg_58_0)
			local var_58_0 = arg_54_0

			var_1.ReadyMoveCar(var_58_0, var_54_1, arg_58_0)

			return
		end,
		function(arg_59_0)
			local var_59_0 = arg_54_0

			var_1.CheckCountStory(var_59_0, arg_59_0)

			return
		end
	}, arg_54_1)

	return
end

function var_0_0.HideOrShowUI(arg_60_0, arg_60_1)
	ipairs = var_1_10002

	for iter_60_0, iter_60_1 in var_1_10002(arg_60_0.hideList) do
		setActive = var_1_10007

		var_1_10007(iter_60_1, arg_60_1)
	end

	return
end

function var_0_0.TriggerEvent(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0
	local var_61_1 = arg_61_0.emit

	MonopolyCar2024Mediator = var_1_10004

	var_61_1(var_61_0, var_1_10004.ON_TRIGGER, arg_61_0.actId, function(arg_62_0, arg_62_1)
		if arg_62_0 and #arg_62_0 >= 0 then
			arg_61_1(arg_62_0)
		end

		return
	end)

	return
end

function var_0_0.CheckCountStory(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0.useCount
	local var_63_1 = arg_63_0.storys

	_ = var_1_10004

	if var_1_10004.detect(var_63_1, function(arg_64_0)
		return arg_64_0[1] == var_63_0
	end) then
		pg = var_5

		local var_63_2 = var_5.NewStoryMgr.GetInstance()

		var_5.Play(var_63_2, var_4[2], arg_63_1)
	else
		arg_63_1()
	end

	return
end

function var_0_0.CheckSpEvent(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_1.result and arg_65_1.result > 0 then
		arg_65_0:CheckRollResultForSpEvent(arg_65_1.result, arg_65_1.shipId)

		if arg_65_2 then
			arg_65_2()
		end
	elseif arg_65_1.repeatChat then
		arg_65_0:CheckRepeatCharForSpEvent(arg_65_1.shipId)

		if arg_65_2 then
			arg_65_2()
		end
	elseif arg_65_1.finished then
		arg_65_0:CheckFinishedForSpEvent(arg_65_1.shipId)

		if arg_65_2 then
			arg_65_2()
		end
	elseif arg_65_2 then
		arg_65_2()
	end

	return
end

function var_0_0.CheckFinishedForSpEvent(arg_66_0, arg_66_1)
	if arg_66_0.turnCnt <= arg_66_0.cacheTurnCnt then
		return
	end

	arg_66_0.cacheTurnCnt = arg_66_0.turnCnt
	_ = var_2

	if #var_2.select(arg_66_0.spEvents[arg_66_1], function(arg_67_0)
		return arg_67_0[1] == 4
	end) <= 0 then
		return
	end

	local var_66_0

	if not var_2[1][2] then
		var_66_0 = {}
	end

	local var_66_1 = arg_66_0:GetUnReadDialogue(var_66_0)
	local var_66_2 = arg_66_0.bubblePage

	var_6.Show(var_66_2, arg_66_0.actId, arg_66_1, var_66_1)

	return
end

function var_0_0.CheckRepeatCharForSpEvent(arg_68_0, arg_68_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_68_0.pickCharList, arg_68_1) then
		return
	end

	_ = var_2

	local var_68_0 = var_2.select
	local var_68_1

	if not arg_68_0.spEvents[arg_68_1] then
		var_68_1 = {}
	end

	if #var_68_0(var_68_1, function(arg_69_0)
		return arg_69_0[1] == 5
	end) <= 0 then
		return
	end

	local var_68_2

	if not var_2[1][2] then
		var_68_2 = {}
	end

	local var_68_3 = arg_68_0:GetUnReadDialogue(var_68_2)
	local var_68_4 = arg_68_0.bubblePage

	var_6.Show(var_68_4, arg_68_0.actId, arg_68_1, var_68_3)

	return
end

function var_0_0.GetUnReadDialogue(arg_70_0, arg_70_1)
	local var_70_0 = {}

	ipairs = var_1_10003

	for iter_70_0, iter_70_1 in var_1_10003(arg_70_1) do
		table = var_1_10008

		if not var_1_10008.contains(arg_70_0.dialogRecorder, iter_70_1) then
			table = var_1_10008

			var_1_10008.insert(var_70_0, iter_70_1)
		end
	end

	if #var_70_0 <= 0 then
		math = var_3

		return arg_70_1[var_3.random(1, #arg_70_1)]
	end

	math = var_3

	return var_70_0[var_3.random(1, #var_70_0)]
end

function var_0_0.CheckRollResultForSpEvent(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = {
		{
			1,
			2
		},
		{
			3,
			4
		},
		{
			5,
			6
		}
	}

	assert = var_4

	var_4(arg_71_0.spEvents[arg_71_2], arg_71_2)

	_ = var_4

	local var_71_1 = var_4.select
	local var_71_2

	if not arg_71_0.spEvents[arg_71_2] then
		var_71_2 = {}
	end

	if #var_71_1(var_71_2, function(arg_72_0)
		local var_72_0

		if not var_71_0[arg_72_0[1]] then
			var_72_0 = {
				99,
				99
			}
		end

		return arg_71_1 == var_72_0[1] or arg_71_1 == var_72_0[2]
	end) <= 0 then
		return
	end

	local var_71_3

	if not var_4[1][2] then
		var_71_3 = {}
	end

	local var_71_4 = arg_71_0:GetUnReadDialogue(var_71_3)
	local var_71_5 = arg_71_0.bubblePage

	var_8.Show(var_71_5, arg_71_0.actId, arg_71_2, var_71_4)

	return
end

function var_0_0.CheckMove(arg_73_0, arg_73_1)
	local var_73_0 = {}

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_74_0)
			local var_74_0 = arg_73_0
			local var_74_1 = var_1.emit

			MonopolyCar2024Mediator = var_2_10003

			var_74_1(var_74_0, var_2_10003.ON_MOVE, arg_73_0.actId, function(arg_75_0, arg_75_1, arg_75_2)
				if not arg_75_0 or not arg_75_1 or not arg_75_2 then
					warning = var_3_10003

					var_3_10003(arg_75_0, arg_75_1, arg_75_2)

					return
				end

				var_73_0 = arg_75_1

				arg_74_0()

				return
			end)

			return
		end,
		function(arg_76_0)
			local var_76_0 = arg_73_0

			var_1.ReadyMoveCar(var_76_0, var_73_0, arg_76_0)

			return
		end
	}, arg_73_1)

	return
end

function var_0_0.ReadyMoveCar(arg_77_0, arg_77_1, arg_77_2)
	if not arg_77_1 or #arg_77_1 <= 0 then
		if arg_77_2 then
			arg_77_2()
		end

		return
	end

	local var_77_0 = {}
	local var_77_1 = arg_77_0.car.localPosition
	local var_77_2 = {}
	local var_77_3 = {}

	for iter_77_0 = 1, #arg_77_1 do
		if arg_77_0:CheckPathTurn(arg_77_1[iter_77_0]) then
			table = var_1_10011

			var_1_10011.insert(var_77_2, arg_77_0.mapCells[arg_77_1[iter_77_0]].position)

			table = var_1_10011

			var_1_10011.insert(var_77_3, arg_77_1[iter_77_0])
		elseif iter_77_0 == #arg_77_1 then
			table = var_1_10011

			var_1_10011.insert(var_77_2, arg_77_0.mapCells[arg_77_1[iter_77_0]].position)

			table = var_1_10011

			var_1_10011.insert(var_77_3, arg_77_1[iter_77_0])
		end
	end

	arg_77_0.speedX = 0
	arg_77_0.speedY = 0
	arg_77_0.baseSpeed = 6
	arg_77_0.baseASpeed = 0.1

	for iter_77_1 = 1, #var_77_2 do
		table = var_1_10011

		var_1_10011.insert(var_77_0, function(arg_78_0)
			arg_77_0.moveComplete = arg_78_0
			arg_77_0.stopOnEnd = false
			arg_77_0.targetPosition = var_77_2[iter_77_1]
			arg_77_0.targetPosIndex = var_77_3[iter_77_1]
			arg_77_0.moveX = arg_77_0.targetPosition.x - arg_77_0.car.localPosition.x
			arg_77_0.moveY = arg_77_0.targetPosition.y - arg_77_0.car.localPosition.y

			local var_78_0 = arg_77_0
			local var_78_1 = arg_77_0.baseSpeed
			local var_78_2 = arg_77_0.moveX

			math = var_2_10004
			var_78_0.baseSpeedX = var_78_1 * (var_78_2 / var_2_10004.abs(arg_77_0.moveX))

			local var_78_3 = arg_77_0
			local var_78_4 = arg_77_0.baseASpeed
			local var_78_5 = arg_77_0.moveX

			math = var_4
			var_78_3.baseASpeedX = var_78_4 * (var_78_5 / var_4.abs(arg_77_0.moveX))

			local var_78_6 = arg_77_0

			math = var_2

			local var_78_7 = var_2.abs(arg_77_0.baseSpeedX)

			math = var_3
			var_78_6.baseSpeedY = var_78_7 / (var_3.abs(arg_77_0.moveX) / arg_77_0.moveY)

			local var_78_8 = arg_77_0

			math = var_2

			local var_78_9 = var_2.abs(arg_77_0.baseASpeedX)

			math = var_3
			var_78_8.baseASpeedY = var_78_9 / (var_3.abs(arg_77_0.moveX) / arg_77_0.moveY)

			if iter_77_1 == 1 then
				arg_77_0.speedX = 0
				arg_77_0.speedY = 0
			else
				arg_77_0.speedX = arg_77_0.baseSpeedX
				arg_77_0.speedY = arg_77_0.baseSpeedY
			end

			return
		end)
	end

	table = var_7

	var_7.insert(var_77_0, function(arg_79_0)
		arg_77_0.moveComplete = nil

		local var_79_0 = arg_77_0

		var_1.UpdateCarPos(var_79_0, arg_77_1[#arg_77_1], false)
		arg_79_0()

		return
	end)

	table = var_7

	var_7.insert(var_77_0, function(arg_80_0)
		LeanTween = var_2_10001

		local var_80_0 = var_2_10001.value

		go = var_2_10002

		local var_80_1 = var_80_0(var_2_10002(arg_77_0._tf), 1, 0, 0.1)
		local var_80_2 = var_1.setOnComplete

		System = var_3

		var_80_2(var_80_1, var_3.Action(arg_80_0))

		return
	end)

	seriesAsync = var_7

	var_7(var_77_0, arg_77_2)

	return
end

function var_0_0.MoveCar(arg_81_0)
	if not arg_81_0.targetPosition then
		return
	end

	math = var_1

	local var_81_0 = var_1.abs(arg_81_0.targetPosition.x - arg_81_0.car.localPosition.x)

	math = var_2

	local var_81_1 = var_2.abs(arg_81_0.targetPosition.y - arg_81_0.car.localPosition.y)

	if var_81_0 <= 6.5 and var_81_1 <= 6.5 then
		arg_81_0.targetPosition = nil

		if arg_81_0.moveComplete then
			arg_81_0:UpdateCarPos(arg_81_0.targetPosIndex, true)
			arg_81_0.moveComplete()
		end
	end

	math = var_3

	local var_81_2 = var_3.abs(arg_81_0.speedX + arg_81_0.baseASpeedX)

	math = var_4

	local var_81_3

	if not (var_81_2 > var_4.abs(arg_81_0.baseSpeedX)) or not arg_81_0.baseSpeedX then
		var_81_3 = arg_81_0.speedX + arg_81_0.baseASpeedX
	end

	arg_81_0.speedX = var_81_3
	math = var_81_3

	local var_81_4 = var_81_3.abs(arg_81_0.speedY + arg_81_0.baseASpeedY)

	math = var_4

	local var_81_5

	if not (var_81_4 > var_4.abs(arg_81_0.baseSpeedY)) or not arg_81_0.baseSpeedY then
		var_81_5 = arg_81_0.speedY + arg_81_0.baseASpeedY
	end

	arg_81_0.speedY = var_81_5

	local var_81_6 = arg_81_0.car.localPosition
	local var_81_7 = arg_81_0.car

	Vector3 = var_5
	var_81_7.localPosition = var_5(var_81_6.x + arg_81_0.speedX, var_81_6.y + arg_81_0.speedY, 0)

	return
end

function var_0_0.CheckPathTurn(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_1 + 1 > #arg_82_0.mapCells and 1 or arg_82_1 + 1
	local var_82_1

	if not (arg_82_1 - 1 < 1) or not #arg_82_0.mapCells then
		var_82_1 = arg_82_1 - 1
	end

	if arg_82_0.mapCells[var_82_0].col == arg_82_0.mapCells[var_82_1].col or arg_82_0.mapCells[var_82_0].row == arg_82_0.mapCells[var_82_1].row then
		return false
	end

	return true
end

function var_0_0.CheckPickCharacter(arg_83_0, arg_83_1)
	if arg_83_0.selectedShipId == 0 or #arg_83_0.pickCharList == 0 then
		local function var_83_0(arg_84_0)
			local var_84_0 = arg_83_0.pickableShipId[arg_84_0]
			local var_84_1 = arg_83_0

			var_2.CheckSpEvent(var_84_1, {
				repeatChat = true,
				shipId = var_84_0
			})

			local var_84_2 = arg_83_0
			local var_84_3 = var_2.emit

			MonopolyCar2024Mediator = var_4

			var_84_3(var_84_2, var_4.ON_PICK, arg_83_0.actId, var_84_0, function(arg_85_0)
				local var_85_0 = arg_83_0.pickPage

				var_1.Hide(var_85_0)

				seriesAsync = var_1

				var_1({
					function(arg_86_0)
						local var_86_0 = arg_83_0

						var_1.ReadyMoveCar(var_86_0, arg_85_0, arg_86_0)

						return
					end,
					function(arg_87_0)
						local var_87_0 = arg_83_0

						var_1.CheckEventAndMove(var_87_0, arg_87_0)

						return
					end
				}, arg_83_1)

				return
			end)

			return
		end

		_ = var_1_10004

		local var_83_1 = var_1_10004.map(arg_83_0.pickCharList, function(arg_88_0)
			table = var_2_10001

			return var_2_10001.indexof(arg_83_0.pickableShipId, arg_88_0)
		end)
		local var_83_2 = arg_83_0.pickPage

		var_5.ExecuteAction(var_83_2, "Show", arg_83_0.actId, var_83_1, arg_83_0.autoFlag, var_83_0)
	else
		arg_83_1()
	end

	return
end

function var_0_0.InitMap(arg_89_0)
	arg_89_0.mapCells = {}

	for iter_89_0 = 1, #var_0_4 do
		local var_89_0 = iter_89_0 - 1
		local var_89_1 = {
			x = -var_89_0 * var_0_1,
			y = -var_89_0 * var_0_2
		}
		local var_89_2 = var_0_4[iter_89_0]

		for iter_89_1 = 1, #var_89_2 do
			local var_89_3 = iter_89_1 - 1
			local var_89_4 = var_89_2[iter_89_1]

			if 0 < var_89_4 then
				cloneTplTo = var_14

				local var_89_5 = arg_89_0.tplMapCell
				local var_89_6 = arg_89_0.mapContainer

				tostring = var_1_10017

				local var_89_7 = var_14(var_89_5, var_89_6, var_1_10017(var_89_4))

				Vector2 = var_89_5
				var_89_7.localPosition = var_89_5(var_0_1 * var_89_3 + var_89_1.x, -var_0_2 * var_89_3 + var_89_1.y)
				pg = var_16

				local var_89_8 = var_16.activity_event_monopoly_map[var_89_4].icon

				GetSpriteFromAtlas = var_1_10017
				var_1_10017 = var_1_10017("ui/MonopolyCar2024_atlas", var_89_8)

				local var_89_9 = var_89_7
				local var_89_10 = var_89_7.GetComponent

				typeof = var_1_10020
				Image = var_1_10021
				var_89_10(var_89_9, var_1_10020(var_1_10021)).sprite = var_1_10017

				local var_89_11 = var_89_7
				local var_89_12 = var_89_7.GetComponent

				typeof = var_1_10020
				Image = var_1_10021

				local var_89_13 = var_89_12(var_89_11, var_1_10020(var_1_10021))

				var_18.SetNativeSize(var_89_13)

				local var_89_14 = {
					col = var_89_3,
					row = var_89_0,
					mapId = var_89_4,
					tf = var_89_7,
					icon = var_89_8,
					position = var_15
				}

				table = var_89_13

				var_89_13.insert(arg_89_0.mapCells, var_89_14)
			end
		end
	end

	table = var_1

	var_1.sort(arg_89_0.mapCells, function(arg_90_0, arg_90_1)
		return arg_90_0.mapId < arg_90_1.mapId
	end)

	return
end

function var_0_0.InitCar(arg_91_0, arg_91_1)
	PoolMgr = var_1_10002

	local var_91_0 = var_1_10002.GetInstance()

	var_2.GetSpineChar(var_91_0, var_0_3, true, function(arg_92_0)
		arg_91_0.model = arg_92_0

		local var_92_0 = arg_91_0.model.transform

		Vector3 = var_2_10002
		var_92_0.localScale = var_2_10002.one

		local var_92_1 = arg_91_0.model.transform

		Vector3 = var_2
		var_92_1.localPosition = var_2.zero

		local var_92_2 = arg_91_0.model.transform

		var_1.SetParent(var_92_2, arg_91_0.car, false)

		local var_92_3 = arg_91_0
		local var_92_4 = arg_91_0.model
		local var_92_5 = var_2.GetComponent

		typeof = var_4
		SpineAnimUI = var_2_10005
		var_92_3.anim = var_92_5(var_92_4, var_4(var_2_10005))

		if arg_91_0.pos then
			local var_92_6 = arg_91_0

			var_1.UpdateCarPos(var_92_6, arg_91_0.pos, false)
		end

		arg_91_1()

		return
	end)

	return
end

function var_0_0.UpdateCarPos(arg_93_0, arg_93_1, arg_93_2)
	if arg_93_0.model then
		assert = var_3

		var_3(arg_93_0.mapCells[arg_93_1], arg_93_1)

		local var_93_0 = arg_93_0.mapCells[arg_93_1].position
		local var_93_1 = arg_93_1 + 1 > #arg_93_0.mapCells and 1 or arg_93_1 + 1
		local var_93_2 = arg_93_0.mapCells[var_93_1]
		local var_93_3, var_93_4 = arg_93_0:GetCarMoveType(arg_93_0.mapCells[arg_93_1].mapId, arg_93_0.mapCells[var_93_1].mapId, arg_93_2)

		arg_93_0.car.localScale = var_93_4

		local var_93_5 = arg_93_0.anim

		var_8.SetActionCallBack(var_93_5, nil)

		local var_93_6 = arg_93_0.anim

		var_8.SetAction(var_93_6, var_93_3, 0)

		arg_93_0.car.localPosition = var_93_0

		local var_93_7 = arg_93_0.car

		var_8.SetAsLastSibling(var_93_7)
	end

	return
end

function var_0_0.GetCarMoveType(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
	local var_94_0 = {}
	local var_94_1 = {}

	for iter_94_0 = 1, #var_0_4 do
		local var_94_2 = var_0_4[iter_94_0]

		for iter_94_1 = 1, #var_94_2 do
			if var_94_2[iter_94_1] == arg_94_1 then
				var_94_0 = {
					x = iter_94_1,
					y = iter_94_0
				}
			end

			if var_15 == arg_94_2 then
				var_94_1 = {
					x = iter_94_1,
					y = iter_94_0
				}
			end
		end
	end

	local var_94_3
	local var_94_4

	if var_94_1.y > var_94_0.y then
		var_94_3 = arg_94_3 and var_0_11 or var_0_9
		Vector3 = var_8
		var_94_4 = var_8(var_0_5, var_0_5, var_0_5)
	elseif var_94_1.y < var_94_0.y then
		var_94_3 = arg_94_3 and var_0_10 or var_0_8
		Vector3 = var_8
		var_94_4 = var_8(var_0_5, var_0_5, var_0_5)
	elseif var_94_1.x > var_94_0.x then
		var_94_3 = arg_94_3 and var_0_11 or var_0_9
		Vector3 = var_8
		var_94_4 = var_8(-var_0_5, var_0_5, var_0_5)
	elseif var_94_1.x < var_94_0.x then
		var_94_3 = arg_94_3 and var_0_10 or var_0_8
		Vector3 = var_8
		var_94_4 = var_8(-var_0_5, var_0_5, var_0_5)
	end

	return var_94_3, var_94_4
end

function var_0_0.UpdateUI(arg_95_0)
	setText = var_1_10001

	var_1_10001(arg_95_0.labelLeftCount, arg_95_0.leftCount)

	setText = var_1_10001

	var_1_10001(arg_95_0.registerTxt, arg_95_0.turnCnt - 1)

	return
end

function var_0_0.UpdateActivity(arg_96_0, arg_96_1)
	arg_96_0:UpdateActData(arg_96_1)
	arg_96_0:UpdateUI()

	return
end

function var_0_0.Dispose(arg_97_0)
	pairs = var_1_10001

	for iter_97_0, iter_97_1 in var_1_10001(arg_97_0.cheerLeaders) do
		PoolMgr = var_1_10006

		local var_97_0 = var_1_10006.GetInstance()

		var_1_10006.ReturnSpineChar(var_97_0, iter_97_0, iter_97_1)
	end

	if arg_97_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_97_0.handle)

		arg_97_0.handle = nil
	end

	if arg_97_0.awardWindow then
		local var_97_1 = arg_97_0.awardWindow

		var_1.Destroy(var_97_1)

		arg_97_0.awardWindow = nil
	end

	if arg_97_0.pickPage then
		local var_97_2 = arg_97_0.pickPage

		if var_1.isShowing(var_97_2) then
			local var_97_3 = arg_97_0.pickPage

			var_1.Hide(var_97_3)
		end

		local var_97_4 = arg_97_0.pickPage

		var_1.Destroy(var_97_4)

		arg_97_0.pickPage = nil
	end

	if arg_97_0.resultPage then
		local var_97_5 = arg_97_0.resultPage

		var_1.Destroy(var_97_5)

		arg_97_0.resultPage = nil
	end

	if arg_97_0.awardCollector then
		local var_97_6 = arg_97_0.awardCollector

		var_1.Dispose(var_97_6)

		arg_97_0.awardCollector = nil
	end

	local var_97_7 = arg_97_0.bubblePage

	var_1.Dispose(var_97_7)

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_97_0)

	PoolMgr = var_1

	local var_97_8 = var_1.GetInstance()

	var_1.ReturnSpineChar(var_97_8, var_0_3, arg_97_0.model)

	return
end

return var_0_0
