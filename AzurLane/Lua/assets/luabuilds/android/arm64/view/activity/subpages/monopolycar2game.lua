class = var_0_10000

local var_0_0 = var_0_10000("MonopolyCar2Game")
local var_0_1 = 100
local var_0_2 = 50
local var_0_3 = "xinnongpaoche"
local var_0_4 = {
	"yuekegongjue_2",
	"dafeng_5",
	"baerdimo_6"
}
local var_0_5 = {
	"gaoxiong_5",
	"aidang_5",
	"xinnong_3",
	"qiye_7"
}
local var_0_6 = {
	"ruihe_3",
	"xianghe_3",
	"ougen_5",
	"weiershiqinwang_3"
}
local var_0_7 = {
	xianghe_3 = "dance",
	baerdimo_6 = "stand2",
	xinnong_3 = "stand2",
	dafeng_5 = "stand2",
	weiershiqinwang_3 = "stand2",
	ruihe_3 = "stand2",
	qiye_7 = "dance",
	ougen_5 = "stand2",
	aidang_5 = "dance",
	yuekegongjue_2 = "stand2",
	gaoxiong_5 = "dance"
}
local var_0_8 = 0.6
local var_0_9 = "ui/activityuipage/monopolycar2_atlas"
local var_0_10 = "B-stand"
local var_0_11 = "F-stand"
local var_0_12 = "B-walk"
local var_0_13 = "F-walk"
local var_0_14 = "typeMoveUp"
local var_0_15 = "typeMoveDown"
local var_0_16 = "typeMoveLeft"
local var_0_17 = "typeMoveRight"
local var_0_18 = {
	{
		5006,
		5007,
		5008,
		5009,
		5010
	},
	{
		5005,
		0,
		0,
		0,
		5011
	},
	{
		5004,
		0,
		0,
		0,
		5012
	},
	{
		5003,
		0,
		0,
		0,
		5013
	},
	{
		5002,
		0,
		0,
		0,
		5014
	},
	{
		2001,
		5018,
		5017,
		5016,
		5015
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0._event = arg_1_3

	arg_1_0:initData()
	arg_1_0:initUI()
	arg_1_0:initEvent()

	return
end

function var_0_0.initData(arg_2_0)
	arg_2_0.leftCount = 0
	arg_2_0.inAnimatedFlag = false
	arg_2_0.mapCells = {}
	arg_2_0.showCharNames = {}

	if var_0_4 and #var_0_4 > 0 then
		table = var_1

		local var_2_0 = var_1.insert
		local var_2_1 = arg_2_0.showCharNames

		Clone = var_1_10004

		local var_2_2 = var_0_4

		math = var_1_10007

		var_2_0(var_2_1, var_1_10004(var_2_2[var_1_10007.random(1, #var_0_4)]))
	end

	if var_0_5 and #var_0_5 > 0 then
		table = var_1

		local var_2_3 = var_1.insert
		local var_2_4 = arg_2_0.showCharNames

		Clone = var_1_10004

		local var_2_5 = var_0_5

		math = var_1_10007

		var_2_3(var_2_4, var_1_10004(var_2_5[var_1_10007.random(1, #var_0_5)]))
	end

	if var_0_6 and #var_0_6 > 0 then
		table = var_1

		local var_2_6 = var_1.insert
		local var_2_7 = arg_2_0.showCharNames

		Clone = var_1_10004

		local var_2_8 = var_0_6

		math = var_1_10007

		var_2_6(var_2_7, var_1_10004(var_2_8[var_1_10007.random(1, #var_0_6)]))
	end

	return
end

function var_0_0.initUI(arg_3_0)
	findTF = var_1_10001
	arg_3_0.tplMapCell = var_1_10001(arg_3_0._tf, "tplMapCell")
	findTF = var_1
	arg_3_0.mapContainer = var_1(arg_3_0._tf, "mapContainer")
	findTF = var_1
	arg_3_0.char = var_1(arg_3_0._tf, "mapContainer/char")
	arg_3_0.showChars = {}

	for iter_3_0 = 1, 3 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_3_0 = arg_3_0.showChars

		findTF = var_1_10008

		var_1_10005(var_3_0, var_1_10008(arg_3_0._tf, "showChar" .. iter_3_0))
	end

	setActive = var_1

	var_1(arg_3_0.char, false)

	findTF = var_1
	arg_3_0.btnStart = var_1(arg_3_0._tf, "btnStart")
	findTF = var_1
	arg_3_0.btnHelp = var_1(arg_3_0._tf, "btnHelp")
	findTF = var_1
	arg_3_0.btnRp = var_1(arg_3_0._tf, "btnRp")
	findTF = var_1

	local var_3_1 = var_1(arg_3_0.btnRp, "rpAni")
	local var_3_2 = var_1.GetComponent

	typeof = var_4
	Animator = var_1_10006
	arg_3_0.commonAnim = var_3_2(var_3_1, var_4(var_1_10006))
	findTF = var_1
	arg_3_0.labelLeftCountTip = var_1(arg_3_0.btnStart, "labelLeftCountTip")
	setActive = var_1

	var_1(arg_3_0.labelLeftCountTip, false)

	findTF = var_1
	arg_3_0.labelLeftCount = var_1(arg_3_0.btnStart, "labelLeftCount")
	findTF = var_1
	arg_3_0.labelDropShip = var_1(arg_3_0._tf, "labelDropShip")
	findTF = var_1
	arg_3_0.labelLeftRpCount = var_1(arg_3_0._tf, "labelLeftRpCount")
	findTF = var_1
	arg_3_0.rollStep = var_1(arg_3_0._tf, "step")
	setActive = var_1

	var_1(arg_3_0.rollStep, false)
	arg_3_0:initMap()
	arg_3_0:initChar()

	return
end

function var_0_0.initEvent(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0._binder
	local var_4_1 = arg_4_0.btnStart

	local function var_4_2()
		if arg_4_0.inAnimatedFlag then
			return
		end

		if arg_4_0.leftCount and arg_4_0.leftCount <= 0 then
			pg = var_0

			local var_5_0 = var_0.TipsMgr.GetInstance()
			local var_5_1 = var_0.ShowTips

			i18n = var_2_10003

			var_5_1(var_5_0, var_2_10003("common_count_noenough"))

			return
		end

		local var_5_2 = arg_4_0

		var_0.changeAnimeState(var_5_2, true)

		setActive = var_0

		var_0(arg_4_0.btnStart, true)

		local var_5_3 = arg_4_0._event
		local var_5_4 = var_0.emit

		MonopolyCar2Page = var_3

		var_5_4(var_5_3, var_3.ON_START, arg_4_0.activity.id, function(arg_6_0)
			if arg_6_0 and arg_6_0 > 0 then
				local var_6_0 = arg_4_0

				var_1.showRollAnimated(var_6_0, arg_6_0)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0._binder
	local var_4_4 = arg_4_0.btnHelp

	local function var_4_5()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.help_monopoly_car_2.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	for iter_4_0 = 1, #arg_4_0.showChars do
		local var_4_6 = arg_4_0.showChars[iter_4_0]

		onButton = var_1_10006

		local var_4_7 = arg_4_0._binder
		local var_4_8 = var_4_6

		local function var_4_9()
			local var_8_0 = arg_4_0._event
			local var_8_1 = var_0.emit

			ActivityMediator = var_2_10003

			local var_8_2 = var_2_10003.EVENT_GO_SCENE

			SCENE = var_2_10004

			var_8_1(var_8_0, var_8_2, var_2_10004.SKINSHOP)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_4_7, var_4_8, var_4_9, var_1_10011)
	end

	onButton = var_1

	local var_4_10 = arg_4_0._binder
	local var_4_11 = arg_4_0.btnRp

	local function var_4_12()
		if arg_4_0.leftAwardCnt > 0 then
			local var_9_0 = arg_4_0._event
			local var_9_1 = var_0.emit

			MonopolyCar2Page = var_2_10003

			var_9_1(var_9_0, var_2_10003.ON_AWARD)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_10, var_4_11, var_4_12, var_1_10006)

	return
end

function var_0_0.showRollAnimated(arg_10_0, arg_10_1)
	findTF = var_1_10002

	local var_10_0 = var_1_10002(arg_10_0.rollStep, "stepArrow")

	Vector3 = var_1_10003
	var_10_0.localEulerAngles = var_1_10003(0, 0, 0)
	findTF = var_3

	local var_10_1 = var_3(arg_10_0.rollStep, "progress/bg")
	local var_10_2 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008

	local var_10_3 = var_10_2(var_10_1, var_6(var_1_10008))

	var_10_3.fillAmount = 0.1
	findTF = var_10_3

	local var_10_4 = var_10_3(arg_10_0.rollStep, "select/bg")
	local var_10_5 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008

	local var_10_6 = var_10_5(var_10_4, var_6(var_1_10008))

	var_10_6.fillAmount = 0.1
	setText = var_10_6
	findTF = var_10_4

	var_10_6(var_10_4(arg_10_0.rollStep, "labelRoll"), "0")

	seriesAsync = var_10_6

	var_10_6({
		function(arg_11_0)
			LeanTween = var_2_10001

			local var_11_0 = var_2_10001.value

			go = var_2_10003

			local var_11_1 = var_11_0(var_2_10003(arg_10_0._tf), 1, 0, 0.2)
			local var_11_2 = var_1.setOnUpdate

			System = var_4

			local var_11_3 = var_11_2(var_11_1, var_4.Action_float(function(arg_12_0)
				local var_12_0 = arg_10_0.btnStart
				local var_12_1 = var_1.GetComponent

				typeof = var_3_10004
				CanvasGroup = var_3_10006
				var_12_1(var_12_0, var_3_10004(var_3_10006)).alpha = arg_12_0

				return
			end))
			local var_11_4 = var_1.setOnComplete

			System = var_4

			var_11_4(var_11_3, var_4.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_10_0.btnStart, false)

				local var_13_0 = arg_10_0.btnStart
				local var_13_1 = var_0.GetComponent

				typeof = var_3
				CanvasGroup = var_3_10005
				var_13_1(var_13_0, var_3(var_3_10005)).alpha = 1

				arg_11_0()

				return
			end))

			return
		end,
		function(arg_14_0)
			LeanTween = var_2_10001

			local var_14_0 = var_2_10001.value

			go = var_2_10003

			local var_14_1 = var_14_0(var_2_10003(arg_10_0._tf), 0, 1, 0.2)
			local var_14_2 = var_1.setOnUpdate

			System = var_4

			local var_14_3 = var_14_2(var_14_1, var_4.Action_float(function(arg_15_0)
				local var_15_0 = arg_10_0.rollStep
				local var_15_1 = var_1.GetComponent

				typeof = var_3_10004
				CanvasGroup = var_3_10006

				local var_15_2 = var_15_1(var_15_0, var_3_10004(var_3_10006))

				var_15_2.alpha = arg_15_0
				setActive = var_15_2

				var_15_2(arg_10_0.rollStep, true)

				return
			end))
			local var_14_4 = var_1.setOnComplete

			System = var_4

			var_14_4(var_14_3, var_4.Action(function()
				arg_14_0()

				return
			end))

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_10_1 / 6 * 0.62 / arg_10_1
			local var_17_1 = -arg_10_1 * 31

			LeanTween = var_2_10004

			local var_17_2 = var_2_10004.value

			go = var_2_10006

			local var_17_3 = var_17_2(var_2_10006(arg_10_0._tf), 0, 1, 0.7 + arg_10_1 / 5)
			local var_17_4 = var_4.setEase

			LeanTweenType = var_7

			local var_17_5 = var_17_4(var_17_3, var_7.easeOutCirc)
			local var_17_6 = var_4.setOnUpdate

			System = var_7

			local var_17_7 = var_17_6(var_17_5, var_7.Action_float(function(arg_18_0)
				findTF = var_3_10001

				local var_18_0 = var_3_10001(arg_10_0.rollStep, "progress/bg")
				local var_18_1 = var_1.GetComponent

				typeof = var_4
				Image = var_3_10006

				local var_18_2 = var_18_1(var_18_0, var_4(var_3_10006))

				var_18_2.fillAmount = var_0 * arg_18_0 + 0.13
				findTF = var_18_2

				local var_18_3 = var_18_2(arg_10_0.rollStep, "select/bg")
				local var_18_4 = var_1.GetComponent

				typeof = var_4
				Image = var_3_10006

				local var_18_5 = var_18_4(var_18_3, var_4(var_3_10006))
				local var_18_6 = var_17_0

				math = var_18_3
				var_18_5.fillAmount = var_18_6 * var_18_3.floor(arg_18_0 / (1 / arg_10_1)) + 0.17
				setText = var_18_5
				findTF = var_3

				local var_18_7 = var_3(arg_10_0.rollStep, "labelRoll")

				math = var_4

				var_18_5(var_18_7, var_4.floor(arg_18_0 / (1 / arg_10_1)))

				local var_18_8 = var_17_1 * arg_18_0 - 13
				local var_18_9 = var_10_0

				Vector3 = var_18_7
				var_18_9.localEulerAngles = var_18_7(0, 0, var_18_8)

				return
			end))
			local var_17_8 = var_4.setOnComplete

			System = var_7

			var_17_8(var_17_7, var_7.Action(function()
				arg_17_0()

				return
			end))

			return
		end,
		function(arg_20_0)
			LeanTween = var_2_10001

			local var_20_0 = var_2_10001.value

			go = var_2_10003

			local var_20_1 = var_20_0(var_2_10003(arg_10_0._tf), 1, 0, 0.3)
			local var_20_2 = var_1.setOnComplete

			System = var_4

			var_20_2(var_20_1, var_4.Action(function()
				arg_20_0()

				return
			end))

			return
		end,
		function(arg_22_0)
			LeanTween = var_2_10001

			local var_22_0 = var_2_10001.value

			go = var_2_10003

			local var_22_1 = var_22_0(var_2_10003(arg_10_0._tf), 1, 0, 0.3)
			local var_22_2 = var_1.setOnUpdate

			System = var_4

			local var_22_3 = var_22_2(var_22_1, var_4.Action_float(function(arg_23_0)
				local var_23_0 = arg_10_0.rollStep
				local var_23_1 = var_1.GetComponent

				typeof = var_3_10004
				CanvasGroup = var_3_10006
				var_23_1(var_23_0, var_3_10004(var_3_10006)).alpha = arg_23_0

				return
			end))
			local var_22_4 = var_1.setOnComplete

			System = var_4

			var_22_4(var_22_3, var_4.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_10_0.rollStep, false)

				local var_24_0 = arg_10_0.rollStep
				local var_24_1 = var_0.GetComponent

				typeof = var_3
				CanvasGroup = var_3_10005
				var_24_1(var_24_0, var_3(var_3_10005)).alpha = 1

				arg_22_0()

				return
			end))

			return
		end
	}, function()
		arg_10_0.useCount = arg_10_0.useCount + 1
		arg_10_0.step = arg_10_1

		if arg_10_0.step > 0 then
			GetSpriteFromAtlas = var_0

			local var_25_0 = var_0(var_0_9, arg_10_0.step)
		end

		local var_25_1 = arg_10_0

		var_0.updataUI(var_25_1)

		local var_25_2 = arg_10_0

		var_0.checkCharActive(var_25_2)

		return
	end)

	return
end

function var_0_0.checkCountStory(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.useCount
	local var_26_1 = arg_26_0.activity
	local var_26_2

	if not var_3.getDataConfig(var_26_1, "story") then
		var_26_2 = {}
	end

	_ = var_1_10005

	if var_1_10005.detect(var_26_2, function(arg_27_0)
		return arg_27_0[1] == var_26_0
	end) then
		pg = var_26_1

		local var_26_3 = var_26_1.NewStoryMgr.GetInstance()

		var_6.Play(var_26_3, var_5[2], arg_26_1)
	else
		arg_26_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_28_0, arg_28_1)
	if arg_28_1 then
		local var_28_0 = arg_28_0.btnStart

		var_1_10002 = var_1_10002.GetComponent
		typeof = var_1_10005
		Image = var_1_10007
		var_1_10002 = var_1_10002(var_28_0, var_1_10005(var_1_10007))
		var_1_10002.raycastTarget = false
		arg_28_0.inAnimatedFlag = true

		local var_28_1 = arg_28_0._event

		var_1_10002 = var_1_10002.emit
		ActivityMainScene = var_1_10005

		var_1_10002(var_28_1, var_1_10005.LOCK_ACT_MAIN, true)
	else
		arg_28_0.inAnimatedFlag = false

		local var_28_2 = arg_28_0.btnStart

		var_1_10002 = var_1_10002.GetComponent
		typeof = var_1_10005
		Image = var_1_10007
		var_1_10002 = var_1_10002(var_28_2, var_1_10005(var_1_10007))
		var_1_10002.raycastTarget = true

		local var_28_3 = arg_28_0._event

		var_1_10002 = var_1_10002.emit
		ActivityMainScene = var_5

		var_1_10002(var_28_3, var_5.LOCK_ACT_MAIN, false)
	end

	setActive = var_1_10002

	var_1_10002(arg_28_0.btnStart, not arg_28_1)

	return
end

function var_0_0.initMap(arg_29_0)
	local var_29_0 = var_0_18

	arg_29_0.mapCells = {}

	for iter_29_0 = 1, #var_29_0 do
		local var_29_1 = iter_29_0 - 1
		local var_29_2 = {
			x = -var_29_1 * var_0_1,
			y = -var_29_1 * var_0_2
		}
		local var_29_3 = var_29_0[iter_29_0]

		for iter_29_1 = 1, #var_29_3 do
			local var_29_4 = iter_29_1 - 1
			local var_29_5 = var_29_3[iter_29_1]

			if 0 < var_29_5 then
				cloneTplTo = var_15

				local var_29_6 = arg_29_0.tplMapCell
				local var_29_7 = arg_29_0.mapContainer

				tostring = var_1_10019

				local var_29_8 = var_15(var_29_6, var_29_7, var_1_10019(var_29_5))

				Vector2 = var_1_10016
				var_29_8.localPosition = var_1_10016(var_0_1 * var_29_4 + var_29_2.x, -var_0_2 * var_29_4 + var_29_2.y)
				pg = var_29_6

				local var_29_9 = var_29_6.activity_event_monopoly_map[var_29_5].icon

				GetSpriteFromAtlas = var_18

				local var_29_10 = var_18(var_0_9, var_29_9)

				findTF = var_1_10019

				local var_29_11 = var_1_10019(var_29_8, "image")

				var_1_10019 = var_1_10019.GetComponent
				typeof = var_22
				Image = var_1_10024
				var_1_10019 = var_1_10019(var_29_11, var_22(var_1_10024))
				var_1_10019.sprite = var_29_10
				findTF = var_1_10019

				local var_29_12 = var_1_10019(var_29_8, "image")

				var_1_10019 = var_1_10019.GetComponent
				typeof = var_22
				Image = var_1_10024

				local var_29_13 = var_1_10019(var_29_12, var_22(var_1_10024))

				var_1_10019.SetNativeSize(var_29_13)

				var_1_10019 = {
					col = var_29_4,
					row = var_29_1,
					mapId = var_29_5,
					tf = var_29_8,
					icon = var_29_9,
					position = var_1_10016
				}
				table = var_20

				var_20.insert(arg_29_0.mapCells, var_1_10019)
			end
		end
	end

	table = var_2

	var_2.sort(arg_29_0.mapCells, function(arg_30_0, arg_30_1)
		return arg_30_0.mapId < arg_30_1.mapId
	end)

	return
end

function var_0_0.initChar(arg_31_0)
	PoolMgr = var_1_10001

	local var_31_0 = var_1_10001.GetInstance()

	var_1.GetSpineChar(var_31_0, var_0_3, true, function(arg_32_0)
		arg_31_0.model = arg_32_0

		local var_32_0 = arg_31_0.model.transform

		Vector3 = var_2_10002
		var_32_0.localScale = var_2_10002.one

		local var_32_1 = arg_31_0.model.transform

		Vector3 = var_2
		var_32_1.localPosition = var_2.zero

		local var_32_2 = arg_31_0.model.transform

		var_1.SetParent(var_32_2, arg_31_0.char, false)

		local var_32_3 = arg_31_0
		local var_32_4 = arg_31_0.model
		local var_32_5 = var_2.GetComponent

		typeof = var_5
		SpineAnimUI = var_2_10007
		var_32_3.anim = var_32_5(var_32_4, var_5(var_2_10007))

		local var_32_6 = arg_31_0

		var_1.checkCharActive(var_32_6)

		if arg_31_0.pos then
			local var_32_7 = arg_31_0

			var_1.updataCharDirect(var_32_7, arg_31_0.pos, false)
		end

		return
	end)

	arg_31_0.showCharMods = {}

	for iter_31_0 = 1, #arg_31_0.showCharNames do
		local var_31_1 = arg_31_0.showCharNames[iter_31_0]

		PoolMgr = var_6

		local var_31_2 = var_6.GetInstance()

		var_6.GetSpineChar(var_31_2, var_31_1, true, function(arg_33_0)
			local var_33_0 = arg_33_0.transform

			Vector3 = var_2_10002
			var_33_0.localScale = var_2_10002.one

			local var_33_1 = arg_33_0.transform

			Vector3 = var_2
			var_33_1.localPosition = var_2.zero

			local var_33_2 = arg_33_0.transform

			var_1.SetParent(var_33_2, arg_31_0.showChars[iter_31_0], false)

			local var_33_3 = arg_33_0
			local var_33_4 = arg_33_0.GetComponent

			typeof = var_4
			SpineAnimUI = var_2_10006

			local var_33_5 = var_33_4(var_33_3, var_4(var_2_10006))

			if var_0_7[var_31_1] then
				var_33_5:SetAction(var_0_7[var_31_1], 0)
			else
				var_33_5:SetAction("stand", 0)
			end

			table = var_2

			var_2.insert(arg_31_0.showCharMods, arg_33_0)

			return
		end)
	end

	return
end

function var_0_0.updataCharDirect(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.model then
		local var_34_0 = arg_34_0.mapCells[arg_34_1].position
		local var_34_1 = arg_34_1 + 1 > #arg_34_0.mapCells and 1 or arg_34_1 + 1
		local var_34_2 = arg_34_0.mapCells[var_34_1]
		local var_34_3, var_34_4 = arg_34_0:getMoveType(arg_34_0.mapCells[arg_34_1].mapId, arg_34_0.mapCells[var_34_1].mapId, arg_34_2)
		local var_34_5 = arg_34_0.char

		Vector3 = var_9
		var_34_5.localScale = var_9(var_34_4, arg_34_0.char.localScale.y, arg_34_0.char.localScale.z)

		local var_34_6 = arg_34_0.anim

		var_8.SetActionCallBack(var_34_6, nil)

		local var_34_7 = arg_34_0.anim

		var_8.SetAction(var_34_7, var_34_3, 0)
	end

	return
end

function var_0_0.getMoveType(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = var_0_18
	local var_35_1 = {}
	local var_35_2 = {}

	for iter_35_0 = 1, #var_35_0 do
		local var_35_3 = var_35_0[iter_35_0]

		for iter_35_1 = 1, #var_35_3 do
			if var_35_3[iter_35_1] == arg_35_1 then
				var_35_1 = {
					x = iter_35_1,
					y = iter_35_0
				}
			end

			if var_16 == arg_35_2 then
				var_35_2 = {
					x = iter_35_1,
					y = iter_35_0
				}
			end
		end
	end

	local var_35_4
	local var_35_5

	if var_35_2.y > var_35_1.y then
		var_35_4 = arg_35_3 and var_0_13 or var_0_11
		var_35_5 = var_0_8
	elseif var_35_2.y < var_35_1.y then
		var_35_4 = arg_35_3 and var_0_12 or var_0_10
		var_35_5 = var_0_8
	elseif var_35_2.x > var_35_1.x then
		var_35_4 = arg_35_3 and var_0_13 or var_0_11
		var_35_5 = -var_0_8
	elseif var_35_2.x < var_35_1.x then
		var_35_4 = arg_35_3 and var_0_12 or var_0_10
		var_35_5 = -var_0_8
	end

	return var_35_4, var_35_5
end

function var_0_0.checkCharActive(arg_36_0)
	if arg_36_0.anim then
		if arg_36_0.effectId and arg_36_0.effectId > 0 then
			arg_36_0:changeAnimeState(true)
			arg_36_0:checkEffect(function()
				local var_37_0 = arg_36_0

				var_0.changeAnimeState(var_37_0, false)

				local var_37_1 = arg_36_0

				var_0.checkCharActive(var_37_1)

				return
			end)
		elseif arg_36_0.step and arg_36_0.step > 0 then
			arg_36_0:changeAnimeState(true)
			arg_36_0:checkStep(function()
				local var_38_0 = arg_36_0

				var_0.changeAnimeState(var_38_0, false)

				local var_38_1 = arg_36_0

				var_0.checkCharActive(var_38_1)

				return
			end)
		end
	end

	return
end

function var_0_0.firstUpdata(arg_39_0, arg_39_1)
	arg_39_0:activityDataUpdata(arg_39_1)
	arg_39_0:updataUI()
	arg_39_0:updataChar()
	arg_39_0:checkCharActive()

	return
end

function var_0_0.updataActivity(arg_40_0, arg_40_1)
	arg_40_0:activityDataUpdata(arg_40_1)
	arg_40_0:updataUI()

	return
end

function var_0_0.activityDataUpdata(arg_41_0, arg_41_1)
	arg_41_0.activity = arg_41_1
	pg = var_1_10002

	local var_41_0 = var_1_10002.TimeMgr.GetInstance()
	local var_41_1 = var_2.GetServerTime(var_41_0)
	local var_41_2 = arg_41_0.activity.data1

	math = var_41_0

	local var_41_3 = var_41_0.ceil((var_41_1 - var_41_2) / 0)
	local var_41_4 = arg_41_0.activity

	arg_41_0.totalCnt = var_41_3 * var_5.getDataConfig(var_41_4, "daily_time") + arg_41_0.activity.data1_list[1]
	arg_41_0.useCount = arg_41_0.activity.data1_list[2]
	arg_41_0.leftCount = arg_41_0.totalCnt - arg_41_0.useCount
	arg_41_0.turnCnt = arg_41_0.activity.data1_list[3] - 1
	arg_41_0.leftDropShipCnt = 8 - arg_41_0.turnCnt

	local var_41_5 = arg_41_0.activity.data2_list[2]
	local var_41_6 = arg_41_1

	arg_41_0.advanceTotalCnt = #arg_41_1.getDataConfig(var_41_6, "reward")
	arg_41_0.isAdvanceRp = arg_41_0.advanceTotalCnt - var_41_5 > 0
	arg_41_0.leftAwardCnt = arg_41_0.activity.data2_list[1] - var_41_5
	math = var_10

	local var_41_7 = var_10.max
	local var_41_8 = 0

	math = var_1_10013
	arg_41_0.advanceRpCount = var_41_7(var_41_8, var_1_10013.min(var_9, arg_41_0.advanceTotalCnt) - var_41_5)
	math = var_10

	local var_41_9 = var_10.max(0, var_9 - arg_41_0.advanceTotalCnt)

	math = var_41_6
	arg_41_0.commonRpCount = var_41_9 - var_41_6.max(0, var_41_5 - arg_41_0.advanceTotalCnt)
	arg_41_0.nextredPacketStep = arg_41_1:getDataConfig("reward_time") - arg_41_0.useCount % var_10
	arg_41_0.pos = arg_41_0.activity.data2
	arg_41_0.step = arg_41_0.activity.data3
	arg_41_0.effectId = arg_41_0.activity.data4

	return
end

function var_0_0.checkStep(arg_42_0, arg_42_1)
	if arg_42_0.step > 0 then
		local var_42_0 = arg_42_0._event
		local var_42_1 = var_2.emit

		MonopolyCar2Page = var_1_10005

		var_42_1(var_42_0, var_1_10005.ON_MOVE, arg_42_0.activity.id, function(arg_43_0, arg_43_1, arg_43_2)
			arg_42_0.step = arg_43_0
			arg_42_0.pos = arg_43_1[#arg_43_1]

			local var_43_0 = arg_42_0

			var_43_0.effectId = arg_43_2
			seriesAsync = var_43_0

			var_43_0({
				function(arg_44_0)
					local var_44_0
					local var_44_1 = arg_42_0

					var_2.moveCharWithPaths(var_44_1, arg_43_1, var_44_0, arg_44_0)

					return
				end,
				function(arg_45_0)
					local var_45_0 = arg_42_0

					var_1.checkEffect(var_45_0, arg_45_0)

					return
				end
			}, function()
				if arg_42_1 then
					arg_42_1()
				end

				return
			end)

			return
		end)
	elseif arg_42_1 then
		arg_42_1()
	end

	return
end

function var_0_0.updataUI(arg_47_0)
	setText = var_1_10001

	var_1_10001(arg_47_0.labelLeftRpCount, "" .. arg_47_0.leftAwardCnt)

	local var_47_0 = arg_47_0.commonAnim

	var_1.SetInteger(var_47_0, "count", arg_47_0.leftAwardCnt)

	setText = var_1

	var_1(arg_47_0.labelDropShip, "" .. arg_47_0.turnCnt + 1)

	setText = var_1

	local var_47_1 = arg_47_0.labelLeftCountTip

	i18n = var_4

	var_1(var_47_1, var_4("monopoly_left_count"))

	setText = var_1

	var_1(arg_47_0.labelLeftCount, arg_47_0.leftCount)

	return
end

function var_0_0.updataChar(arg_48_0)
	local var_48_0 = arg_48_0.mapCells[arg_48_0.pos]
	local var_48_1 = arg_48_0.char

	var_48_1.localPosition = var_48_0.position
	isActive = var_48_1

	if not var_48_1(arg_48_0.char) then
		SetActive = var_2

		var_2(arg_48_0.char, true)

		local var_48_2 = arg_48_0.char

		var_2.SetAsLastSibling(var_48_2)
	end

	if arg_48_0.model then
		arg_48_0:updataCharDirect(arg_48_0.pos, false)
	end

	return
end

function var_0_0.checkEffect(arg_49_0, arg_49_1)
	if arg_49_0.effectId > 0 then
		local var_49_0 = arg_49_0.mapCells[arg_49_0.pos]

		pg = var_3

		local var_49_1 = var_3.activity_event_monopoly_event[arg_49_0.effectId].story

		seriesAsync = var_4

		var_4({
			function(arg_50_0)
				if var_49_1 then
					tonumber = var_1

					if var_1(var_49_1) ~= 0 then
						pg = var_1

						local var_50_0 = var_1.NewStoryMgr.GetInstance()

						var_1.Play(var_50_0, var_49_1, arg_50_0, true, true)

						goto label_50_0
					end
				end

				arg_50_0()

				::label_50_0::

				return
			end,
			function(arg_51_0)
				local var_51_0 = arg_49_0

				var_1.triggerEfeect(var_51_0, arg_51_0)

				return
			end,
			function(arg_52_0)
				local var_52_0 = arg_49_0

				var_1.checkCountStory(var_52_0, arg_52_0)

				return
			end
		}, arg_49_1)
	elseif arg_49_1 then
		arg_49_1()
	end

	return
end

function var_0_0.triggerEfeect(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0._event
	local var_53_1 = var_2.emit

	MonopolyCar2Page = var_1_10005

	var_53_1(var_53_0, var_1_10005.ON_TRIGGER, arg_53_0.activity.id, function(arg_54_0, arg_54_1)
		if arg_54_0 and #arg_54_0 >= 0 then
			arg_53_0.effectId = arg_54_1

			local var_54_0 = arg_53_0

			var_54_0.pos = arg_54_0[#arg_54_0]
			seriesAsync = var_54_0

			var_54_0({
				function(arg_55_0)
					local var_55_0 = arg_53_0

					var_1.moveCharWithPaths(var_55_0, arg_54_0, nil, arg_55_0)

					return
				end
			}, function()
				arg_53_1()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.moveCarWithPaths(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	if not arg_57_1 or #arg_57_1 <= 0 then
		if arg_57_3 then
			arg_57_3()
		end

		return
	end

	local var_57_0 = {}
	local var_57_1 = arg_57_0.char.localPosition
	local var_57_2 = {}
	local var_57_3 = {}

	for iter_57_0 = 1, #arg_57_1 do
		if arg_57_0:checkPathTurn(arg_57_1[iter_57_0]) then
			table = var_1_10012

			var_1_10012.insert(var_57_2, arg_57_0.mapCells[arg_57_1[iter_57_0]].position)

			table = var_1_10012

			var_1_10012.insert(var_57_3, arg_57_1[iter_57_0])
		elseif iter_57_0 == #arg_57_1 then
			table = var_1_10012

			var_1_10012.insert(var_57_2, arg_57_0.mapCells[arg_57_1[iter_57_0]].position)

			table = var_1_10012

			var_1_10012.insert(var_57_3, arg_57_1[iter_57_0])
		end
	end

	arg_57_0.speedX = 0
	arg_57_0.speedY = 0
	arg_57_0.baseSpeed = 6
	arg_57_0.baseASpeed = 0.1

	if not arg_57_0.timer then
		Timer = var_8
		arg_57_0.timer = var_8.New(function()
			local var_58_0 = arg_57_0

			var_0.toMoveCar(var_58_0)

			return
		end, 0.016666666666666666, -1)

		local var_57_4 = arg_57_0.timer

		var_8.Start(var_57_4)
	end

	for iter_57_1 = 1, #var_57_2 do
		table = var_1_10012

		var_1_10012.insert(var_57_0, function(arg_59_0)
			arg_57_0.moveComplete = arg_59_0
			arg_57_0.stopOnEnd = false
			arg_57_0.targetPosition = var_57_2[iter_57_1]
			arg_57_0.targetPosIndex = var_57_3[iter_57_1]
			arg_57_0.moveX = arg_57_0.targetPosition.x - arg_57_0.char.localPosition.x
			arg_57_0.moveY = arg_57_0.targetPosition.y - arg_57_0.char.localPosition.y

			local var_59_0 = arg_57_0
			local var_59_1 = arg_57_0.baseSpeed
			local var_59_2 = arg_57_0.moveX

			math = var_2_10004
			var_59_0.baseSpeedX = var_59_1 * (var_59_2 / var_2_10004.abs(arg_57_0.moveX))

			local var_59_3 = arg_57_0
			local var_59_4 = arg_57_0.baseASpeed
			local var_59_5 = arg_57_0.moveX

			math = var_4
			var_59_3.baseASpeedX = var_59_4 * (var_59_5 / var_4.abs(arg_57_0.moveX))

			local var_59_6 = arg_57_0

			math = var_2

			local var_59_7 = var_2.abs(arg_57_0.baseSpeedX)

			math = var_3
			var_59_6.baseSpeedY = var_59_7 / (var_3.abs(arg_57_0.moveX) / arg_57_0.moveY)

			local var_59_8 = arg_57_0

			math = var_2

			local var_59_9 = var_2.abs(arg_57_0.baseASpeedX)

			math = var_3
			var_59_8.baseASpeedY = var_59_9 / (var_3.abs(arg_57_0.moveX) / arg_57_0.moveY)

			if iter_57_1 == 1 then
				arg_57_0.speedX = 0
				arg_57_0.speedY = 0
			else
				arg_57_0.speedX = arg_57_0.baseSpeedX
				arg_57_0.speedY = arg_57_0.baseSpeedY
			end

			return
		end)
	end

	table = var_8

	var_8.insert(var_57_0, function(arg_60_0)
		arg_57_0.moveComplete = nil

		local var_60_0 = arg_57_0

		var_1.updataCharDirect(var_60_0, arg_57_1[#arg_57_1], false)
		arg_60_0()

		return
	end)

	table = var_8

	var_8.insert(var_57_0, function(arg_61_0)
		LeanTween = var_2_10001

		local var_61_0 = var_2_10001.value

		go = var_2_10003

		local var_61_1 = var_61_0(var_2_10003(arg_57_0._tf), 1, 0, 0.1)
		local var_61_2 = var_1.setOnComplete

		System = var_4

		var_61_2(var_61_1, var_4.Action(function()
			arg_61_0()

			return
		end))

		return
	end)

	seriesAsync = var_8

	var_8(var_57_0, arg_57_3)

	return
end

function var_0_0.toMoveCar(arg_63_0)
	if not arg_63_0.targetPosition then
		return
	end

	math = var_1

	local var_63_0 = var_1.abs(arg_63_0.targetPosition.x - arg_63_0.char.localPosition.x)

	math = var_1_10002

	local var_63_1 = var_1_10002.abs(arg_63_0.targetPosition.y - arg_63_0.char.localPosition.y)

	if var_63_0 <= 6.5 and var_63_1 <= 6.5 then
		arg_63_0.targetPosition = nil

		if arg_63_0.moveComplete then
			arg_63_0:updataCharDirect(arg_63_0.targetPosIndex, true)
			arg_63_0.moveComplete()
		end
	end

	math = var_3

	local var_63_2 = var_3.abs(arg_63_0.speedX + arg_63_0.baseASpeedX)

	math = var_4

	local var_63_3

	if not (var_4.abs(arg_63_0.baseSpeedX) < var_63_2) or not arg_63_0.baseSpeedX then
		var_63_3 = arg_63_0.speedX + arg_63_0.baseASpeedX
	end

	arg_63_0.speedX = var_63_3
	math = var_63_3

	local var_63_4 = var_63_3.abs(arg_63_0.speedY + arg_63_0.baseASpeedY)

	math = var_4

	local var_63_5

	if not (var_63_4 > var_4.abs(arg_63_0.baseSpeedY)) or not arg_63_0.baseSpeedY then
		var_63_5 = arg_63_0.speedY + arg_63_0.baseASpeedY
	end

	arg_63_0.speedY = var_63_5

	local var_63_6 = arg_63_0.char.localPosition
	local var_63_7 = arg_63_0.char

	Vector3 = var_5
	var_63_7.localPosition = var_5(var_63_6.x + arg_63_0.speedX, var_63_6.y + arg_63_0.speedY, 0)

	return
end

function var_0_0.checkPathTurn(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_1 + 1 > #arg_64_0.mapCells and 1 or arg_64_1 + 1
	local var_64_1

	if not (arg_64_1 - 1 < 1) or not #arg_64_0.mapCells then
		var_64_1 = arg_64_1 - 1
	end

	if arg_64_0.mapCells[var_64_0].col == arg_64_0.mapCells[var_64_1].col or arg_64_0.mapCells[var_64_0].row == arg_64_0.mapCells[var_64_1].row then
		return false
	end

	return true
end

function var_0_0.moveCharWithPaths(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_0:moveCarWithPaths(arg_65_1, arg_65_2, arg_65_3)

	do return end

	if not arg_65_1 or #arg_65_1 <= 0 then
		if arg_65_3 then
			arg_65_3()
		end

		return
	end

	local var_65_0 = {}
	local var_65_1

	if not (arg_65_1[1] - 1 < 1) or not #arg_65_0.mapCells then
		var_65_1 = arg_65_1[1] - 1
	end

	for iter_65_0 = 1, #arg_65_1 do
		local var_65_2 = arg_65_0.mapCells[arg_65_1[iter_65_0]]

		table = var_11

		var_11.insert(var_65_0, function(arg_66_0)
			local var_66_0 = arg_65_0

			var_1.updataCharDirect(var_66_0, var_65_1, true)

			var_65_1 = arg_65_1[iter_65_0]

			local var_66_1 = 0.35

			LeanTween = var_2

			local var_66_2 = var_2.moveLocal

			go = var_4

			local var_66_3 = var_66_2(var_4(arg_65_0.char), var_65_2.tf.localPosition, var_66_1)
			local var_66_4 = var_2.setEase

			LeanTweenType = var_5

			local var_66_5 = var_66_4(var_66_3, var_5.linear)
			local var_66_6 = var_2.setOnComplete

			System = var_5

			var_66_6(var_66_5, var_5.Action(function()
				arg_66_0()

				return
			end))

			return
		end)

		if iter_65_0 == #arg_65_1 then
			table = var_11

			var_11.insert(var_65_0, function(arg_68_0)
				local var_68_0 = arg_65_0

				var_1.updataCharDirect(var_68_0, arg_65_1[iter_65_0], false)
				arg_68_0()

				return
			end)
		end
	end

	seriesAsync = var_6

	var_6(var_65_0, arg_65_3)

	return
end

function var_0_0.dispose(arg_69_0)
	PoolMgr = var_1_10001

	local var_69_0 = var_1_10001.GetInstance()

	var_1.ReturnSpineChar(var_69_0, var_0_3, arg_69_0.showModel)

	for iter_69_0 = 1, 3 do
		if arg_69_0.showCharNames[iter_69_0] then
			PoolMgr = var_5

			local var_69_1 = var_5.GetInstance()

			var_5.ReturnSpineChar(var_69_1, arg_69_0.showCharNames[iter_69_0], arg_69_0.showCharMods[iter_69_0])
		end
	end

	return
end

return var_0_0
