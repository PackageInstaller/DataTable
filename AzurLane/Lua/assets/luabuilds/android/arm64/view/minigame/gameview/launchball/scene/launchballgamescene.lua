local var_0_0 = class("LaunchBallGameScene")
local var_0_5 = 90
local var_0_6 = {
	{
		tpl = "pointer01"
	},
	{
		tpl = "pointer02"
	},
	{
		tpl = "pointer03"
	},
	{
		tpl = "pointer04"
	},
	{
		tpl = "pointer05"
	},
	{
		tpl = "pointer06"
	},
	{
		tpl = "pointer07"
	}
}

var_0_0.PLAYING_CHANGE = "playing change"
var_0_0.FIRE_AMULET = "fire amulet"
var_0_0.ENEMY_FINISH = "enemy finish"
var_0_0.HIT_ENEMY = "hit enemy"
var_0_0.RANDOM_FIRE = "random fire"
var_0_0.CHANGE_AMULET = "change amulet"
var_0_0.CONCENTRATE_TRIGGER = "concentrate trigger"
var_0_0.SLEEP_TIME_TRIGGER = "sleep time trigger"
var_0_0.SPILT_ENEMY_SCORE = "spilt enemy score"
var_0_0.SPLIT_ALL_ENEMYS = "split all enemys"
var_0_0.STOP_ENEMY_TIME = "stop enemy time"
var_0_0.SPLIT_BUFF_ENEMY = "split buff enemy"
var_0_0.SLASH_ENEMY = "slash enemy"
var_0_0.PLAYER_EFFECT = "player effect"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.sceneMask = findTF(arg_1_0._tf, "sceneMask")
	arg_1_0.tplContent = findTF(arg_1_0._tf, "sceneMask/sceneContainer/scene/tpl")
	arg_1_0.contentBack = findTF(arg_1_0._tf, "sceneMask/sceneContainer/scene_background/content")
	arg_1_0.contentMid = findTF(arg_1_0._tf, "sceneMask/sceneContainer/scene/content")
	arg_1_0.contentTop = findTF(arg_1_0._tf, "sceneMask/sceneContainer/scene_front/content")
	arg_1_0.contentEF = findTF(arg_1_0._tf, "sceneMask/sceneContainer/scene/effect_front")
	arg_1_0.playerContent = findTF(arg_1_0.contentTop, "player")
	arg_1_0.amuletContent = findTF(arg_1_0.contentTop, "amulet")
	arg_1_0.amuletsContent = findTF(arg_1_0.contentTop, "amulets")
	arg_1_0.amuletLifeContent = findTF(arg_1_0.contentTop, "amuletLifeContent")
	arg_1_0.enemyContent = findTF(arg_1_0.contentMid, "enemy")
	arg_1_0.lineContent = findTF(arg_1_0.contentMid, "line")
	arg_1_0.joyStick = LaunchBallGameJoyStick.New(findTF(arg_1_0.contentTop, "joyStick"))

	arg_1_0.joyStick:setActiveCallback(function(arg_2_0)
		arg_1_0:joystickActive(arg_2_0)

		return
	end)

	local var_1_0 = Clone(LaunchBallGameConst.map_data[LaunchBallGameVo.gameRoundData.map].map)
	local var_1_1 = findTF(arg_1_0.contentBack, "bg")
	local var_1_2 = findTF(arg_1_0.contentTop, "bg")

	for iter_1_0 = 0, var_1_1.childCount - 1 do
		local var_1_3 = var_1_1:GetChild(iter_1_0)

		setActive(var_1_3, var_1_3.name == var_1_0)
	end

	for iter_1_1 = 0, var_1_2.childCount - 1 do
		local var_1_4 = var_1_2:GetChild(iter_1_1)

		setActive(var_1_4, var_1_4.name == var_1_0)
	end

	for iter_1_2 = 0, arg_1_0.lineContent.childCount - 1 do
		setActive(arg_1_0.lineContent:GetChild(iter_1_2), false)
	end

	arg_1_0.launchBallAmulet = LaunchBallAmulet.New(arg_1_0.amuletContent, arg_1_0.amuletsContent, arg_1_0.amuletLifeContent, arg_1_0.tplContent, function(arg_3_0, arg_3_1)
		arg_1_0.launchBallAmulet:eventCall(arg_3_0, arg_3_1)
		arg_1_0.launchBallPlayer:eventCall(arg_3_0, arg_3_1)
		arg_1_0.launchBallEnemy:eventCall(arg_3_0, arg_3_1)

		if arg_3_0 == LaunchBallGameScene.ENEMY_FINISH then
			arg_1_0._event:emit(LaunchBallGameView.GAME_OVER)
		elseif arg_3_0 == LaunchBallGameScene.SPILT_ENEMY_SCORE then
			arg_1_0._event:emit(LaunchBallGameView.ADD_SCORE, arg_3_1)
		elseif arg_3_0 == LaunchBallGameScene.SLASH_ENEMY then
			arg_1_0.timeSlashDirect = arg_3_1.direct
			arg_1_0.timeSlash = arg_3_1.time
		end

		return
	end)
	arg_1_0.launchBallPlayer = LaunchBallPlayerControl.New(arg_1_0.contentTop, arg_1_0.playerContent, arg_1_0.tplContent, function(arg_3_0, arg_3_1)
		arg_1_0.launchBallAmulet:eventCall(arg_3_0, arg_3_1)
		arg_1_0.launchBallPlayer:eventCall(arg_3_0, arg_3_1)
		arg_1_0.launchBallEnemy:eventCall(arg_3_0, arg_3_1)

		if arg_3_0 == LaunchBallGameScene.ENEMY_FINISH then
			arg_1_0._event:emit(LaunchBallGameView.GAME_OVER)
		elseif arg_3_0 == LaunchBallGameScene.SPILT_ENEMY_SCORE then
			arg_1_0._event:emit(LaunchBallGameView.ADD_SCORE, arg_3_1)
		elseif arg_3_0 == LaunchBallGameScene.SLASH_ENEMY then
			arg_1_0.timeSlashDirect = arg_3_1.direct
			arg_1_0.timeSlash = arg_3_1.time
		end

		return
	end)
	arg_1_0.launchBallEnemy = LaunchBallEnemy.New(arg_1_0.enemyContent, arg_1_0.lineContent, arg_1_0.tplContent, function(arg_3_0, arg_3_1)
		arg_1_0.launchBallAmulet:eventCall(arg_3_0, arg_3_1)
		arg_1_0.launchBallPlayer:eventCall(arg_3_0, arg_3_1)
		arg_1_0.launchBallEnemy:eventCall(arg_3_0, arg_3_1)

		if arg_3_0 == LaunchBallGameScene.ENEMY_FINISH then
			arg_1_0._event:emit(LaunchBallGameView.GAME_OVER)
		elseif arg_3_0 == LaunchBallGameScene.SPILT_ENEMY_SCORE then
			arg_1_0._event:emit(LaunchBallGameView.ADD_SCORE, arg_3_1)
		elseif arg_3_0 == LaunchBallGameScene.SLASH_ENEMY then
			arg_1_0.timeSlashDirect = arg_3_1.direct
			arg_1_0.timeSlash = arg_3_1.time
		end

		return
	end)
	arg_1_0.pointerContent = arg_1_0.pointerContent or findTF(arg_1_0.contentTop, "pointer")

	if not arg_1_0.pointerCollider then
		arg_1_0.pointerCollider = findTF(arg_1_0.contentTop, "collider")

		setActive(arg_1_0.pointerCollider, false)
	end

	return
