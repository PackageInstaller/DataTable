class = var_0_10000

local var_0_0 = "RivalInfoLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.TYPE_DISPLAY = 1
var_0_1.TYPE_BATTLE = 2

function var_0_1.getUIName(arg_1_0)
	return "RivalInfoUI"
end

function var_0_1.setRival(arg_2_0, arg_2_1)
	arg_2_0.rivalVO = arg_2_1

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_3_0)

	onButton = var_1

	local var_3_1 = arg_3_0

	findTF = var_1_10003

	var_1(var_3_1, var_1_10003(arg_3_0._tf, "bg"), function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_3_2 = arg_3_0._tf

	arg_3_0.shipCardTpl = var_1.Find(var_3_2, "ShipCardTpl")
	findTF = var_1
	arg_3_0.startBtn = var_1(arg_3_0._tf, "ships_container/start_btn")
	setActive = var_1

	var_1(arg_3_0.startBtn, false)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_3_0._tf, "info/title_miex"), arg_3_0.contextData.type == arg_3_0.TYPE_BATTLE)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.startBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		RivalInfoMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.START_BATTLE)

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_3_3, var_3_4, var_3_5, var_5)

	pg = var_1

	local var_3_6 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_6, arg_3_0._tf)
	arg_3_0:initRivalInfo()

	arg_3_0.isRealName = false

	local var_3_7 = arg_3_0._tf

	arg_3_0.realNameToggle = var_1.Find(var_3_7, "info/real_name")
	onToggle = var_1

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.realNameToggle

	local function var_3_10(arg_6_0)
		arg_3_0.isRealName = arg_6_0

		local var_6_0 = arg_3_0

		var_1.UpdateNames(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_8, var_3_9, var_3_10, var_5)

	setActive = var_1

	local var_3_11 = arg_3_0.realNameToggle

	pg = var_3_9

	local var_3_12 = var_3_9.PushNotificationMgr.GetInstance()

	var_1(var_3_11, var_3.isEnableShipName(var_3_12))

	return
end

function var_0_1.UpdateNames(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.names) do
		local var_7_0 = iter_7_1[1]
		local var_7_1 = iter_7_1[2]

		if arg_7_0.isRealName then
			var_1_10009 = var_7_1

			local var_7_2

			if not var_7_1.GetDefaultName(var_1_10009) then
				var_1_10009 = var_7_1
				var_7_2 = var_7_1.getName(var_1_10009)
			end

			setText = var_1_10009
			findTF = var_1_10010

			var_1_10009(var_1_10010(var_7_0, "content/info/name_mask/name"), var_7_2)
		end
	end

	return
end

