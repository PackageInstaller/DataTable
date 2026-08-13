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

	typeof = var_1_10007
	CanvasGroup = var_1_10009
	arg_1_0.cg = var_4(var_1_0, var_1_10007(var_1_10009))
	findTF = var_4
	arg_1_0.maskTr = var_4(arg_1_0._tf.parent, "mask")
	arg_1_0.pickPage = arg_1_0:NewPickPage(arg_1_2, arg_1_3)
	arg_1_0.bubblePage = arg_1_0:NewBubblePage(arg_1_2, arg_1_3)
	AwardWindow = var_4
	arg_1_0.awardWindow = var_4.New(arg_1_2, arg_1_3)
	MonopolyCar2024TotalRewardPanel = var_4
	arg_1_0.resultPage = var_4.New(arg_1_2, arg_1_3)
	MonopolyCar2024GameAwardCollector = var_4
	arg_1_0.awardCollector = var_4.New()

	arg_1_0:UpdateActData(arg_1_1)

	return
end

function var_0_0.UpdateStory(arg_2_0)
	return
end

function var_0_0.NewBubblePage(arg_3_0, arg_3_1, arg_3_2)
	MonopolyCar2024BubblePage = var_1_10003

	return var_1_10003.New(arg_3_1:Find("bubble"), arg_3_2)
end

function var_0_0.NewPickPage(arg_4_0, arg_4_1, arg_4_2)
	MonopolyCar2024PickPage = var_1_10003

	return var_1_10003.New(arg_4_1, arg_4_2)
end

function var_0_0.emit(arg_5_0, ...)
	local var_5_0 = arg_5_0._event

	var_1.emit(var_5_0, ...)

	return
end

function var_0_0.UpdateActData(arg_6_0, arg_6_1)
	arg_6_0.actId = arg_6_1.id
	pg = var_2

	local var_6_0 = var_2.TimeMgr.GetInstance()
	local var_6_1 = var_2.GetServerTime(var_6_0)
	local var_6_2 = arg_6_1.data1

	math = var_6_0

	local var_6_3 = var_6_0.ceil((var_6_1 - var_6_2) / 0) * arg_6_1:getDataConfig("daily_time")
	local var_6_4

	if not arg_6_1.data1_list[1] then
		var_6_4 = 0
	end

	arg_6_0.totalCnt = var_6_3 + var_6_4

	local var_6_5

	if not arg_6_1.data1_list[2] then
		var_6_5 = 0
	end

	arg_6_0.useCount = var_6_5
	arg_6_0.leftCount = arg_6_0.totalCnt - arg_6_0.useCount
	arg_6_0.dialogRecorder = arg_6_1.data4_list
	arg_6_0.pickCharList = arg_6_1.data3_list
	math = var_7
	arg_6_0.pos = var_7.max(arg_6_1.data2, 1)

	local var_6_6

	if not arg_6_1.data3 then
		var_6_6 = 0
	end

	arg_6_0.step = var_6_6

	local var_6_7

	if not arg_6_1.data4 then
		var_6_7 = 0
	end

	arg_6_0.effectId = var_6_7

	local var_6_8

	if not arg_6_1.data1_list[3] then
		var_6_8 = 0
	end

	arg_6_0.turnCnt = var_6_8

	local var_6_9

	if not arg_6_1.data1_list[4] then
		var_6_9 = 0
	end

	arg_6_0.selectedShipId = var_6_9

	local var_6_10

	if not arg_6_1:getDataConfig("story") then
		var_6_10 = {}
	end

	arg_6_0.storys = var_6_10

	local var_6_11

	if not arg_6_1:getDataConfig("sum_lap_reward_show") then
		var_6_11 = {}
	end

	arg_6_0.lapReward = var_6_11

	local var_6_12 = {}

	i18n = var_8
	var_6_12[1] = var_8("MonopolyCar2024Game_title1")
	i18n = var_8
	var_6_12[2] = var_8("MonopolyCar2024Game_title2")
	arg_6_0.titles = var_6_12
	_ = var_6_12
	arg_6_0.pickableShipId = var_6_12.map(arg_6_1:getDataConfig("ship_reward"), function(arg_7_0)
		return arg_7_0[1]
	end)
	arg_6_0.spEvents = {}
	ipairs = var_7

	local var_6_13

	if not arg_6_1:getDataConfig("ship_dialog") then
		var_6_13 = {}
	end

	for iter_6_0, iter_6_1 in var_7(var_6_13) do
		arg_6_0.spEvents[iter_6_1[1]] = iter_6_1[2]
	end

	arg_6_0.cacheTurnCnt = arg_6_0.turnCnt

	return
end

function var_0_0.Setup(arg_8_0)
	arg_8_0:BlocksRaycasts(false)

	seriesAsync = var_1

	var_1({
		function(arg_9_0)
			local var_9_0 = arg_8_0

			var_1.InitUI(var_9_0)

			local var_9_1 = arg_8_0

			var_1.InitMap(var_9_1)

			local var_9_2 = arg_8_0

			var_1.InitCar(var_9_2, arg_9_0)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_8_0

			var_1.InitCheerLeaders(var_10_0, arg_10_0)

			return
		end,
		function(arg_11_0)
			local var_11_0 = arg_8_0

			var_1.OnEnterDone(var_11_0, arg_11_0)

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_8_0

			var_1.RegisterUI(var_12_0)

			local var_12_1 = arg_8_0

			var_1.UpdateUI(var_12_1)

			local var_12_2 = arg_8_0

			var_1.SetUpMainLoop(var_12_2)

			local var_12_3 = arg_8_0

			var_1.CheckEventAndMove(var_12_3, arg_12_0)

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_8_0

			var_1.CheckSpEvent(var_13_0, {
				finished = true,
				shipId = arg_8_0.selectedShipId
			}, arg_13_0)

			return
		end,
		function(arg_14_0)
			local var_14_0 = arg_8_0

			var_1.CheckPickCharacter(var_14_0, arg_14_0)

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_8_0

			var_1.InitDone(var_15_0, arg_15_0)

			return
		end,
		function(arg_16_0)
			local var_16_0 = arg_8_0

			var_1.CheckMainStorys(var_16_0, arg_16_0)

			return
		end
	}, function()
		local var_17_0 = arg_8_0

		var_0.BlocksRaycasts(var_17_0, true)

		return
	end)

	return
