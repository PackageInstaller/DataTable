class = var_0_10000

local var_0_0 = var_0_10000("RectCollisionInfo")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.above = false
	arg_1_0.below = false
	arg_1_0.left = false
	arg_1_0.right = false
	arg_1_0.fullSliding = false
	arg_1_0.climbingSlope = false
	arg_1_0.descendingSlope = false
	arg_1_0.slidingDownMaxSlope = false
	arg_1_0.slopeAngle = 0
	arg_1_0.slopeAngleOld = 0
	Vector3 = var_2
	arg_1_0.slopeNormal = var_2.zero
	arg_1_0.horizontalLeftTfs = {}
	arg_1_0.horizontalRightTfs = {}
	arg_1_0.verticalTopTfs = {}
	arg_1_0.verticalBottomTfs = {}
	arg_1_0.script = nil
	arg_1_0.scriptWeight = nil
	arg_1_0.scriptTime = nil
	arg_1_0.scriptOverrideAble = nil
	arg_1_0.frameRate = 0.016666666666666666
	RectCollisionData = var_2
	arg_1_0.config = var_2.New(arg_1_1)
	LayerMask = var_2
	arg_1_0.layerMask = var_2.GetMask("Collider", "Character")

	local var_1_0 = {}

	LayerMask = var_3
	var_1_0[1] = var_3.NameToLayer("Character")
	arg_1_0.ignoreLayerMask = var_1_0
	Vector2 = var_1_0
	arg_1_0.playerInput = var_1_0(0, 0)
	Vector2 = var_2
	arg_1_0.directionalInput = var_2.zero
	Vector3 = var_2
	arg_1_0._velocity = var_2.zero
	arg_1_0.standingOnPlatform = false
	arg_1_0.velocityXSmoothing = 0
	arg_1_0.moveAmountOld = 0
	arg_1_0.moveAmount = 0
	arg_1_0.fallingThroughPlatform = false
	arg_1_0.MoveDir = 1
	arg_1_0.FaceDir = 1
	arg_1_0.LockFaceDir = false
	arg_1_0.useJumpTimes = 0
	arg_1_0.holdInSlider = false
	arg_1_0.lockHorizontalMove = false
	arg_1_0.lockVerticalMove = false
	arg_1_0.sprint = false
	arg_1_0.damaged = false

	function arg_1_0.wallSliding()
		if not arg_1_0.left or arg_1_0.FaceDir ~= -1 then
			local var_2_0

			if arg_1_0.right then
				if arg_1_0.FaceDir == 1 then
					if not arg_1_0.below then
						var_2_0 = arg_1_0.fullSliding

						goto label_2_0
					end
				end

				var_2_0 = false

				if false then
					var_2_0 = true
				end
			end

			::label_2_0::

			return var_2_0
		end
	end

	function arg_1_0.wallSlidingDown()
		local var_3_0

		if arg_1_0.wallSliding then
			var_3_0 = arg_1_0.moveAmount < 0
		end

		return var_3_0
	end

	function arg_1_0.wallDirX()
		local var_4_0 = arg_1_0

		return var_0.getWallDirX(var_4_0)
	end

	return
end

function var_0_0.getVelocity(arg_5_0)
	return arg_5_0._velocity
end

function var_0_0.setVelocity(arg_6_0, arg_6_1)
	arg_6_0._velocity.x = arg_6_1.x
	arg_6_0._velocity.y = arg_6_1.y
	arg_6_0._velocity.z = arg_6_1.z

	return
end

function var_0_0.changeVelocity(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._velocity.x = arg_7_1 or arg_7_0._velocity.x
	arg_7_0._velocity.y = arg_7_2 or arg_7_0._velocity.y
	arg_7_0._velocity.z = arg_7_3 or arg_7_0._velocity.z

	return
end

function var_0_0.setPos(arg_8_0, arg_8_1)
	arg_8_0._anchoredPosition = arg_8_1

	return
end

function var_0_0.getPos(arg_9_0)
	local var_9_0

	if not arg_9_0._anchoredPosition then
		Vector2 = var_9_0
		var_9_0 = var_9_0.zero
	end

	return var_9_0
end

function var_0_0.setScript(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0.script = arg_10_1
	arg_10_0.scriptWeight = arg_10_2
	arg_10_0.scriptTime = arg_10_3
	arg_10_0.scriptOverrideAble = arg_10_4

	return
end

function var_0_0.removeScript(arg_11_0)
	if arg_11_0.script then
		local var_11_0 = arg_11_0.script

		var_1.active(var_11_0, false)
	end

	arg_11_0.script = nil
	arg_11_0.scriptWeight = nil
	arg_11_0.scriptTime = nil
	arg_11_0.scriptOverrideAble = nil

	return
end

function var_0_0.getWallDirX(arg_12_0)
	if arg_12_0.fullSliding then
		if arg_12_0.left then
			return -1
		elseif arg_12_0.right then
			return 1
		end
	end

	return 0
end

function var_0_0.reset(arg_13_0)
	arg_13_0.above = false
	arg_13_0.below = false
	arg_13_0.left = false
	arg_13_0.right = false
	arg_13_0.climbingSlope = false
	arg_13_0.descendingSlope = false
	arg_13_0.slidingDownMaxSlope = false
	arg_13_0.lockHorizontalMove = false
	arg_13_0.lockVerticalMove = false
	arg_13_0.fullSliding = false
	Vector3 = var_1
	arg_13_0.slopeNormal = var_1.zero
	arg_13_0.slopeAngleOld = arg_13_0.slopeAngle
	arg_13_0.slopeAngle = 0
	arg_13_0.standingOnPlatform = false
	arg_13_0.horizontalLeftTfs = {}
	arg_13_0.horizontalRightTfs = {}
	arg_13_0.verticalTopTfs = {}
	arg_13_0.verticalBottomTfs = {}

	return
end

return var_0_0
