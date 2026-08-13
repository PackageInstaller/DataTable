class = var_0_10000

local var_0_0 = var_0_10000("RectCollisionData")

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
		math = var_2
		arg_1_0.timeToJumpApex = var_2.sqrt(-(2 * arg_1_0.maxJumpHeight) / arg_1_0.gravity)
		math = var_2
		arg_1_0.maxJumpVelocity = var_2.abs(arg_1_0.gravity) * arg_1_0.timeToJumpApex
		math = var_2

		local var_1_0 = var_2.sqrt

		Mathf = var_3
		arg_1_0.minJumpVelocity = var_1_0(2 * var_3.Abs(arg_1_0.gravity) * arg_1_0.minJumpHeight)
		arg_1_0.jumpVelocitys = {}
		arg_1_0.jumpTimes = arg_1_0.jumpTimes <= 0 and 1 or arg_1_0.jumpTimes

		if arg_1_0.jumpHeights ~= nil then
			for iter_1_0 = 1, #arg_1_0.jumpHeights do
				math = var_1_10006
				arg_1_0.timeToJumpApex = var_1_10006.sqrt(-(2 * arg_1_0.jumpHeights[iter_1_0]) / arg_1_0.gravity)
				table = var_1_10006
				var_1_10006 = var_1_10006.insert

				local var_1_1 = arg_1_0.jumpVelocitys

				math = var_8

				var_1_10006(var_1_1, var_8.abs(arg_1_0.gravity) * arg_1_0.timeToJumpApex)
			end
		end
	end

	return
end

return var_0_0
