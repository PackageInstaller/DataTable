class = var_0_10000

local var_0_0 = var_0_10000("RectCollisionVertical")

Vector3 = var_0_10001
var_0_0.directUp = var_0_10001(0, 1, 0)
Vector3 = var_1
var_0_0.directDown = var_1(0, -1, 0)
Vector3 = var_1
var_0_0.directRight = var_1(1, 0, 0)
Vector3 = var_1
var_0_0.directLeft = var_1(-1, 0, 0)

function var_0_0.DescendSlope(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2.bottomLeft
	local var_1_1 = arg_1_2.bottomRight

	Vector3 = var_1_10005

	local var_1_2 = var_1_10005(0, -1, 0)

	Mathf = var_1_10006

	local var_1_3 = var_1_10006.Abs(arg_1_0.y) + arg_1_2.skinWidth
	local var_1_4 = arg_1_1.layerMask

	Physics = var_8

	local var_1_5 = var_8.Raycast
	local var_1_6 = arg_1_2.bottomLeft

	Vector3 = var_1_10011

	local var_1_7, var_1_8 = var_1_5(var_1_6, var_1_10011.down, nil, var_1_3, var_1_4)

	Physics = var_1_6

	local var_1_9 = var_1_6.Raycast
	local var_1_10 = arg_1_2.bottomRight

	Vector3 = var_13

	local var_1_11, var_1_12 = var_1_9(var_1_10, var_13.down, nil, var_1_3, var_1_4)

	if var_1_7 or var_1_11 then
		local var_1_13 = false

		if var_1_7 and not var_1_11 or not var_1_7 and var_1_11 then
			var_1_13 = true
		else
			Vector3 = var_13

			local var_1_14 = var_13.Angle
			local var_1_15 = var_1_8.normal

			Vector3 = var_16

			local var_1_16 = var_1_14(var_1_15, var_16.up)

			Vector3 = var_14

			local var_1_17 = var_14.Angle
			local var_1_18 = var_1_12.normal

			Vector3 = var_1_10017

			local var_1_19 = var_1_17(var_1_18, var_1_10017.up)

			if var_1_16 <= arg_1_1.config.maxSlopeAngle and var_1_19 > arg_1_1.config.maxSlopeAngle then
				var_1_13 = true
			elseif var_1_16 > arg_1_1.config.maxSlopeAngle and var_1_19 <= arg_1_1.config.maxSlopeAngle then
				var_1_13 = true
			end
		end

		if var_1_13 then
			var_0_0.slideDownMaxSlope(var_1_8, arg_1_0, arg_1_1)
			var_0_0.slideDownMaxSlope(var_1_12, arg_1_0, arg_1_1)
		end
	end

	if not arg_1_1.slidingDownMaxSlope then
		Mathf = var_12

		local var_1_20

		if var_12.Sign(arg_1_0.x) ~= -1 or not arg_1_2.bottomRight then
			var_1_20 = arg_1_2.bottomLeft
		end

		Physics = var_14

		local var_1_21 = var_14.Raycast
		local var_1_22 = var_1_20
		local var_1_23 = var_0_0.directDown
		local var_1_24

		Mathf = var_1_10019

		local var_1_25, var_1_26 = var_1_21(var_1_22, var_1_23, var_1_24, var_1_10019.Infinity, var_1_4)

		if var_1_25 then
			Vector3 = var_1_22

			if var_1_22.Angle(var_1_26.normal, var_0_0.directUp) ~= 0 and var_16 <= arg_1_1.config.maxSlopeAngle then
				Mathf = var_17

				if var_17.Sign(var_1_26.normal.x) == var_12 then
					local var_1_27 = var_1_26.distance - arg_1_2.skinWidth

					Mathf = var_18

					local var_1_28 = var_18.Tan

					Mathf = var_20

					local var_1_29 = var_1_28(var_16 * var_20.Deg2Rad)

					Mathf = var_19

					if var_1_27 <= var_1_29 * var_19.Abs(arg_1_0.x) then
						Mathf = var_1_27

						local var_1_30 = var_1_27.Abs(arg_1_0.x)

						Mathf = var_18

						local var_1_31 = var_18.Sin

						Mathf = var_20

						local var_1_32 = var_1_31(var_16 * var_20.Deg2Rad) * var_1_30

						Mathf = var_19

						local var_1_33 = var_19.Cos

						Mathf = var_21

						local var_1_34 = var_1_33(var_16 * var_21.Deg2Rad) * var_1_30

						Mathf = var_20
						arg_1_0.x = var_1_34 * var_20.Sign(arg_1_0.x)
						arg_1_0.y = arg_1_0.y - var_1_32
						arg_1_1.slopeAngle = var_16
						arg_1_1.descendingSlope = true
						arg_1_1.below = true
						arg_1_1.slopeNormal = var_1_26.normal
					end
				end
			end
		end
	end

	return
end

function var_0_0.slideDownMaxSlope(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0 and arg_2_1.y ~= 0 then
		Vector3 = var_3

		local var_2_0 = var_3.Angle
		local var_2_1 = arg_2_0.normal

		Vector3 = var_1_10006

		local var_2_2 = var_2_0(var_2_1, var_1_10006.up)

		if arg_2_2.config.maxSlopeAngle < var_2_2 then
			Mathf = var_4

			local var_2_3 = var_4.Sign(arg_2_1.y)

			Mathf = var_2_1

			local var_2_4 = var_2_1.Abs(arg_2_1.y)
			local var_2_5 = arg_2_2.config.downMaxSlopeSpeed

			Time = var_7

			if var_2_5 * var_7.deltaTime < var_2_4 then
				var_2_4 = arg_2_2.config.downMaxSlopeSpeed
				Time = var_6
				arg_2_1.y = var_2_4 * var_6.deltaTime * var_2_3
			end

			Mathf = var_2_4

			local var_2_6 = var_2_4.Abs(arg_2_1.y) - arg_2_0.distance

			Mathf = var_6

			local var_2_7 = var_6.Tan

			Mathf = var_1_10008

			local var_2_8 = var_2_6 / var_2_7(var_2_2 * var_1_10008.Deg2Rad)

			Mathf = var_6
			arg_2_1.x = var_6.Sign(arg_2_0.normal.x) * var_2_8
			arg_2_2.slopeAngle = var_2_2
			arg_2_2.slidingDownMaxSlope = true
			arg_2_2.slopeNormal = arg_2_0.normal
		end
	end

	return
end

function var_0_0.VerticalCollisions(arg_3_0, arg_3_1, arg_3_2)
	Mathf = var_1_10003

	local var_3_0

	if var_1_10003.Sign(arg_3_0.y) ~= 1 or not var_0_0.directUp then
		var_3_0 = var_0_0.directDown
	end

	Mathf = var_5

	local var_3_1 = var_5.Abs(arg_3_0.y) + arg_3_2.skinWidth * 2

	Vector3 = var_6

	local var_3_2 = var_6(0, 0, 0)
	local var_3_3

	if var_3 ~= -1 or not arg_3_2.bottomLeft then
		var_3_3 = arg_3_2.topLeft
	end

	for iter_3_0 = 1, arg_3_2.verticalRayCount do
		var_3_2.x = var_3_3.x + (arg_3_2.verticalRaySpacing * (iter_3_0 - 1) + arg_3_0.x)
		var_3_2.y = var_3_3.y
		var_3_2.z = var_3_3.z
		Physics = var_12

		local var_3_4, var_3_5 = var_12.Raycast(var_3_2, var_3_0, nil, var_3_1, arg_3_1.layerMask)
		local var_3_6 = false
		local var_3_7 = false

		if var_3_5 then
			local var_3_8 = var_3_5.transform.parent

			table = var_17

			local var_3_9 = var_17.contains
			local var_3_10 = arg_3_1.ignoreLayerMask

			go = var_1_10020

			if var_3_9(var_3_10, var_1_10020(var_3_8).layer) then
				var_3_7 = true
			end

			if var_3 == 1 and not arg_3_1.verticalTopTfs[var_3_8] then
				arg_3_1.verticalTopTfs[var_3_8] = var_3_8
			elseif var_3 == -1 and not arg_3_1.verticalBottomTfs[var_3_8] then
				arg_3_1.verticalBottomTfs[var_3_8] = var_3_8
			end
		end

		if not var_3_7 and var_3_4 then
			local var_3_11 = var_3_5

			if not var_3_6 then
				arg_3_0.y = (var_3_5.distance - arg_3_2.skinWidth) * var_3
				var_3_1 = var_3_5.distance

				if arg_3_1.climbingSlope then
					local var_3_12 = arg_3_0.y

					Mathf = var_18

					local var_3_13 = var_18.Tan

					var_1_10020 = arg_3_1.slopeAngle
					Mathf = var_1_10021

					local var_3_14 = var_3_12 / var_3_13(var_1_10020 * var_1_10021.Deg2Rad)

					Mathf = var_18
					arg_3_0.x = var_3_14 * var_18.Sign(arg_3_0.x)
				end

				arg_3_1.below = var_3 == -1
				arg_3_1.above = var_3 == 1
			end
		end
	end

	return
end

return var_0_0