end

function var_0_0.CheckMainStorys(arg_18_0, arg_18_1)
	arg_18_1()

	return
end

function var_0_0.OnEnterDone(arg_19_0, arg_19_1)
	arg_19_1()

	return
end

function var_0_0.InitDone(arg_20_0, arg_20_1)
	arg_20_1()

	return
end

function var_0_0.InitCheerLeaders(arg_21_0, arg_21_1)
	local var_21_0 = {}

	arg_21_0.cheerLeaders = {}
	ipairs = var_3

	for iter_21_0, iter_21_1 in var_3(var_0_6) do
		table = var_1_10008

		var_1_10008.insert(var_21_0, function(arg_22_0)
			PoolMgr = var_2_10001

			local var_22_0 = var_2_10001.GetInstance()

			var_1.GetSpineChar(var_22_0, iter_21_1, true, function(arg_23_0)
				local var_23_0 = arg_23_0.transform

				Vector3 = var_3_10003
				var_23_0.localScale = var_3_10003(0.6, 0.6, 1)
				var_1.transform.localPosition = var_0_7[iter_21_0]

				local var_23_1 = var_1.transform

				var_2.SetParent(var_23_1, arg_21_0._tf, false)

				local var_23_2 = var_1
				local var_23_3 = var_1.GetComponent

				typeof = var_5
				SpineAnimUI = var_7

				local var_23_4 = var_23_3(var_23_2, var_5(var_7))

				var_2.SetAction(var_23_4, "stand", 0)

				arg_21_0.cheerLeaders[iter_21_1] = arg_23_0

				arg_22_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_21_0, arg_21_1)

	return
end

function var_0_0.SetUpMainLoop(arg_24_0)
	if not arg_24_0.handle then
		UpdateBeat = var_1
		arg_24_0.handle = var_1:CreateListener(arg_24_0.Update, arg_24_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_24_0.handle)

	return
end

function var_0_0.Update(arg_25_0)
	arg_25_0:MoveCar()

	return
end

function var_0_0.InitUI(arg_26_0)
	findTF = var_1_10001
	arg_26_0.tplMapCell = var_1_10001(arg_26_0._tf, "mapContainer/tplMapCell")
	findTF = var_1
	arg_26_0.mapContainer = var_1(arg_26_0._tf, "mapContainer")
	findTF = var_1
	arg_26_0.car = var_1(arg_26_0._tf, "mapContainer/char")
	findTF = var_1
	arg_26_0.btnStart = var_1(arg_26_0._tf, "btnStart")
	findTF = var_1
	arg_26_0.btnHelp = var_1(arg_26_0._tf, "btnHelp")

	local var_26_0 = arg_26_0._tf.parent

	arg_26_0.topTr = var_1.Find(var_26_0, "top")
	findTF = var_1
	arg_26_0.btnAuto = var_1(arg_26_0.topTr, "btnAuto")
	findTF = var_1

	local var_26_1 = var_1(arg_26_0.topTr, "btnAuto")
	local var_26_2 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_26_0.btnAutoImg = var_26_2(var_26_1, var_4(var_1_10006))
	findTF = var_1
	arg_26_0.btnAutoSel = var_1(arg_26_0.topTr, "btnAuto/Text")
	findTF = var_1
	arg_26_0.btnAutoAct = var_1(arg_26_0.topTr, "btnAuto/actvie")
	findTF = var_1
	arg_26_0.btnBack = var_1(arg_26_0._tf.parent, "adapt_1/btnBack")
	findTF = var_1
	arg_26_0.labelLeftCount = var_1(arg_26_0.btnStart, "Text")
	findTF = var_1
	arg_26_0.register = var_1(arg_26_0._tf, "register")
	findTF = var_1
	arg_26_0.registerTxt = var_1(arg_26_0._tf, "register/Text")
	findTF = var_1
	arg_26_0.rollStep = var_1(arg_26_0._tf, "step")
	arg_26_0.hideList = {
		arg_26_0.btnStart,
		arg_26_0.btnHelp,
		arg_26_0.btnBack,
		arg_26_0.btnAuto,
		arg_26_0.register
	}

	arg_26_0:SetRollStepAct(false)

	return
end

function var_0_0.RegisterUI(arg_27_0)
	onButton = var_1_10001

	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.btnStart

	local function var_27_2()
		if arg_27_0.leftCount and arg_27_0.leftCount <= 0 then
			pg = var_0

			local var_28_0 = var_0.TipsMgr.GetInstance()
			local var_28_1 = var_0.ShowTips

			i18n = var_2_10003

			var_28_1(var_28_0, var_2_10003("common_count_noenough"))

			return
		end

		local var_28_2 = arg_27_0

		var_0.Roll(var_28_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_27_0, var_27_1, var_27_2, var_1_10006)

	onButton = var_1_10001

	local var_27_3 = arg_27_0
	local var_27_4 = arg_27_0.btnHelp

	local function var_27_5()
		pg = var_2_10000

		local var_29_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_29_1 = var_0.ShowMsgBox
		local var_29_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_29_2.type = var_2_10004
		pg = var_2_10004
		var_29_2.helps = var_2_10004.gametip.help_monopoly_car2024.tip

		var_29_1(var_29_0, var_29_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_27_3, var_27_4, var_27_5, var_1_10006)

	onButton = var_1_10001

	local var_27_6 = arg_27_0
	local var_27_7 = arg_27_0.btnAuto

	local function var_27_8()
		if arg_27_0.autoFlag then
			local var_30_0 = arg_27_0

			var_0.DisableAuto(var_30_0)
		else
			local var_30_1 = arg_27_0

			var_0.EnableAuto(var_30_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_27_6, var_27_7, var_27_8, var_1_10006)

	onButton = var_1_10001

	local var_27_9 = arg_27_0
	local var_27_10 = arg_27_0.btnBack

	local function var_27_11()
		local var_31_0 = arg_27_0
		local var_31_1 = var_0.emit

		BaseUI = var_2_10003

		var_31_1(var_31_0, var_2_10003.ON_CLOSE)

		return
	end

	SFX_BACK = var_1_10006

	var_1_10001(var_27_9, var_27_10, var_27_11, var_1_10006)

	onButton = var_1_10001

	local var_27_12 = arg_27_0
	local var_27_13 = arg_27_0.register

	local function var_27_14()
		local var_32_0 = arg_27_0.turnCnt - 1
		local var_32_1 = arg_27_0.awardWindow

		var_1.ExecuteAction(var_32_1, "Flush", arg_27_0.lapReward, var_32_0, arg_27_0.titles)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_27_12, var_27_13, var_27_14, var_1_10006)
	arg_27_0:UpdateAutoBtn()

	return
