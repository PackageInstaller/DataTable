class = var_0_10000

local var_0_0 = "AirForceOfDragonEmperyUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AirForceOfDragonEmperyUI"
end

local var_0_2 = {
	"J-20",
	"J-10",
	"J-15",
	"FC-1",
	"FC-31"
}
local var_0_3 = {
	"fighterplane_J20_tip",
	"fighterplane_J10_tip",
	"fighterplane_J15_tip",
	"fighterplane_FC1_tip",
	"fighterplane_FC31_tip"
}

function var_0_1.init(arg_2_0)
	arg_2_0.itemList = {}

	local var_2_0 = 0
	local var_2_1 = arg_2_0._tf

	for iter_2_0 = var_2_0, var_2.Find(var_2_1, "List").childCount - 1 do
		local var_2_2 = arg_2_0._tf
		local var_2_3 = var_5.Find(var_2_2, "List")
		local var_2_4 = var_5.GetChild(var_2_3, iter_2_0)

		setImageAlpha = var_1_10006

		var_1_10006(var_2_4:Find("Button"), 0.5)

		table = var_1_10006

		var_1_10006.insert(arg_2_0.itemList, var_2_4)
	end

	local var_2_5 = arg_2_0._tf

	arg_2_0.currentNameImage = var_1.Find(var_2_5, "FighterName")

	local var_2_6 = arg_2_0._tf

	arg_2_0.currentFighterImage = var_1.Find(var_2_6, "FighterImage")

	local var_2_7 = arg_2_0._tf

	arg_2_0.currentFighterDesc = var_1.Find(var_2_7, "FighterProgress")
	setImageAlpha = var_1

	var_1(arg_2_0.currentNameImage, 0)

	setImageAlpha = var_1

	var_1(arg_2_0.currentFighterImage, 0)

	local var_2_8 = arg_2_0._tf

	arg_2_0.BattleTimes = var_1.Find(var_2_8, "BattleTimes")
	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.SetActivityData(arg_3_0, arg_3_1)
	arg_3_0.activity = arg_3_1

	return
end

function var_0_1.GetFighterData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.activity
	local var_4_1

	if not var_2.getKVPList(var_4_0, 1, arg_4_1) then
		var_4_1 = 0
	end

	local var_4_2 = arg_4_0.activity
	local var_4_3 = var_3.getKVPList(var_4_2, 2, arg_4_1) == 1

	return var_4_1, var_4_3
end

