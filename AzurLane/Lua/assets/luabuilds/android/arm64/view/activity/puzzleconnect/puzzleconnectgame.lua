class = var_0_10000

local var_0_0 = var_0_10000("PuzzleConnectGame")
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0._content = var_1_10003(arg_1_0._tf, "ad/content")
	findTF = var_3
	arg_1_0._pop = var_3(arg_1_0._tf, "ad/pop")
	GetComponent = var_3

	local var_1_0 = arg_1_0._tf

	typeof = var_6
	Animation = var_1_10008
	arg_1_0._animation = var_3(var_1_0, var_6(var_1_10008))
	arg_1_0.cheatCount = 0
	setText = var_3
	findTF = var_1_0

	local var_1_1 = var_1_0(arg_1_0._tf, "ad/pop/btnOver/text")

	i18n = var_6

	var_3(var_1_1, var_6("tolovegame_puzzle_pop_finish"))

	setText = var_3
	findTF = var_1_1

	local var_1_2 = var_1_1(arg_1_0._tf, "ad/pop/btnNext/text")

	i18n = var_6

	var_3(var_1_2, var_6("tolovegame_puzzle_pop_next"))

	setText = var_3
	findTF = var_1_2

	local var_1_3 = var_1_2(arg_1_0._tf, "ad/pop/titleDesc")

	i18n = var_6

	var_3(var_1_3, var_6("tolovegame_puzzle_pop_save"))

	onButton = var_3

	local var_1_4 = arg_1_0._event

	findTF = var_6

	local var_1_5 = var_6(arg_1_0._tf, "ad/back")

	local function var_1_6()
		local var_2_0 = arg_1_0._event
		local var_2_1 = var_0.emit

		PuzzleConnectLayer = var_2_10003

		var_2_1(var_2_0, var_2_10003.OPEN_DETAIL)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_4, var_1_5, var_1_6, var_8)

	onButton = var_3

	local var_1_7 = arg_1_0._event

	findTF = var_1_5

	local var_1_8 = var_1_5(arg_1_0._tf, "ad/title")

	local function var_1_9()
		if arg_1_0.lockCheat then
			return
		end

		arg_1_0.cheatCount = arg_1_0.cheatCount + 1

		if arg_1_0.cheatCount >= 5 then
			arg_1_0.cheatCount = 0
			arg_1_0.lockCheat = true

			local var_3_0 = arg_1_0
			local var_3_1 = var_0.getState(var_3_0)

			PuzzleConnectPlaying = var_1

			if var_3_1 == var_1.game_state_connect then
				pg = var_3_1

				local var_3_2 = var_3_1.TipsMgr.GetInstance()
				local var_3_3 = var_0.ShowTips

				i18n = var_2_10003

				var_3_3(var_3_2, var_2_10003("tolovegame_puzzle_cheat"))

				local var_3_4 = arg_1_0

				var_0.openComplete(var_3_4, var_0_2)

				local var_3_5 = arg_1_0._animation

				var_0.Play(var_3_5, "anim_puzzle_playing_phase2")
			else
				local var_3_6 = arg_1_0
				local var_3_7 = var_0.getState(var_3_6)

				PuzzleConnectPlaying = var_1

				if var_3_7 == var_1.game_state_puzzle then
					pg = var_3_7

					local var_3_8 = var_3_7.TipsMgr.GetInstance()
					local var_3_9 = var_0.ShowTips

					i18n = var_2_10003

					var_3_9(var_3_8, var_2_10003("tolovegame_puzzle_cheat"))

					local var_3_10 = arg_1_0

					var_0.openComplete(var_3_10, var_0_1)

					local var_3_11 = arg_1_0._animation

					var_0.Play(var_3_11, "anim_puzzle_playing_phase2")

					local var_3_12 = arg_1_0._event
					local var_3_13 = var_0.emit

					PuzzleConnectMediator = var_3

					var_3_13(var_3_12, var_3.CMD_ACTIVITY, {
						index = 2,
						config_id = arg_1_0._configData.id
					})
				end
			end
		end

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_1_7, var_1_8, var_1_9, var_8)

	arg_1_0.lockCheat = false
	onButton = var_3

	local var_1_10 = arg_1_0._event

	findTF = var_1_8

	local var_1_11 = var_1_8(arg_1_0._tf, "ad/home")

	local function var_1_12()
		local var_4_0 = arg_1_0._event
		local var_4_1 = var_0.emit

		BaseUI = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_HOME)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_10, var_1_11, var_1_12, var_8)

	onButton = var_3

	local var_1_13 = arg_1_0._event

	findTF = var_1_11

	local var_1_14 = var_1_11(arg_1_0._tf, "ad/reset")

	local function var_1_15()
		local var_5_0 = arg_1_0.playingUI

		var_0.reset(var_5_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_13, var_1_14, var_1_15, var_8)

	onButton = var_3

	local var_1_16 = arg_1_0._event

	findTF = var_1_14

	local var_1_17 = var_1_14(arg_1_0._pop, "btnNext")

	local function var_1_18()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.openPlayUI
		local var_6_2 = arg_1_0

		var_6_1(var_6_0, var_3.getState(var_6_2))

		local var_6_3 = arg_1_0._animation

		var_0.Play(var_6_3, "anim_puzzle_playing_phase3")

		arg_1_0.lockCheat = false

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_16, var_1_17, var_1_18, var_8)

	onButton = var_3

	local var_1_19 = arg_1_0._event

	findTF = var_1_17

	local var_1_20 = var_1_17(arg_1_0._pop, "btnOver")

	local function var_1_21()
		if arg_1_0._configData.after_story then
			pg = var_0

			local var_7_0 = var_0.NewStoryMgr.GetInstance()

			var_0.Play(var_7_0, arg_1_0._configData.after_story, function()
				local var_8_0 = arg_1_0._event
				local var_8_1 = var_0.emit

				PuzzleConnectMediator = var_3_10003

				var_8_1(var_8_0, var_3_10003.CMD_ACTIVITY, {
					index = 3,
					config_id = arg_1_0._configData.id
				})

				return
			end)
		else
			local var_7_1 = arg_1_0._event
			local var_7_2 = var_0.emit

			PuzzleConnectMediator = var_2_10003

			var_7_2(var_7_1, var_2_10003.CMD_ACTIVITY, {
				index = 3,
				config_id = arg_1_0._configData.id
			})
		end

		local var_7_3 = arg_1_0._event
		local var_7_4 = var_0.emit

		PuzzleConnectLayer = var_2_10003

		var_7_4(var_7_3, var_2_10003.OPEN_MENU)

		arg_1_0.lockCheat = false

		return
	end

	SFX_CANCEL = var_8

	var_3(var_1_19, var_1_20, var_1_21, var_8)

	PuzzleConnectPlaying = var_3

	local var_1_22 = var_3.New

	findTF = var_1_19
	arg_1_0.playingUI = var_1_22(var_1_19(arg_1_0._tf, "ad/content/PuzzleConnectPlayingUI"))

	local var_1_23 = arg_1_0.playingUI

	var_3.addCallback(var_1_23, function()
		local var_9_0 = arg_1_0

		var_0.openComplete(var_9_0, var_0_1)

		local var_9_1 = arg_1_0._animation

		var_0.Play(var_9_1, "anim_puzzle_playing_phase2")

		local var_9_2 = arg_1_0._event
		local var_9_3 = var_0.emit

		PuzzleConnectMediator = var_3

		var_9_3(var_9_2, var_3.CMD_ACTIVITY, {
			index = 2,
			config_id = arg_1_0._configData.id
		})

		return
	end, function()
		local var_10_0 = arg_1_0

		var_0.openComplete(var_10_0, var_0_2)

		local var_10_1 = arg_1_0._animation

		var_0.Play(var_10_1, "anim_puzzle_playing_phase2")

		return
	end)

	return
