class = var_0_10000

local var_0_0 = "ActivityBossTotalRewardPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.level.BaseTotalRewardPanel"))

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossTotalRewardPanel"
end

local var_0_2 = 0.15

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0.boxView

	arg_2_0.itemList = var_1.Find(var_2_0, "Content/ItemGrid2")
	setText = var_1

	local var_2_1 = arg_2_0.window
	local var_2_2 = var_2.Find(var_2_1, "Fixed/top/bg/obtain/title")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("autofight_rewards"))

	setText = var_1

	local var_2_3 = arg_2_0.window
	local var_2_4 = var_2.Find(var_2_3, "Fixed/ButtonGO/pic")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("text_confirm"))

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf, {
		lockGlobalBlur = true
	})

	local var_3_1 = arg_3_0

	arg_3_0.UpdateView(var_3_1)

	local var_3_2 = arg_3_0.contextData.isAutoFight

	PlayerPrefs = var_3_1

	local var_3_3 = var_3_1.GetInt

	AUTO_BATTLE_LABEL = var_3

	local var_3_4 = var_3_3(var_3, 0)
	local var_3_5 = 0 < var_3_4

	if var_3_2 and var_3_5 then
		pg = var_3

		local var_3_6 = var_3.CriMgr.GetInstance()
		local var_3_7 = var_3.PlaySoundEffect_V3

		SFX_AUTO_BATTLE = var_1_10005

		var_3_7(var_3_6, var_1_10005)

		LuaHelper = var_3_7

		var_3_7.Vibrate()
	end

	return
end

