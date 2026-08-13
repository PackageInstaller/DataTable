class = var_0_10000

local var_0_0 = var_0_10000("LaunchBallGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
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
	onButton = var_3

	local var_1_0 = arg_1_0._event
	local var_1_1 = arg_1_0.btnBack

	local function var_1_2()
		local var_2_0 = arg_1_0._event
		local var_2_1 = var_0.emit

		LaunchBallGameView = var_2_10002

		var_2_1(var_2_0, var_2_10002.PAUSE_GAME, true)

		local var_2_2 = arg_1_0._event
		local var_2_3 = var_0.emit

		LaunchBallGameView = var_2

		var_2_3(var_2_2, var_2.OPEN_LEVEL_UI)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_0, var_1_1, var_1_2, var_1_10007)

	onButton = var_3

	local var_1_3 = arg_1_0._event
	local var_1_4 = arg_1_0.btnPause

	local function var_1_5()
		local var_3_0 = arg_1_0._event
		local var_3_1 = var_0.emit

		LaunchBallGameView = var_2_10002

		var_3_1(var_3_0, var_2_10002.PAUSE_GAME, true)

		local var_3_2 = arg_1_0._event
		local var_3_3 = var_0.emit

		LaunchBallGameView = var_2

		var_3_3(var_3_2, var_2.OPEN_PAUSE_UI)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_3(var_1_3, var_1_4, var_1_5, var_1_10007)

	Vector2 = var_3
	arg_1_0.direct = var_3(0, 0)
	findTF = var_3
	arg_1_0.skill = var_3(arg_1_0._gameUI, "Skill")
	GetComponent = var_3
	findTF = var_4

	local var_1_6 = var_4(arg_1_0.skill, "ad/anim")

	typeof = var_5
	Animator = var_6
	arg_1_0.skillAnim = var_3(var_1_6, var_5(var_6))
	onButton = var_3

	var_3(arg_1_0._event, arg_1_0.skill, function()
		local var_4_0 = arg_1_0._event
		local var_4_1 = var_0.emit

		LaunchBallGameView = var_2_10002

		var_4_1(var_4_0, var_2_10002.PRESS_SKILL)

		return
	end)

	findTF = var_3
	arg_1_0.skillCd = var_3(arg_1_0.skill, "ad/black")

	return
end

function var_0_0.show(arg_5_0, arg_5_1)
	setActive = var_1_10002

	var_1_10002(arg_5_0._gameUI, arg_5_1)

	return
end

function var_0_0.update(arg_6_0)
	return
end

function var_0_0.start(arg_7_0)
	Vector2 = var_1_10001
	arg_7_0.direct = var_1_10001(0, 0)
	arg_7_0.subGameStepTime = 0

	return
end

function var_0_0.addScore(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.num
	local var_8_1 = arg_8_1.pos
	local var_8_2 = arg_8_1.id

	return
end

function var_0_0.step(arg_9_0)
	LaunchBallGameVo = var_1_10001

	local var_9_0

	if var_1_10001.enemyStopTime then
		LaunchBallGameVo = var_9_0
		var_9_0 = var_9_0.enemyStopTime

		if 0 < var_9_0 then
			var_9_0 = arg_9_0.subGameStepTime
			LaunchBallGameVo = var_2
			arg_9_0.subGameStepTime = var_9_0 + var_2.deltaTime
		end
	end

	setText = var_9_0

	local var_9_1 = arg_9_0.gameTime

	math = var_1_10003

	local var_9_2 = var_1_10003.floor

	LaunchBallGameVo = var_1_10004

	var_9_0(var_9_1, var_9_2(var_1_10004.gameStepTime - arg_9_0.subGameStepTime))

	setText = var_9_0

	local var_9_3 = arg_9_0.gameScore

	LaunchBallGameVo = var_3

	var_9_0(var_9_3, var_3.scoreNum)

	LaunchBallGameVo = var_9_0

	if var_9_0.pressSkill and var_1.time > 0 then
		setFillAmount = var_9_3

		var_9_3(arg_9_0.skillCd, var_1.time / var_1.data.cd_time)

		isActive = var_9_3

		if not var_9_3(arg_9_0.skillCd) then
			local var_9_4 = arg_9_0.skillAnim

			var_9_3.Play(var_9_4, "empty")

			setActive = var_9_3

			var_9_3(arg_9_0.skillCd, true)
		end
	else
		isActive = var_9_3

		if var_9_3(arg_9_0.skillCd) then
			setActive = var_2

			var_2(arg_9_0.skillCd, false)

			local var_9_5 = arg_9_0.skillAnim

			var_2.Play(var_9_5, "Skill")
		end
	end

	return
end

function var_0_0.press(arg_10_0, arg_10_1, arg_10_2)
	KeyCode = var_1_10003

	local var_10_0

	if arg_10_1 == var_1_10003.W then
		if arg_10_2 then
			var_10_0 = arg_10_0.direct
			var_10_0.y = 1
		elseif arg_10_0.direct.y == 1 then
			var_10_0 = arg_10_0.direct
			var_10_0.y = 0
		end
	end

	KeyCode = var_10_0

	local var_10_1

	if arg_10_1 == var_10_0.S then
		if arg_10_2 then
			var_10_1 = arg_10_0.direct
			var_10_1.y = -1
		elseif arg_10_0.direct.y == -1 then
			var_10_1 = arg_10_0.direct
			var_10_1.y = 0
		end
	end

	KeyCode = var_10_1

	local var_10_2

	if arg_10_1 == var_10_1.A then
		if arg_10_2 then
			var_10_2 = arg_10_0.direct
			var_10_2.x = -1
		elseif arg_10_0.direct.x == -1 then
			var_10_2 = arg_10_0.direct
			var_10_2.x = 0
		end
	end

	KeyCode = var_10_2

	if arg_10_1 == var_10_2.D then
		if arg_10_2 then
			arg_10_0.direct.x = 1
		elseif arg_10_0.direct.x == 1 then
			arg_10_0.direct.x = 0
		end
	end

	return
end

return var_0_0