end

local var_0_7 = 50
local var_0_8 = 500 / 50

function var_0_0.start(arg_4_0)
	arg_4_0:prepareScene()
	arg_4_0.launchBallAmulet:start()
	arg_4_0.launchBallPlayer:start()
	arg_4_0.launchBallEnemy:start()

	arg_4_0.pointerRotation = Vector3(0, 0, 0)
	arg_4_0.pointerPosition = Vector2(0, 0)

	for iter_4_0 = 0, arg_4_0.pointerContent.childCount - 1 do
		setActive(arg_4_0.pointerContent:GetChild(iter_4_0), false)
	end

	arg_4_0.timeSlash = nil

	return
end

function var_0_0.step(arg_5_0)
	arg_5_0.joyStick:step()

	LaunchBallGameVo.joyStickData = arg_5_0.joyStick:getValue()

	arg_5_0.launchBallAmulet:step()
	arg_5_0.launchBallPlayer:step()
	arg_5_0.launchBallEnemy:step()

	local var_5_0 = arg_5_0.launchBallAmulet:getAngle()

	if var_5_0 < 0 and arg_5_0.lastContent ~= arg_5_0.amuletContent then
		arg_5_0.amuletContent:SetAsLastSibling()
		arg_5_0.amuletsContent:SetAsFirstSibling()

		arg_5_0.lastContent = arg_5_0.amuletContent
	elseif var_5_0 > 0 and arg_5_0.lastContent ~= arg_5_0.playerContent then
		arg_5_0.amuletContent:SetAsFirstSibling()
		arg_5_0.amuletsContent:SetAsLastSibling()

		arg_5_0.lastContent = arg_5_0.playerContent
	end

	if arg_5_0.timeSlash and arg_5_0.timeSlash > 0 then
		arg_5_0.timeSlash = arg_5_0.timeSlash - LaunchBallGameVo.deltaTime

		if arg_5_0.timeSlash <= 0 then
			arg_5_0.timeSlash = nil

			local var_5_1 = GetComponent(findTF(arg_5_0.contentTop, "effect/SlashBound/ad/" .. arg_5_0.timeSlashDirect), typeof(BoxCollider2D))
			local var_5_2 = arg_5_0.launchBallEnemy:getEnemysInBounds(var_5_1.bounds.min, var_5_1.bounds.max)

			for iter_5_0 = 1, #var_5_2 do
				var_5_2[iter_5_0]:hit()
				arg_5_0._event:emit(LaunchBallGameView.ADD_SCORE, {
					num = LaunchBallGameVo.GetScore(1, 1)
				})
			end

			LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_skill_count, #var_5_2)
		end
	end

	local var_5_3 = arg_5_0.launchBallAmulet:getFireAmulet()

	for iter_5_1 = #var_5_3, 1, -1 do
		if not var_5_3[iter_5_1].removeFlag and arg_5_0.launchBallEnemy:checkAmulet(var_5_3[iter_5_1]) then
			var_5_3[iter_5_1].removeFlag = true
		end
	end

	local var_5_5 = arg_5_0.launchBallAmulet:getButterfly()

	for iter_5_2 = #var_5_5, 1, -1 do
		if not var_5_5[iter_5_2].removeFlag and not var_5_5[iter_5_2].removeTime then
			local var_5_6 = arg_5_0.launchBallEnemy:checkPositionIn(var_5_5[iter_5_2].tf.position)

			if var_5_6 then
				var_5_5[iter_5_2].removeTime = 0.2
				var_5_5[iter_5_2].speed.x = 0
				var_5_5[iter_5_2].speed.y = 0

				var_5_5[iter_5_2].anim:Play("Hit")
				var_5_6:setTimeRemove()
				arg_5_0._event:emit(LaunchBallGameView.ADD_SCORE, {
					num = LaunchBallGameVo.GetScore(1, 1)
				})
				LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_pass_skill_count, 1)
			end
		end
	end

	if LaunchBallGameVo.joyStickData.active and LaunchBallGameVo.amulet then
		arg_5_0.pointerTime = arg_5_0.pointerTime + LaunchBallGameVo.deltaTime

		if not arg_5_0.pointerColor then
			for iter_5_3 = 0, arg_5_0.pointerContent.childCount - 1 do
				local var_5_8 = arg_5_0.pointerContent:GetChild(iter_5_3)

				if var_5_8.name == var_0_6[LaunchBallGameVo.amulet.color].tpl then
					arg_5_0.anglePointer = var_5_8
				end

				setActive(var_5_8, false)
			end
		end

		if arg_5_0.pointerTime > 0.3 and LaunchBallGameVo.joyStickData.active then
			if LaunchBallGameVo.joyStickData.angle and LaunchBallGameVo.joyStickData.rad then
				arg_5_0.pointerRotation.z = LaunchBallGameVo.joyStickData.angle + var_0_5
				arg_5_0.anglePointer.localEulerAngles = arg_5_0.pointerRotation

				setActive(arg_5_0.anglePointer, true)

				local var_5_9 = 0

				for iter_5_4 = 1, var_0_8 do
					var_5_9 = iter_5_4 * var_0_7
					arg_5_0.pointerPosition.x = math.cos(LaunchBallGameVo.joyStickData.rad) * (iter_5_4 * var_0_7)
					arg_5_0.pointerPosition.y = math.sin(LaunchBallGameVo.joyStickData.rad) * var_5_9

					if arg_5_0.launchBallEnemy:checkWorldInEnemy((arg_5_0.pointerContent:TransformPoint(arg_5_0.pointerPosition))) then
						break
					end
				end

				for iter_5_5 = 1, 4 do
					arg_5_0.pointerPosition.x = 0
					arg_5_0.pointerPosition.y = (5 - iter_5_5) / 4 * var_5_9 * -1
					findTF(arg_5_0.anglePointer, "ad/" .. iter_5_5).anchoredPosition = arg_5_0.pointerPosition
				end
			end
		end
	else
		arg_5_0.pointerTime = 0
		arg_5_0.pointerColor = nil

		if arg_5_0.anglePointer then
			setActive(arg_5_0.anglePointer, false)
		end
	end

	return
end

function var_0_0.clear(arg_6_0)
	arg_6_0.launchBallAmulet:clear()
	arg_6_0.launchBallPlayer:clear()
	arg_6_0.launchBallEnemy:clear()

	return
end

function var_0_0.stop(arg_7_0)
	return
end

function var_0_0.resume(arg_8_0)
	return
end

function var_0_0.dispose(arg_9_0)
	return
end

function var_0_0.prepareScene(arg_10_0)
	arg_10_0:showContainer(true)

	return
end

function var_0_0.showContainer(arg_11_0, arg_11_1)
	setActive(arg_11_0.sceneMask, arg_11_1)

	return
end

function var_0_0.useSkill(arg_12_0)
	arg_12_0.launchBallPlayer:useSkill()

	return
end

function var_0_0.press(arg_13_0, arg_13_1)
	arg_13_0.launchBallEnemy:press(arg_13_1)

	return
end

function var_0_0.joystickActive(arg_14_0, arg_14_1)
	arg_14_0.launchBallPlayer:joystickActive(arg_14_1)

	return
end

return var_0_0
