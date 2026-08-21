local var_0_0 = class("RectCollisionInfo")

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
	arg_1_0.slopeNormal = Vector3.zero
	arg_1_0.horizontalLeftTfs = {}
	arg_1_0.horizontalRightTfs = {}
	arg_1_0.verticalTopTfs = {}
	arg_1_0.verticalBottomTfs = {}
	arg_1_0.script = nil
	arg_1_0.scriptWeight = nil
	arg_1_0.scriptTime = nil
	arg_1_0.scriptOverrideAble = nil
	arg_1_0.frameRate = 0.016666666666666666
	arg_1_0.config = RectCollisionData.New(arg_1_1)
	arg_1_0.layerMask = LayerMask.GetMask("Collider", "Character")
	arg_1_0.ignoreLayerMask = {
		LayerMask.NameToLayer("Character")
	}
	arg_1_0.playerInput = Vector2(0, 0)
	arg_1_0.directionalInput = Vector2.zero
	arg_1_0._velocity = Vector3.zero
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
			local var_2_0 = arg_1_0.right

			if arg_1_0.right then
				if arg_1_0.FaceDir == 1 then
					if not arg_1_0.below then
						var_2_0 = arg_1_0.fullSliding

						goto label_2_0
					end
				end

				var_2_0 = false and true
			end

			::label_2_0::

			return var_2_0
		end
	end

	function arg_1_0.wallSlidingDown()
		return arg_1_0.wallSliding and arg_1_0.moveAmount < 0
	end

	function arg_1_0.wallDirX()
		return arg_1_0:getWallDirX()
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
	return arg_9_0._anchoredPosition or Vector2.zero
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
		arg_11_0.script:active(false)
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
	arg_13_0.slopeNormal = Vector3.zero
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
