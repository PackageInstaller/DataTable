class = var_0_10000

local var_0_0 = var_0_10000("RectCollisionHorizontal")

Vector3 = var_0_10001
var_0_0.directUp = var_0_10001(0, 1, 0)
Vector3 = var_1
var_0_0.directDown = var_1(0, -1, 0)
Vector3 = var_1
var_0_0.directRight = var_1(1, 0, 0)
Vector3 = var_1
var_0_0.directLeft = var_1(-1, 0, 0)

function var_0_0.HorizontalCollisions(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0.x ~= 0 then
		Mathf = var_3

		local var_1_0

		if not var_3.Sign(arg_1_0.x) then
			var_1_0 = arg_1_1.MoveDir
		end

		local var_1_1

		if var_1_0 ~= 1 or not var_0_0.directRight then
			var_1_1 = var_0_0.directLeft
		end

		local var_1_2

		if var_1_0 ~= -1 or not arg_1_2.bottomLeft then
			var_1_2 = arg_1_2.bottomRight
		end

		Mathf = var_1_10006

		local var_1_3 = var_1_10006.Abs(arg_1_0.x) + arg_1_2.skinWidth

		Mathf = var_7

		if var_7.Abs(arg_1_0.x) < arg_1_2.skinWidth then
			var_1_3 = 2 * arg_1_2.skinWidth
		end

		local var_1_4 = false

		Vector3 = var_8

		local var_1_5 = var_8.zero

		for iter_1_0 = 1, arg_1_2.horizontalRayCount do
			var_1_5.x = var_1_2.x
			var_1_5.y = var_1_2.y + arg_1_2.horizontalRaySpacing * (iter_1_0 - 1)
			var_1_5.z = var_1_2.z
			Physics = var_13

			local var_1_6, var_1_7 = var_13.Raycast(var_1_5, var_1_1, nil, var_1_3, arg_1_1.layerMask)
			local var_1_8 = false

			if var_1_7 then
				local var_1_9 = var_1_7.transform.parent

				table = var_17

				local var_1_10 = var_17.contains
				local var_1_11 = arg_1_1.ignoreLayerMask

				go = var_1_10020

				if var_1_10(var_1_11, var_1_10020(var_1_9).layer) then
					var_1_8 = true
				end

				if var_1_0 == 1 and not arg_1_1.horizontalRightTfs[var_1_9] then
					arg_1_1.horizontalRightTfs[var_1_9] = var_1_9
				elseif var_1_0 == -1 and not arg_1_1.horizontalLeftTfs[var_1_9] then
					arg_1_1.horizontalLeftTfs[var_1_9] = var_1_9
				end
			end

			if not var_1_8 and var_1_6 and var_1_7.distance ~= 0 then
				Vector3 = var_16

				local var_1_12 = var_16.Angle(var_1_7.normal, var_0_0.directUp)

				if iter_1_0 == 1 and var_1_12 <= arg_1_1.config.maxSlopeAngle then
					if arg_1_1.descendingSlope then
						arg_1_1.descendingSlope = false
						arg_1_0 = arg_1_1.moveAmountOld
					end

					local var_1_13 = 0

					if var_1_12 ~= arg_1_1.slopeAngleOld then
						var_1_13 = var_1_7.distance - arg_1_2.skinWidth
						arg_1_0.x = arg_1_0.x - var_1_13 * var_1_0
					end

					RectCollisionHorizontal = var_18

					var_18.ClimbSlope(arg_1_0, arg_1_1, var_1_12, var_1_7.normal)

					arg_1_0.x = arg_1_0.x + var_1_13 * var_1_0
				end

				if not arg_1_1.climbingSlope or var_1_12 > arg_1_1.config.maxSlopeAngle then
					arg_1_0.x = (var_1_7.distance - arg_1_2.skinWidth) * var_1_0
					var_1_3 = var_1_7.distance

					if arg_1_1.climbingSlope then
						Mathf = var_17

						local var_1_14 = var_17.Tan
						local var_1_15 = arg_1_1.slopeAngle

						Mathf = var_1_10020

						local var_1_16 = var_1_14(var_1_15 * var_1_10020.Deg2Rad)

						Mathf = var_18
						arg_1_0.y = var_1_16 * var_18.Abs(arg_1_0.x)
					end

					if iter_1_0 == 1 then
						var_1_4 = true
					end

					arg_1_1.left = var_1_0 == -1
					arg_1_1.right = var_1_0 == 1
				end
			end
		end

		if var_1_4 then
			local var_1_17 = 2 * arg_1_2.skinWidth

			var_1_5.x = var_1_2.x
			var_1_5.y = var_1_2.y + arg_1_2.horizontalRaySpacing * (arg_1_2.horizontalRayCount - 1)
			var_1_5.z = var_1_2.z
			Physics = var_10

			local var_1_18, var_1_19 = var_10.Raycast(var_1_5, var_1_1, nil, var_1_17, arg_1_1.layerMask)

			if var_1_18 then
				Vector3 = var_12

				if var_12.Angle(var_1_19.normal, var_0_0.directUp) > arg_1_1.config.maxSlopeAngle then
					arg_1_1.fullSliding = true
				end
			end
		end

		return
	end
end

function var_0_0.ClimbSlope(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	Mathf = var_1_10004

	local var_2_0 = var_1_10004.Abs(arg_2_0.x)

	Mathf = var_1_10005

	local var_2_1 = var_1_10005.Sin

	Mathf = var_1_10007

	local var_2_2 = var_2_1(arg_2_2 * var_1_10007.Deg2Rad) * var_2_0

	if arg_2_0.y <= var_2_2 then
		arg_2_0.y = var_2_2
		Mathf = var_6

		local var_2_3 = var_6.Cos

		Mathf = var_1_10008

		local var_2_4 = var_2_3(arg_2_2 * var_1_10008.Deg2Rad) * var_2_0

		Mathf = var_7
		arg_2_0.x = var_2_4 * var_7.Sign(arg_2_0.x)
		arg_2_1.below = true
		arg_2_1.climbingSlope = true
		arg_2_1.slopeAngle = arg_2_2
		arg_2_1.slopeNormal = arg_2_3
	end

	return
end

return var_0_0
