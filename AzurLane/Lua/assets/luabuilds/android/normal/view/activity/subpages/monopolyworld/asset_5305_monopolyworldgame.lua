class = var_0_10000

local var_0_0 = var_0_10000("MonopolyWorldGame")
local var_0_1 = 117
local var_0_2 = 60
local var_0_3 = {
	{
		0,
		4007,
		4008,
		4009,
		4010,
		0
	},
	{
		4005,
		4006,
		0,
		0,
		4011,
		4012
	},
	{
		4004,
		0,
		0,
		0,
		0,
		4013
	},
	{
		4003,
		4002,
		0,
		0,
		4015,
		4014
	},
	{
		0,
		4001,
		4018,
		4017,
		4016,
		0
	}
}
local var_0_4 = "mengya"
local var_0_5 = "monopoly_world_tip1"
local var_0_6 = "monopoly_world_tip2"
local var_0_7 = "monopoly_world_tip3"
local var_0_8 = 0.6
local var_0_9 = "dafuweng_gold"
local var_0_10 = "dafuweng_oil"
local var_0_11 = "dafuweng_event"
local var_0_12 = "dafuweng_walk"
local var_0_13 = "dafuweng_stand"
local var_0_14 = "dafuweng_walk"
local var_0_15 = "dafuweng_run"
local var_0_16 = "dafuweng_touch"
local var_0_17 = "cell gold"
local var_0_18 = "cell move"
local var_0_19 = "cell oil"
local var_0_20 = "cell event"
local var_0_21 = "cell item"
local var_0_22 = {
	{
		name = "gulitemengya_1",
		path_length = 1,
		cell_type = var_0_18
	},
	{
		name = "gulitemengya_2",
		path_length = 2,
		cell_type = var_0_18
	},
	{
		name = "gulitemengya_3",
		path_length = 3,
		cell_type = var_0_18
	},
	{
		name = "gulitemengya_daoju",
		cell_type = var_0_21
	},
	{
		name = "gulitemengya_jinbi",
		cell_type = var_0_17
	},
	{
		name = "gulitemengya_mingyun",
		cell_type = var_0_20
	},
	{
		name = "gulitemengya_shiyou",
		cell_type = var_0_19
	}
}
local var_0_23 = {
	84180,
	84181,
	84183,
	84179,
	84182
}
local var_0_24
local var_0_25

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

	return
end

function var_0_0.initUI(arg_3_0)
	findTF = var_1_10001
	arg_3_0.tplMapCell = var_1_10001(arg_3_0._tf, "tplMapCell")
	findTF = var_1
	arg_3_0.gameTipUI1 = var_1(arg_3_0._tf, "btnStart/desc")
	setText = var_1

	local var_3_0 = arg_3_0.gameTipUI1

	i18n = var_3

	var_1(var_3_0, var_3(var_0_5))

	findTF = var_1
	arg_3_0.gameTipUI2 = var_1(arg_3_0._tf, "bg/desc")
	setText = var_1

	var_1(arg_3_0.gameTipUI2, "")

	findTF = var_1
	arg_3_0.mapContainer = var_1(arg_3_0._tf, "mapContainer")
	findTF = var_1
	arg_3_0.char = var_1(arg_3_0._tf, "mapContainer/char")
	setActive = var_1

	var_1(arg_3_0.char, false)

	findTF = var_1
	arg_3_0.btnStart = var_1(arg_3_0._tf, "btnStart")
	findTF = var_1
	arg_3_0.effectStart = var_1(arg_3_0.btnStart, "gulitemengya_pingmu")
	findTF = var_1
	arg_3_0.btnHelp = var_1(arg_3_0._tf, "topRight/btnHelp")
	findTF = var_1
	arg_3_0.labelLeftCount = var_1(arg_3_0.btnStart, "times")
	findTF = var_1
	arg_3_0.btnBack = var_1(arg_3_0._tf, "leftTop/back")

	arg_3_0:initMap()
	arg_3_0:initChar()
	arg_3_0:initFurn()

	return
end

