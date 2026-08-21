local var_0_0 = class("CutFruitGamePopUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initPauseUI()
	arg_1_0:initSettlementUI()
	arg_1_0:initSelectUI()

	return
end

function var_0_0.initSelectUI(arg_2_0)
	local function var_2_0(arg_3_0)
		if arg_2_0.selectChar and arg_2_0.selectChar == arg_3_0 then
			return
		end

		if table.contains(arg_2_0.selectNpc, arg_3_0) then
			return
		end

		if arg_2_0.selectChar and arg_2_0.selectChar > 0 then
			setActive(findTF(arg_2_0.selectGridList[arg_2_0.selectChar], "ad/use"), false)
		end

		if arg_3_0 > 0 then
			setActive(findTF(arg_2_0.selectGridList[arg_3_0], "ad/use"), true)
		end

		GetSpriteFromAtlasAsync(CutFruitGameConst.ui_atlas, "char_" .. arg_3_0, function(arg_4_0)
			setImageSprite(arg_2_0.selectCharTF, arg_4_0, true)

			return
		end)

		arg_2_0.selectChar = arg_3_0

		return
	end

	arg_2_0.selectUI = findTF(arg_2_0._tf, "pop/SelectUI")

	local var_2_1 = findTF(arg_2_0.selectUI, "ad/select_list/grid_tpl")

	setActive(var_2_1, false)

	local var_2_2 = findTF(arg_2_0.selectUI, "ad/select_list")

	arg_2_0.selectGridList = {}

	for iter_2_0 = 1, CutFruitGameConst.character_num do
		local var_2_3 = iter_2_0
		local var_2_4 = tf(instantiate(var_2_1))

		setActive(var_2_4, true)
		SetParent(var_2_4, var_2_2)
		onButton(arg_2_0._event, var_2_4, function()
			var_2_0(var_2_3)

			return
		end, SFX_CONFIRM)
		GetSpriteFromAtlasAsync(CutFruitGameConst.ui_atlas, "char_grid_" .. iter_2_0, function(arg_6_0)
			setImageSprite(findTF(var_2_4, "ad/char"), arg_6_0, true)

			return
		end)
		table.insert(arg_2_0.selectGridList, var_2_4)
	end

	arg_2_0.selectCharTF = findTF(arg_2_0.selectUI, "ad/char")
	arg_2_0.selectStartTF = findTF(arg_2_0.selectUI, "ad/start")
	arg_2_0.selectCloseTF = findTF(arg_2_0.selectUI, "ad/close")

	onButton(arg_2_0._event, arg_2_0.selectStartTF, function()
		arg_2_0._event:emit(SimpleMGEvent.READY_START, {
			char = arg_2_0.selectChar,
			npc = arg_2_0.selectNpc
		})
		arg_2_0:PopSelectUI(false)

		return
	end, SFX_CONFIRM)
	onButton(arg_2_0._event, arg_2_0.selectCloseTF, function()
		arg_2_0._event:emit(SimpleMGEvent.CLOSE_GAME)

		return
	end, SFX_CANCEL)

	local var_2_5 = CutFruitGameConst.chapter_data[arg_2_0._gameVo:GetGameRound()]

	if var_2_5.char ~= 0 then
		arg_2_0.selectChar = var_2_5.char or math.random(1, CutFruitGameConst.character_num)

		if #var_2_5.npc > 0 then
			arg_2_0.selectNpc = var_2_5.npc or arg_2_0:GetNpcRandom(arg_2_0.selectChar)

			arg_2_0:updateSelectUI()

			return
		end
	end
end

function var_0_0.updateSelectUI(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.selectGridList do
		local var_9_0 = arg_9_0.selectGridList[iter_9_0]
		local var_9_1 = iter_9_0

		if arg_9_0.selectChar and arg_9_0.selectChar == var_9_1 then
			setActive(findTF(var_9_0, "ad/use"), true)
			GetSpriteFromAtlasAsync(CutFruitGameConst.ui_atlas, "char_" .. var_9_1, function(arg_10_0)
				setImageSprite(arg_9_0.selectCharTF, arg_10_0, true)

				return
			end)
		else
			setActive(findTF(var_9_0, "ad/use"), false)
		end

		if table.contains(arg_9_0.selectNpc, var_9_1) then
			setActive(findTF(var_9_0, "ad/npc"), true)
		else
			setActive(findTF(var_9_0, "ad/npc"), false)
		end
	end

	return
end

function var_0_0.GetNpcRandom(arg_11_0, arg_11_1)
	for iter_11_0 = 1, CutFruitGameConst.character_num do
		if iter_11_0 ~= arg_11_1 then
			table.insert({}, iter_11_0)
		end
	end

	for iter_11_1 = 1, 2 do
		table.insert({}, table.remove({}, math.random(1, #{})))
	end

	return {}
end

function var_0_0.initCountUI(arg_12_0)
	arg_12_0.countUI = findTF(arg_12_0._tf, "pop/CountUI")
	arg_12_0.countAnimator = GetComponent(findTF(arg_12_0.countUI, "count"), typeof(Animator))
	arg_12_0.countDft = GetOrAddComponent(findTF(arg_12_0.countUI, "count"), typeof(DftAniEvent))

	arg_12_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_12_0.countDft:SetEndEvent(function()
		arg_12_0._event:emit(SimpleMGEvent.COUNT_DOWN)

		return
	end)

	return
end

function var_0_0.initLeavelUI(arg_15_0)
	arg_15_0.leaveUI = findTF(arg_15_0._tf, "pop/LeaveUI")

	setActive(arg_15_0.leaveUI, false)
	onButton(arg_15_0._event, findTF(arg_15_0.leaveUI, "ad/btnConfirm"), function()
		arg_15_0:ResumeGame()
		arg_15_0._event:emit(SimpleMGEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(arg_15_0._event, findTF(arg_15_0.leaveUI, "ad/btnCancel"), function()
		arg_15_0:ResumeGame()
		arg_15_0._event:emit(SimpleMGEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initPauseUI(arg_18_0)
	arg_18_0.pauseUI = findTF(arg_18_0._tf, "pop/pauseUI")

	setActive(arg_18_0.pauseUI, false)
	onButton(arg_18_0._event, findTF(arg_18_0.pauseUI, "ad/btnOk"), function()
		arg_18_0:ResumeGame()
		arg_18_0._event:emit(SimpleMGEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initSettlementUI(arg_20_0)
	arg_20_0.settlementUI = findTF(arg_20_0._tf, "pop/SettleMentUI")

	setActive(arg_20_0.settlementUI, false)
	onButton(arg_20_0._event, findTF(arg_20_0.settlementUI, "ad/btnOver"), function()
		arg_20_0:ClearUI()
		arg_20_0._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)
	onButton(arg_20_0._event, findTF(arg_20_0.settlementUI, "ad/btnAgain"), function()
		arg_20_0:ClearUI()
		arg_20_0._event:emit(SimpleMGEvent.BACK_MENU, {
			restart = true
		})

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.setChildVisible(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0 = 1, arg_23_1.childCount do
		setActive(arg_23_1:GetChild(iter_23_0 - 1), arg_23_2)
	end

	return
end

function var_0_0.PopSelectUI(arg_24_0, arg_24_1)
	setActive(arg_24_0.selectUI, arg_24_1)

	return
end

function var_0_0.PopPauseUI(arg_25_0)
	if isActive(arg_25_0.leaveUI) then
		setActive(arg_25_0.leaveUI, false)
	end

	setActive(arg_25_0.pauseUI, true)

	return
end

function var_0_0.PopCountUI(arg_26_0, arg_26_1)
	setActive(arg_26_0.countUI, arg_26_1)

	return
end

function var_0_0.PopSettlementUI(arg_27_0, arg_27_1)
	setActive(arg_27_0.settlementUI, arg_27_1)

	return
end

function var_0_0.PopLeaveUI(arg_28_0)
	if isActive(arg_28_0.pauseUI) then
		setActive(arg_28_0.pauseUI, false)
	end

	setActive(arg_28_0.leaveUI, true)

	return
end

function var_0_0.UpdateSettlementUI(arg_29_0)
	local var_29_0 = arg_29_0._gameVo:GetStepTimeInteger()

	if arg_29_0._gameVo:GetSuccess() then
		setActive(findTF(arg_29_0.settlementUI, "ad/1"), true)
		setActive(findTF(arg_29_0.settlementUI, "ad/2"), false)
		setActive(findTF(arg_29_0.settlementUI, "ad/currentText"), true)
	else
		setActive(findTF(arg_29_0.settlementUI, "ad/1"), false)
		setActive(findTF(arg_29_0.settlementUI, "ad/2"), true)
		setActive(findTF(arg_29_0.settlementUI, "ad/currentText"), false)
	end

	local var_29_1 = findTF(arg_29_0.settlementUI, "ad/currentText")

	if var_29_0 < 0 then
		var_29_0 = ""
	end

	setText(var_29_1, var_29_0)
	arg_29_0._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, var_29_0)

	return
end

function var_0_0.BackPressed(arg_30_0)
	if isActive(arg_30_0.pauseUI) then
		arg_30_0:ResumeGame()
		arg_30_0._event:emit(SimpleMGEvent.PAUSE_GAME, false)
	elseif isActive(arg_30_0.leaveUI) then
		arg_30_0:ResumeGame()
		arg_30_0._event:emit(SimpleMGEvent.LEVEL_GAME, false)
	elseif not isActive(arg_30_0.pauseUI) and not isActive(arg_30_0.pauseUI) then
		if not arg_30_0._gameVo:IsSettlement() then
			arg_30_0:PopPauseUI()
			arg_30_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		end
	else
		arg_30_0:ResumeGame()
	end

	return
end

function var_0_0.ResumeGame(arg_31_0)
	setActive(arg_31_0.leaveUI, false)
	setActive(arg_31_0.pauseUI, false)

	return
end

function var_0_0.UpdateGameUI(arg_32_0, arg_32_1)
	setText(arg_32_0.scoreTf, arg_32_1.scoreNum)
	setText(arg_32_0.gameTimeS, math.ceil(arg_32_1.gameTime))

	return
end

function var_0_0.ReadyStart(arg_33_0)
	arg_33_0:PopCountUI(true)
	arg_33_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(CutFruitGameConst.SFX_COUNT_DOWN)

	return
end

function var_0_0.ClearUI(arg_34_0)
	setActive(arg_34_0.settlementUI, false)
	setActive(arg_34_0.countUI, false)

	return
end

return var_0_0
