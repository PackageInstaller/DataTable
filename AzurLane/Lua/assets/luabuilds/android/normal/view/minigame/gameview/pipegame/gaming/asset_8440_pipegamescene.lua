class = var_0_10000

local var_0_0 = var_0_10000("PipeGameScene")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	PipeGameVo = var_1_10003
	var_0_5 = var_1_10003
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0.sceneMask = var_1_10003(arg_1_0._tf, "sceneMask")
	findTF = var_3
	arg_1_0.sceneContent = var_3(arg_1_0._tf, "sceneMask/sceneContainer")
	GetComponent = var_3

	local var_1_0 = arg_1_0.sceneContent

	typeof = var_5
	Animator = var_1_10006
	arg_1_0._moveAnimator = var_3(var_1_0, var_5(var_1_10006))
	findTF = var_3
	arg_1_0._bgRight = var_3(arg_1_0.sceneContent, "scene_background/content/bgRight")
	GetComponent = var_3
	findTF = var_4

	local var_1_1 = var_4(arg_1_0._bgRight, "img")

	typeof = var_5
	Animator = var_6
	arg_1_0._bgRightAnimator = var_3(var_1_1, var_5(var_6))

	local function var_1_2(arg_2_0, arg_2_1)
		PipeGameEvent = var_2_10002

		if arg_2_0 == var_2_10002.REMOVE_RECT_TOP then
			local var_2_0 = arg_1_0.rectCtrl

			var_2.removeTopRectData(var_2_0)
		else
			PipeGameEvent = var_2

			local var_2_1

			if arg_2_0 == var_2.PALY_ANIMATION_COMPLETE then
				var_2_1 = var_0_5

				local var_2_2 = arg_1_0.mapCtrl

				var_2_1.scoreNum = var_3.getSuccessCount(var_2_2)

				local var_2_3 = arg_1_0

				var_2_1.playMove(var_2_3, function()
					local var_3_0 = arg_1_0._event
					local var_3_1 = var_0.emit

					PipeGameEvent = var_3_10002

					var_3_1(var_3_0, var_3_10002.GAME_OVER)

					return
				end)
			else
				PipeGameEvent = var_2_1

				if arg_2_0 == var_2_1.STOP_RECT_DRAG then
					local var_2_4 = arg_1_0.rectCtrl

					var_2.stopTopDrag(var_2_4)
				else
					PipeGameEvent = var_2

					local var_2_6

					if arg_2_0 == var_2.SET_TOP_RECT then
						local var_2_5 = arg_1_0.rectCtrl

						var_2_6 = var_2_6.getTopData(var_2_5)

						local var_2_7 = arg_1_0.mapCtrl

						var_3.setClickTempItem(var_2_7, var_2_6)
					else
						PipeGameEvent = var_2_6

						if arg_2_0 == var_2_6.START_SETTLEMENT then
							var_0_5.startSettlement = true
						end
					end
				end
			end
		end

		return
	end

	PipeMapControl = var_1_1

	local var_1_3 = var_1_1.New

	findTF = var_5
	arg_1_0.mapCtrl = var_1_3(var_5(arg_1_0.sceneContent, "scene/content/map"), var_1_2)
	PipeRectControll = var_4

	local var_1_4 = var_4.New

	findTF = var_5

	local var_1_5 = var_5(arg_1_0.sceneContent, "scene/content/rect")

	findTF = var_6
	arg_1_0.rectCtrl = var_1_4(var_1_5, var_6(arg_1_0.sceneContent, "scene/content/dragPos"), var_1_2)
	PiPePassTest = var_4

	local var_1_6 = var_4.New

	findTF = var_1_5
	arg_1_0.passCtrl = var_1_6(var_1_5(arg_1_0.sceneContent, "scene/content/passTest"), function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if arg_1_0.mapCtrl then
			local var_4_0 = arg_1_0.mapCtrl
			local var_4_1 = var_4.checkItemSuccess(var_4_0, arg_4_0, arg_4_1, arg_4_2, arg_4_3)
			local var_4_2 = arg_1_0.passCtrl

			var_5.setPassDesc(var_4_2, var_4_1)
		end

		return
	end)

	local var_1_7 = arg_1_0.passCtrl

	var_4.setVisible(var_1_7, false)
	arg_1_0:showContainer(false)

	return