function var_0_1.initRivalInfo(arg_8_0)
	setText = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_8_0._tf, "info/name/container/name"), arg_8_0.rivalVO.name)

	setText = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_8_0._tf, "info/name/container/lv"), "Lv." .. arg_8_0.rivalVO.level)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_8_0._tf, "info/rank"), arg_8_0.rivalVO.rank ~= nil)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_8_0._tf, "info/medal"), arg_8_0.rivalVO.rank ~= nil)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_8_0._tf, "info/medal/Text"), arg_8_0.rivalVO.rank ~= nil)

	if arg_8_0.rivalVO.rank then
		setText = var_1
		findTF = var_2

		var_1(var_2(arg_8_0._tf, "info/rank/container/value"), arg_8_0.rivalVO.rank)

		SeasonInfo = var_1

		local var_8_0 = var_1.getMilitaryRank(arg_8_0.rivalVO.score, arg_8_0.rivalVO.rank)

		findTF = var_2

		local var_8_1 = var_2(arg_8_0._tf, "info/medal")
		local var_8_2 = var_2.GetComponent

		typeof = var_4
		Image = var_1_10005

		local var_8_3 = var_8_2(var_8_1, var_4(var_1_10005))

		findTF = var_8_1

		local var_8_4 = var_8_1(arg_8_0._tf, "info/medal/Text")
		local var_8_5 = var_3.GetComponent

		typeof = var_5
		Image = var_1_10006

		local var_8_6 = var_8_5(var_8_4, var_5(var_1_10006))

		SeasonInfo = var_8_4

		local var_8_7 = var_8_4.getEmblem(arg_8_0.rivalVO.score, arg_8_0.rivalVO.rank)

		LoadSpriteAsync = var_5

		var_5("emblem/" .. var_8_7, function(arg_9_0)
			var_8_3.sprite = arg_9_0

			local var_9_0 = var_8_6

			var_1.SetNativeSize(var_9_0)

			return
		end)

		LoadSpriteAsync = var_5

		var_5("emblem/n_" .. var_8_7, function(arg_10_0)
			var_8_6.sprite = arg_10_0

			local var_10_0 = var_8_6

			var_1.SetNativeSize(var_10_0)

			return
		end)
	end

	arg_8_0.names = {}

	local function var_8_8(arg_11_0, arg_11_1)
		flushShipCard = var_2_10002

		var_2_10002(arg_11_0, arg_11_1)

		getProxy = var_2_10002
		PlayerProxy = var_3

		local var_11_0 = var_2_10002(var_3)
		local var_11_1 = var_2.getRawData(var_11_0)

		if var_2.ShouldCheckCustomName(var_11_1) then
			var_11_1 = arg_11_1

			local var_11_2

			if not arg_11_1.GetDefaultName(var_11_1) then
				var_11_1 = arg_11_1
				var_11_2 = arg_11_1.getName(var_11_1)
			end

			setScrollText = var_11_1
			findTF = var_4

			var_11_1(var_4(arg_11_0, "content/info/name_mask/name"), arg_11_1:GetColorName(var_11_2))

			return
		end
	end

	local function var_8_9(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		cloneTplTo = var_2_10004

		local var_12_0 = var_2_10004(arg_8_0.shipCardTpl, arg_12_2)

		setActive = var_5

		var_5(var_12_0, true)

		Vector3 = var_5
		var_12_0.localScale = var_5(1.1, 1.1, 1)
		setActive = var_5

		var_5(var_12_0:Find("content"), arg_12_3 ~= nil)

		setActive = var_5

		var_5(var_12_0:Find("empty"), arg_12_3 == nil)

		if arg_12_3 then
			var_8_8(var_12_0, arg_12_3)

			table = var_5

			var_5.insert(arg_8_0.names, {
				var_12_0,
				arg_12_3
			})
		end

		return
	end

	local var_8_10 = arg_8_0._tf
	local var_8_11 = var_3.Find(var_8_10, "ships_container/ships/main")
	local var_8_12 = #arg_8_0.rivalVO.mainShips

	for iter_8_0 = 1, 3 do
		var_8_9(var_8_12, iter_8_0, var_8_11, arg_8_0.rivalVO.mainShips[iter_8_0])
	end

	local var_8_13 = arg_8_0._tf
	local var_8_14 = var_5.Find(var_8_13, "ships_container/ships/vanguard")
	local var_8_15 = #arg_8_0.rivalVO.vanguardShips

	for iter_8_1 = 1, 3 do
		var_8_9(var_8_15, iter_8_1, var_8_14, arg_8_0.rivalVO.vanguardShips[iter_8_1])
	end

	local var_8_16 = arg_8_0._tf
	local var_8_17 = var_7.Find(var_8_16, "ships_container/main_comprehensive")
	local var_8_18 = arg_8_0._tf
	local var_8_19 = var_8.Find(var_8_18, "ships_container/vanguard_comprehensive")
	local var_8_20 = arg_8_0._tf
	local var_8_21 = var_9.Find(var_8_20, "ships_container/main_comprehensive/Text")
	local var_8_22 = arg_8_0._tf
	local var_8_23 = var_10.Find(var_8_22, "ships_container/vanguard_comprehensive/Text")
	local var_8_24 = arg_8_0.rivalVO
	local var_8_25 = var_11.GetGearScoreSum

	TeamType = var_1_10013

	local var_8_26 = var_8_25(var_8_24, var_1_10013.Main)
	local var_8_27 = arg_8_0.rivalVO
	local var_8_28 = var_12.GetGearScoreSum

	TeamType = var_1_10014

	local var_8_29 = var_8_28(var_8_27, var_1_10014.Vanguard)

	LeanTween = var_8_27

	local var_8_30 = var_8_27.value

	go = var_14

	local var_8_31 = var_8_30(var_14(var_8_21), 0, var_8_26, 0.5)
	local var_8_32 = var_13.setOnUpdate

	System = var_15

	var_8_32(var_8_31, var_15.Action_float(function(arg_13_0)
		setText = var_2_10001

		local var_13_0 = var_8_21

		math = var_2_10003

		var_2_10001(var_13_0, var_2_10003.floor(arg_13_0))

		return
	end))

	LeanTween = var_8_32

	local var_8_33 = var_8_32.value

	go = var_8_31

	local var_8_34 = var_8_33(var_8_31(var_8_23), 0, var_8_29, 0.5)
	local var_8_35 = var_13.setOnUpdate

	System = var_15

	local var_8_36 = var_8_35(var_8_34, var_15.Action_float(function(arg_14_0)
		setText = var_2_10001

		local var_14_0 = var_8_23

		math = var_2_10003

		var_2_10001(var_14_0, var_2_10003.floor(arg_14_0))

		return
	end))
	local var_8_37 = var_13.setOnComplete

	System = var_15

	var_8_37(var_8_36, var_15.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_8_0.startBtn, arg_8_0.contextData.type == arg_8_0.TYPE_BATTLE)

		pg = var_2_10000

		local var_15_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_15_0)

		return
	end))

	return
end

function var_0_1.willExit(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.UIMgr.GetInstance()
	local var_16_1 = var_1.UnOverlayPanel
	local var_16_2 = arg_16_0._tf

	pg = var_1_10004

	var_16_1(var_16_0, var_16_2, var_1_10004.UIMgr.GetInstance().UIMain)

	return
end

return var_0_1
