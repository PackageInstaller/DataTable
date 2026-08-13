class = var_0_10000

local var_0_0 = var_0_10000("LaunchBallGameScene")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3
local var_0_8 = 4
local var_0_9 = 5
local var_0_10 = 6
local var_0_11 = 7
local var_0_12 = 90
local var_0_13 = {
	[var_0_5] = {
		tpl = "pointer01"
	},
	[var_0_6] = {
		tpl = "pointer02"
	},
	[var_0_7] = {
		tpl = "pointer03"
	},
	[var_0_8] = {
		tpl = "pointer04"
	},
	[var_0_9] = {
		tpl = "pointer05"
	},
	[var_0_10] = {
		tpl = "pointer06"
	},
	[var_0_11] = {
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
	findTF = var_1_10003
	arg_1_0.sceneMask = var_1_10003(arg_1_0._tf, "sceneMask")
	findTF = var_3
	arg_1_0.tplContent = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/tpl")
	findTF = var_3
	arg_1_0.contentBack = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene_background/content")
	findTF = var_3
	arg_1_0.contentMid = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/content")
	findTF = var_3
	arg_1_0.contentTop = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene_front/content")
	findTF = var_3
	arg_1_0.contentEF = var_3(arg_1_0._tf, "sceneMask/sceneContainer/scene/effect_front")
	findTF = var_3
	arg_1_0.playerContent = var_3(arg_1_0.contentTop, "player")
	findTF = var_3
	arg_1_0.amuletContent = var_3(arg_1_0.contentTop, "amulet")
	findTF = var_3
	arg_1_0.amuletsContent = var_3(arg_1_0.contentTop, "amulets")
	findTF = var_3
	arg_1_0.amuletLifeContent = var_3(arg_1_0.contentTop, "amuletLifeContent")
	findTF = var_3
	arg_1_0.enemyContent = var_3(arg_1_0.contentMid, "enemy")
	findTF = var_3
	arg_1_0.lineContent = var_3(arg_1_0.contentMid, "line")
	LaunchBallGameJoyStick = var_3

	local var_1_0 = var_3.New

	findTF = var_4
	arg_1_0.joyStick = var_1_0(var_4(arg_1_0.contentTop, "joyStick"))

	local var_1_1 = arg_1_0.joyStick

	var_3.setActiveCallback(var_1_1, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.joystickActive(var_2_0, arg_2_0)

		return
	end)

	local function var_1_2(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0.launchBallAmulet

		var_2.eventCall(var_3_0, arg_3_0, arg_3_1)

		local var_3_1 = arg_1_0.launchBallPlayer

		var_2.eventCall(var_3_1, arg_3_0, arg_3_1)

		local var_3_2 = arg_1_0.launchBallEnemy

		var_2.eventCall(var_3_2, arg_3_0, arg_3_1)

		LaunchBallGameScene = var_2

		local var_3_4

		if arg_3_0 == var_2.ENEMY_FINISH then
			local var_3_3 = arg_1_0._event

			var_3_4 = var_3_4.emit
			LaunchBallGameView = var_4

			var_3_4(var_3_3, var_4.GAME_OVER)
		else
			LaunchBallGameScene = var_3_4

			local var_3_6

			if arg_3_0 == var_3_4.SPILT_ENEMY_SCORE then
				local var_3_5 = arg_1_0._event

				var_3_6 = var_3_6.emit
				LaunchBallGameView = var_4

				var_3_6(var_3_5, var_4.ADD_SCORE, arg_3_1)
			else
				LaunchBallGameScene = var_3_6

				if arg_3_0 == var_3_6.SLASH_ENEMY then
					arg_1_0.timeSlashDirect = arg_3_1.direct
					arg_1_0.timeSlash = arg_3_1.time
				end
			end
		end

		return
	end

	Clone = var_1_1
	LaunchBallGameConst = var_5

	local var_1_3 = var_5.map_data

	LaunchBallGameVo = var_6

	local var_1_4 = var_1_1(var_1_3[var_6.gameRoundData.map].map)

	findTF = var_5

	local var_1_5 = var_5(arg_1_0.contentBack, "bg")

	findTF = var_6

	local var_1_6 = var_6(arg_1_0.contentTop, "bg")

	for iter_1_0 = 0, var_1_5.childCount - 1 do
		local var_1_7 = var_1_5

		var_1_10011 = var_1_5.GetChild(var_1_7, iter_1_0)
		setActive = var_1_7

		var_1_7(var_1_10011, var_1_10011.name == var_1_4)
	end

	for iter_1_1 = 0, var_1_6.childCount - 1 do
		local var_1_8 = var_1_6

		var_1_10011 = var_1_6.GetChild(var_1_8, iter_1_1)
		setActive = var_1_8

		var_1_8(var_1_10011, var_1_10011.name == var_1_4)
	end

	for iter_1_2 = 0, arg_1_0.lineContent.childCount - 1 do
		setActive = var_1_10011

		local var_1_9 = arg_1_0.lineContent

		var_1_10011(var_12.GetChild(var_1_9, iter_1_2), false)
	end

	LaunchBallAmulet = var_7
	arg_1_0.launchBallAmulet = var_7.New(arg_1_0.amuletContent, arg_1_0.amuletsContent, arg_1_0.amuletLifeContent, arg_1_0.tplContent, var_1_2)
	LaunchBallPlayerControl = var_7
	arg_1_0.launchBallPlayer = var_7.New(arg_1_0.contentTop, arg_1_0.playerContent, arg_1_0.tplContent, var_1_2)
	LaunchBallEnemy = var_7
	arg_1_0.launchBallEnemy = var_7.New(arg_1_0.enemyContent, arg_1_0.lineContent, arg_1_0.tplContent, var_1_2)

	if not arg_1_0.pointerContent then
		findTF = var_7
		arg_1_0.pointerContent = var_7(arg_1_0.contentTop, "pointer")
	end

	if not arg_1_0.pointerCollider then
		findTF = var_7
		arg_1_0.pointerCollider = var_7(arg_1_0.contentTop, "collider")
		setActive = var_7

		var_7(arg_1_0.pointerCollider, false)
	end

	return
end

local var_0_14 = 50
local var_0_15 = 500
local var_0_16 = var_0_15 / 50

function var_0_0.start(arg_4_0)
	arg_4_0:prepareScene()

	local var_4_0 = arg_4_0.launchBallAmulet

	var_1.start(var_4_0)

	local var_4_1 = arg_4_0.launchBallPlayer

	var_1.start(var_4_1)

	local var_4_2 = arg_4_0.launchBallEnemy

	var_1.start(var_4_2)

	Vector3 = var_1
	arg_4_0.pointerRotation = var_1(0, 0, 0)
	Vector2 = var_1
	arg_4_0.pointerPosition = var_1(0, 0)

	for iter_4_0 = 0, arg_4_0.pointerContent.childCount - 1 do
		local var_4_3 = arg_4_0.pointerContent
		local var_4_4 = var_5.GetChild(var_4_3, iter_4_0)

		setActive = var_4_3

		var_4_3(var_4_4, false)
	end

	arg_4_0.timeSlash = nil

	return
end

function var_0_0.step(arg_5_0)
	local var_5_0 = arg_5_0.joyStick

	var_1.step(var_5_0)

	LaunchBallGameVo = var_1

	local var_5_1 = arg_5_0.joyStick

	var_1.joyStickData = var_2.getValue(var_5_1)

	local var_5_2 = arg_5_0.launchBallAmulet

	var_1.step(var_5_2)

	local var_5_3 = arg_5_0.launchBallPlayer

	var_1.step(var_5_3)

	local var_5_4 = arg_5_0.launchBallEnemy

	var_1.step(var_5_4)

	local var_5_5 = arg_5_0.launchBallAmulet

	if var_1.getAngle(var_5_5) < 0 and arg_5_0.lastContent ~= arg_5_0.amuletContent then
		local var_5_6 = arg_5_0.amuletContent

		var_2.SetAsLastSibling(var_5_6)

		local var_5_7 = arg_5_0.amuletsContent

		var_2.SetAsFirstSibling(var_5_7)

		arg_5_0.lastContent = arg_5_0.amuletContent
	elseif var_1 > 0 and arg_5_0.lastContent ~= arg_5_0.playerContent then
		local var_5_8 = arg_5_0.amuletContent

		var_2.SetAsFirstSibling(var_5_8)

		local var_5_9 = arg_5_0.amuletsContent

		var_2.SetAsLastSibling(var_5_9)

		arg_5_0.lastContent = arg_5_0.playerContent
	end

	if arg_5_0.timeSlash then
		local var_5_10 = arg_5_0.timeSlash

		if 0 < var_5_10 then
			local var_5_11 = arg_5_0.timeSlash

			LaunchBallGameVo = var_3
			arg_5_0.timeSlash = var_5_11 - var_3.deltaTime

			if arg_5_0.timeSlash <= 0 then
				arg_5_0.timeSlash = nil
				GetComponent = var_2
				findTF = var_3

				local var_5_12 = var_3(arg_5_0.contentTop, "effect/SlashBound/ad/" .. arg_5_0.timeSlashDirect)

				typeof = var_4
				BoxCollider2D = var_5

				local var_5_13 = var_2(var_5_12, var_4(var_5)).bounds.min
				local var_5_14 = var_2.bounds.max
				local var_5_15 = arg_5_0.launchBallEnemy
				local var_5_16 = var_5.getEnemysInBounds(var_5_15, var_5_13, var_5_14)

				for iter_5_0 = 1, #var_5_16 do
					local var_5_17 = var_5_16[iter_5_0]

					var_10.hit(var_5_17)

					LaunchBallGameVo = var_10

					local var_5_18 = var_10.GetScore(1, 1)

					var_1_10012 = arg_5_0._event

					local var_5_19 = var_11.emit

					LaunchBallGameView = var_1_10013

					var_5_19(var_1_10012, var_1_10013.ADD_SCORE, {
						num = var_5_18
					})
				end

				LaunchBallGameVo = var_6

				local var_5_20 = var_6.AddGameResultData

				LaunchBallGameVo = var_7

				var_5_20(var_7.result_skill_count, #var_5_16)
			end
		end
	end

	local var_5_21 = arg_5_0.launchBallAmulet

	for iter_5_1 = #var_2.getFireAmulet(var_5_21), 1, -1 do
		local var_5_22 = var_2[iter_5_1]
		local var_5_23 = var_2[iter_5_1].tf.position

		if not var_5_22.removeFlag then
			local var_5_24 = arg_5_0.launchBallEnemy

			if var_9.checkAmulet(var_5_24, var_2[iter_5_1]) then
				var_5_22.removeFlag = true
			end
		end
	end

	local var_5_25 = arg_5_0.launchBallAmulet

	for iter_5_2 = #var_3.getButterfly(var_5_25), 1, -1 do
		local var_5_26 = var_3[iter_5_2].tf

		if not var_8.removeFlag and not var_8.removeTime then
			local var_5_27 = var_5_26.position

			var_1_10012 = arg_5_0.launchBallEnemy

			if var_11.checkPositionIn(var_1_10012, var_5_27) then
				var_8.removeTime = 0.2
				var_1_10012 = var_8.speed
				var_1_10012.x = 0
				var_1_10012 = var_8.speed
				var_1_10012.y = 0

				local var_5_28 = var_8.anim

				var_1_10012.Play(var_5_28, "Hit")
				var_11:setTimeRemove()

				LaunchBallGameVo = var_1_10012
				var_1_10012 = var_1_10012.GetScore(1, 1)

				local var_5_29 = arg_5_0._event
				local var_5_30 = var_13.emit

				LaunchBallGameView = var_1_10015

				var_5_30(var_5_29, var_1_10015.ADD_SCORE, {
					num = var_1_10012
				})

				LaunchBallGameVo = var_5_30

				local var_5_31 = var_5_30.AddGameResultData

				LaunchBallGameVo = var_5_29

				var_5_31(var_5_29.result_pass_skill_count, 1)
			end
		end
	end

	LaunchBallGameVo = var_4

	if var_4.joyStickData.active then
		LaunchBallGameVo = var_4

		if var_4.amulet then
			local var_5_32 = arg_5_0.pointerTime

			LaunchBallGameVo = var_5
			arg_5_0.pointerTime = var_5_32 + var_5.deltaTime

			if not arg_5_0.pointerColor then
				LaunchBallGameVo = var_4

				local var_5_33 = var_4.amulet.color
				local var_5_34 = var_0_13

				LaunchBallGameVo = var_6

				local var_5_35 = var_5_34[var_6.amulet.color].tpl

				for iter_5_3 = 0, arg_5_0.pointerContent.childCount - 1 do
					local var_5_36 = arg_5_0.pointerContent

					if var_10.GetChild(var_5_36, iter_5_3).name == var_5_35 then
						arg_5_0.anglePointer = var_10
					end

					setActive = var_11

					var_11(var_10, false)
				end
			end

			local var_5_37 = arg_5_0.pointerTime

			if 0.3 < var_5_37 then
				LaunchBallGameVo = var_5_37

				if var_5_37.joyStickData.active then
					LaunchBallGameVo = var_4

					local var_5_38 = var_4.joyStickData.angle

					LaunchBallGameVo = var_5

					local var_5_39 = var_5.joyStickData.rad

					if var_5_38 and var_5_39 then
						arg_5_0.pointerRotation.z = var_5_38 + var_0_12

						local var_5_40 = arg_5_0.anglePointer

						var_5_40.localEulerAngles = arg_5_0.pointerRotation
						setActive = var_5_40

						var_5_40(arg_5_0.anglePointer, true)

						local var_5_41 = 0

						for iter_5_4 = 1, var_0_16 do
							var_5_41 = iter_5_4 * var_0_14

							local var_5_42 = arg_5_0.pointerPosition

							math = var_1_10012
							var_5_42.x = var_1_10012.cos(var_5_39) * var_5_41

							local var_5_43 = arg_5_0.pointerPosition

							math = var_1_10012
							var_5_43.y = var_1_10012.sin(var_5_39) * var_5_41
							var_1_10012 = arg_5_0.pointerContent

							local var_5_44 = var_11.TransformPoint(var_1_10012, arg_5_0.pointerPosition)
							local var_5_45 = arg_5_0.launchBallEnemy

							if var_1_10012.checkWorldInEnemy(var_5_45, var_5_44) then
								break
							end
						end

						for iter_5_5 = 1, 4 do
							arg_5_0.pointerPosition.x = 0

							local var_5_46 = arg_5_0.pointerPosition

							var_5_46.y = (5 - iter_5_5) / 4 * var_5_41 * -1
							findTF = var_5_46
							var_5_46(arg_5_0.anglePointer, "ad/" .. iter_5_5).anchoredPosition = arg_5_0.pointerPosition
						end
					end
				end
			end

			goto label_5_0
		end
	end

	arg_5_0.pointerTime = 0
	arg_5_0.pointerColor = nil

	if arg_5_0.anglePointer then
		setActive = var_4

		var_4(arg_5_0.anglePointer, false)
	end

	::label_5_0::

	return
end

function var_0_0.clear(arg_6_0)
	local var_6_0 = arg_6_0.launchBallAmulet

	var_1.clear(var_6_0)

	local var_6_1 = arg_6_0.launchBallPlayer

	var_1.clear(var_6_1)

	local var_6_2 = arg_6_0.launchBallEnemy

	var_1.clear(var_6_2)

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
	setActive = var_1_10002

	var_1_10002(arg_11_0.sceneMask, arg_11_1)

	return
end

function var_0_0.useSkill(arg_12_0)
	local var_12_0 = arg_12_0.launchBallPlayer

	var_1.useSkill(var_12_0)

	return
end

function var_0_0.press(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.launchBallEnemy

	var_2.press(var_13_0, arg_13_1)

	return
end

function var_0_0.joystickActive(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.launchBallPlayer

	var_2.joystickActive(var_14_0, arg_14_1)

	return
end

return var_0_0
