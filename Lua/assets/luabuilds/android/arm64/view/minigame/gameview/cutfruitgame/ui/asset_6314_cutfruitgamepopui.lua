local CutFruitGamePopUI = class("CutFruitGamePopUI")

function CutFruitGamePopUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3

	self:initCountUI()
	self:initLeavelUI()
	self:initPauseUI()
	self:initSettlementUI()
	self:initSelectUI()

	return
end

function CutFruitGamePopUI:initSelectUI()
	local function var_2_0(arg_3_0)
		if self.selectChar and self.selectChar == arg_3_0 then
			return
		end

		if table.contains(self.selectNpc, arg_3_0) then
			return
		end

		if self.selectChar and self.selectChar > 0 then
			setActive(findTF(self.selectGridList[self.selectChar], "ad/use"), false)
		end

		if arg_3_0 > 0 then
			setActive(findTF(self.selectGridList[arg_3_0], "ad/use"), true)
		end

		GetSpriteFromAtlasAsync(CutFruitGameConst.ui_atlas, "char_" .. arg_3_0, function(arg_4_0)
			setImageSprite(self.selectCharTF, arg_4_0, true)

			return
		end)

		self.selectChar = arg_3_0

		return
	end

	self.selectUI = findTF(self._tf, "pop/SelectUI")

	local var_2_1 = findTF(self.selectUI, "ad/select_list/grid_tpl")

	setActive(var_2_1, false)

	local var_2_2 = findTF(self.selectUI, "ad/select_list")

	self.selectGridList = {}

	for iter_2_0 = 1, CutFruitGameConst.character_num do
		local var_2_3 = iter_2_0
		local var_2_4 = tf(instantiate(var_2_1))

		setActive(var_2_4, true)
		SetParent(var_2_4, var_2_2)
		onButton(self._event, var_2_4, function()
			var_2_0(var_2_3)

			return
		end, SFX_CONFIRM)
		GetSpriteFromAtlasAsync(CutFruitGameConst.ui_atlas, "char_grid_" .. iter_2_0, function(arg_6_0)
			setImageSprite(findTF(var_2_4, "ad/char"), arg_6_0, true)

			return
		end)
		table.insert(self.selectGridList, var_2_4)
	end

	self.selectCharTF = findTF(self.selectUI, "ad/char")
	self.selectStartTF = findTF(self.selectUI, "ad/start")
	self.selectCloseTF = findTF(self.selectUI, "ad/close")

	onButton(self._event, self.selectStartTF, function()
		self._event:emit(SimpleMGEvent.READY_START, {
			char = self.selectChar,
			npc = self.selectNpc
		})
		self:PopSelectUI(false)

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.selectCloseTF, function()
		self._event:emit(SimpleMGEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)

	local var_2_5 = CutFruitGameConst.chapter_data[self._gameVo:GetGameRound()]

	if var_2_5.char ~= 0 then
		self.selectChar = var_2_5.char or math.random(1, CutFruitGameConst.character_num)
	end

	if #var_2_5.npc > 0 then
		self.selectNpc = var_2_5.npc or self:GetNpcRandom(self.selectChar)
	end

	self:updateSelectUI()

	return
end

function CutFruitGamePopUI:updateSelectUI()
	for iter_9_0 = 1, #self.selectGridList do
		local var_9_0 = self.selectGridList[iter_9_0]
		local var_9_1 = iter_9_0

		if self.selectChar and self.selectChar == var_9_1 then
			setActive(findTF(var_9_0, "ad/use"), true)
			GetSpriteFromAtlasAsync(CutFruitGameConst.ui_atlas, "char_" .. var_9_1, function(arg_10_0)
				setImageSprite(self.selectCharTF, arg_10_0, true)

				return
			end)
		else
			setActive(findTF(var_9_0, "ad/use"), false)
		end

		if table.contains(self.selectNpc, var_9_1) then
			setActive(findTF(var_9_0, "ad/npc"), true)
		else
			setActive(findTF(var_9_0, "ad/npc"), false)
		end
	end

	return
end

function CutFruitGamePopUI:GetNpcRandom(arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0 = 1, CutFruitGameConst.character_num do
		if iter_11_0 ~= arg_11_1 then
			table.insert(var_11_1, iter_11_0)
		end
	end

	for iter_11_1 = 1, 2 do
		table.insert(var_11_0, table.remove(var_11_1, math.random(1, #var_11_1)))
	end

	return var_11_0
end

function CutFruitGamePopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(SimpleMGEvent.COUNT_DOWN)

		return
	end)

	return
end

function CutFruitGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnConfirm"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function CutFruitGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	setActive(self.pauseUI, false)
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function CutFruitGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:ClearUI()
		self._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.settlementUI, "ad/btnAgain"), function()
		self:ClearUI()
		self._event:emit(SimpleMGEvent.BACK_MENU, {
			restart = true
		})

		return
	end, SFX_CANCEL)

	return
end

function CutFruitGamePopUI:setChildVisible(arg_23_1, arg_23_2)
	for iter_23_0 = 1, arg_23_1.childCount do
		setActive(arg_23_1:GetChild(iter_23_0 - 1), arg_23_2)
	end

	return
end

function CutFruitGamePopUI:PopSelectUI(arg_24_1)
	setActive(self.selectUI, arg_24_1)

	return
end

function CutFruitGamePopUI:PopPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function CutFruitGamePopUI:PopCountUI(arg_26_1)
	setActive(self.countUI, arg_26_1)

	return
end

function CutFruitGamePopUI:PopSettlementUI(arg_27_1)
	setActive(self.settlementUI, arg_27_1)

	return
end

function CutFruitGamePopUI:PopLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function CutFruitGamePopUI:UpdateSettlementUI()
	local var_29_0 = self._gameVo:GetStepTimeInteger()

	if self._gameVo:GetSuccess() then
		setActive(findTF(self.settlementUI, "ad/1"), true)
		setActive(findTF(self.settlementUI, "ad/2"), false)
		setActive(findTF(self.settlementUI, "ad/currentText"), true)
	else
		setActive(findTF(self.settlementUI, "ad/1"), false)
		setActive(findTF(self.settlementUI, "ad/2"), true)
		setActive(findTF(self.settlementUI, "ad/currentText"), false)
	end

	if var_29_0 < 0 then
		var_29_0 = ""
	end

	setText(findTF(self.settlementUI, "ad/currentText"), var_29_0)
	self._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, var_29_0)

	return
end

function CutFruitGamePopUI:BackPressed()
	if isActive(self.pauseUI) then
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		if not self._gameVo:IsSettlement() then
			self:PopPauseUI()
			self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		end
	else
		self:ResumeGame()
	end

	return
end

function CutFruitGamePopUI:ResumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function CutFruitGamePopUI:UpdateGameUI(arg_32_1)
	setText(self.scoreTf, arg_32_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_32_1.gameTime))

	return
end

function CutFruitGamePopUI:ReadyStart()
	self:PopCountUI(true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(CutFruitGameConst.SFX_COUNT_DOWN)

	return
end

function CutFruitGamePopUI:ClearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return CutFruitGamePopUI
