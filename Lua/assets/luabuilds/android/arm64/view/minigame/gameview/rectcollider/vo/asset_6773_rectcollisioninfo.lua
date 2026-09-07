local RectCollisionInfo = class("RectCollisionInfo")

function RectCollisionInfo:Ctor(arg_1_1)
	self.above = false
	self.below = false
	self.left = false
	self.right = false
	self.fullSliding = false
	self.climbingSlope = false
	self.descendingSlope = false
	self.slidingDownMaxSlope = false
	self.slopeAngle = 0
	self.slopeAngleOld = 0
	self.slopeNormal = Vector3.zero
	self.horizontalLeftTfs = {}
	self.horizontalRightTfs = {}
	self.verticalTopTfs = {}
	self.verticalBottomTfs = {}
	self.script = nil
	self.scriptWeight = nil
	self.scriptTime = nil
	self.scriptOverrideAble = nil
	self.frameRate = 0.016666666666666666
	self.config = RectCollisionData.New(arg_1_1)
	self.layerMask = LayerMask.GetMask("Collider", "Character")
	self.ignoreLayerMask = {
		LayerMask.NameToLayer("Character")
	}
	self.playerInput = Vector2(0, 0)
	self.directionalInput = Vector2.zero
	self._velocity = Vector3.zero
	self.standingOnPlatform = false
	self.velocityXSmoothing = 0
	self.moveAmountOld = 0
	self.moveAmount = 0
	self.fallingThroughPlatform = false
	self.MoveDir = 1
	self.FaceDir = 1
	self.LockFaceDir = false
	self.useJumpTimes = 0
	self.holdInSlider = false
	self.lockHorizontalMove = false
	self.lockVerticalMove = false
	self.sprint = false
	self.damaged = false

	function self.wallSliding()
		local var_2_0

		if not self.left or self.FaceDir ~= -1 then
			var_2_0 = self.right

			if self.right then
				if self.FaceDir == 1 then
					if not self.below then
						var_2_0 = self.fullSliding

						goto label_2_0
					end
				end

				var_2_0 = false

				goto label_2_0
			end
		end

		::label_2_0::

		return true
	end

	function self.wallSlidingDown()
		return self.wallSliding and self.moveAmount < 0
	end

	function self.wallDirX()
		return self:getWallDirX()
	end

	return
end

function RectCollisionInfo:getVelocity()
	return self._velocity
end

function RectCollisionInfo:setVelocity(arg_6_1)
	self._velocity.x = arg_6_1.x
	self._velocity.y = arg_6_1.y
	self._velocity.z = arg_6_1.z

	return
end

function RectCollisionInfo:changeVelocity(arg_7_1, arg_7_2, arg_7_3)
	self._velocity.x = arg_7_1 or self._velocity.x
	self._velocity.y = arg_7_2 or self._velocity.y
	self._velocity.z = arg_7_3 or self._velocity.z

	return
end

function RectCollisionInfo:setPos(arg_8_1)
	self._anchoredPosition = arg_8_1

	return
end

function RectCollisionInfo:getPos()
	return self._anchoredPosition or Vector2.zero
end

function RectCollisionInfo:setScript(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.script = arg_10_1
	self.scriptWeight = arg_10_2
	self.scriptTime = arg_10_3
	self.scriptOverrideAble = arg_10_4

	return
end

function RectCollisionInfo:removeScript()
	if self.script then
		self.script:active(false)
	end

	self.script = nil
	self.scriptWeight = nil
	self.scriptTime = nil
	self.scriptOverrideAble = nil

	return
end

function RectCollisionInfo:getWallDirX()
	if self.fullSliding then
		if self.left then
			return -1
		elseif self.right then
			return 1
		end
	end

	return 0
end

function RectCollisionInfo:reset()
	self.above = false
	self.below = false
	self.left = false
	self.right = false
	self.climbingSlope = false
	self.descendingSlope = false
	self.slidingDownMaxSlope = false
	self.lockHorizontalMove = false
	self.lockVerticalMove = false
	self.fullSliding = false
	self.slopeNormal = Vector3.zero
	self.slopeAngleOld = self.slopeAngle
	self.slopeAngle = 0
	self.standingOnPlatform = false
	self.horizontalLeftTfs = {}
	self.horizontalRightTfs = {}
	self.verticalTopTfs = {}
	self.verticalBottomTfs = {}

	return
end

return RectCollisionInfo