function var_0_0.initFurn(arg_4_0)
	findTF = var_1_10001

	local var_4_0 = var_1_10001(arg_4_0._tf, "bg/mask/event")
	local var_4_1 = var_1.GetComponent(var_4_0, "HScrollSnap")

	GetComponent = var_4_0
	findTF = var_3

	local var_4_2 = var_3(arg_4_0._tf, "bg/mask")

	typeof = var_4
	CanvasGroup = var_5
	arg_4_0.bannerCanvas = var_4_0(var_4_2, var_4(var_5))

	var_4_1:Init()

	findTF = var_2

	local var_4_3 = var_2(var_4_1, "content")

	findTF = var_3

	local var_4_4 = var_3(var_4_1, "item")

	findTF = var_4

	local var_4_5 = var_4(arg_4_0._tf, "bg/dots")

	findTF = var_5

	local var_4_6 = var_5(arg_4_0._tf, "bg/dot")

	setActive = var_6

	var_6(var_4_4, false)

	setActive = var_6

	var_6(var_4_6, false)

	arg_4_0.furnItems = {}

	for iter_4_0 = 0, #var_0_23 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(var_4_6, var_4_5)

		Instantiate = var_1_10010
		var_1_10010 = var_1_10010(var_4_4)
		pg = var_11
		var_0_24 = var_11.furniture_data_template[var_0_23[iter_4_0 + 1]]
		var_0_25 = var_0_24.icon
		GetImageSpriteFromAtlasAsync = var_11
		var_1_10012 = "ui/monopolyworldui_atlas"

		local var_4_7 = var_0_25

		findTF = var_1_10014

		var_11(var_1_10012, var_4_7, var_1_10014(var_1_10010, "img"), true)

		var_1_10012 = var_4_1

		var_4_1.AddChild(var_1_10012, var_1_10010)

		setActive = var_11

		var_11(var_1_10010, true)

		table = var_11

		var_11.insert(arg_4_0.furnItems, var_1_10010)
	end

	arg_4_0.bannerSnap = var_4_1
	arg_4_0.bannerContent = var_4_3
	arg_4_0.bannerDots = var_4_5
	arg_4_0.furnNames = {}

	for iter_4_1 = 1, #var_0_23 do
		table = var_1_10010
		var_1_10010 = var_1_10010.insert

		local var_4_8 = arg_4_0.furnNames

		findTF = var_1_10012

		var_1_10010(var_4_8, var_1_10012(arg_4_0._tf, "bg/furnName/img" .. iter_4_1))
	end

	local function var_4_9()
		for iter_5_0 = 1, #var_0_23 do
			local var_5_0 = arg_4_0.bannerSnap

			if iter_5_0 == var_4.CurrentScreen(var_5_0) + 1 then
				isActive = var_5

				if not var_5(arg_4_0.furnNames[iter_5_0]) then
					setActive = var_5

					var_5(arg_4_0.furnNames[iter_5_0], true)
				end
			else
				isActive = var_5

				if var_5(arg_4_0.furnNames[iter_5_0]) then
					setActive = var_5

					var_5(arg_4_0.furnNames[iter_5_0], false)
				end
			end
		end

		return
	end

	Timer = var_7
	arg_4_0.funrTimer = var_7.New(var_4_9, 0.2, -1)

	local var_4_10 = arg_4_0.funrTimer

	var_7.Start(var_4_10)
	var_4_9()

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

			i18n = var_2_10002

			var_7_1(var_7_0, var_2_10002("common_count_noenough"))

			return
		end

		local var_7_2 = arg_6_0

		var_0.changeAnimeState(var_7_2, true)

		setActive = var_0

		var_0(arg_6_0.btnStart, true)

		local var_7_3 = arg_6_0._event
		local var_7_4 = var_0.emit

		MonopolyWorldScene = var_2

		var_7_4(var_7_3, var_2.ON_START, arg_6_0.activity.id, function(arg_8_0)
			if arg_8_0 and arg_8_0 > 0 then
				local var_8_0 = arg_6_0

				var_1.showRollAnimated(var_8_0, arg_8_0)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1_10001

	local var_6_3 = arg_6_0._binder
	local var_6_4 = arg_6_0.btnHelp

	local function var_6_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		pg = var_2_10003
		var_9_2.helps = var_2_10003.gametip.help_monopoly_world.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	onButton = var_1_10001

	local var_6_6 = arg_6_0._binder
	local var_6_7 = arg_6_0.btnBack

	local function var_6_8()
		if not arg_6_0.inAnimatedFlag then
			local var_10_0 = arg_6_0._event
			local var_10_1 = var_0.emit

			BaseUI = var_2_10002

			var_10_1(var_10_0, var_2_10002.ON_BACK)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10005)

	onButton = var_1_10001

	local var_6_9 = arg_6_0._binder

	findTF = var_6_7

	local var_6_10 = var_6_7(arg_6_0.char, "click")

	local function var_6_11()
		if not arg_6_0.model or arg_6_0.inAnimatedFlag then
			return
		end

		local var_11_0 = arg_6_0

		var_0.changeCharAction(var_11_0, var_0_16, 1, function()
			local var_12_0 = arg_6_0

			var_0.changeCharAction(var_12_0, var_0_13)

			return
		end)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_9, var_6_10, var_6_11, var_5)

	return
end

function var_0_0.showRollAnimated(arg_13_0, arg_13_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_14_0)
			setActive = var_2_10001

			var_2_10001(arg_13_0.effectStart, true)

			GetComponent = var_2_10001
			findTF = var_2

			local var_14_0 = var_2(arg_13_0.btnStart, "anim")

			typeof = var_3
			Animator = var_4

			local var_14_1 = var_2_10001(var_14_0, var_3(var_4))

			var_1.Play(var_14_1, "start", -1, 0)

			LeanTween = var_1

			local var_14_2 = var_1.delayedCall
			local var_14_3 = 1

			System = var_3

			var_14_2(var_14_3, var_3.Action(function()
				for iter_15_0 = 1, 6 do
					findTF = var_3_10004
					var_3_10004 = var_3_10004(arg_13_0.btnStart, "num/" .. iter_15_0)

					if iter_15_0 ~= arg_13_1 then
						setActive = var_5

						var_5(var_3_10004, false)
					else
						setActive = var_5

						var_5(var_3_10004, true)
					end
				end

				return
			end))

			LeanTween = var_14_2

			local var_14_4 = var_14_2.delayedCall
			local var_14_5 = 2

			System = var_3

			var_14_4(var_14_5, var_3.Action(function()
				arg_14_0()

				return
			end))

			return
		end
	}, function()
		arg_13_0.useCount = arg_13_0.useCount + 1
		arg_13_0.leftCount = arg_13_0.leftCount - 1
		arg_13_0.step = arg_13_1

		local var_17_0 = arg_13_0

		var_0.updataUI(var_17_0)

		local var_17_1 = arg_13_0

		var_0.checkCharActive(var_17_1)

		return
	end)

	return
end