end

function var_0_0.show(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0._tf, true)

	return
end

function var_0_0.setData(arg_12_0, arg_12_1)
	arg_12_0._data = arg_12_1
	arg_12_0._configData = arg_12_1.data
	arg_12_0._index = arg_12_1.index

	arg_12_0:openPlayUI(arg_12_0:getState())

	return
end

function var_0_0.setActivity(arg_13_0, arg_13_1)
	arg_13_0._activity = arg_13_1

	return
end

function var_0_0.getState(arg_14_0)
	local var_14_0

	if arg_14_0._activity then
		var_14_0 = arg_14_0._activity.data2_list
		table = var_1_10002

		if var_1_10002.contains(var_14_0, arg_14_0._configData.id) then
			PuzzleConnectPlaying = var_2

			return var_2.game_state_connect
		else
			PuzzleConnectPlaying = var_2

			return var_2.game_state_puzzle
		end
	end

	PuzzleConnectPlaying = var_14_0

	return var_14_0.game_state_puzzle
end

function var_0_0.openComplete(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0._content, false)

	setActive = var_1_10002

	var_1_10002(arg_15_0._pop, true)

	if arg_15_1 == var_0_1 then
		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "bgConnect"), false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "bgPuzzle"), true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "btnNext"), true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "btnOver"), false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "btnOver"), false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "progress/success/line_2"), true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "progress/success/line_3"), false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "progress/success/3"), false)
	elseif arg_15_1 == var_0_2 then
		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "bgConnect"), true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "bgPuzzle"), false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "btnNext"), false)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "btnOver"), true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "progress/success/line_2"), true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "progress/success/line_3"), true)

		setActive = var_2
		findTF = var_4

		var_2(var_4(arg_15_0._pop, "progress/success/3"), true)
	end

	return
end

function var_0_0.openPlayUI(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0._content, true)

	setActive = var_1_10002

	var_1_10002(arg_16_0._pop, false)

	local var_16_0 = arg_16_0.playingUI
	local var_16_1 = var_2.setData

	PuzzleConnectConst = var_5

	var_16_1(var_16_0, var_5.chapter_data[arg_16_0._configData.id], arg_16_1)

	arg_16_0.lockCheat = false

	return
end

function var_0_0.hide(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0._tf, false)

	arg_17_0.lockCheat = false

	return
end

function var_0_0.dispose(arg_18_0)
	return
end

return var_0_0