end

function var_0_0.start(arg_5_0)
	arg_5_0:showContainer(true)
	arg_5_0:resetScene()

	local var_5_0 = arg_5_0.mapCtrl

	var_1.start(var_5_0)

	local var_5_1 = arg_5_0.rectCtrl

	var_1.start(var_5_1)

	return
end

function var_0_0.step(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.mapCtrl

	var_2.step(var_6_0)

	local var_6_1 = arg_6_0.rectCtrl

	var_2.step(var_6_1)

	return
end

function var_0_0.clear(arg_7_0)
	local var_7_0 = arg_7_0.mapCtrl

	var_1.clear(var_7_0)

	local var_7_1 = arg_7_0.rectCtrl

	var_1.clear(var_7_1)

	return
end

function var_0_0.stop(arg_8_0)
	local var_8_0 = arg_8_0.mapCtrl

	var_1.stop(var_8_0)

	local var_8_1 = arg_8_0.rectCtrl

	var_1.stop(var_8_1)

	return
end

function var_0_0.resume(arg_9_0)
	local var_9_0 = arg_9_0.mapCtrl

	var_1.resume(var_9_0)

	local var_9_1 = arg_9_0.rectCtrl

	var_1.resume(var_9_1)

	return
end

function var_0_0.setGameOver(arg_10_0)
	local var_10_0 = arg_10_0.mapCtrl

	var_1.startOverAniamtion(var_10_0)

	return
end

function var_0_0.dispose(arg_11_0)
	local var_11_0 = arg_11_0.mapCtrl

	var_1.dispose(var_11_0)

	local var_11_1 = arg_11_0.rectCtrl

	var_1.dispose(var_11_1)

	local var_11_2 = arg_11_0.passCtrl

	var_1.dispose(var_11_2)

	LeanTween = var_1

	local var_11_3 = var_1.isTweening

	go = var_11_2

	if var_11_3(var_11_2(arg_11_0.sceneContent)) then
		LeanTween = var_1

		local var_11_4 = var_1.cancel

		go = var_2

		var_11_4(var_2(arg_11_0.sceneContent))
	end

	return
end

function var_0_0.resetScene(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0._bgRight, false)

	local var_12_0 = arg_12_0._moveAnimator

	var_1.SetTrigger(var_12_0, "reset")

	return
end

function var_0_0.playMove(arg_13_0, arg_13_1)
	local var_13_0 = var_0_5.GetResultLevel()

	setActive = var_1_10003

	var_1_10003(arg_13_0._bgRight, true)

	local var_13_1 = arg_13_0._bgRightAnimator
	local var_13_2 = var_3.SetTrigger

	tostring = var_5

	var_13_2(var_13_1, var_5(var_13_0))

	local var_13_3 = arg_13_0._moveAnimator

	var_3.SetTrigger(var_13_3, "move")

	LeanTween = var_3

	local var_13_4 = var_3.delayedCall

	go = var_13_3

	local var_13_5 = var_13_3(arg_13_0.sceneContent)
	local var_13_6 = 5

	System = var_6

	var_13_4(var_13_5, var_13_6, var_6.Action(function()
		if arg_13_1 then
			arg_13_1()
		end

		return
	end))

	return
end

function var_0_0.showContainer(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.sceneMask, arg_15_1)

	return
end

function var_0_0.press(arg_16_0, arg_16_1, arg_16_2)
	return
end

function var_0_0.joystickActive(arg_17_0, arg_17_1)
	return
end

return var_0_0