function var_0_0.checkCountStory(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.useCount
	local var_18_1 = arg_18_0.activity
	local var_18_2

	if not var_3.getDataConfig(var_18_1, "story") then
		var_18_2 = {}
	end

	_ = var_18_1

	if var_18_1.detect(var_18_2, function(arg_19_0)
		return arg_19_0[1] == var_18_0
	end) then
		pg = var_6

		local var_18_3 = var_6.NewStoryMgr.GetInstance()

		var_6.Play(var_18_3, var_5[2], arg_18_1)
	else
		arg_18_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_20_0, arg_20_1)
	if arg_20_1 then
		local var_20_0 = arg_20_0.btnStart
		local var_20_1 = var_2.GetComponent

		typeof = var_1_10004
		Image = var_1_10005
		var_20_1(var_20_0, var_1_10004(var_1_10005)).raycastTarget = false
		arg_20_0.inAnimatedFlag = true

		local var_20_2 = arg_20_0._event
		local var_20_3 = var_2.emit

		ActivityMainScene = var_1_10004

		var_20_3(var_20_2, var_1_10004.LOCK_ACT_MAIN, true)
	else
		arg_20_0.inAnimatedFlag = false

		local var_20_4 = arg_20_0.btnStart
		local var_20_5 = var_2.GetComponent

		typeof = var_1_10004
		Image = var_1_10005
		var_20_5(var_20_4, var_1_10004(var_1_10005)).raycastTarget = true

		local var_20_6 = arg_20_0._event
		local var_20_7 = var_2.emit

		ActivityMainScene = var_4

		var_20_7(var_20_6, var_4.LOCK_ACT_MAIN, false)
	end

	return
end

function var_0_0.initMap(arg_21_0)
	local var_21_0 = var_0_3

	arg_21_0.mapCells = {}

	for iter_21_0 = 1, #var_21_0 do
		local var_21_1 = iter_21_0 - 1
		local var_21_2 = {
			x = -var_21_1 * var_0_1,
			y = -var_21_1 * var_0_2
		}
		local var_21_3 = var_21_0[iter_21_0]

		for iter_21_1 = 1, #var_21_3 do
			local var_21_4 = iter_21_1 - 1
			local var_21_5 = var_21_3[iter_21_1]

			if 0 < var_21_5 then
				cloneTplTo = var_15

				local var_21_6 = arg_21_0.tplMapCell
				local var_21_7 = arg_21_0.mapContainer

				tostring = var_1_10018

				local var_21_8 = var_15(var_21_6, var_21_7, var_1_10018(var_21_5))

				Vector2 = var_21_6
				var_21_8.localPosition = var_21_6(var_0_1 * var_21_4 + var_21_2.x, -var_0_2 * var_21_4 + var_21_2.y)
				pg = var_17

				local var_21_9 = var_17.activity_event_monopoly_map[var_21_5].icon

				GetSpriteFromAtlas = var_1_10018
				var_1_10018 = var_1_10018("ui/monopolyworldui_atlas", var_21_9)
				findTF = var_19

				local var_21_10 = var_19(var_21_8, "image")
				local var_21_11 = var_19.GetComponent

				typeof = var_21
				Image = var_1_10022

				local var_21_12 = var_21_11(var_21_10, var_21(var_1_10022))

				var_21_12.sprite = var_1_10018
				findTF = var_21_12

				local var_21_13 = var_21_12(var_21_8, "image")
				local var_21_14 = var_19.GetComponent

				typeof = var_21
				Image = var_1_10022

				local var_21_15 = var_21_14(var_21_13, var_21(var_1_10022))

				var_19.SetNativeSize(var_21_15)

				local var_21_16 = {
					col = var_21_4,
					row = var_21_1,
					mapId = var_21_5,
					tf = var_21_8,
					icon = var_21_9,
					position = var_16
				}

				table = var_21_15

				var_21_15.insert(arg_21_0.mapCells, var_21_16)
			end
		end
	end

	table = var_2

	var_2.sort(arg_21_0.mapCells, function(arg_22_0, arg_22_1)
		return arg_22_0.mapId < arg_22_1.mapId
	end)

	return
end

function var_0_0.initChar(arg_23_0)
	PoolMgr = var_1_10001

	local var_23_0 = var_1_10001.GetInstance()

	var_1.GetSpineChar(var_23_0, var_0_4, true, function(arg_24_0)
		arg_23_0.model = arg_24_0

		local var_24_0 = arg_23_0.model.transform

		Vector3 = var_2_10002
		var_24_0.localScale = var_2_10002.one

		local var_24_1 = arg_23_0.model.transform

		Vector3 = var_2
		var_24_1.localPosition = var_2.zero

		local var_24_2 = arg_23_0.model.transform

		var_1.SetParent(var_24_2, arg_23_0.char, false)

		local var_24_3 = arg_23_0
		local var_24_4 = arg_23_0.model
		local var_24_5 = var_2.GetComponent

		typeof = var_4
		SpineAnimUI = var_2_10005
		var_24_3.anim = var_24_5(var_24_4, var_4(var_2_10005))

		local var_24_6 = arg_23_0

		var_1.changeCharAction(var_24_6, var_0_13, 0, nil)

		local var_24_7 = arg_23_0

		var_1.checkCharActive(var_24_7)

		if arg_23_0.pos then
			local var_24_8 = arg_23_0

			var_1.updataCharDirect(var_24_8, arg_23_0.pos, false)
		end

		return
	end)

	return
end

