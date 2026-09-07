local RectCollisionHorizontal = class("RectCollisionHorizontal")

RectCollisionHorizontal.directUp = Vector3(0, 1, 0)
RectCollisionHorizontal.directDown = Vector3(0, -1, 0)
RectCollisionHorizontal.directRight = Vector3(1, 0, 0)
RectCollisionHorizontal.directLeft = Vector3(-1, 0, 0)

function RectCollisionHorizontal:HorizontalCollisions(arg_1_1, arg_1_2)
	local var_1_0 = self.x ~= 0 and Mathf.Sign(self.x) or arg_1_1.MoveDir
	local var_1_1

	if var_1_0 == 1 then
		var_1_1 = RectCollisionHorizontal.directRight or RectCollisionHorizontal.directLeft

		local var_1_2

		if var_1_0 == -1 then
			var_1_2 = arg_1_2.bottomLeft or arg_1_2.bottomRight
		end
	end

	local var_1_3 = Mathf.Abs(self.x) + arg_1_2.skinWidth

	if Mathf.Abs(self.x) < arg_1_2.skinWidth then
		var_1_3 = 2 * arg_1_2.skinWidth
	end

	local var_1_4 = false

	for iter_1_0 = 1, arg_1_2.horizontalRayCount do
		Vector3.zero.x = var_1_2.x
		Vector3.zero.y = var_1_2.y + arg_1_2.horizontalRaySpacing * (iter_1_0 - 1)
		Vector3.zero.z = var_1_2.z

		local var_1_5, var_1_6 = Physics.Raycast(Vector3.zero, var_1_1, nil, var_1_3, arg_1_1.layerMask)
		local var_1_7 = false

		if var_1_6 then
			if table.contains(arg_1_1.ignoreLayerMask, go(var_1_6.transform.parent).layer) then
				var_1_7 = true
			end

			if var_1_0 == 1 and not arg_1_1.horizontalRightTfs[var_1_6.transform.parent] then
				arg_1_1.horizontalRightTfs[var_1_6.transform.parent] = var_1_6.transform.parent
			elseif var_1_0 == -1 and not arg_1_1.horizontalLeftTfs[var_1_6.transform.parent] then
				arg_1_1.horizontalLeftTfs[var_1_6.transform.parent] = var_1_6.transform.parent
			end
		end

		if not var_1_7 and var_1_5 and var_1_6.distance ~= 0 then
			local var_1_8 = Vector3.Angle(var_1_6.normal, RectCollisionHorizontal.directUp)

			if iter_1_0 == 1 and var_1_8 <= arg_1_1.config.maxSlopeAngle then
				if arg_1_1.descendingSlope then
					arg_1_1.descendingSlope = false
					self = arg_1_1.moveAmountOld
				end

				local var_1_9 = 0

				if var_1_8 ~= arg_1_1.slopeAngleOld then
					var_1_9 = var_1_6.distance - arg_1_2.skinWidth
					self.x = self.x - (var_1_6.distance - arg_1_2.skinWidth) * var_1_0
				end

				RectCollisionHorizontal.ClimbSlope(self, arg_1_1, var_1_8, var_1_6.normal)

				self.x = self.x + var_1_9 * var_1_0
			end

			if not arg_1_1.climbingSlope or var_1_8 > arg_1_1.config.maxSlopeAngle then
				self.x = (var_1_6.distance - arg_1_2.skinWidth) * var_1_0
				var_1_3 = var_1_6.distance

				if arg_1_1.climbingSlope then
					self.y = Mathf.Tan(arg_1_1.slopeAngle * Mathf.Deg2Rad) * Mathf.Abs(self.x)
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
		Vector3.zero.x = var_1_2.x
		Vector3.zero.y = var_1_2.y + arg_1_2.horizontalRaySpacing * (arg_1_2.horizontalRayCount - 1)
		Vector3.zero.z = var_1_2.z

		local var_1_10, var_1_11 = Physics.Raycast(Vector3.zero, var_1_1, nil, 2 * arg_1_2.skinWidth, arg_1_1.layerMask)

		if var_1_10 and Vector3.Angle(var_1_11.normal, RectCollisionHorizontal.directUp) > arg_1_1.config.maxSlopeAngle then
			arg_1_1.fullSliding = true
		end
	end

	return
end

function RectCollisionHorizontal:ClimbSlope(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = Mathf.Abs(self.x)
	local var_2_1 = Mathf.Sin(arg_2_2 * Mathf.Deg2Rad) * var_2_0

	if var_2_1 >= self.y then
		self.y = var_2_1
		self.x = Mathf.Cos(arg_2_2 * Mathf.Deg2Rad) * var_2_0 * Mathf.Sign(self.x)
		arg_2_1.below = true
		arg_2_1.climbingSlope = true
		arg_2_1.slopeAngle = arg_2_2
		arg_2_1.slopeNormal = arg_2_3
	end

	return
end

return RectCollisionHorizontal
