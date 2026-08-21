local var_0_0 = class("RectCollisionData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.maxSlopeAngle = 45
	arg_1_0.downMaxSlopeSpeed = 8
	arg_1_0.gravity = -50
	arg_1_0.maxJumpHeight = 4
	arg_1_0.minJumpHeight = 2
	arg_1_0.accelerationTimeAirborne = 0.05
	arg_1_0.accelerationTimeGrounded = 0.05
	arg_1_0.moveSpeed = 8
	arg_1_0.wallJumpClimb = 10
	arg_1_0.wallJumpOff = 10
	arg_1_0.wallLeap = 10
	arg_1_0.wallSlideSpeedMax = 3
	arg_1_0.wallStickTime = 0.25
	arg_1_0.jumpStickTime = 0.01
	arg_1_0.jumpTimes = 0
	arg_1_0.jumpHeights = {
		50,
		30
	}
	arg_1_0.useSprint = false
	arg_1_0.sprintDistance = 5
	arg_1_0.sprintSpeed = 0
	arg_1_0.sprintDirect = true
	arg_1_0.sprintStopWithCollision = false
	arg_1_0.sprintStickTime = 0
	arg_1_0.holdInSlider = false

	if arg_1_0.gravity ~= 0 then
		arg_1_0.timeToJumpApex = math.sqrt(-(2 * arg_1_0.maxJumpHeight) / arg_1_0.gravity)
		arg_1_0.maxJumpVelocity = math.abs(arg_1_0.gravity) * arg_1_0.timeToJumpApex
		arg_1_0.minJumpVelocity = math.sqrt(2 * Mathf.Abs(arg_1_0.gravity) * arg_1_0.minJumpHeight)
		arg_1_0.jumpVelocitys = {}
		arg_1_0.jumpTimes = arg_1_0.jumpTimes <= 0 and 1 or arg_1_0.jumpTimes

		if arg_1_0.jumpHeights ~= nil then
			for iter_1_0 = 1, #arg_1_0.jumpHeights do
				arg_1_0.timeToJumpApex = math.sqrt(-(2 * arg_1_0.jumpHeights[iter_1_0]) / arg_1_0.gravity)

				table.insert(arg_1_0.jumpVelocitys, math.abs(arg_1_0.gravity) * arg_1_0.timeToJumpApex)
			end
		end
	end

	return
end

return var_0_0