end

function var_0_0.DisableAuto(arg_33_0)
	arg_33_0.autoFlag = false

	arg_33_0:DisplayResult()
	arg_33_0:UpdateAutoBtn()

	return
end

function var_0_0.EnableAuto(arg_34_0)
	if arg_34_0.rolling then
		return
	end

	if arg_34_0.leftCount <= 0 then
		pg = var_1

		local var_34_0 = var_1.TipsMgr.GetInstance()
		local var_34_1 = var_1.ShowTips

		i18n = var_1_10004

		var_34_1(var_34_0, var_1_10004("common_count_noenough"))

		return
	end

	if arg_34_0.useCount < 10 then
		pg = var_1

		local var_34_2 = var_1.TipsMgr.GetInstance()
		local var_34_3 = var_1.ShowTips

		i18n = var_1_10004

		var_34_3(var_34_2, var_1_10004("MonopolyCar2024Game_lock_auto_tip", arg_34_0.useCount))

		return
	end

	local var_34_4 = arg_34_0.awardCollector

	var_1.SetUp(var_34_4)

	arg_34_0.autoFlag = true

	arg_34_0:RollAuto()
	arg_34_0:UpdateAutoBtn()

	pg = var_1

	local var_34_5 = var_1.TipsMgr.GetInstance()
	local var_34_6 = var_1.ShowTips

	i18n = var_1_10004

	var_34_6(var_34_5, var_1_10004("MonopolyCar2024Game_open_auto_tip"))

	return
end

function var_0_0.UpdateAutoBtn(arg_35_0)
	local var_35_0 = arg_35_0.useCount
	local var_35_1 = 10 <= var_35_0

	setActive = var_2

	var_2(arg_35_0.btnAutoSel, var_35_1)

	local var_35_2 = arg_35_0.btnAutoImg

	var_35_2.enabled = not var_35_1
	setActive = var_35_2

	var_35_2(arg_35_0.btnAutoAct, arg_35_0.autoFlag)

	return
end

function var_0_0.DisplayResult(arg_36_0)
	local var_36_0 = arg_36_0.awardCollector

	if #var_1.Fetch(var_36_0) <= 0 then
		return
	end

	local var_36_1 = arg_36_0.resultPage

	var_2.ExecuteAction(var_36_1, "Show", var_1)

	return
end

function var_0_0.RollAuto(arg_37_0)
	if not arg_37_0.autoFlag then
		return
	end

	if arg_37_0.leftCount <= 0 then
		arg_37_0.autoFlag = false

		arg_37_0:DisplayResult()
		arg_37_0:UpdateAutoBtn()

		return
	end

	arg_37_0:Roll(function()
		local var_38_0 = arg_37_0

		var_0.RollAuto(var_38_0)

		return
	end)

	return
end

