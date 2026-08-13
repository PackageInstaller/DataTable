class = var_0_10000

local var_0_0 = "BossRushTotalRewardPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.worldboss.ActivityBossTotalRewardPanel"))

function var_0_1.getUIName(arg_1_0)
	return "BossRushTotalRewardPanel"
end

local var_0_2 = 0.15

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

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

function var_0_1.UpdateView(arg_4_0)
	local var_4_0 = arg_4_0.contextData

	onButton = var_1_10002

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0._tf

	var_1_10002(var_4_1, var_4.Find(var_4_2, "BG"), function()
		if arg_4_0.isRewardAnimating then
			local var_5_0 = arg_4_0

			var_0.SkipAnim(var_5_0)

			return
		end

		existCall = var_0

		var_0(var_4_0.onClose)

		local var_5_1 = arg_4_0

		var_0.closeView(var_5_1)

		return
	end)

	setText = var_1_10002

	local var_4_3 = arg_4_0.window
	local var_4_4 = var_3.Find(var_4_3, "Fixed/ButtonGO/pic")

	i18n = var_4_3

	var_1_10002(var_4_4, var_4_3("text_confirm"))

	onButton = var_1_10002

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0.window
	local var_4_7 = var_4.Find(var_4_6, "Fixed/ButtonGO")

	local function var_4_8()
		existCall = var_2_10000

		var_2_10000(var_4_0.onClose)

		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CONFIRM = var_6

	var_1_10002(var_4_5, var_4_7, var_4_8, var_6)

	setText = var_1_10002

	local var_4_9 = arg_4_0.window
	local var_4_10 = var_3.Find(var_4_9, "Fixed/ButtonExit/pic")

	i18n = var_4_9

	var_1_10002(var_4_10, var_4_9("autofight_leave"))

	onButton = var_1_10002

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0.window
	local var_4_13 = var_4.Find(var_4_12, "Fixed/ButtonExit")

	local function var_4_14()
		existCall = var_2_10000

		var_2_10000(var_4_0.onClose)

		local var_7_0 = arg_4_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_6

	var_1_10002(var_4_11, var_4_13, var_4_14, var_6)

	local var_4_15 = var_4_0.rewards
	local var_4_16 = {}

	setActive = var_4_13

	local var_4_17 = arg_4_0.boxView

	var_4_13(var_5.Find(var_4_17, "Content/TextArea2"), arg_4_0.contextData.totalBattleTimes)

	local var_4_19

	if var_4_15 then
		::label_4_0::

		local var_4_18 = #var_4_15

		var_4_19 = 0 < var_4_18
	end

	CustomIndexLayer = var_5

	local var_4_20 = var_5.Clone2Full(arg_4_0.itemList, #var_4_15)

	ipairs = var_6

	for iter_4_0, iter_4_1 in var_6(var_4_20) do
		var_1_10011 = var_4_15[iter_4_0]

		local var_4_21 = var_4_20[iter_4_0]

		updateDrop = var_1_10013

		var_1_10013(var_4_21:Find("Icon"), var_1_10011)

		onButton = var_1_10013

		local var_4_22 = arg_4_0
		local var_4_23 = var_4_21:Find("Icon")

		local function var_4_24()
			local var_8_0 = arg_4_0
			local var_8_1 = var_0.emit

			BaseUI = var_2_10002

			var_8_1(var_8_0, var_2_10002.ON_DROP, var_1_10011)

			return
		end

		SFX_PANEL = var_17

		var_1_10013(var_4_22, var_4_23, var_4_24, var_17)
	end

	if var_4_19 then
		arg_4_0.isRewardAnimating = true

		for iter_4_2 = 1, #var_4_15 do
			iter_4_1 = var_4_20[iter_4_2]
			setActive = var_1_10011

			var_1_10011(iter_4_1, false)

			table = var_1_10011

			var_1_10011.insert(var_4_16, function(arg_9_0)
				if arg_4_0.exited then
					return
				end

				setActive = var_1

				var_1(iter_4_1, true)

				scrollTo = var_1

				local var_9_0 = arg_4_0.boxView

				var_1(var_2.Find(var_9_0, "Content"), {
					y = 0
				})

				local var_9_1 = arg_4_0

				LeanTween = var_2

				local var_9_2 = var_2.delayedCall
				local var_9_3 = var_0_2

				System = var_4
				var_9_1.LTid = var_9_2(var_9_3, var_4.Action(arg_9_0)).uniqueId

				return
			end)
		end
	end

	local var_4_25 = {}
	local var_4_26

	if not arg_4_0.contextData.stopReason then
		if arg_4_0.contextData.isAutoFight then
			table = var_4_26
			var_4_26 = var_4_26.insert

			local var_4_27 = var_4_25

			i18n = iter_4_1

			var_4_26(var_4_27, iter_4_1("multiple_sorties_finish"))
		else
			table = var_4_26
			var_4_26 = var_4_26.insert

			local var_4_28 = var_4_25

			i18n = iter_4_1

			var_4_26(var_4_28, iter_4_1("multiple_sorties_stop"))
		end
	else
		table = var_4_26

		local var_4_29 = var_4_26.insert
		local var_4_30 = var_4_25

		iter_4_1 = var_7
		i18n = var_1_10011

		var_4_29(var_4_30, iter_4_1 .. var_1_10011("multiple_sorties_stop_tip_end"))
	end

	if arg_4_0.contextData.totalBattleTimes then
		table = var_8

		local var_4_31 = var_8.insert
		local var_4_32 = var_4_25

		i18n = iter_4_1

		var_4_31(var_4_32, iter_4_1("multiple_sorties_end_status", arg_4_0.contextData.totalBattleTimes, arg_4_0.contextData.totalBattleTimes - arg_4_0.contextData.continuousBattleTimes))

		if #var_4_25 > 0 then
			setText = var_8

			local var_4_33 = arg_4_0.boxView
			local var_4_34 = var_9.Find(var_4_33, "Content/TextArea2/Text")

			table = var_4_33

			var_8(var_4_34, var_4_33.concat(var_4_25, "\n"))
		end
	end

	arg_4_0:ShowShips(var_4_15)

	seriesAsync = var_8

	var_8(var_4_16, function()
		local var_10_0 = arg_4_0

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
					local var_13_0 = arg_11_0
					local var_13_1 = var_1.emit

					BossRushTotalRewardPanelMediator = var_2_10003

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

function var_0_1.willExit(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.m02
	local var_14_1 = var_1.sendNotification

	BossRushTotalRewardPanelMediator = var_1_10003

	var_14_1(var_14_0, var_1_10003.ON_WILL_EXIT)

	return
end

return var_0_1
