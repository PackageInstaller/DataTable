local PuzzleConnectGame = class("PuzzleConnectGame")
local var_0_1 = 1
local var_0_2 = 2

function PuzzleConnectGame:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._content = findTF(self._tf, "ad/content")
	self._pop = findTF(self._tf, "ad/pop")
	self._animation = GetComponent(self._tf, typeof(Animation))
	self.cheatCount = 0

	setText(findTF(self._tf, "ad/pop/btnOver/text"), i18n("tolovegame_puzzle_pop_finish"))
	setText(findTF(self._tf, "ad/pop/btnNext/text"), i18n("tolovegame_puzzle_pop_next"))
	setText(findTF(self._tf, "ad/pop/titleDesc"), i18n("tolovegame_puzzle_pop_save"))
	onButton(self._event, findTF(self._tf, "ad/back"), function()
		self._event:emit(PuzzleConnectLayer.OPEN_DETAIL)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self._tf, "ad/title"), function()
		if self.lockCheat then
			return
		end

		self.cheatCount = self.cheatCount + 1

		if self.cheatCount >= 5 then
			self.cheatCount = 0
			self.lockCheat = true

			if self:getState() == PuzzleConnectPlaying.game_state_connect then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tolovegame_puzzle_cheat"))
				self:openComplete(var_0_2)
				self._animation:Play("anim_puzzle_playing_phase2")
			elseif self:getState() == PuzzleConnectPlaying.game_state_puzzle then
				pg.TipsMgr.GetInstance():ShowTips(i18n("tolovegame_puzzle_cheat"))
				self:openComplete(var_0_1)
				self._animation:Play("anim_puzzle_playing_phase2")
				self._event:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
					index = 2,
					config_id = self._configData.id
				})
			end
		end

		return
	end, SFX_CONFIRM)

	self.lockCheat = false

	onButton(self._event, findTF(self._tf, "ad/home"), function()
		self._event:emit(BaseUI.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self._tf, "ad/reset"), function()
		self.playingUI:reset()

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self._pop, "btnNext"), function()
		self:openPlayUI(self:getState())
		self._animation:Play("anim_puzzle_playing_phase3")

		self.lockCheat = false

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self._pop, "btnOver"), function()
		if self._configData.after_story then
			pg.NewStoryMgr.GetInstance():Play(self._configData.after_story, function()
				self._event:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
					index = 3,
					config_id = self._configData.id
				})

				return
			end)
		else
			self._event:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
				index = 3,
				config_id = self._configData.id
			})
		end

		self._event:emit(PuzzleConnectLayer.OPEN_MENU)

		self.lockCheat = false

		return
	end, SFX_CANCEL)

	self.playingUI = PuzzleConnectPlaying.New(findTF(self._tf, "ad/content/PuzzleConnectPlayingUI"))

	self.playingUI:addCallback(function()
		self:openComplete(var_0_1)
		self._animation:Play("anim_puzzle_playing_phase2")
		self._event:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
			index = 2,
			config_id = self._configData.id
		})

		return
	end, function()
		self:openComplete(var_0_2)
		self._animation:Play("anim_puzzle_playing_phase2")

		return
	end)

	return
end

function PuzzleConnectGame:show()
	setActive(self._tf, true)

	return
end

function PuzzleConnectGame:setData(arg_12_1)
	self._data = arg_12_1
	self._configData = arg_12_1.data
	self._index = arg_12_1.index

	self:openPlayUI(self:getState())

	return
end

function PuzzleConnectGame:setActivity(arg_13_1)
	self._activity = arg_13_1

	return
end

function PuzzleConnectGame:getState()
	if self._activity then
		if table.contains(self._activity.data2_list, self._configData.id) then
			return PuzzleConnectPlaying.game_state_connect
		else
			return PuzzleConnectPlaying.game_state_puzzle
		end
	end

	return PuzzleConnectPlaying.game_state_puzzle
end

function PuzzleConnectGame:openComplete(arg_15_1)
	setActive(self._content, false)
	setActive(self._pop, true)

	if arg_15_1 == var_0_1 then
		setActive(findTF(self._pop, "bgConnect"), false)
		setActive(findTF(self._pop, "bgPuzzle"), true)
		setActive(findTF(self._pop, "btnNext"), true)
		setActive(findTF(self._pop, "btnOver"), false)
		setActive(findTF(self._pop, "btnOver"), false)
		setActive(findTF(self._pop, "progress/success/line_2"), true)
		setActive(findTF(self._pop, "progress/success/line_3"), false)
		setActive(findTF(self._pop, "progress/success/3"), false)
	elseif arg_15_1 == var_0_2 then
		setActive(findTF(self._pop, "bgConnect"), true)
		setActive(findTF(self._pop, "bgPuzzle"), false)
		setActive(findTF(self._pop, "btnNext"), false)
		setActive(findTF(self._pop, "btnOver"), true)
		setActive(findTF(self._pop, "progress/success/line_2"), true)
		setActive(findTF(self._pop, "progress/success/line_3"), true)
		setActive(findTF(self._pop, "progress/success/3"), true)
	end

	return
end

function PuzzleConnectGame:openPlayUI(arg_16_1)
	setActive(self._content, true)
	setActive(self._pop, false)
	self.playingUI:setData(PuzzleConnectConst.chapter_data[self._configData.id], arg_16_1)

	self.lockCheat = false

	return
end

function PuzzleConnectGame:hide()
	setActive(self._tf, false)

	self.lockCheat = false

	return
end

function PuzzleConnectGame:dispose()
	return
end

return PuzzleConnectGame
