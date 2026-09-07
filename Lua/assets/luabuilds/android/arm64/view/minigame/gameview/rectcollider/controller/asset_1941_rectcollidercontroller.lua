local RectColliderController = class("RectColliderController")

function RectColliderController:Ctor(arg_1_1, arg_1_2)
	self.collisionInfo = arg_1_1
	self.origins = arg_1_2
	self.zeroVec = Vector2.zero

	return
end

function RectColliderController:platformMove(arg_2_1)
	self.collisionInfo.standingOnPlatform = true

	self:move(arg_2_1)

	return
end

function RectColliderController:move(arg_3_1)
	self:updateCollisionInfo(arg_3_1)

	if arg_3_1.y <= 0 then
		RectCollisionVertical.DescendSlope(arg_3_1, self.collisionInfo, self.origins)
	end

	RectCollisionHorizontal.HorizontalCollisions(arg_3_1, self.collisionInfo, self.origins)

	if arg_3_1.y ~= 0 then
		RectCollisionVertical.VerticalCollisions(arg_3_1, self.collisionInfo, self.origins)
	end

	self.collisionInfo.moveAmount = arg_3_1

	self:afterUpdateCollisionInfo()

	return
end

function RectColliderController:updateCollisionInfo(arg_4_1)
	self.origins:updateRaycastOrigins()
	self.collisionInfo:reset()

	self.collisionInfo.moveAmountOld = arg_4_1
	self.collisionInfo.MoveDir = arg_4_1.x > 0 and 1 or self.collisionInfo.MoveDir
	self.collisionInfo.MoveDir = arg_4_1.x < 0 and -1 or self.collisionInfo.MoveDir

	return
end

function RectColliderController:afterUpdateCollisionInfo()
	self.collisionInfo.below = self.collisionInfo.standingOnPlatform or self.collisionInfo.below

	return
end

return RectColliderController
