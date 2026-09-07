local RectCollisionData = class("RectCollisionData")

function RectCollisionData:Ctor(arg_1_1)
	self.maxSlopeAngle = 45
	self.downMaxSlopeSpeed = 8
	self.gravity = -50
	self.maxJumpHeight = 4
	self.minJumpHeight = 2
	self.accelerationTimeAirborne = 0.05
	self.accelerationTimeGrounded = 0.05
	self.moveSpeed = 8
	self.wallJumpClimb = 10
	self.wallJumpOff = 10
	self.wallLeap = 10
	self.wallSlideSpeedMax = 3
	self.wallStickTime = 0.25
	self.jumpStickTime = 0.01
	self.jumpTimes = 0
	self.jumpHeights = {
		50,
		30
	}
	self.useSprint = false
	self.sprintDistance = 5
	self.sprintSpeed = 0
	self.sprintDirect = true
	self.sprintStopWithCollision = false
	self.sprintStickTime = 0
	self.holdInSlider = false

	if self.gravity ~= 0 then
		self.timeToJumpApex = math.sqrt(-(2 * self.maxJumpHeight) / self.gravity)
		self.maxJumpVelocity = math.abs(self.gravity) * self.timeToJumpApex
		self.minJumpVelocity = math.sqrt(2 * Mathf.Abs(self.gravity) * self.minJumpHeight)
		self.jumpVelocitys = {}
		self.jumpTimes = self.jumpTimes <= 0 and 1 or self.jumpTimes

		if self.jumpHeights ~= nil then
			for iter_1_0 = 1, #self.jumpHeights do
				self.timeToJumpApex = math.sqrt(-(2 * self.jumpHeights[iter_1_0]) / self.gravity)

				table.insert(self.jumpVelocitys, math.abs(self.gravity) * self.timeToJumpApex)
			end
		end
	end

	return
end

return RectCollisionData