function var_0_0.BlocksRaycasts(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.cg

	var_39_0.blocksRaycasts = arg_39_1
	setActive = var_39_0

	var_39_0(arg_39_0.maskTr, not arg_39_1)

	arg_39_0.isBlocksRaycasts = not arg_39_1

	return
end

function var_0_0.Roll(arg_40_0, arg_40_1)
	local var_40_0 = 0

	arg_40_0:BlocksRaycasts(false)

	arg_40_0.rolling = true
	seriesAsync = var_3

	var_3({
		function(arg_41_0)
			local var_41_0 = arg_40_0
			local var_41_1 = var_1.emit

			MonopolyCar2024Mediator = var_2_10004

			var_41_1(var_41_0, var_2_10004.ON_START, arg_40_0.actId, function(arg_42_0)
				if arg_42_0 and arg_42_0 > 0 then
					var_40_0 = arg_42_0

					arg_41_0()
				end

				return
			end)

			return
		end,
		function(arg_43_0)
			local var_43_0 = arg_40_0

			var_1.PlayRollAnimation(var_43_0, var_40_0, arg_43_0)

			return
		end,
		function(arg_44_0)
			local var_44_0 = arg_40_0

			var_1.CheckSpEvent(var_44_0, {
				result = var_40_0,
				shipId = arg_40_0.selectedShipId
			}, arg_44_0)

			return
		end,
		function(arg_45_0)
			local var_45_0 = arg_40_0

			var_1.CheckEventAndMove(var_45_0, arg_45_0)

			return
		end,
		function(arg_46_0)
			local var_46_0 = arg_40_0

			var_1.CheckSpStory(var_46_0, arg_40_0.selectedShipId, arg_46_0)

			return
		end,
		function(arg_47_0)
			local var_47_0 = arg_40_0

			var_1.CheckSpEvent(var_47_0, {
				finished = true,
				shipId = arg_40_0.selectedShipId
			}, arg_47_0)

			return
		end,
		function(arg_48_0)
			local var_48_0 = arg_40_0

			var_1.CheckMainStorys(var_48_0, arg_48_0)

			return
		end
	}, function()
		local var_49_0 = arg_40_0

		var_0.UpdateAutoBtn(var_49_0)

		local var_49_1 = arg_40_0

		var_0.BlocksRaycasts(var_49_1, true)

		arg_40_0.rolling = false

		if arg_40_1 then
			arg_40_1()
		end

		return
	end)

	return
end

function var_0_0.CheckSpStory(arg_50_0, arg_50_1, arg_50_2)
	if not arg_50_0.mapCells[arg_50_0.pos] then
		arg_50_2()

		return
	end

	local var_50_0 = var_3.mapId

	pg = var_1_10005

	local var_50_1 = var_1_10005.activity_event_monopoly_map[var_50_0].ship_event

	_ = var_1_10007

	if not var_1_10007.detect(var_50_1, function(arg_51_0)
		return arg_51_0[1] == arg_50_1
	end) then
		arg_50_2()

		return
	end

	local var_50_2

	if not var_7[2] then
		var_50_2 = {}
	end

	if #var_50_2 <= 0 then
		arg_50_2()

		return
	end

	math = var_9

	local var_50_3 = var_50_2[var_9.random(1, #var_50_2)]

	arg_50_0:HideOrShowUI(false)

	local function var_50_4()
		local var_52_0 = arg_50_0

		var_0.HideOrShowUI(var_52_0, true)
		arg_50_2()

		return
	end

	if arg_50_0.autoFlag then
		pg = var_12

		local var_50_5 = var_12.NewStoryMgr.GetInstance()

		var_12.ForceAutoPlay(var_50_5, var_50_3, var_50_4, true, true)
	else
		pg = var_12

		local var_50_6 = var_12.NewStoryMgr.GetInstance()

		var_12.Play(var_50_6, var_50_3, var_50_4, true)
	end

	return
end

function var_0_0.PlayRollAnimation(arg_53_0, arg_53_1, arg_53_2)
	setText = var_1_10003
	findTF = var_1_10005

	var_1_10003(var_1_10005(arg_53_0.rollStep, "animroot/Image/Text"), "00")

	local var_53_0 = arg_53_0.btnStart
	local var_53_1 = var_3.GetComponent

	typeof = var_6
	Animation = var_8

	local var_53_2 = var_53_1(var_53_0, var_6(var_8))
	local var_53_3 = var_3.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10009

	local var_53_4 = var_53_3(var_53_2, var_7(var_1_10009))

	findTF = var_53_0

	local var_53_5 = var_53_0(arg_53_0.rollStep, "animroot")
	local var_53_6 = var_5.GetComponent

	typeof = var_8
	Animation = var_1_10010

	local var_53_7 = var_53_6(var_53_5, var_8(var_1_10010))
	local var_53_8 = var_5.GetComponent

	typeof = var_1_10009
	DftAniEvent = var_1_10011

	local var_53_9 = var_53_8(var_53_7, var_1_10009(var_1_10011))

	var_6.SetTriggerEvent(var_53_9, function()
		setText = var_2_10000
		findTF = var_2_10002

		var_2_10000(var_2_10002(arg_53_0.rollStep, "animroot/Image/Text"), "0" .. arg_53_1)

		return
	end)

	seriesAsync = var_7

	var_7({
		function(arg_55_0)
			local var_55_0 = var_53_4

			var_1.SetEndEvent(var_55_0, function()
				setActive = var_3_10000

				var_3_10000(arg_53_0.btnStart, false)
				arg_55_0()

				return
			end)

			local var_55_1 = var_0

			var_1.Play(var_55_1, "anim_monopolycar_mainui_btn_hide")

			return
		end,
		function(arg_57_0)
			local var_57_0 = arg_53_0

			var_1.SetRollStepAct(var_57_0, true)
			arg_57_0()

			return
		end,
		function(arg_58_0)
			local var_58_0 = var_0

			var_1.SetEndEvent(var_58_0, function()
				arg_58_0()

				return
			end)

			local var_58_1 = var_0

			var_1.Play(var_58_1, "anim_monopolycar_mainui_step_0" .. arg_53_1)

			return
		end,
		function(arg_60_0)
			local var_60_0 = var_0

			var_1.SetEndEvent(var_60_0, function()
				local var_61_0 = arg_53_0

				var_0.SetRollStepAct(var_61_0, false)
				arg_60_0()

				return
			end)

			local var_60_1 = var_0

			var_1.Play(var_60_1, "anim_monopolycar_mainui_step_hide")

			return
		end
	}, function()
		setActive = var_2_10000

		var_2_10000(arg_53_0.btnStart, true)

		local var_62_0 = var_0

		var_0.Play(var_62_0, "anim_monopolycar_mainui_btn_show")
		arg_53_2()

		return
	end)

	return
end

function var_0_0.SetRollStepAct(arg_63_0, arg_63_1)
	setActive = var_1_10002

	var_1_10002(arg_63_0.rollStep, arg_63_1)

	return
end

function var_0_0.CheckEventAndMove(arg_64_0, arg_64_1)
	local function var_64_0()
		local var_65_0 = arg_64_0

		var_0.CheckEventAndMove(var_65_0, arg_64_1)

		return
	end

	if arg_64_0.selectedShipId == 0 then
		arg_64_0:CheckPickCharacter(var_64_0)
	elseif arg_64_0.effectId and arg_64_0.effectId > 0 then
		arg_64_0:CheckEvent(var_64_0)
	elseif arg_64_0.step and arg_64_0.step > 0 then
		arg_64_0:CheckMove(var_64_0)
	else
		arg_64_1()
	end

	return
end

function var_0_0.CheckEvent(arg_66_0, arg_66_1)
	if not arg_66_0.effectId or arg_66_0.effectId <= 0 then
		if arg_66_1 then
			arg_66_1()
		end

		return
	end

	local var_66_0 = arg_66_0.mapCells[arg_66_0.pos]
	local var_66_1 = {}

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_67_0)
			pg = var_2_10001

			if var_2_10001.activity_event_monopoly_event[arg_66_0.effectId].story then
				tonumber = var_2

				if var_2(var_1) == 0 then
					arg_67_0()

					return
				end

				local var_67_0 = arg_66_0

				var_2.HideOrShowUI(var_67_0, false)

				if arg_66_0.autoFlag then
					pg = var_2

					local var_67_1 = var_2.NewStoryMgr.GetInstance()

					var_2.ForceAutoPlay(var_67_1, var_1, arg_67_0, true, true)
				else
					pg = var_2

					local var_67_2 = var_2.NewStoryMgr.GetInstance()

					var_2.Play(var_67_2, var_1, arg_67_0, true, true)
				end

				return
			end
		end,
		function(arg_68_0)
			local var_68_0 = arg_66_0

			var_1.HideOrShowUI(var_68_0, true)

			local var_68_1 = arg_66_0

			var_1.TriggerEvent(var_68_1, function(arg_69_0)
				var_66_1 = arg_69_0

				arg_68_0()

				return
			end)

			return
		end,
		function(arg_70_0)
			local var_70_0 = arg_66_0

			var_1.ReadyMoveCar(var_70_0, var_66_1, arg_70_0)

			return
		end,
		function(arg_71_0)
			local var_71_0 = arg_66_0

			var_1.CheckCountStory(var_71_0, arg_71_0)

			return
		end
	}, arg_66_1)

	return
