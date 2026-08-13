class = var_0_10000

local var_0_0 = var_0_10000("PipeGamingUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	PipeGameVo = var_1_10003
	var_0_1 = var_1_10003
	findTF = var_1_10003
	arg_1_0._gameUI = var_1_10003(arg_1_0._tf, "ui/gamingUI")
	findTF = var_3
	arg_1_0.btnBack = var_3(arg_1_0._gameUI, "back")
	findTF = var_3
	arg_1_0.btnPause = var_3(arg_1_0._gameUI, "pause")
	findTF = var_3
	arg_1_0.gameTime = var_3(arg_1_0._gameUI, "time")
	onButton = var_3

	local var_1_0 = arg_1_0._event
	local var_1_1 = arg_1_0.btnBack

	local function var_1_2()
		if not var_0_1.startSettlement then
			local var_2_0 = arg_1_0._event
			local var_2_1 = var_0.emit

			PipeGameEvent = var_2_10003

			var_2_1(var_2_0, var_2_10003.PAUSE_GAME, true)

			local var_2_2 = arg_1_0._event
			local var_2_3 = var_0.emit

			PipeGameEvent = var_3

			var_2_3(var_2_2, var_3.OPEN_LEVEL_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10008

	var_3(var_1_0, var_1_1, var_1_2, var_1_10008)

	onButton = var_3

	local var_1_3 = arg_1_0._event
	local var_1_4 = arg_1_0.btnPause

	local function var_1_5()
		if not var_0_1.startSettlement then
			local var_3_0 = arg_1_0._event
			local var_3_1 = var_0.emit

			PipeGameEvent = var_2_10003

			var_3_1(var_3_0, var_2_10003.PAUSE_GAME, true)

			local var_3_2 = arg_1_0._event
			local var_3_3 = var_0.emit

			PipeGameEvent = var_3

			var_3_3(var_3_2, var_3.OPEN_PAUSE_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10008

	var_3(var_1_3, var_1_4, var_1_5, var_1_10008)

	return
end

function var_0_0.show(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0._gameUI, arg_4_1)

	return
end

function var_0_0.update(arg_5_0)
	return
end

function var_0_0.start(arg_6_0)
	arg_6_0.subGameStepTime = 0

	arg_6_0:show(true)

	return
end

function var_0_0.addScore(arg_7_0, arg_7_1)
	return
end

function var_0_0.step(arg_8_0, arg_8_1)
	local var_8_0 = var_0_1.gameDragTime

	setText = var_1_10003

	local var_8_1 = arg_8_0.gameTime

	math = var_1_10006

	var_1_10003(var_8_1, var_1_10006.floor(var_8_0))

	if var_8_0 <= 0 then
		arg_8_0:show(false)
	elseif var_0_1.startSettlement then
		isActive = var_3

		if var_3(arg_8_0._gameUI) then
			arg_8_0:show(false)
		end
	end

	return
end

function var_0_0.press(arg_9_0, arg_9_1, arg_9_2)
	return
end

return var_0_0
