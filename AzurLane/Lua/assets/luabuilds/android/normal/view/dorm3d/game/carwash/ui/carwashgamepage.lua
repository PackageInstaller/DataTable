class = var_0_10000

local var_0_0 = "CarWashGamePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_1.GUN_COUNT = 3

function var_0_1.Init(arg_1_0)
	arg_1_0:InitConfig()
	arg_1_0:InitUI()
	arg_1_0:BindEvent()

	return
end

function var_0_1.InitConfig(arg_2_0)
	_ = var_1_10001
	arg_2_0.posConfig = var_1_10001.map(arg_2_0.contextData.gameConfig.pos, function(arg_3_0)
		pg = var_2_10001

		return var_2_10001.dorm3d_carwash_pos[arg_3_0]
	end)
	arg_2_0.selectPosIndex = 1
	_ = var_1
	arg_2_0.posUnlock = var_1.map(arg_2_0.posConfig, function(arg_4_0)
		return arg_4_0.mood_value <= arg_2_0.contextData.gameStatus.heartBeatValue
	end)
	_ = var_1
	arg_2_0.heartBeatDotVals = var_1.map(arg_2_0.posConfig, function(arg_5_0)
		return arg_5_0.mood_value
	end)
	table = var_1

	var_1.insert(arg_2_0.heartBeatDotVals, 100)

	return
end