function var_0_0.updataCharDirect(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.model then
		local var_25_0 = arg_25_0.mapCells[arg_25_1].position
		local var_25_1 = arg_25_1 + 1 > #arg_25_0.mapCells and 1 or arg_25_1 + 1
		local var_25_2 = arg_25_0.mapCells[var_25_1]
		local var_25_3

		if not arg_25_0:getMoveType(arg_25_0.mapCells[arg_25_1].mapId, arg_25_0.mapCells[var_25_1].mapId, arg_25_2) then
			var_25_3 = arg_25_0.char.localScale.x
		end

		local var_25_4 = arg_25_0.char

		Vector3 = var_8
		var_25_4.localScale = var_8(var_25_3, arg_25_0.char.localScale.y, arg_25_0.char.localScale.z)
	end

	return
end

function var_0_0.getMoveType(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = var_0_3
	local var_26_1 = {}
	local var_26_2 = {}

	for iter_26_0 = 1, #var_26_0 do
		local var_26_3 = var_26_0[iter_26_0]

		for iter_26_1 = 1, #var_26_3 do
			if var_26_3[iter_26_1] == arg_26_1 then
				var_26_1 = {
					x = iter_26_1,
					y = iter_26_0
				}
			end

			if var_16 == arg_26_2 then
				var_26_2 = {
					x = iter_26_1,
					y = iter_26_0
				}
			end
		end
	end

	local var_26_4

	if var_26_2.y > var_26_1.y then
		var_26_4 = -var_0_8
	elseif var_26_2.y < var_26_1.y then
		var_26_4 = var_0_8
	elseif var_26_2.x > var_26_1.x then
		var_26_4 = var_0_8
	elseif var_26_2.x < var_26_1.x then
		var_26_4 = -var_0_8
	end

	return var_26_4
end

function var_0_0.checkCharActive(arg_27_0)
	if arg_27_0.anim then
		if arg_27_0.effectId then
			local var_27_0 = arg_27_0.effectId

			if 0 < var_27_0 then
				var_1_10002 = arg_27_0

				arg_27_0.changeAnimeState(var_1_10002, true)

				var_1_10002 = arg_27_0

				arg_27_0.checkEffect(var_1_10002, function()
					local var_28_0 = arg_27_0

					var_0.changeAnimeState(var_28_0, false)

					local var_28_1 = arg_27_0

					var_0.checkCharActive(var_28_1)

					return
				end)

				goto label_27_0
			end
		end

		if arg_27_0.step then
			local var_27_1 = arg_27_0.step

			if 0 < var_27_1 then
				var_1_10002 = arg_27_0

				arg_27_0.changeAnimeState(var_1_10002, true)

				var_1_10002 = arg_27_0

				arg_27_0.checkStep(var_1_10002, function()
					local var_29_0 = arg_27_0

					var_0.changeAnimeState(var_29_0, false)

					local var_29_1 = arg_27_0

					var_0.checkCharActive(var_29_1)

					return
				end)

				goto label_27_0
			end
		end

		if arg_27_0.activity then
			getProxy = var_1
			ActivityProxy = var_1_10002

			local var_27_2 = var_1(var_1_10002)

			arg_27_0.activity = var_1.getActivityById(var_27_2, arg_27_0.activity.id)

			arg_27_0:updataActivity(arg_27_0.activity)
		end
	end

	::label_27_0::

	return
end

function var_0_0.firstUpdata(arg_30_0, arg_30_1)
	arg_30_0:activityDataUpdata(arg_30_1)
	arg_30_0:updataUI()
	arg_30_0:updataChar()
	arg_30_0:checkCharActive()

	return
end

function var_0_0.updataActivity(arg_31_0, arg_31_1)
	arg_31_0:activityDataUpdata(arg_31_1)
	arg_31_0:updataUI()

	return
end

function var_0_0.activityDataUpdata(arg_32_0, arg_32_1)
	arg_32_0.activity = arg_32_1
	pg = var_1_10002

	local var_32_0 = var_1_10002.TimeMgr.GetInstance()
	local var_32_1 = var_2.GetServerTime(var_32_0)
	local var_32_2 = arg_32_0.activity.data1

	math = var_1_10004

	local var_32_3 = var_1_10004.ceil((var_32_1 - var_32_2) / 0)
	local var_32_4 = arg_32_0.activity

	arg_32_0.totalCnt = var_32_3 * var_5.getDataConfig(var_32_4, "daily_time") + arg_32_0.activity.data1_list[1]
	arg_32_0.useCount = arg_32_0.activity.data1_list[2]
	arg_32_0.leftCount = arg_32_0.totalCnt - arg_32_0.useCount

	if arg_32_0.turnCnt and arg_32_0.turnCnt ~= arg_32_0.activity.data1_list[3] - 1 then
		arg_32_0.autoShowScreen = nil
	end

	arg_32_0.turnCnt = arg_32_0.activity.data1_list[3] - 1
	arg_32_0.leftDropShipCnt = 8 - arg_32_0.turnCnt

	local var_32_5 = arg_32_0.activity.data2_list[2]

	arg_32_0.advanceTotalCnt = #arg_32_1:getDataConfig("reward")
	arg_32_0.isAdvanceRp = arg_32_0.advanceTotalCnt - var_32_5 > 0
	arg_32_0.leftAwardCnt = arg_32_0.activity.data2_list[1] - var_32_5
	math = var_10

	local var_32_6 = var_10.max
	local var_32_7 = 0

	math = var_1_10012
	arg_32_0.advanceRpCount = var_32_6(var_32_7, var_1_10012.min(var_9, arg_32_0.advanceTotalCnt) - var_32_5)
	math = var_10

	local var_32_8 = var_10.max(0, var_9 - arg_32_0.advanceTotalCnt)

	math = var_11
	arg_32_0.commonRpCount = var_32_8 - var_11.max(0, var_32_5 - arg_32_0.advanceTotalCnt)
	arg_32_0.nextredPacketStep = arg_32_1:getDataConfig("reward_time") - arg_32_0.useCount % var_10
	arg_32_0.pos = arg_32_0.activity.data2
	arg_32_0.lastPos = arg_32_0.pos
	arg_32_0.step = arg_32_0.activity.data3
	arg_32_0.effectId = arg_32_0.activity.data4

	return
end

function var_0_0.checkStep(arg_33_0, arg_33_1)
	if arg_33_0.step > 0 then
		local var_33_0 = arg_33_0._event
		local var_33_1 = var_2.emit

		MonopolyWorldScene = var_1_10004

		var_33_1(var_33_0, var_1_10004.ON_MOVE, arg_33_0.activity.id, function(arg_34_0, arg_34_1, arg_34_2)
			arg_33_0.step = arg_34_0
			arg_33_0.lastPos = arg_33_0.pos
			arg_33_0.pos = arg_34_1[#arg_34_1]

			local var_34_0 = arg_33_0

			var_34_0.effectId = arg_34_2
			seriesAsync = var_34_0

			var_34_0({
				function(arg_35_0)
					local var_35_0

					if not (#arg_34_1 > 3) or not var_0_15 then
						var_35_0 = var_0_14
					end

					local var_35_1 = arg_33_0

					var_2.moveCharWithPaths(var_35_1, arg_34_1, var_35_0, arg_35_0)

					return
				end,
				function(arg_36_0)
					local var_36_0

					if arg_34_1 and #arg_34_1 > 0 and arg_33_0.pos == 1 then
						var_36_0 = arg_33_0
						var_36_0.turnCnt = arg_33_0.turnCnt + 1
						setText = var_36_0
						findTF = var_2

						local var_36_1 = var_2(arg_33_0._tf, "topRight/times")

						tostring = var_3

						var_36_0(var_36_1, var_3(arg_33_0.turnCnt))

						local var_36_2 = arg_33_0

						var_36_0.changeBg(var_36_2)
					end

					isActive = var_36_0

					if var_36_0(arg_33_0.effectStart) then
						setActive = var_1

						var_1(arg_33_0.effectStart, false)

						setActive = var_1

						var_1(arg_33_0.effectStart, true)

						LeanTween = var_1

						local var_36_3 = var_1.delayedCall
						local var_36_4 = 1

						System = var_3

						var_36_3(var_36_4, var_3.Action(function()
							for iter_37_0 = 1, 6 do
								findTF = var_4_10004
								var_4_10004 = var_4_10004(arg_33_0.btnStart, "num/" .. iter_37_0)
								setActive = var_5

								var_5(var_4_10004, false)
							end

							return
						end))

						LeanTween = var_36_3

						local var_36_5 = var_36_3.delayedCall
						local var_36_6 = 2

						System = var_3

						var_36_5(var_36_6, var_3.Action(function()
							setActive = var_4_10000

							var_4_10000(arg_33_0.effectStart, false)

							return
						end))
					end

					local var_36_7 = arg_33_0

					var_1.checkEffect(var_36_7, arg_36_0)

					return
				end
			}, function()
				if arg_33_1 then
					arg_33_1()
				end

				return
			end)

			return
		end)
	else
		if arg_33_0.pos == 1 then
			arg_33_0.turnCnt = arg_33_0.turnCnt + 1

			arg_33_0:changeBg()
		end

		if arg_33_1 then
			arg_33_1()
		end
	end

	return
end

function var_0_0.updataUI(arg_40_0)
	setText = var_1_10001

	var_1_10001(arg_40_0.labelLeftCount, arg_40_0.leftCount)

	local var_40_0 = arg_40_0.activity
	local var_40_1 = var_1.getDataConfig(var_40_0, "daily_time")

	var_0_25 = var_0_24.icon

	local var_40_2

	if arg_40_0.turnCnt and arg_40_0.turnCnt < #var_0_23 then
		pg = var_2
		var_0_24 = var_2.furniture_data_template[var_0_23[arg_40_0.turnCnt + 1]]
		setText = var_2
		var_40_2 = arg_40_0.gameTipUI2
		i18n = var_1_10004

		var_2(var_40_2, var_1_10004(var_0_6, var_40_1, 1))
	else
		setText = var_2
		var_40_2 = arg_40_0.gameTipUI2
		i18n = var_1_10004

		var_2(var_40_2, var_1_10004(var_0_7, var_40_1))
	end

	local var_40_3

	if arg_40_0.leftCount then
		var_40_3 = arg_40_0.leftCount

		if 0 < var_40_3 then
			setActive = var_40_3
			findTF = var_40_2

			var_40_3(var_40_2(arg_40_0.btnStart, "img3"), true)

			setActive = var_40_3
			findTF = var_40_2

			var_40_3(var_40_2(arg_40_0.btnStart, "img4"), false)

			goto label_40_0
		end
	end

	setActive = var_40_3
	findTF = var_40_2

	var_40_3(var_40_2(arg_40_0.btnStart, "img3"), false)

	setActive = var_40_3
	findTF = var_40_2

	var_40_3(var_40_2(arg_40_0.btnStart, "img4"), true)

	::label_40_0::

	setText = var_40_3
	findTF = var_40_2

	local var_40_4 = var_40_2(arg_40_0._tf, "topRight/times")

	tostring = var_4

	var_40_3(var_40_4, var_4(arg_40_0.turnCnt))

	for iter_40_0 = 1, #arg_40_0.furnItems do
		if iter_40_0 <= arg_40_0.turnCnt then
			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(arg_40_0.furnItems[iter_40_0], "got"), true)
		else
			setActive = var_6
			findTF = var_1_10007

			var_6(var_1_10007(arg_40_0.furnItems[iter_40_0], "got"), false)
		end
	end

	if arg_40_0.bannerSnap.StartingScreen == 0 and not arg_40_0.bannerInit then
		if arg_40_0.turnCnt < #var_0_23 then
			arg_40_0.bannerSnap.StartingScreen = arg_40_0.turnCnt % 5 + 1
			arg_40_0.bannerInit = true
		else
			arg_40_0.bannerSnap.autoSnap = 5
		end
	else
		local var_40_5 = arg_40_0.bannerSnap

		if var_2.CurrentScreen(var_40_5) ~= arg_40_0.turnCnt and arg_40_0.turnCnt < #var_0_23 then
			local var_40_6 = arg_40_0.turnCnt % 5
			local var_40_7 = arg_40_0.bannerSnap
			local var_40_8 = var_40_6 - var_3.CurrentScreen(var_40_7)
			local var_40_9 = 1

			math = var_40_7

			for iter_40_1 = var_40_9, var_40_7.abs(var_40_8) do
				math = var_1_10007

				if var_1_10007.sign(var_40_8) > 0 then
					local var_40_10 = arg_40_0.bannerSnap

					var_1_10007.NextScreen(var_40_10, true)
				else
					local var_40_11 = arg_40_0.bannerSnap

					var_1_10007.PreviousScreen(var_40_11, true)
				end
			end
		end
	end

	local var_40_12 = arg_40_0.turnCnt
	local var_40_14

	if #var_0_23 <= var_40_12 then
		local var_40_13

		if arg_40_0.bannerCanvas.blocksRaycasts ~= true then
			var_40_13 = arg_40_0.bannerCanvas
			var_40_13.blocksRaycasts = true
		end

		isActive = var_40_13
		findTF = var_40_14

		if not var_40_13(var_40_14(arg_40_0._tf, "bg/dots")) then
			var_40_14 = arg_40_0.bannerSnap

			var_2.NextScreen(var_40_14, true)

			setActive = var_2
			findTF = var_40_14

			var_2(var_40_14(arg_40_0._tf, "bg/dots"), true)
		end
	else
		local var_40_15

		if arg_40_0.bannerCanvas.blocksRaycasts == true then
			var_40_15 = arg_40_0.bannerCanvas
			var_40_15.blocksRaycasts = false
		end

		isActive = var_40_15
		findTF = var_40_14

		if var_40_15(var_40_14(arg_40_0._tf, "bg/dots")) then
			setActive = var_2
			findTF = var_3

			var_2(var_3(arg_40_0._tf, "bg/dots"), false)
		end
	end

	arg_40_0:changeBg()

	return
end

function var_0_0.updataChar(arg_41_0)
	local var_41_0 = arg_41_0.mapCells[arg_41_0.pos]
	local var_41_1 = arg_41_0.char

	var_41_1.localPosition = var_41_0.position
	isActive = var_41_1

	if not var_41_1(arg_41_0.char) then
		SetActive = var_2

		var_2(arg_41_0.char, true)

		local var_41_2 = arg_41_0.char

		var_2.SetAsLastSibling(var_41_2)
	end

	if arg_41_0.model then
		arg_41_0:updataCharDirect(arg_41_0.pos, false)
	end

	return
end

function var_0_0.getEffectTf(arg_42_0, arg_42_1, arg_42_2)
	for iter_42_0 = 1, #var_0_22 do
		if var_0_22[iter_42_0].cell_type == arg_42_1 then
			local var_42_0 = var_7.name

			if not arg_42_2 then
				findTF = var_1_10009

				return var_1_10009(arg_42_0._tf, "mapContainer/effect/" .. var_42_0)
			elseif arg_42_2 == var_7.path_length then
				findTF = var_1_10009

				return var_1_10009(arg_42_0._tf, "mapContainer/effect/" .. var_42_0)
			end
		end
	end

	return nil
end

function var_0_0.checkEffect(arg_43_0, arg_43_1)
	if arg_43_0.effectId > 0 then
		local var_43_0 = arg_43_0.mapCells[arg_43_0.pos]
		local var_43_1, var_43_2 = arg_43_0:getActionName(var_43_0.icon)

		pg = var_5

		local var_43_3 = var_5.activity_event_monopoly_event[arg_43_0.effectId].story

		seriesAsync = var_6

		var_6({
			function(arg_44_0)
				if var_43_1 then
					local var_44_0 = arg_43_0

					var_1.changeCharAction(var_44_0, var_43_1, 1, function()
						local var_45_0 = arg_43_0

						var_0.changeCharAction(var_45_0, var_0_13, 0, nil)
						arg_44_0()

						return
					end)
				end

				if var_43_2 then
					local var_44_1 = arg_43_0

					if var_1.getEffectTf(var_44_1, var_43_2) then
						Vector2 = var_44_1
						var_1.anchoredPosition = var_44_1(var_43_0.position.x, var_43_0.position.y)
						setActive = var_2

						var_2(var_1, false)

						setActive = var_2

						var_2(var_1, true)
					end
				end

				if not var_43_1 and not var_43_2 then
					arg_44_0()
				elseif not var_43_1 and var_43_2 then
					LeanTween = var_1

					local var_44_2 = var_1.delayedCall
					local var_44_3 = 1

					System = var_2_10003

					var_44_2(var_44_3, var_2_10003.Action(function()
						arg_44_0()

						return
					end))
				end

				return
			end,
			function(arg_47_0)
				if var_43_3 then
					tonumber = var_1

					if var_1(var_43_3) ~= 0 then
						pg = var_1

						local var_47_0 = var_1.NewStoryMgr.GetInstance()

						var_1.Play(var_47_0, var_43_3, arg_47_0, true, true)

						goto label_47_0
					end
				end

				arg_47_0()

				::label_47_0::

				return
			end,
			function(arg_48_0)
				local var_48_0 = arg_43_0

				var_1.triggerEfeect(var_48_0, arg_48_0)

				return
			end,
			function(arg_49_0)
				local var_49_0 = arg_43_0

				var_1.checkCountStory(var_49_0, arg_49_0)

				return
			end,
			function(arg_50_0)
				if arg_43_0.pos == 1 then
					local var_50_0 = arg_43_0

					var_1.changeBg(var_50_0)
				end

				arg_50_0()

				return
			end
		}, arg_43_1)
	elseif arg_43_1 then
		arg_43_1()
	end

	return
end

function var_0_0.triggerEfeect(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0._event
	local var_51_1 = var_2.emit

	MonopolyWorldScene = var_1_10004

	var_51_1(var_51_0, var_1_10004.ON_TRIGGER, arg_51_0.activity.id, function(arg_52_0, arg_52_1)
		if arg_52_0 and #arg_52_0 >= 0 then
			arg_51_0.effectId = arg_52_1
			arg_51_0.lastPos = arg_51_0.pos
			arg_51_0.pos = arg_52_0[#arg_52_0]

			if #arg_52_0 > 0 then
				print = var_2

				var_2()
			end

			local var_52_0 = arg_51_0
			local var_52_1 = var_2.getEffectTf(var_52_0, var_0_18, #arg_52_0)

			seriesAsync = var_52_0

			var_52_0({
				function(arg_53_0)
					if var_52_1 then
						setActive = var_1

						var_1(var_52_1, false)

						setActive = var_1

						var_1(var_52_1, true)

						local var_53_0 = var_52_1

						var_53_0.anchoredPosition = arg_51_0.mapCells[arg_51_0.lastPos].position
						LeanTween = var_53_0

						local var_53_1 = var_53_0.delayedCall
						local var_53_2 = 1

						System = var_3

						var_53_1(var_53_2, var_3.Action(function()
							arg_53_0()

							return
						end))
					else
						arg_53_0()
					end

					return
				end,
				function(arg_55_0)
					local var_55_0 = arg_51_0

					var_1.moveCharWithPaths(var_55_0, arg_52_0, var_0_12, arg_55_0)

					return
				end
			}, function()
				if var_52_1 then
					-- block empty
				end

				arg_51_1()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.changeBg(arg_57_0)
	local var_57_0

	if not arg_57_0.turnCnt or not (arg_57_0.turnCnt % 5 + 1) then
		var_57_0 = 1
	end

	for iter_57_0 = 1, 5 do
		findTF = var_1_10006
		var_1_10006 = var_1_10006(arg_57_0._tf, "bg/img" .. iter_57_0)
		GetComponent = var_7

		local var_57_1 = var_1_10006

		typeof = var_9
		Image = var_1_10010

		local var_57_2 = var_7(var_57_1, var_9(var_1_10010)).color.a

		if iter_57_0 == var_57_0 then
			if var_57_2 ~= 1 then
				LeanTween = var_9

				var_9.alpha(var_1_10006, 1, 0.5)
			end
		elseif var_57_2 ~= 0 then
			LeanTween = var_9

			var_9.alpha(var_1_10006, 0, 0.5)
		end
	end

	return
end

function var_0_0.toMoveCar(arg_58_0)
	if not arg_58_0.targetPosition then
		return
	end

	math = var_1

	local var_58_0 = var_1.abs(arg_58_0.targetPosition.x - arg_58_0.char.localPosition.x)

	math = var_2

	local var_58_1 = var_2.abs(arg_58_0.targetPosition.y - arg_58_0.char.localPosition.y)

	if var_58_0 <= 6.5 and var_58_1 <= 6.5 then
		arg_58_0.targetPosition = nil

		if arg_58_0.moveComplete then
			arg_58_0:updataCharDirect(arg_58_0.targetPosIndex, true)
			arg_58_0.moveComplete()
		end
	end

	math = var_3

	local var_58_2 = var_3.abs(arg_58_0.speedX + arg_58_0.baseASpeedX)

	math = var_4

	local var_58_3

	if not (var_58_2 > var_4.abs(arg_58_0.baseSpeedX)) or not arg_58_0.baseSpeedX then
		var_58_3 = arg_58_0.speedX + arg_58_0.baseASpeedX
	end

	arg_58_0.speedX = var_58_3
	math = var_58_3

	local var_58_4 = var_58_3.abs(arg_58_0.speedY + arg_58_0.baseASpeedY)

	math = var_4

	local var_58_5

	if not (var_58_4 > var_4.abs(arg_58_0.baseSpeedY)) or not arg_58_0.baseSpeedY then
		var_58_5 = arg_58_0.speedY + arg_58_0.baseASpeedY
	end

	arg_58_0.speedY = var_58_5

	local var_58_6 = arg_58_0.char.localPosition
	local var_58_7 = arg_58_0.char

	Vector3 = var_5
	var_58_7.localPosition = var_5(var_58_6.x + arg_58_0.speedX, var_58_6.y + arg_58_0.speedY, 0)

	return
end

function var_0_0.checkPathTurn(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_1 + 1 > #arg_59_0.mapCells and 1 or arg_59_1 + 1
	local var_59_1

	if not (arg_59_1 - 1 < 1) or not #arg_59_0.mapCells then
		var_59_1 = arg_59_1 - 1
	end

	if arg_59_0.mapCells[var_59_0].col == arg_59_0.mapCells[var_59_1].col or arg_59_0.mapCells[var_59_0].row == arg_59_0.mapCells[var_59_1].row then
		return false
	end

	return true
end

function var_0_0.moveCharWithPaths(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_1 or #arg_60_1 <= 0 then
		if arg_60_3 then
			arg_60_3()
		end

		return
	end

	local var_60_0 = {}
	local var_60_1

	if not (arg_60_1[1] - 1 < 1) or not #arg_60_0.mapCells then
		var_60_1 = arg_60_1[1] - 1
	end

	for iter_60_0 = 1, #arg_60_1 do
		local var_60_2 = arg_60_0.mapCells[arg_60_1[iter_60_0]]

		table = var_11

		var_11.insert(var_60_0, function(arg_61_0)
			local var_61_0 = arg_60_0

			var_1.changeCharAction(var_61_0, arg_60_2, 0, nil)

			local var_61_1 = arg_60_0

			var_1.updataCharDirect(var_61_1, var_60_1, true)

			var_60_1 = arg_60_1[iter_60_0]

			local var_61_2
			local var_61_3 = arg_60_2 == var_0_12 and 0.9 or arg_60_2 == var_0_14 and 0.9 or 0.5

			LeanTween = var_2

			local var_61_4 = var_2.moveLocal

			go = var_3

			local var_61_5 = var_61_4(var_3(arg_60_0.char), var_60_2.tf.localPosition, var_61_3)
			local var_61_6 = var_2.setEase

			LeanTweenType = var_4

			local var_61_7 = var_61_6(var_61_5, var_4.linear)
			local var_61_8 = var_2.setOnComplete

			System = var_4

			var_61_8(var_61_7, var_4.Action(function()
				if arg_60_2 == var_0_14 then
					LeanTween = var_0

					local var_62_0 = var_0.delayedCall
					local var_62_1 = 0.05

					System = var_3_10002

					var_62_0(var_62_1, var_3_10002.Action(function()
						arg_61_0()

						return
					end))
				else
					arg_61_0()
				end

				return
			end))

			return
		end)

		if iter_60_0 == #arg_60_1 then
			table = var_11

			var_11.insert(var_60_0, function(arg_64_0)
				local var_64_0 = arg_60_0

				var_1.changeCharAction(var_64_0, var_0_13, 0, nil)

				local var_64_1 = arg_60_0

				var_1.updataCharDirect(var_64_1, arg_60_1[iter_60_0], false)
				arg_64_0()

				return
			end)
		end
	end

	seriesAsync = var_6

	var_6(var_60_0, arg_60_3)

	return
end

function var_0_0.changeCharAction(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	if arg_65_0.actionName == arg_65_1 and arg_65_0.actionName ~= var_0_14 then
		return
	end

	arg_65_0.actionName = arg_65_1

	local var_65_0 = arg_65_0.anim

	var_4.SetActionCallBack(var_65_0, nil)

	local var_65_1 = arg_65_0.anim

	var_4.SetAction(var_65_1, arg_65_1, 0)

	local var_65_2 = arg_65_0.anim

	var_4.SetActionCallBack(var_65_2, function(arg_66_0)
		if arg_66_0 == "finish" then
			if arg_65_2 == 1 then
				local var_66_0 = arg_65_0.anim

				var_1.SetActionCallBack(var_66_0, nil)

				local var_66_1 = arg_65_0.anim

				var_1.SetAction(var_66_1, var_0_13, 0)
			end

			if arg_65_3 then
				arg_65_3()
			end
		end

		return
	end)

	if arg_65_2 ~= 1 and arg_65_3 then
		arg_65_3()
	end

	return
end

function var_0_0.getActionName(arg_67_0, arg_67_1)
	if arg_67_1 == "icon_1" then
		return var_0_11, var_0_21
	elseif arg_67_1 == "icon_2" then
		return var_0_9, var_0_17
	elseif arg_67_1 == "icon_3" then
		return var_0_11, var_0_20
	elseif arg_67_1 == "icon_4" then
		return var_0_11, var_0_21
	elseif arg_67_1 == "icon_5" then
		return var_0_10, var_0_19
	elseif arg_67_1 == "icon_6" then
		return nil, nil
	end

	return
end

function var_0_0.dispose(arg_68_0)
	if arg_68_0.skinCardName and arg_68_0.showModel then
		PoolMgr = var_1

		local var_68_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_68_0, arg_68_0.skinCardName, arg_68_0.showModel)
	end

	if arg_68_0.funrTimer then
		local var_68_1 = arg_68_0.funrTimer

		var_1.Stop(var_68_1)

		arg_68_0.funrTimer = nil
	end

	for iter_68_0 = 1, 5 do
		findTF = var_1_10005
		var_1_10005 = var_1_10005(arg_68_0._tf, "bg/img" .. iter_68_0)
		LeanTween = var_6

		if var_6.isTweening(var_1_10005) then
			LeanTween = var_6

			var_6.cancel(var_1_10005)
		end
	end

	return
end

return var_0_0
