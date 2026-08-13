class = var_0_10000

local var_0_0 = var_0_10000("TouchCakeScene")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5

var_0_0.EVENT_ACTION_PROP = "event action prop"
var_0_0.EVENT_ACTION_CAKE = "event action cake"
var_0_0.EVENT_ACTION_WIELD = "event action wield"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	TouchCakeGameVo = var_1_10003
	var_0_5 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.sceneMask = var_1_10003(arg_1_0._tf, "sceneMask")
	findTF = var_3
	arg_1_0.sceneContent = var_3(arg_1_0._tf, "sceneMask/sceneContainer")

	local function var_1_0(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.onSceneEventCall(var_2_0, arg_2_0, arg_2_1, arg_2_2)

		return
	end

	arg_1_0:showContainer(false)

	findTF = var_4

	local var_1_1 = var_4(arg_1_0.sceneContent, "scene/content/cakeContent")

	TouchCakeTowerController = var_5
	arg_1_0.cakeController = var_5.New(var_1_1, var_1_0)
	findTF = var_5

	local var_1_2 = var_5(arg_1_0.sceneContent, "scene/content/charContent")

	TouchCakeCharController = var_6
	arg_1_0.charController = var_6.New(var_1_2, var_1_0)
	findTF = var_6

	local var_1_3 = var_6(arg_1_0.sceneContent, "scene/content/effectContent")

	TouchCakeEffectController = var_7
	arg_1_0.effectController = var_7.New(var_1_3, var_1_0)

	return
end

function var_0_0.onSceneEventCall(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	TouchCakeScene = var_1_10004

	if arg_3_1 == var_1_10004.EVENT_ACTION_PROP then
		local var_3_0 = arg_3_2.prop.data.dizzi
		local var_3_1 = var_4.data.guard
		local var_3_2 = var_4.data.boom
		local var_3_3 = var_4.data.score
		local var_3_4 = arg_3_0.charController

		var_1_10009 = var_1_10009.getDirect(var_3_4)

		if var_4.direct == var_1_10009 then
			if arg_3_3 then
				arg_3_3(true)
			end

			if var_3_3 and var_3_3 >= 0 then
				local var_3_5 = arg_3_0:getScore(var_3_3, var_0_5.comboNum)
				local var_3_6 = arg_3_0._event

				var_3_4 = var_3_4.emit
				TouchCakeGameEvent = var_14

				var_3_4(var_3_6, var_14.ADD_SCORE, var_3_5)
			end

			if var_3_1 and 0 < var_3_1 then
				pg = var_10

				local var_3_7 = var_10.CriMgr.GetInstance()

				var_10.PlaySoundEffect_V3(var_3_7, var_0_5.SFX_COUNT_PERFECT)

				local var_3_8 = arg_3_0.charController

				var_10.guard(var_3_8, var_3_1)
			end

			if var_3_0 and var_3_0 > 0 then
				local var_3_9 = arg_3_0.charController

				if var_10.dizzi(var_3_9, var_3_0) then
					pg = var_3_4

					local var_3_10 = var_3_4.CriMgr.GetInstance()

					var_11.PlaySoundEffect_V3(var_3_10, var_0_5.SFX_COUNT_STEP)

					local var_3_11 = arg_3_0._event
					local var_3_12 = var_11.emit

					TouchCakeGameEvent = var_14

					var_3_12(var_3_11, var_14.PLAYER_DIZZI, var_3_3)
				end
			end

			if var_3_2 and var_3_2 > 0 then
				local var_3_13 = arg_3_0.charController

				if not var_10.getGuard(var_3_13) then
					local var_3_14 = arg_3_0.effectController

					var_10.showBoom(var_3_14, var_3_2, 0.1)

					local var_3_15 = arg_3_0._event
					local var_3_16 = var_10.emit

					TouchCakeGameEvent = var_13

					var_3_16(var_3_15, var_13.PLAYER_BOOM)
				end
			end
		elseif arg_3_3 then
			arg_3_3(false)
		end
	else
		TouchCakeScene = var_4

		if arg_3_1 == var_4.EVENT_ACTION_WIELD then
			pg = var_4

			local var_3_17 = var_4.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_3_17, var_0_5.SFX_COUNT_THROW)

			local var_3_18 = arg_3_0.cakeController

			var_4.touchBottomCake(var_3_18, arg_3_2, arg_3_3)
		else
			TouchCakeScene = var_4

			if arg_3_1 == var_4.EVENT_ACTION_CAKE and arg_3_2.cake.score and var_5 >= 0 then
				local var_3_19 = arg_3_0._event
				local var_3_20 = var_6.emit

				TouchCakeGameEvent = var_1_10009

				var_3_20(var_3_19, var_1_10009.ADD_COMBO)

				local var_3_21 = arg_3_0:getScore(var_5, var_0_5.comboNum)
				local var_3_22 = arg_3_0._event
				local var_3_23 = var_7.emit

				TouchCakeGameEvent = var_10

				var_3_23(var_3_22, var_10.ADD_SCORE, var_3_21)
			end
		end
	end

	return
end

function var_0_0.start(arg_4_0)
	arg_4_0.touchTimeCache = -1

	arg_4_0:showContainer(true)

	local var_4_0 = arg_4_0.cakeController

	var_1.start(var_4_0)

	local var_4_1 = arg_4_0.charController

	var_1.start(var_4_1)

	local var_4_2 = arg_4_0.effectController

	var_1.start(var_4_2)

	return
end

function var_0_0.step(arg_5_0)
	if arg_5_0.touchTimeCache and arg_5_0.touchTimeCache > 0 then
		arg_5_0.touchTimeCache = arg_5_0.touchTimeCache - var_0_5.deltaTime

		if arg_5_0.touchTimeCache <= 0 then
			arg_5_0.touchTimeCache = -1

			arg_5_0:touchDirect(arg_5_0.touchDirectCache, true)
		end
	end

	local var_5_0 = arg_5_0.cakeController

	var_1.step(var_5_0)

	local var_5_1 = arg_5_0.charController

	var_1.step(var_5_1)

	local var_5_2 = arg_5_0.effectController

	var_1.step(var_5_2)

	return
end

function var_0_0.clear(arg_6_0)
	return
end

function var_0_0.stop(arg_7_0)
	local var_7_0 = arg_7_0.cakeController

	var_1.stop(var_7_0)

	local var_7_1 = arg_7_0.charController

	var_1.stop(var_7_1)

	local var_7_2 = arg_7_0.effectController

	var_1.stop(var_7_2)

	return
end

function var_0_0.resume(arg_8_0)
	local var_8_0 = arg_8_0.cakeController

	var_1.resume(var_8_0)

	local var_8_1 = arg_8_0.charController

	var_1.resume(var_8_1)

	local var_8_2 = arg_8_0.effectController

	var_1.resume(var_8_2)

	return
end

function var_0_0.setGameOver(arg_9_0)
	return
end

function var_0_0.dispose(arg_10_0)
	local var_10_0 = arg_10_0.cakeController

	var_1.dispose(var_10_0)

	local var_10_1 = arg_10_0.charController

	var_1.dispose(var_10_1)

	return
end

function var_0_0.showContainer(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.sceneMask, arg_11_1)

	return
end

function var_0_0.press(arg_12_0, arg_12_1, arg_12_2)
	KeyCode = var_1_10003

	if arg_12_1 == var_1_10003.A and arg_12_2 then
		arg_12_0:touchDirect(-1, false)
	else
		KeyCode = var_3

		if arg_12_1 == var_3.D and arg_12_2 then
			arg_12_0:touchDirect(1, false)
		end
	end

	return
end

function var_0_0.getScore(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 <= 0 then
		arg_13_2 = 1
	end

	TouchCakeGameConst = var_3

	for iter_13_0 = #var_3.score_rate_count, 1, -1 do
		TouchCakeGameConst = var_1_10007
		var_1_10007 = var_1_10007.score_rate_count[iter_13_0][1]
		TouchCakeGameConst = var_1_10008
		var_1_10008 = var_1_10008.score_rate_count[iter_13_0][2]

		if var_1_10007 <= arg_13_2 then
			math = var_1_10009

			return var_1_10009.floor(arg_13_1 * var_1_10008)
		end
	end

	return arg_13_1
end

function var_0_0.touchDirect(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.charController

	if var_3.getTouchAble(var_14_0) then
		local var_14_1 = arg_14_0.cakeController

		if not var_3.getTouchAble(var_14_1) then
			if not arg_14_2 then
				arg_14_0.touchTimeCache = 0.1
				arg_14_0.touchDirectCache = arg_14_1
			end

			return
		end

		arg_14_0.touchTimeCache = -1

		if arg_14_1 == -1 then
			local var_14_2 = arg_14_0.charController

			var_3.onTouchLeft(var_14_2)
		elseif arg_14_1 == 1 then
			local var_14_3 = arg_14_0.charController

			var_3.onTouchRight(var_14_3)
		end

		return
	end
end

return var_0_0
