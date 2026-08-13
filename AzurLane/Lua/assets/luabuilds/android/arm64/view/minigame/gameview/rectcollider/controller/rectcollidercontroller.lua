class = var_0_10000

local var_0_0 = var_0_10000("RectColliderController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.collisionInfo = arg_1_1
	arg_1_0.origins = arg_1_2
	Vector2 = var_1_10003
	arg_1_0.zeroVec = var_1_10003.zero

	return
end

function var_0_0.platformMove(arg_2_0, arg_2_1)
	arg_2_0.collisionInfo.standingOnPlatform = true

	arg_2_0:move(arg_2_1)

	return
end

function var_0_0.move(arg_3_0, arg_3_1)
	arg_3_0:updateCollisionInfo(arg_3_1)

	if arg_3_1.y <= 0 then
		RectCollisionVertical = var_2

		var_2.DescendSlope(arg_3_1, arg_3_0.collisionInfo, arg_3_0.origins)
	end

	RectCollisionHorizontal = var_2

	var_2.HorizontalCollisions(arg_3_1, arg_3_0.collisionInfo, arg_3_0.origins)

	if arg_3_1.y ~= 0 then
		RectCollisionVertical = var_2

		var_2.VerticalCollisions(arg_3_1, arg_3_0.collisionInfo, arg_3_0.origins)
	end

	arg_3_0.collisionInfo.moveAmount = arg_3_1

	arg_3_0:afterUpdateCollisionInfo()

	return
end

function var_0_0.updateCollisionInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.origins

	var_2.updateRaycastOrigins(var_4_0)

	local var_4_1 = arg_4_0.collisionInfo

	var_2.reset(var_4_1)

	arg_4_0.collisionInfo.moveAmountOld = arg_4_1
	arg_4_0.collisionInfo.MoveDir = arg_4_1.x > 0 and 1 or arg_4_0.collisionInfo.MoveDir
	arg_4_0.collisionInfo.MoveDir = arg_4_1.x < 0 and -1 or arg_4_0.collisionInfo.MoveDir

	return
end

function var_0_0.afterUpdateCollisionInfo(arg_5_0)
	local var_5_0 = arg_5_0.collisionInfo
	local var_5_1

	if not arg_5_0.collisionInfo.standingOnPlatform then
		var_5_1 = arg_5_0.collisionInfo.below
	end

	var_5_0.below = var_5_1

	return
end

return var_0_0
