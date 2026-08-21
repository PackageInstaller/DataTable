local var_0_0 = class("PuzzleConnectGame")
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._content = findTF(arg_1_0._tf, "ad/content")
	arg_1_0._pop = findTF(arg_1_0._tf, "ad/pop")
	arg_1_0._animation = GetComponent(arg_1_0._tf, typeof(Animation))
	arg_1_0.cheatCount = 0

	setText(findTF(arg_1_0._tf, "ad/pop/btnOver/text"), i18n("tolovegame_puzzle_pop_finish"))
	setText(findTF(arg_1_0._tf, "ad/pop/btnNext/text"), i18n("tolovegame_puzzle_pop_next"))
	setText(findTF(arg_1_0._tf, "ad/pop/titleDesc"), i18n("tolovegame_puzzle_pop_save"))
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/back"), function()
		arg_1_0._event:emit(PuzzleConnectLayer.OPEN_DETAIL)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/title"), function()
		if arg_1_0.lockCheat then
			return
		end

		arg_1_0.cheatCount = arg_1_0.cheatCount + 1

		if arg_1_0.cheatCount >= 5 then
			arg_1_0.cheatCount = 0
			arg_1_0.lockCheat = true

			if arg_1_0:getState() == PuzzleConnectPlaying.game_state_connect then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tolovegame_puzzle_cheat"))
				arg_1_0:openComplete(var_0_2)
				arg_1_0._animation:Play("anim_puzzle_playing_phase2")
			elseif arg_1_0:getState() == PuzzleConnectPlaying.game_state_puzzle then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tolovegame_puzzle_cheat"))
				arg_1_0:openComplete(var_0_1)
				arg_1_0._animation:Play("anim_puzzle_playing_phase2")
				arg_1_0._event:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
					index = 2,
					config_id = arg_1_0._configData.id
				})
			end
		end

		return
	end, SFX_CONFIRM)

	arg_1_0.lockCheat = false

	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/home"), function()
		arg_1_0._event:emit(BaseUI.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/reset"), function()
		arg_1_0.playingUI:reset()

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0._pop, "btnNext"), function()
		arg_1_0:openPlayUI(arg_1_0:getState())
		arg_1_0._animation:Play("anim_puzzle_playing_phase3")

		arg_1_0.lockCheat = false

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0._pop, "btnOver"), function()
		if arg_1_0._configData.after_story then
			pg.NewStoryMgr.GetInstance():Play(arg_1_0._configData.after_story, function()
				arg_1_0._event:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
					index = 3,
					config_id = arg_1_0._configData.id
				})

				return
			end)
		else
			arg_1_0._event:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
				index = 3,
				config_id = arg_1_0._configData.id
			})
		end

		arg_1_0._event:emit(PuzzleConnectLayer.OPEN_MENU)

		arg_1_0.lockCheat = false

		return
	end, SFX_CANCEL)

	arg_1_0.playingUI = PuzzleConnectPlaying.New(findTF(arg_1_0._tf, "ad/content/PuzzleConnectPlayingUI"))

	arg_1_0.playingUI:addCallback(function()
		arg_1_0:openComplete(var_0_1)
		arg_1_0._animation:Play("anim_puzzle_playing_phase2")
		arg_1_0._event:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
			index = 2,
			config_id = arg_1_0._configData.id
		})

		return
	end, function()
		arg_1_0:openComplete(var_0_2)
		arg_1_0._animation:Play("anim_puzzle_playing_phase2")

		return
	end)

	return
end

function var_0_0.show(arg_11_0)
	setActive(arg_11_0._tf, true)

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
	if arg_14_0._activity then
		if table.contains(arg_14_0._activity.data2_list, arg_14_0._configData.id) then
			return PuzzleConnectPlaying.game_state_connect
		else
			return PuzzleConnectPlaying.game_state_puzzle
		end
	end

	return PuzzleConnectPlaying.game_state_puzzle
end

function var_0_0.openComplete(arg_15_0, arg_15_1)
	setActive(arg_15_0._content, false)
	setActive(arg_15_0._pop, true)

	if arg_15_1 == var_0_1 then
		setActive(findTF(arg_15_0._pop, "bgConnect"), false)
		setActive(findTF(arg_15_0._pop, "bgPuzzle"), true)
		setActive(findTF(arg_15_0._pop, "btnNext"), true)
		setActive(findTF(arg_15_0._pop, "btnOver"), false)
		setActive(findTF(arg_15_0._pop, "btnOver"), false)
		setActive(findTF(arg_15_0._pop, "progress/success/line_2"), true)
		setActive(findTF(arg_15_0._pop, "progress/success/line_3"), false)
		setActive(findTF(arg_15_0._pop, "progress/success/3"), false)
	elseif arg_15_1 == var_0_2 then
		setActive(findTF(arg_15_0._pop, "bgConnect"), true)
		setActive(findTF(arg_15_0._pop, "bgPuzzle"), false)
		setActive(findTF(arg_15_0._pop, "btnNext"), false)
		setActive(findTF(arg_15_0._pop, "btnOver"), true)
		setActive(findTF(arg_15_0._pop, "progress/success/line_2"), true)
		setActive(findTF(arg_15_0._pop, "progress/success/line_3"), true)
		setActive(findTF(arg_15_0._pop, "progress/success/3"), true)
	end

	return
end

function var_0_0.openPlayUI(arg_16_0, arg_16_1)
	setActive(arg_16_0._content, true)
	setActive(arg_16_0._pop, false)
	arg_16_0.playingUI:setData(PuzzleConnectConst.chapter_data[arg_16_0._configData.id], arg_16_1)

	arg_16_0.lockCheat = false

	return
end

function var_0_0.hide(arg_17_0)
	setActive(arg_17_0._tf, false)

	arg_17_0.lockCheat = false

	return
end

function var_0_0.dispose(arg_18_0)
	return
end

return var_0_0