end

function var_0_0.HideOrShowUI(arg_72_0, arg_72_1)
	ipairs = var_1_10002

	for iter_72_0, iter_72_1 in var_1_10002(arg_72_0.hideList) do
		setActive = var_1_10007

		var_1_10007(iter_72_1, arg_72_1)
	end

	return
end

function var_0_0.TriggerEvent(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0
	local var_73_1 = arg_73_0.emit

	MonopolyCar2024Mediator = var_1_10005

	var_73_1(var_73_0, var_1_10005.ON_TRIGGER, arg_73_0.actId, function(arg_74_0, arg_74_1)
		if arg_74_0 and #arg_74_0 >= 0 then
			arg_73_1(arg_74_0)
		end

		return
	end)

	return
end

function var_0_0.CheckCountStory(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0.useCount
	local var_75_1 = arg_75_0.storys

	_ = var_1_10004

	if var_1_10004.detect(var_75_1, function(arg_76_0)
		return arg_76_0[1] == var_75_0
	end) then
		pg = var_1_10005

		local var_75_2 = var_1_10005.NewStoryMgr.GetInstance()

		var_5.Play(var_75_2, var_4[2], arg_75_1)
	else
		arg_75_1()
	end

	return
end

function var_0_0.CheckSpEvent(arg_77_0, arg_77_1, arg_77_2)
	if arg_77_1.result and arg_77_1.result > 0 then
		arg_77_0:CheckRollResultForSpEvent(arg_77_1.result, arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_1.repeatChat then
		arg_77_0:CheckRepeatCharForSpEvent(arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_1.finished then
		arg_77_0:CheckFinishedForSpEvent(arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_2 then
		arg_77_2()
	end

	return
end

function var_0_0.CheckFinishedForSpEvent(arg_78_0, arg_78_1)
	if arg_78_0.turnCnt <= arg_78_0.cacheTurnCnt then
		return
	end

	arg_78_0.cacheTurnCnt = arg_78_0.turnCnt
	_ = var_2

	if #var_2.select(arg_78_0.spEvents[arg_78_1], function(arg_79_0)
		return arg_79_0[1] == 4
	end) <= 0 then
		return
	end

	local var_78_0

	if not var_2[1][2] then
		var_78_0 = {}
	end

	local var_78_1 = arg_78_0:GetUnReadDialogue(var_78_0)
	local var_78_2 = arg_78_0.bubblePage

	var_6.Show(var_78_2, arg_78_0.actId, arg_78_1, var_78_1)

	return
end

function var_0_0.CheckRepeatCharForSpEvent(arg_80_0, arg_80_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_80_0.pickCharList, arg_80_1) then
		return
	end

	_ = var_2

	local var_80_0 = var_2.select
	local var_80_1

	if not arg_80_0.spEvents[arg_80_1] then
		var_80_1 = {}
	end

	if #var_80_0(var_80_1, function(arg_81_0)
		return arg_81_0[1] == 5
	end) <= 0 then
		return
	end

	local var_80_2

	if not var_2[1][2] then
		var_80_2 = {}
	end

	local var_80_3 = arg_80_0:GetUnReadDialogue(var_80_2)
	local var_80_4 = arg_80_0.bubblePage

	var_6.Show(var_80_4, arg_80_0.actId, arg_80_1, var_80_3)

	return
end

function var_0_0.GetUnReadDialogue(arg_82_0, arg_82_1)
	local var_82_0 = {}

	ipairs = var_1_10003

	for iter_82_0, iter_82_1 in var_1_10003(arg_82_1) do
		table = var_1_10008

		if not var_1_10008.contains(arg_82_0.dialogRecorder, iter_82_1) then
			table = var_1_10008

			var_1_10008.insert(var_82_0, iter_82_1)
		end
	end

	if #var_82_0 <= 0 then
		math = var_3

		return arg_82_1[var_3.random(1, #arg_82_1)]
	end

	math = var_3

	return var_82_0[var_3.random(1, #var_82_0)]
end

function var_0_0.CheckRollResultForSpEvent(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = {
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

	var_4(arg_83_0.spEvents[arg_83_2], arg_83_2)

	_ = var_4

	local var_83_1 = var_4.select
	local var_83_2

	if not arg_83_0.spEvents[arg_83_2] then
		var_83_2 = {}
	end

	if #var_83_1(var_83_2, function(arg_84_0)
		local var_84_0

		if not var_83_0[arg_84_0[1]] then
			var_84_0 = {
				99,
				99
			}
		end

		return arg_83_1 == var_84_0[1] or arg_83_1 == var_84_0[2]
	end) <= 0 then
		return
	end

	local var_83_3

	if not var_4[1][2] then
		var_83_3 = {}
	end

	local var_83_4 = arg_83_0:GetUnReadDialogue(var_83_3)
	local var_83_5 = arg_83_0.bubblePage

	var_8.Show(var_83_5, arg_83_0.actId, arg_83_2, var_83_4)

	return
end

function var_0_0.CheckMove(arg_85_0, arg_85_1)
	local var_85_0 = {}

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_86_0)
			local var_86_0 = arg_85_0
			local var_86_1 = var_1.emit

			MonopolyCar2024Mediator = var_2_10004

			var_86_1(var_86_0, var_2_10004.ON_MOVE, arg_85_0.actId, function(arg_87_0, arg_87_1, arg_87_2)
				if not arg_87_0 or not arg_87_1 or not arg_87_2 then
					warning = var_3_10003

					var_3_10003(arg_87_0, arg_87_1, arg_87_2)

					return
				end

				var_85_0 = arg_87_1

				arg_86_0()

				return
			end)

			return
		end,
		function(arg_88_0)
			local var_88_0 = arg_85_0

			var_1.ReadyMoveCar(var_88_0, var_85_0, arg_88_0)

			return
		end
	}, arg_85_1)

	return
end

function var_0_0.ReadyMoveCar(arg_89_0, arg_89_1, arg_89_2)
	if not arg_89_1 or #arg_89_1 <= 0 then
		if arg_89_2 then
			arg_89_2()
		end

		return
	end

	local var_89_0 = {}
	local var_89_1 = arg_89_0.car.localPosition
	local var_89_2 = {}
	local var_89_3 = {}

	for iter_89_0 = 1, #arg_89_1 do
		if arg_89_0:CheckPathTurn(arg_89_1[iter_89_0]) then
			table = var_1_10011

			var_1_10011.insert(var_89_2, arg_89_0.mapCells[arg_89_1[iter_89_0]].position)

			table = var_1_10011

			var_1_10011.insert(var_89_3, arg_89_1[iter_89_0])
		elseif iter_89_0 == #arg_89_1 then
			table = var_1_10011

			var_1_10011.insert(var_89_2, arg_89_0.mapCells[arg_89_1[iter_89_0]].position)

			table = var_1_10011

			var_1_10011.insert(var_89_3, arg_89_1[iter_89_0])
		end
	end

	arg_89_0.speedX = 0
	arg_89_0.speedY = 0
	arg_89_0.baseSpeed = 6
	arg_89_0.baseASpeed = 0.1

	for iter_89_1 = 1, #var_89_2 do
		table = var_1_10011

		var_1_10011.insert(var_89_0, function(arg_90_0)
			arg_89_0.moveComplete = arg_90_0
			arg_89_0.stopOnEnd = false
			arg_89_0.targetPosition = var_89_2[iter_89_1]
			arg_89_0.targetPosIndex = var_89_3[iter_89_1]
			arg_89_0.moveX = arg_89_0.targetPosition.x - arg_89_0.car.localPosition.x
			arg_89_0.moveY = arg_89_0.targetPosition.y - arg_89_0.car.localPosition.y

			local var_90_0 = arg_89_0
			local var_90_1 = arg_89_0.baseSpeed
			local var_90_2 = arg_89_0.moveX

			math = var_2_10004
			var_90_0.baseSpeedX = var_90_1 * (var_90_2 / var_2_10004.abs(arg_89_0.moveX))

			local var_90_3 = arg_89_0
			local var_90_4 = arg_89_0.baseASpeed
			local var_90_5 = arg_89_0.moveX

			math = var_4
			var_90_3.baseASpeedX = var_90_4 * (var_90_5 / var_4.abs(arg_89_0.moveX))

			local var_90_6 = arg_89_0

			math = var_2

			local var_90_7 = var_2.abs(arg_89_0.baseSpeedX)

			math = var_3
			var_90_6.baseSpeedY = var_90_7 / (var_3.abs(arg_89_0.moveX) / arg_89_0.moveY)

			local var_90_8 = arg_89_0

			math = var_2

			local var_90_9 = var_2.abs(arg_89_0.baseASpeedX)

			math = var_3
			var_90_8.baseASpeedY = var_90_9 / (var_3.abs(arg_89_0.moveX) / arg_89_0.moveY)

			if iter_89_1 == 1 then
				arg_89_0.speedX = 0
				arg_89_0.speedY = 0
			else
				arg_89_0.speedX = arg_89_0.baseSpeedX
				arg_89_0.speedY = arg_89_0.baseSpeedY
			end

			return
		end)
	end

	table = var_7

	var_7.insert(var_89_0, function(arg_91_0)
		arg_89_0.moveComplete = nil

		local var_91_0 = arg_89_0

		var_1.UpdateCarPos(var_91_0, arg_89_1[#arg_89_1], false)
		arg_91_0()

		return
	end)

	table = var_7

	var_7.insert(var_89_0, function(arg_92_0)
		LeanTween = var_2_10001

		local var_92_0 = var_2_10001.value

		go = var_2_10003

		local var_92_1 = var_92_0(var_2_10003(arg_89_0._tf), 1, 0, 0.1)
		local var_92_2 = var_1.setOnComplete

		System = var_4

		var_92_2(var_92_1, var_4.Action(arg_92_0))

		return
	end)

	seriesAsync = var_7

	var_7(var_89_0, arg_89_2)

	return
end

function var_0_0.MoveCar(arg_93_0)
	if not arg_93_0.targetPosition then
		return
	end

	math = var_1

	local var_93_0 = var_1.abs(arg_93_0.targetPosition.x - arg_93_0.car.localPosition.x)

	math = var_1_10002

	local var_93_1 = var_1_10002.abs(arg_93_0.targetPosition.y - arg_93_0.car.localPosition.y)

	if var_93_0 <= 6.5 and var_93_1 <= 6.5 then
		arg_93_0.targetPosition = nil

		if arg_93_0.moveComplete then
			arg_93_0:UpdateCarPos(arg_93_0.targetPosIndex, true)
			arg_93_0.moveComplete()
		end
	end

	math = var_3

	local var_93_2 = var_3.abs(arg_93_0.speedX + arg_93_0.baseASpeedX)

	math = var_4

	local var_93_3

	if not (var_4.abs(arg_93_0.baseSpeedX) < var_93_2) or not arg_93_0.baseSpeedX then
		var_93_3 = arg_93_0.speedX + arg_93_0.baseASpeedX
	end

	arg_93_0.speedX = var_93_3
	math = var_93_3

	local var_93_4 = var_93_3.abs(arg_93_0.speedY + arg_93_0.baseASpeedY)

	math = var_4

	local var_93_5

	if not (var_93_4 > var_4.abs(arg_93_0.baseSpeedY)) or not arg_93_0.baseSpeedY then
		var_93_5 = arg_93_0.speedY + arg_93_0.baseASpeedY
	end

	arg_93_0.speedY = var_93_5

	local var_93_6 = arg_93_0.car.localPosition
	local var_93_7 = arg_93_0.car

	Vector3 = var_5
	var_93_7.localPosition = var_5(var_93_6.x + arg_93_0.speedX, var_93_6.y + arg_93_0.speedY, 0)

	return
end

function var_0_0.CheckPathTurn(arg_94_0, arg_94_1)
	local var_94_0 = arg_94_1 + 1 > #arg_94_0.mapCells and 1 or arg_94_1 + 1
	local var_94_1

	if not (arg_94_1 - 1 < 1) or not #arg_94_0.mapCells then
		var_94_1 = arg_94_1 - 1
	end

	if arg_94_0.mapCells[var_94_0].col == arg_94_0.mapCells[var_94_1].col or arg_94_0.mapCells[var_94_0].row == arg_94_0.mapCells[var_94_1].row then
		return false
	end

	return true
end

function var_0_0.CheckPickCharacter(arg_95_0, arg_95_1)
	if arg_95_0.selectedShipId == 0 or #arg_95_0.pickCharList == 0 then
		local function var_95_0(arg_96_0)
			local var_96_0 = arg_95_0.pickableShipId[arg_96_0]
			local var_96_1 = arg_95_0

			var_2.CheckSpEvent(var_96_1, {
				repeatChat = true,
				shipId = var_96_0
			})

			local var_96_2 = arg_95_0
			local var_96_3 = var_2.emit

			MonopolyCar2024Mediator = var_5

			var_96_3(var_96_2, var_5.ON_PICK, arg_95_0.actId, var_96_0, function(arg_97_0)
				local var_97_0 = arg_95_0.pickPage

				var_1.Hide(var_97_0)

				seriesAsync = var_1

				var_1({
					function(arg_98_0)
						local var_98_0 = arg_95_0

						var_1.ReadyMoveCar(var_98_0, arg_97_0, arg_98_0)

						return
					end,
					function(arg_99_0)
						local var_99_0 = arg_95_0

						var_1.CheckEventAndMove(var_99_0, arg_99_0)

						return
					end
				}, arg_95_1)

				return
			end)

			return
		end

		_ = var_1_10004

		local var_95_1 = var_1_10004.map(arg_95_0.pickCharList, function(arg_100_0)
			table = var_2_10001

			return var_2_10001.indexof(arg_95_0.pickableShipId, arg_100_0)
		end)
		local var_95_2 = arg_95_0.pickPage

		var_5.ExecuteAction(var_95_2, "Show", arg_95_0.actId, var_95_1, arg_95_0.autoFlag, arg_95_0.turnCnt, var_95_0)
	else
		arg_95_1()
	end

	return
end

function var_0_0.InitMap(arg_101_0)
	arg_101_0.mapCells = {}

	for iter_101_0 = 1, #var_0_4 do
		local var_101_0 = iter_101_0 - 1
		local var_101_1 = {
			x = -var_101_0 * var_0_1,
			y = -var_101_0 * var_0_2
		}
		local var_101_2 = var_0_4[iter_101_0]

		for iter_101_1 = 1, #var_101_2 do
			local var_101_3 = iter_101_1 - 1
			local var_101_4 = var_101_2[iter_101_1]

			if 0 < var_101_4 then
				cloneTplTo = var_14

				local var_101_5 = arg_101_0.tplMapCell
				local var_101_6 = arg_101_0.mapContainer

				tostring = var_1_10018

				local var_101_7 = var_14(var_101_5, var_101_6, var_1_10018(var_101_4))

				Vector2 = var_1_10015
				var_101_7.localPosition = var_1_10015(var_0_1 * var_101_3 + var_101_1.x, -var_0_2 * var_101_3 + var_101_1.y)
				pg = var_101_5

				local var_101_8 = var_101_5.activity_event_monopoly_map[var_101_4].icon

				GetSpriteFromAtlas = var_17

				local var_101_9 = var_17("ui/MonopolyCar2024_atlas", var_101_8)
				local var_101_10 = var_101_7

				var_1_10018 = var_101_7.GetComponent
				typeof = var_1_10021
				Image = var_1_10023
				var_1_10018 = var_1_10018(var_101_10, var_1_10021(var_1_10023))
				var_1_10018.sprite = var_101_9

				local var_101_11 = var_101_7

				var_1_10018 = var_101_7.GetComponent
				typeof = var_1_10021
				Image = var_1_10023

				local var_101_12 = var_1_10018(var_101_11, var_1_10021(var_1_10023))

				var_1_10018.SetNativeSize(var_101_12)

				var_1_10018 = {
					col = var_101_3,
					row = var_101_0,
					mapId = var_101_4,
					tf = var_101_7,
					icon = var_101_8,
					position = var_1_10015
				}
				table = var_19

				var_19.insert(arg_101_0.mapCells, var_1_10018)
			end
		end
	end

	table = var_1

	var_1.sort(arg_101_0.mapCells, function(arg_102_0, arg_102_1)
		return arg_102_0.mapId < arg_102_1.mapId
	end)

	return
end

function var_0_0.InitCar(arg_103_0, arg_103_1)
	PoolMgr = var_1_10002

	local var_103_0 = var_1_10002.GetInstance()

	var_2.GetSpineChar(var_103_0, var_0_3, true, function(arg_104_0)
		arg_103_0.model = arg_104_0

		local var_104_0 = arg_103_0.model.transform

		Vector3 = var_2_10002
		var_104_0.localScale = var_2_10002.one

		local var_104_1 = arg_103_0.model.transform

		Vector3 = var_2
		var_104_1.localPosition = var_2.zero

		local var_104_2 = arg_103_0.model.transform

		var_1.SetParent(var_104_2, arg_103_0.car, false)

		local var_104_3 = arg_103_0
		local var_104_4 = arg_103_0.model
		local var_104_5 = var_2.GetComponent

		typeof = var_5
		SpineAnimUI = var_2_10007
		var_104_3.anim = var_104_5(var_104_4, var_5(var_2_10007))

		if arg_103_0.pos then
			local var_104_6 = arg_103_0

			var_1.UpdateCarPos(var_104_6, arg_103_0.pos, false)
		end

		arg_103_1()

		return
	end)

	return
end

function var_0_0.UpdateCarPos(arg_105_0, arg_105_1, arg_105_2)
	if arg_105_0.model then
		assert = var_3

		var_3(arg_105_0.mapCells[arg_105_1], arg_105_1)

		local var_105_0 = arg_105_0.mapCells[arg_105_1].position
		local var_105_1 = arg_105_1 + 1 > #arg_105_0.mapCells and 1 or arg_105_1 + 1
		local var_105_2 = arg_105_0.mapCells[var_105_1]
		local var_105_3, var_105_4 = arg_105_0:GetCarMoveType(arg_105_0.mapCells[arg_105_1].mapId, arg_105_0.mapCells[var_105_1].mapId, arg_105_2)

		arg_105_0.car.localScale = var_105_4

		local var_105_5 = arg_105_0.anim

		var_8.SetActionCallBack(var_105_5, nil)

		local var_105_6 = arg_105_0.anim

		var_8.SetAction(var_105_6, var_105_3, 0)

		arg_105_0.car.localPosition = var_105_0

		local var_105_7 = arg_105_0.car

		var_8.SetAsLastSibling(var_105_7)
	end

	return
end

function var_0_0.GetCarMoveType(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
	local var_106_0 = {}
	local var_106_1 = {}

	for iter_106_0 = 1, #var_0_4 do
		local var_106_2 = var_0_4[iter_106_0]

		for iter_106_1 = 1, #var_106_2 do
			if var_106_2[iter_106_1] == arg_106_1 then
				var_106_0 = {
					x = iter_106_1,
					y = iter_106_0
				}
			end

			if var_15 == arg_106_2 then
				var_106_1 = {
					x = iter_106_1,
					y = iter_106_0
				}
			end
		end
	end

	local var_106_3
	local var_106_4

	if var_106_1.y > var_106_0.y then
		var_106_3 = arg_106_3 and var_0_11 or var_0_9
		Vector3 = var_8
		var_106_4 = var_8(var_0_5, var_0_5, var_0_5)
	elseif var_106_1.y < var_106_0.y then
		var_106_3 = arg_106_3 and var_0_10 or var_0_8
		Vector3 = var_8
		var_106_4 = var_8(var_0_5, var_0_5, var_0_5)
	elseif var_106_1.x > var_106_0.x then
		var_106_3 = arg_106_3 and var_0_11 or var_0_9
		Vector3 = var_8
		var_106_4 = var_8(-var_0_5, var_0_5, var_0_5)
	elseif var_106_1.x < var_106_0.x then
		var_106_3 = arg_106_3 and var_0_10 or var_0_8
		Vector3 = var_8
		var_106_4 = var_8(-var_0_5, var_0_5, var_0_5)
	end

	return var_106_3, var_106_4
end

function var_0_0.UpdateUI(arg_107_0)
	setText = var_1_10001

	var_1_10001(arg_107_0.labelLeftCount, arg_107_0.leftCount)

	setText = var_1_10001

	var_1_10001(arg_107_0.registerTxt, arg_107_0.turnCnt - 1)

	return
end

function var_0_0.UpdateActivity(arg_108_0, arg_108_1)
	arg_108_0:UpdateActData(arg_108_1)
	arg_108_0:UpdateUI()

	return
end

function var_0_0.Dispose(arg_109_0)
	pairs = var_1_10001

	local var_109_0

	if not arg_109_0.cheerLeaders then
		var_109_0 = {}
	end

	for iter_109_0, iter_109_1 in var_1_10001(var_109_0) do
		PoolMgr = var_1_10006

		local var_109_1 = var_1_10006.GetInstance()

		var_1_10006.ReturnSpineChar(var_109_1, iter_109_0, iter_109_1)
	end

	if arg_109_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_109_0.handle)

		arg_109_0.handle = nil
	end

	if arg_109_0.awardWindow then
		local var_109_2 = arg_109_0.awardWindow

		var_1.Destroy(var_109_2)

		arg_109_0.awardWindow = nil
	end

	if arg_109_0.pickPage then
		local var_109_3 = arg_109_0.pickPage

		if var_1.isShowing(var_109_3) then
			local var_109_4 = arg_109_0.pickPage

			var_1.Hide(var_109_4)
		end

		local var_109_5 = arg_109_0.pickPage

		var_1.Destroy(var_109_5)

		arg_109_0.pickPage = nil
	end

	if arg_109_0.resultPage then
		local var_109_6 = arg_109_0.resultPage

		var_1.Destroy(var_109_6)

		arg_109_0.resultPage = nil
	end

	if arg_109_0.awardCollector then
		local var_109_7 = arg_109_0.awardCollector

		var_1.Dispose(var_109_7)

		arg_109_0.awardCollector = nil
	end

	local var_109_8 = arg_109_0.bubblePage

	var_1.Dispose(var_109_8)

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_109_0)

	PoolMgr = var_1

	local var_109_9 = var_1.GetInstance()

	var_1.ReturnSpineChar(var_109_9, var_0_3, arg_109_0.model)

	return
end

return var_0_0