function var_0_1.willExit(arg_4_0)
	arg_4_0:SkipAnim()

	pg = var_1

	local var_4_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.UpdateView(arg_5_0)
	local var_5_0 = arg_5_0.contextData

	onButton = var_1_10002

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0._tf

	var_1_10002(var_5_1, var_4.Find(var_5_2, "BG"), function()
		if arg_5_0.isRewardAnimating then
			local var_6_0 = arg_5_0

			var_0.SkipAnim(var_6_0)

			return
		end

		existCall = var_0

		var_0(var_5_0.onClose)

		local var_6_1 = arg_5_0

		var_0.closeView(var_6_1)

		return
	end)

	onButton = var_1_10002

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.window
	local var_5_5 = var_4.Find(var_5_4, "Fixed/ButtonGO")

	local function var_5_6()
		existCall = var_2_10000

		var_2_10000(var_5_0.onClose)

		local var_7_0 = arg_5_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CONFIRM = var_6

	var_1_10002(var_5_3, var_5_5, var_5_6, var_6)

	local var_5_7 = var_5_0.rewards
	local var_5_8 = {}
	local var_5_10

	if var_5_7 then
		::label_5_0::

		local var_5_9 = #var_5_7

		var_5_10 = 0 < var_5_9
	end

	CustomIndexLayer = var_5_6

	local var_5_11 = var_5_6.Clone2Full(arg_5_0.itemList, #var_5_7)

	ipairs = var_6

	for iter_5_0, iter_5_1 in var_6(var_5_11) do
		var_1_10011 = var_5_7[iter_5_0]

		local var_5_12 = var_5_11[iter_5_0]

		updateDrop = var_1_10013

		var_1_10013(var_5_12:Find("Icon"), var_1_10011)

		onButton = var_1_10013

		local var_5_13 = arg_5_0
		local var_5_14 = var_5_12:Find("Icon")

		local function var_5_15()
			local var_8_0 = arg_5_0
			local var_8_1 = var_0.emit

			BaseUI = var_2_10002

			var_8_1(var_8_0, var_2_10002.ON_DROP, var_1_10011)

			return
		end

		SFX_PANEL = var_17

		var_1_10013(var_5_13, var_5_14, var_5_15, var_17)
	end

	if var_5_10 then
		arg_5_0.isRewardAnimating = true

		for iter_5_2 = 1, #var_5_7 do
			iter_5_1 = var_5_11[iter_5_2]
			setActive = var_1_10011

			var_1_10011(iter_5_1, false)

			table = var_1_10011

			var_1_10011.insert(var_5_8, function(arg_9_0)
				if arg_5_0.exited then
					return
				end

				setActive = var_1

				var_1(iter_5_1, true)

				scrollTo = var_1

				local var_9_0 = arg_5_0.boxView

				var_1(var_2.Find(var_9_0, "Content"), {
					y = 0
				})

				local var_9_1 = arg_5_0

				LeanTween = var_2

				local var_9_2 = var_2.delayedCall
				local var_9_3 = var_0_2

				System = var_4
				var_9_1.LTid = var_9_2(var_9_3, var_4.Action(arg_9_0)).uniqueId

				return
			end)
		end
	end

	local var_5_16 = {}
	local var_5_17

	if not arg_5_0.contextData.stopReason then
		if arg_5_0.contextData.isAutoFight then
			table = var_5_17
			var_5_17 = var_5_17.insert

			local var_5_18 = var_5_16

			i18n = iter_5_1

			var_5_17(var_5_18, iter_5_1("multiple_sorties_finish"))
		else
			table = var_5_17
			var_5_17 = var_5_17.insert

			local var_5_19 = var_5_16

			i18n = iter_5_1

			var_5_17(var_5_19, iter_5_1("multiple_sorties_stop"))
		end
	else
		table = var_5_17
		var_5_17 = var_5_17.insert

		local var_5_20 = var_5_16

		iter_5_1 = var_7
		i18n = var_1_10011

		var_5_17(var_5_20, iter_5_1 .. var_1_10011("multiple_sorties_stop_tip_end"))
	end

	table = var_5_17

	local var_5_21 = var_5_17.insert
	local var_5_22 = var_5_16

	i18n = iter_5_1

	var_5_21(var_5_22, iter_5_1("multiple_sorties_end_status", arg_5_0.contextData.totalBattleTimes, arg_5_0.contextData.totalBattleTimes - arg_5_0.contextData.continuousBattleTimes))

	if #var_5_16 > 0 then
		setText = var_8

		local var_5_23 = arg_5_0.boxView
		local var_5_24 = var_9.Find(var_5_23, "Content/TextArea2/Text")

		table = var_5_23

		var_8(var_5_24, var_5_23.concat(var_5_16, "\n"))
	end

	arg_5_0:ShowShips(var_5_7)

	seriesAsync = var_8

	var_8(var_5_8, function()
		local var_10_0 = arg_5_0

		var_0.SkipAnim(var_10_0)

		return
	end)

	return
end

function var_0_1.ShowShips(arg_11_0, arg_11_1, arg_11_2)
	_ = var_1_10003

	local var_11_0 = #var_1_10003.filter(arg_11_1, function(arg_12_0)
		local var_12_0 = arg_12_0.type

		DROP_TYPE_SHIP = var_2_10002

		return var_12_0 == var_2_10002
	end)

	getProxy = var_4
	BayProxy = var_5

	local var_11_1 = var_4(var_5)
	local var_11_2 = var_4.getNewShip(var_11_1, true)
	local var_11_3 = {}

	math = var_6

	for iter_11_0 = var_6.max(1, #var_11_2 - var_11_0 + 1), #var_11_2 do
		local var_11_4 = var_11_2[iter_11_0]

		PlayerPrefs = var_1_10011
		var_1_10011 = var_1_10011.GetInt
		DISPLAY_SHIP_GET_EFFECT = var_1_10012

		if var_1_10011(var_1_10012) ~= 1 then
			if not var_11_4.virgin then
				var_1_10012 = var_11_4
				var_1_10011 = var_11_4.getRarity(var_1_10012)
				ShipRarity = var_1_10012

				if not (var_1_10012.Purple <= var_1_10011) then
					var_1_10011 = false

					goto label_11_0
				end

				var_1_10011 = true
			end

			::label_11_0::

			print = var_1_10012

			var_1_10012(var_1_10011)

			if var_1_10011 then
				table = var_1_10012

				var_1_10012.insert(var_11_3, function(arg_13_0)
					print = var_2_10001

					var_2_10001("eeeeeeeeeeeee")

					local var_13_0 = arg_11_0
					local var_13_1 = var_1.emit

					ActivityBossTotalRewardPanelMediator = var_2_10003

					var_13_1(var_13_0, var_2_10003.GET_NEW_SHIP, var_11_4, arg_13_0)

					return
				end)
			end
		end
	end

	seriesAsync = var_6

	var_6(var_11_3, arg_11_2)

	return
end

function var_0_1.SkipAnim(arg_14_0)
	if not arg_14_0.isRewardAnimating then
		return
	end

	arg_14_0.isRewardAnimating = nil

	if arg_14_0.LTid then
		LeanTween = var_1

		var_1.cancel(arg_14_0.LTid)

		arg_14_0.LTid = nil
	end

	eachChild = var_1

	var_1(arg_14_0.itemList, function(arg_15_0)
		setActive = var_2_10001

		var_2_10001(arg_15_0, true)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_16_0)
	existCall = var_1_10001

	var_1_10001(arg_16_0.contextData.onClose)
	arg_16_0:closeView()

	return
end

return var_0_1