function var_0_1.GetActivityProgress(arg_5_0)
	local var_5_0 = arg_5_0.activity
	local var_5_1 = var_1.GetMaxProgress(var_5_0)
	local var_5_2 = arg_5_0.activity
	local var_5_3 = var_2.GetPerDayCount(var_5_2)
	local var_5_4 = 0
	local var_5_5 = arg_5_0.activity
	local var_5_6 = var_4.GetLevelCount(var_5_5)

	for iter_5_0 = 1, var_5_6 do
		local var_5_7 = arg_5_0.activity
		local var_5_8

		if not var_9.getKVPList(var_5_7, 1, iter_5_0) then
			var_5_8 = 0
		end

		var_5_4 = var_5_4 + var_5_8
	end

	pg = var_5

	local var_5_9 = var_5.TimeMgr.GetInstance()
	local var_5_10 = var_5.DiffDay(var_5_9, arg_5_0.activity.data1, var_5:GetServerTime()) + 1

	math = var_7

	local var_5_11 = var_7.min(var_5_10 * var_5_3, var_5_1)

	return var_5_4, var_5_11
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_4.Find(var_6_1, "Back")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.closeView(var_7_0)

		return
	end

	SOUND_BACK = var_6_1

	var_1_10001(var_6_0, var_6_2, var_6_3, var_6_1)

	onButton = var_1_10001

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_4.Find(var_6_5, "Help")

	local function var_6_7()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		pg = var_2_10004
		var_8_2.helps = var_2_10004.gametip.fighterplane_help.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_4, var_6_6, var_6_7, var_6_5)

	onButton = var_1_10001

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0._tf
	local var_6_10 = var_4.Find(var_6_9, "Battle")

	local function var_6_11()
		local var_9_0 = arg_6_0.contextData.index
		local var_9_1 = arg_6_0
		local var_9_2 = var_1.GetFighterData(var_9_1, var_9_0)

		local function var_9_3()
			local var_10_0 = arg_6_0.activity
			local var_10_1 = var_0.GetLevelCount(var_10_0)
			local var_10_2 = arg_6_0.activity
			local var_10_3 = var_1.getConfig(var_10_2, "config_client").stages

			math = var_10_0

			local var_10_4 = var_10_0.floor(#var_10_3 / var_10_1) * (var_9_0 - 1) + 1

			math = var_4

			local var_10_5 = var_4.min(var_10_4 + var_2 - 1, #var_10_3)

			math = var_3_10005

			local var_10_6 = var_10_3[var_3_10005.random(var_10_4, var_10_5)]
			local var_10_7 = arg_6_0
			local var_10_8 = var_6.emit

			AirForceOfDragonEmperyMediator = var_3_10009

			var_10_8(var_10_7, var_3_10009.ON_BATTLE, var_10_6)

			return
		end

		local var_9_4 = arg_6_0.activity

		if var_3.GetPerLevelProgress(var_9_4) <= var_9_2 then
			pg = var_3

			local var_9_5 = var_3.MsgboxMgr.GetInstance()
			local var_9_6 = var_3.ShowMsgBox
			local var_9_7 = {}

			i18n = var_2_10007
			var_9_7.content = var_2_10007("fighterplane_complete_tip")
			var_9_7.onYes = var_9_3

			var_9_6(var_9_5, var_9_7)
		else
			var_9_3()
		end

		return
	end

	SFX_FIGHTER_BATTLE = var_6_9

	var_1_10001(var_6_8, var_6_10, var_6_11, var_6_9)

	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.itemList) do
		onButton = var_6_9

		local var_6_12 = arg_6_0
		local var_6_13 = iter_6_1

		local function var_6_14()
			local var_11_0 = arg_6_0

			var_0.SwitchIndex(var_11_0, iter_6_0)

			return
		end

		SFX_FIGHTER_SWITCH = var_1_10011

		var_6_9(var_6_12, var_6_13, var_6_14, var_1_10011)
	end

	getProxy = var_1
	PlayerProxy = var_3

	local var_6_15 = var_1(var_3)
	local var_6_16 = var_1.getRawData(var_6_15)
	local var_6_17

	if not arg_6_0.contextData.index then
		PlayerPrefs = var_6_17
		var_6_17 = var_6_17.GetInt("AirFightIndex_" .. var_6_16.id, 1)
	end

	arg_6_0.contextData.index = nil

	arg_6_0:SwitchIndex(var_6_17)
	arg_6_0:UpdateView()

	return
end

function var_0_1.willExit(arg_12_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.getRawData(var_12_0)

	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("AirFightIndex_" .. var_12_1.id, arg_12_0.contextData.index)

	PlayerPrefs = var_2

	var_2.Save()

	LeanTween = var_2

	local var_12_2 = var_2.cancel

	go = var_4

	var_12_2(var_4(arg_12_0.currentNameImage))

	LeanTween = var_12_2

	local var_12_3 = var_12_2.cancel

	go = var_4

	var_12_3(var_4(arg_12_0.currentFighterImage))

	LeanTween = var_12_3

	local var_12_4 = var_12_3.cancel

	go = var_4

	local var_12_5 = arg_12_0.currentFighterDesc

	var_12_4(var_4(var_6.Find(var_12_5, "Desc/Text")))

	LeanTween = var_12_4

	local var_12_6 = var_12_4.cancel

	go = var_4

	local var_12_7 = arg_12_0.currentFighterDesc

	var_12_6(var_4(var_6.Find(var_12_7, "Progress")))

	local var_12_8 = arg_12_0.loader

	var_2.Clear(var_12_8)

	return
end

function var_0_1.UpdateView(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.itemList) do
		local var_13_0, var_13_1 = arg_13_0:GetFighterData(iter_13_0)
		local var_13_2 = arg_13_0.itemList[iter_13_0]

		UIItemList = var_9

		local var_13_3 = var_9.StaticAlign
		local var_13_4 = var_13_2:Find("Progress")
		local var_13_5 = var_13_2:Find("Progress")

		var_13_3(var_13_4, var_12.GetChild(var_13_5, 0), var_13_0)
	end

	arg_13_0:UpdateFighter(arg_13_0.contextData.index)

	local var_13_6 = arg_13_0
	local var_13_7, var_13_8 = arg_13_0.GetActivityProgress(var_13_6)

	setText = var_13_6

	var_13_6(arg_13_0.BattleTimes, var_13_8 - var_13_7)
	arg_13_0:CheckActivityUpdate()

	return
end

function var_0_1.SwitchIndex(arg_14_0, arg_14_1)
	if arg_14_1 == nil or arg_14_1 == arg_14_0.contextData.index then
		return
	end

	if arg_14_0.contextData.index then
		local var_14_0 = arg_14_0.itemList[arg_14_0.contextData.index]

		setActive = var_3

		var_3(var_14_0:Find("Selected"), false)

		setImageAlpha = var_3

		var_3(var_14_0:Find("Button"), 0.5)
	end

	arg_14_0.contextData.index = arg_14_1

	local var_14_1 = arg_14_0.itemList[arg_14_0.contextData.index]

	setActive = var_3

	var_3(var_14_1:Find("Selected"), true)

	setImageAlpha = var_3

	var_3(var_14_1:Find("Button"), 1)
	arg_14_0:UpdateFighter(arg_14_1)
	;(function()
		local var_15_0
		local var_15_1 = arg_14_0.currentFighterImage
		local var_15_2 = var_1.GetComponent

		typeof = var_2_10004
		Image = var_2_10006

		local var_15_3 = var_15_2(var_15_1, var_2_10004(var_2_10006))

		tf = var_2_10002

		local var_15_4 = var_2_10002(arg_14_0.currentFighterImage)

		LeanTween = var_15_1

		local var_15_5 = var_15_1.cancel

		go = var_2_10005

		var_15_5(var_2_10005(arg_14_0.currentFighterImage))

		local var_15_6
		local var_15_7 = arg_14_0.currentNameImage
		local var_15_8 = var_4.GetComponent

		typeof = var_7
		Image = var_2_10009

		local var_15_9 = var_15_8(var_15_7, var_7(var_2_10009))

		tf = var_5

		local var_15_10 = var_5(arg_14_0.currentNameImage)

		LeanTween = var_15_7

		local var_15_11 = var_15_7.cancel

		go = var_2_10008

		var_15_11(var_2_10008(arg_14_0.currentNameImage))

		parallelAsync = var_15_11

		var_15_11({
			function(arg_16_0)
				if var_15_3.color.a < 0.05 then
					arg_16_0()

					return
				end

				LeanTween = var_2

				local var_16_0 = var_2.alpha(var_15_4, 0, var_1 * 0.2)
				local var_16_1 = var_2.setOnComplete

				System = var_5

				var_16_1(var_16_0, var_5.Action(arg_16_0))

				return
			end,
			function(arg_17_0)
				if var_15_9.color.a < 0.05 then
					arg_17_0()

					return
				end

				LeanTween = var_2

				local var_17_0 = var_2.alpha(var_15_10, 0, var_1 * 0.2)
				local var_17_1 = var_2.setOnComplete

				System = var_5

				var_17_1(var_17_0, var_5.Action(arg_17_0))

				return
			end,
			function(arg_18_0)
				local var_18_0 = arg_14_0.loader

				var_1.GetSpriteDirect(var_18_0, "ui/AirForceOfDragonEmperyUI_atlas", var_0_2[arg_14_1], function(arg_19_0)
					var_15_0 = arg_19_0

					arg_18_0()

					return
				end, arg_14_0.currentFighterImage)

				return
			end,
			function(arg_20_0)
				local var_20_0 = arg_14_0.loader

				var_1.GetSpriteDirect(var_20_0, "ui/AirForceOfDragonEmperyUI_atlas", var_0_2[arg_14_1] .. "_BG", function(arg_21_0)
					var_15_6 = arg_21_0

					arg_20_0()

					return
				end, arg_14_0.currentNameImage)

				return
			end
		}, function()
			var_15_3.enabled = true

			local var_22_0 = var_15_3

			var_22_0.sprite = var_15_0
			LeanTween = var_22_0

			var_22_0.alpha(var_15_4, 1, 0.2)

			var_15_9.enabled = true

			local var_22_1 = var_15_9

			var_22_1.sprite = var_15_6
			LeanTween = var_22_1

			var_22_1.alpha(var_15_10, 1, 0.2)

			return
		end)

		return
	end)()
	;(function()
		local var_23_0 = arg_14_0.currentFighterDesc
		local var_23_1 = var_0.Find(var_23_0, "Desc/Text")

		LeanTween = var_2_10001

		var_2_10001.cancel(var_23_1)

		local var_23_2 = var_23_1:GetComponent("ScrollText")
		local var_23_3 = var_1.SetText

		i18n = var_4

		var_23_3(var_23_2, var_4(var_0_3[arg_14_1]))

		LeanTween = var_23_3

		local var_23_4 = var_23_3.textAlpha(var_23_1, 1, 0.5)

		var_1.setFrom(var_23_4, 0)

		return
	end)()

	local var_14_2, var_14_3 = arg_14_0:GetFighterData(arg_14_1)
	local var_14_4 = arg_14_0.currentFighterDesc
	local var_14_5 = var_7.Find(var_14_4, "Progress")
	local var_14_6 = arg_14_0.activity
	local var_14_7 = var_8.GetPerLevelProgress(var_14_6)

	UIItemList = var_14_4

	var_14_4.StaticAlign(var_14_5, var_14_5:GetChild(0), var_14_7, function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = not arg_24_0

		UIItemList = var_2_10004

		if var_24_0 == var_2_10004.EventUpdate then
			return
		end

		setActive = var_24_0

		var_24_0(arg_24_2:GetChild(0), arg_24_1 + 1 <= var_14_2)

		local var_24_1 = arg_24_2:GetChild(0)

		Vector3 = var_4
		var_24_1.localScale = var_4(0, 1, 1)

		return
	end)

	LeanTween = var_9

	local var_14_8 = var_9.cancel

	go = var_11

	var_14_8(var_11(var_14_5))

	LeanTween = var_14_8

	local var_14_9 = var_14_8.value

	go = var_11

	local var_14_10 = var_14_9(var_11(var_14_5), 0, 1, var_14_7 * 0.2)
	local var_14_11 = var_9.setOnUpdate

	System = var_12

	var_14_11(var_14_10, var_12.Action_float(function(arg_25_0)
		for iter_25_0 = 0, 2 do
			local var_25_0 = var_14_5
			local var_25_1 = var_5.GetChild(var_25_0, iter_25_0)

			math = var_2_10006
			var_2_10006 = var_2_10006.clamp(var_14_7 * arg_25_0 - iter_25_0, 0, 1)

			local var_25_2 = var_25_1:GetChild(0)

			Vector3 = var_8
			var_25_2.localScale = var_8(var_2_10006, 1, 1)
		end

		return
	end))

	local var_14_12 = arg_14_0.loader
	local var_14_13 = var_9.GetSprite
	local var_14_14 = "ui/AirForceOfDragonEmperyUI_atlas"
	local var_14_15 = var_0_2[arg_14_1] .. "_Text"
	local var_14_16 = arg_14_0.currentFighterDesc

	var_14_13(var_14_12, var_14_14, var_14_15, var_14.Find(var_14_16, "Name"), true)

	return
end

function var_0_1.UpdateFighter(arg_26_0, arg_26_1)
	local var_26_0, var_26_1 = arg_26_0:GetFighterData(arg_26_1)
	local var_26_2 = arg_26_0.itemList[arg_26_1]

	UIItemList = var_5

	local var_26_3 = var_5.StaticAlign
	local var_26_4 = var_26_2:Find("Progress")
	local var_26_5 = var_26_2:Find("Progress")

	var_26_3(var_26_4, var_8.GetChild(var_26_5, 0), var_26_0)

	local var_26_6 = arg_26_0.currentFighterDesc
	local var_26_7 = arg_26_0.activity
	local var_26_8 = var_6.getConfig(var_26_7, "config_client").awards[arg_26_1]
	local var_26_9 = {
		type = var_26_8[1],
		id = var_26_8[2],
		count = var_26_8[3]
	}

	updateDrop = var_8

	var_8(var_26_6:Find("Item"), var_26_9)

	setActive = var_8

	var_8(var_26_6:Find("ItemMask"), var_26_1)

	onButton = var_8

	local var_26_10 = arg_26_0
	local var_26_11 = var_26_6
	local var_26_12 = var_26_6.Find(var_26_11, "Item")

	local function var_26_13()
		local var_27_0 = arg_26_0
		local var_27_1 = var_0.emit

		BaseUI = var_2_10003

		var_27_1(var_27_0, var_2_10003.ON_DROP, var_26_9)

		return
	end

	SFX_PANEL = var_26_11

	var_8(var_26_10, var_26_12, var_26_13, var_26_11)

	return
end

function var_0_1.CheckActivityUpdate(arg_28_0)
	local var_28_0 = arg_28_0.activity
	local var_28_1 = var_1.GetPerLevelProgress(var_28_0)
	local var_28_2 = arg_28_0.activity
	local var_28_3 = var_2.GetLevelCount(var_28_2)

	for iter_28_0 = 1, var_28_3 do
		local var_28_4, var_28_5 = arg_28_0:GetFighterData(iter_28_0)

		if var_28_1 <= var_28_4 and not var_28_5 then
			local var_28_6 = arg_28_0
			local var_28_7 = arg_28_0.emit

			AirForceOfDragonEmperyMediator = var_1_10012

			var_28_7(var_28_6, var_1_10012.ON_ACTIVITY_OPREATION, {
				cmd = 2,
				activity_id = arg_28_0.activity.id,
				arg1 = iter_28_0
			})

			return
		end
	end

	return
end

return var_0_1
