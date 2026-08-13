class = var_0_10000

local var_0_0 = var_0_10000("SailBoatGamingUI")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	SailBoatGameVo = var_1_10003
	var_0_1 = var_1_10003
	findTF = var_1_10003
	arg_1_0._gameUI = var_1_10003(arg_1_0._tf, "ui/gamingUI")
	findTF = var_3
	arg_1_0.btnBack = var_3(arg_1_0._gameUI, "back")
	findTF = var_3
	arg_1_0.btnPause = var_3(arg_1_0._gameUI, "pause")
	findTF = var_3
	arg_1_0.gameTime = var_3(arg_1_0._gameUI, "time")
	findTF = var_3
	arg_1_0.gameScore = var_3(arg_1_0._gameUI, "score")
	findTF = var_3
	arg_1_0.btnSkill = var_3(arg_1_0._gameUI, "skill")
	findTF = var_3
	arg_1_0.skillCount = var_3(arg_1_0._gameUI, "skill/amount")
	GetComponent = var_3
	findTF = var_4

	local var_1_0 = var_4(arg_1_0._gameUI, "progress")

	typeof = var_5
	Slider = var_6
	arg_1_0.progress = var_3(var_1_0, var_5(var_6))
	findTF = var_3
	arg_1_0.powerTf = var_3(arg_1_0._gameUI, "power")
	onButton = var_3

	local var_1_1 = arg_1_0._event
	local var_1_2 = arg_1_0.btnSkill

	local function var_1_3()
		if arg_1_0.skillTime > 0 then
			return
		end

		if var_0_1.UseSkill() then
			local var_2_0 = arg_1_0._event
			local var_2_1 = var_0.emit

			SailBoatGameView = var_2_10002

			var_2_1(var_2_0, var_2_10002.USE_SKILL)

			local var_2_2 = arg_1_0

			var_2_2.skillTime = var_0_1.skillTime
			setActive = var_2_2

			var_2_2(arg_1_0.powerTf, false)

			setActive = var_2_2

			var_2_2(arg_1_0.powerTf, true)
		end

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_1, var_1_2, var_1_3, var_1_10007)

	onButton = var_3

	local var_1_4 = arg_1_0._event
	local var_1_5 = arg_1_0.btnBack

	local function var_1_6()
		local var_3_0 = arg_1_0._event
		local var_3_1 = var_0.emit

		SailBoatGameView = var_2_10002

		var_3_1(var_3_0, var_2_10002.PAUSE_GAME, true)

		local var_3_2 = arg_1_0._event
		local var_3_3 = var_0.emit

		SailBoatGameView = var_2

		var_3_3(var_3_2, var_2.OPEN_LEVEL_UI)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_4, var_1_5, var_1_6, var_1_10007)

	onButton = var_3

	local var_1_7 = arg_1_0._event
	local var_1_8 = arg_1_0.btnPause

	local function var_1_9()
		local var_4_0 = arg_1_0._event
		local var_4_1 = var_0.emit

		SailBoatGameView = var_2_10002

		var_4_1(var_4_0, var_2_10002.PAUSE_GAME, true)

		local var_4_2 = arg_1_0._event
		local var_4_3 = var_0.emit

		SailBoatGameView = var_2

		var_4_3(var_4_2, var_2.OPEN_PAUSE_UI)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_7, var_1_8, var_1_9, var_1_10007)

	Vector2 = var_3
	arg_1_0.direct = var_3(0, 0)
	MiniGameJoyStick = var_3

	local var_1_10 = var_3.New

	findTF = var_4
	arg_1_0.joyStick = var_1_10(var_4(arg_1_0._gameUI, "joyStick"))

	local var_1_11 = arg_1_0.joyStick

	var_3.setActiveCallback(var_1_11, function(arg_5_0)
		return
	end)

	findTF = var_3
	arg_1_0._hpTf = var_3(arg_1_0._gameUI, "hp")
	GetComponent = var_3

	local var_1_12 = arg_1_0._hpTf

	typeof = var_5
	Slider = var_6
	arg_1_0._hpSlider = var_3(var_1_12, var_5(var_6))
	findTF = var_3
	arg_1_0._powerEnemy = var_3(arg_1_0._gameUI, "powerEnemy")

	return
end

function var_0_0.show(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0._gameUI, arg_6_1)

	return
end

function var_0_0.update(arg_7_0)
	return
end