function var_0_1.InitUI(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf

	var_1_10001(var_6_0, var_3.Find(var_6_1, "bottom/btn_shoot"), function()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		CarWashGameFlowSystem = var_2_10002

		var_7_1(var_7_0, var_2_10002.SWITCH_SHOOTING)

		setActive = var_7_1

		local var_7_2 = arg_6_0._tf

		var_7_1(var_1.Find(var_7_2, "bottom/btn_shoot/on"), arg_6_0.contextData.gameStatus.isShooting)

		setActive = var_7_1

		local var_7_3 = arg_6_0._tf

		var_7_1(var_1.Find(var_7_3, "bottom/btn_shoot/off"), not arg_6_0.contextData.gameStatus.isShooting)

		return
	end)

	UIItemList = var_1_10001

	local var_6_2 = var_1_10001.New
	local var_6_3 = arg_6_0._tf
	local var_6_4 = var_2.Find(var_6_3, "bottom/guns")
	local var_6_5 = arg_6_0._tf

	arg_6_0.gunList = var_6_2(var_6_4, var_3.Find(var_6_5, "bottom/guns/gun1"))

	local var_6_6 = arg_6_0.gunList

	var_1.make(var_6_6, function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventInit then
			onButton = var_3

			var_3(arg_6_0, arg_8_2, function()
				if arg_6_0.contextData.gameStatus.isShooting then
					return
				end

				if arg_6_0.contextData.gameStatus.currentGunType == arg_8_1 then
					return
				end

				local var_9_0 = arg_6_0
				local var_9_1 = var_0.emit

				CarWashGameFlowSystem = var_3_10002

				var_9_1(var_9_0, var_3_10002.SWITCH_GUN_TYPE, arg_8_1)

				return
			end)
		else
			UIItemList = var_3

			if arg_8_0 == var_3.EventUpdate then
				local var_8_0 = arg_6_0.contextData.gameStatus.currentGunType == arg_8_1

				setActive = var_2_10004

				var_2_10004(arg_8_2:Find("select"), var_8_0)

				setActive = var_2_10004

				var_2_10004(arg_8_2:Find("unselect"), not var_8_0)
			end
		end

		return
	end)

	local var_6_7 = arg_6_0.gunList

	var_1.align(var_6_7, var_0_1.GUN_COUNT)

	UIItemList = var_1

	local var_6_8 = var_1.New
	local var_6_9 = arg_6_0._tf
	local var_6_10 = var_2.Find(var_6_9, "left/cams")
	local var_6_11 = arg_6_0._tf

	arg_6_0.camsList = var_6_8(var_6_10, var_3.Find(var_6_11, "left/cams/camTpl"))

	local var_6_12 = arg_6_0.camsList

	var_1.make(var_6_12, function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_1 = arg_10_1 + 1
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventInit then
			onButton = var_3

			var_3(arg_6_0, arg_10_2, function()
				if arg_6_0.posUnlock[arg_10_1] and arg_6_0.selectPosIndex ~= arg_10_1 then
					arg_6_0.selectPosIndex = arg_10_1

					local var_11_0 = arg_6_0

					var_0.Flush(var_11_0)

					local var_11_1 = arg_6_0
					local var_11_2 = var_0.emit

					CarWashTimelineSystem = var_3_10002

					local var_11_3 = var_3_10002.PLAY_TRANSITION
					local var_11_4 = {
						waitHold = true
					}

					CarWashTimelineSystem = var_3_10004
					var_11_4.type = var_3_10004.TRANSITION.BLACK

					function var_11_4.onHold(arg_12_0, arg_12_1)
						local var_12_0 = arg_6_0
						local var_12_1 = var_2.emit

						CarWashGameFlowSystem = var_4_10004

						var_12_1(var_12_0, var_4_10004.SWITCH_LADY_POS, arg_6_0.posConfig[arg_6_0.selectPosIndex].id)
						arg_12_0()

						return
					end

					var_11_2(var_11_1, var_11_3, var_11_4)
				end

				return
			end)
		else
			UIItemList = var_3

			if arg_10_0 == var_3.EventUpdate then
				local var_10_0 = arg_6_0.posUnlock[arg_10_1]
				local var_10_1 = arg_6_0.selectPosIndex == arg_10_1

				setActive = var_2_10005

				var_2_10005(arg_10_2:Find("lock"), not var_10_0)

				setActive = var_2_10005

				var_2_10005(arg_10_2:Find("normal"), var_10_0 and not var_10_1)

				setActive = var_2_10005

				var_2_10005(arg_10_2:Find("select"), var_10_1)
			end
		end

		return
	end)

	local var_6_13 = arg_6_0.camsList

	var_1.align(var_6_13, #arg_6_0.posConfig)

	UIItemList = var_1

	local var_6_14 = var_1.New
	local var_6_15 = arg_6_0._tf
	local var_6_16 = var_2.Find(var_6_15, "left/favor/bar_root")
	local var_6_17 = arg_6_0._tf

	arg_6_0.favorList = var_6_14(var_6_16, var_3.Find(var_6_17, "left/favor/bar_root/bar"))

	local var_6_18 = arg_6_0.favorList

	var_1.make(var_6_18, function(arg_13_0, arg_13_1, arg_13_2)
		arg_13_1 = arg_13_1 + 2
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = arg_6_0.heartBeatDotVals[arg_13_1] - arg_6_0.heartBeatDotVals[arg_13_1 - 1]

			math = var_2_10006

			local var_13_1 = var_2_10006.max
			local var_13_2 = 0

			math = var_2_10008

			local var_13_3 = var_13_1(var_13_2, var_2_10008.min(arg_6_0.contextData.gameStatus.heartBeatValue - var_4, var_13_0)) / var_13_0
			local var_13_4 = arg_13_2
			local var_13_5 = arg_13_2.GetComponent

			typeof = var_10
			Slider = var_2_10011

			local var_13_6 = var_13_5(var_13_4, var_10(var_2_10011))

			var_13_6.value = var_13_3
			setActive = var_13_6

			var_13_6(arg_13_2:Find("dot/fill"), var_6 == var_13_0)

			setActive = var_13_6

			var_13_6(arg_13_2:Find("mask/Vx_bar"), var_13_3 > 0 and var_13_3 < 1)
		end

		return
	end)

	local var_6_19 = arg_6_0.favorList

	var_1.align(var_6_19, #arg_6_0.heartBeatDotVals - 1)

	local var_6_20 = arg_6_0._tf

	arg_6_0.cleanPersentText = var_1.Find(var_6_20, "top/clean/clean_rate")

	local var_6_21 = arg_6_0._tf

	arg_6_0.cleanRank = var_1.Find(var_6_21, "top/clean/rank")

	local var_6_22 = arg_6_0._tf

	arg_6_0.timeText = var_1.Find(var_6_22, "top/clean/time")

	local var_6_23 = arg_6_0
	local var_6_24 = arg_6_0.UpdateTimeText

	CarWashConst = var_3

	var_6_24(var_6_23, var_3.GAME_DURATION)

	setText = var_6_24

	local var_6_25 = arg_6_0._tf
	local var_6_26 = var_2.Find(var_6_25, "left/favor/text")

	i18n = var_6_25

	var_6_24(var_6_26, var_6_25("dorm3d_carwash_mood"))

	setText = var_6_24

	local var_6_27 = arg_6_0._tf
	local var_6_28 = var_2.Find(var_6_27, "top/clean/clean_text")

	i18n = var_6_27

	var_6_24(var_6_28, var_6_27("dorm3d_carwash_clean"))

	return
end

function var_0_1.BindEvent(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.bind

	CarWashGameFlowSystem = var_1_10003

	var_14_1(var_14_0, var_1_10003.UPDATE_COUNTDOWN, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_14_0

		var_2.UpdateTimeText(var_15_0, arg_15_1.remainingSeconds)

		return
	end)

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.bind

	CarWashGameFlowSystem = var_3

	var_14_3(var_14_2, var_3.UPDATE_HEART_BEAT_VALUE, function(arg_16_0, arg_16_1)
		ipairs = var_2_10002

		for iter_16_0, iter_16_1 in var_2_10002(arg_14_0.posConfig) do
			if not arg_14_0.posUnlock[iter_16_0] and iter_16_1.mood_value <= arg_16_1.newValue then
				arg_14_0.posUnlock[iter_16_0] = true

				local var_16_0 = arg_14_0._tf
				local var_16_1 = var_7.Find(var_16_0, "left/cams")
				local var_16_2 = var_7.GetChild(var_16_1, iter_16_0 - 1)

				triggerButton = var_16_1

				var_16_1(var_16_2)

				local var_16_3 = var_16_2
				local var_16_4 = var_16_2.GetComponent

				typeof = var_2_10010
				Animation = var_2_10011

				local var_16_5 = var_16_4(var_16_3, var_2_10010(var_2_10011))

				var_8.Play(var_16_5, "anim_Dorm3dCarWashUI_lock_out")
			end
		end

		local var_16_6 = arg_14_0

		var_2.Flush(var_16_6)

		return
	end)

	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.bind

	CarWashGameFlowSystem = var_3

	var_14_5(var_14_4, var_3.UPDATE_STAINS_COUNT, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_14_0

		var_2.FlushCleanPersent(var_17_0)

		return
	end)

	local var_14_6 = arg_14_0
	local var_14_7 = arg_14_0.bind

	CarWashGameFlowSystem = var_3

	var_14_7(var_14_6, var_3.UPDATE_CURRENT_GUN_TYPE, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_14_0

		var_2.Flush(var_18_0)

		return
	end)

	local var_14_8 = arg_14_0
	local var_14_9 = arg_14_0.bind

	CarWashGameFlowSystem = var_3

	var_14_9(var_14_8, var_3.UPDATE_GAME_STATE, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_1.newValue

		CarWashConst = var_2_10003

		local var_19_1

		if var_19_0 == var_2_10003.GAME_STATE.PHASE_1 then
			var_19_1 = arg_14_0

			var_2.Show(var_19_1)

			goto label_19_0
		end

		local var_19_2 = arg_19_1.newValue

		CarWashConst = var_19_1

		if var_19_2 ~= var_19_1.GAME_STATE.PHASE_2 then
			do
				local var_19_3 = arg_19_1.newValue

				CarWashConst = var_3

				if var_19_3 == var_3.GAME_STATE.END then
					local var_19_4 = arg_14_0

					var_2.Hide(var_19_4)
				end
			end

			::label_19_0::

			return
		end
	end)

	return
end

function var_0_1.UpdateTimeText(arg_20_0, arg_20_1)
	setText = var_1_10002

	var_1_10002(arg_20_0.timeText, arg_20_0:FormatTime(arg_20_1))

	return
end

function var_0_1.FormatTime(arg_21_0, arg_21_1)
	math = var_1_10002
	arg_21_1 = var_1_10002.max(arg_21_1 or 0, 0)
	math = var_2

	local var_21_0 = var_2.floor(arg_21_1 / 60)
	local var_21_1 = arg_21_1 % 60

	string = var_4

	return var_4.format("%02d:%02d", var_21_0, var_21_1)
end

function var_0_1.Flush(arg_22_0)
	local var_22_0 = arg_22_0.gunList

	var_1.align(var_22_0, var_0_1.GUN_COUNT)

	local var_22_1 = arg_22_0.camsList

	var_1.align(var_22_1, #arg_22_0.posConfig)

	local var_22_2 = arg_22_0.favorList

	var_1.align(var_22_2, #arg_22_0.heartBeatDotVals - 1)
	arg_22_0:FlushCleanPersent()

	return
end

function var_0_1.FlushCleanPersent(arg_23_0)
	local var_23_0 = arg_23_0:GetCleanPersent()
	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.GetRank(var_23_1, var_23_0)

	setText = var_23_1

	var_23_1(arg_23_0.cleanPersentText, var_23_0 .. "%")

	eachChild = var_23_1

	var_23_1(arg_23_0.cleanRank, function(arg_24_0)
		setActive = var_2_10001

		var_2_10001(arg_24_0, arg_24_0.name == var_23_2)

		return
	end)

	return
end

function var_0_1.GetCleanPersent(arg_25_0)
	if arg_25_0.contextData.gameStatus.stainsCountMax == 0 then
		return 0
	end

	local var_25_0 = 1 - arg_25_0.contextData.gameStatus.stainsCount / arg_25_0.contextData.gameStatus.stainsCountMax

	math = var_2

	return (var_2.floor(var_25_0 * 100))
end

function var_0_1.GetRank(arg_26_0, arg_26_1)
	CarWashConst = var_1_10002

	return var_1_10002.GetScoreRank(arg_26_1)
end

return var_0_1