function var_0_0.start(arg_8_0)
	Vector2 = var_1_10001
	arg_8_0.direct = var_1_10001(0, 0)
	arg_8_0.subGameStepTime = 0
	arg_8_0.maxProgress = var_0_1.GetRoundData().progress
	Clone = var_1
	arg_8_0.powers = var_1(var_0_1.GetRoundData().powers)
	setText = var_1

	var_1(arg_8_0.skillCount, var_0_1.GetSkill())

	arg_8_0.skillTime = 0
	arg_8_0._char = nil
	setActive = var_1

	var_1(arg_8_0._powerEnemy, false)

	setActive = var_1

	var_1(arg_8_0.powerTf, false)

	return
end

function var_0_0.addScore(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.num
	local var_9_1 = arg_9_1.pos
	local var_9_2 = arg_9_1.id

	return
end

function var_0_0.step(arg_10_0, arg_10_1)
	if not arg_10_0._char then
		arg_10_0._char = var_0_1.GetGameChar()
		arg_10_0._hpSlider.minValue = 0

		local var_10_0 = arg_10_0._hpSlider

		var_1_10004 = arg_10_0._char
		var_10_0.maxValue = var_3.getMaxHp(var_1_10004)
	end

	local var_10_1 = var_0_1.gameTime
	local var_10_2 = var_0_1.gameStepTime

	setText = var_1_10004

	var_1_10004(arg_10_0.gameScore, var_0_1.scoreNum)

	setText = var_1_10004

	local var_10_3 = arg_10_0.gameTime

	math = var_6

	var_1_10004(var_10_3, var_6.floor(var_10_1))

	arg_10_0.progress.value = var_10_2 / arg_10_0.maxProgress

	local var_10_4 = arg_10_0.joyStick

	var_4.step(var_10_4)

	local var_10_5 = arg_10_0.joyStick

	var_4.setDirectTarget(var_10_5, arg_10_0.direct)

	if arg_10_0.skillTime > 0 then
		arg_10_0.skillTime = arg_10_0.skillTime - arg_10_1
	end

	SailBoatGameVo = var_4

	local var_10_6 = arg_10_0.joyStick

	var_4.joyStickData = var_5.getValue(var_10_6)
	setText = var_4

	var_4(arg_10_0.skillCount, var_0_1.GetSkill())

	local var_10_7 = arg_10_0._char
	local var_10_8 = var_4.getHpPos(var_10_7)

	arg_10_0._hpTf.position = var_10_8
	arg_10_0.powerTf.position = var_10_8

	local var_10_9 = arg_10_0._hpSlider
	local var_10_10 = arg_10_0._char

	var_10_9.value = var_6.getHp(var_10_10)

	for iter_10_0 = #arg_10_0.powers, 1, -1 do
		if var_0_1.gameStepTime > arg_10_0.powers[iter_10_0] then
			table = var_9

			var_9.remove(arg_10_0.powers, iter_10_0)

			setActive = var_9

			var_9(arg_10_0._powerEnemy, false)

			setActive = var_9

			var_9(arg_10_0._powerEnemy, true)
		end
	end

	return
end

function var_0_0.press(arg_11_0, arg_11_1, arg_11_2)
	KeyCode = var_1_10003

	local var_11_0

	if arg_11_1 == var_1_10003.W then
		if arg_11_2 then
			var_11_0 = arg_11_0.direct
			var_11_0.y = 1
		elseif arg_11_0.direct.y == 1 then
			var_11_0 = arg_11_0.direct
			var_11_0.y = 0
		end
	else
		KeyCode = var_11_0

		local var_11_1

		if arg_11_1 == var_11_0.S then
			if arg_11_2 then
				var_11_1 = arg_11_0.direct
				var_11_1.y = -1
			elseif arg_11_0.direct.y == -1 then
				var_11_1 = arg_11_0.direct
				var_11_1.y = 0
			end
		else
			KeyCode = var_11_1

			local var_11_2

			if arg_11_1 == var_11_1.A then
				if arg_11_2 then
					var_11_2 = arg_11_0.direct
					var_11_2.x = -1
				elseif arg_11_0.direct.x == -1 then
					var_11_2 = arg_11_0.direct
					var_11_2.x = 0
				end
			else
				KeyCode = var_11_2

				if arg_11_1 == var_11_2.D then
					if arg_11_2 then
						arg_11_0.direct.x = 1
					elseif arg_11_0.direct.x == 1 then
						arg_11_0.direct.x = 0
					end
				end
			end
		end
	end

	return
end

return var_0_0
