local RectCollisionVertical = class("RectCollisionVertical")

RectCollisionVertical.directUp = Vector3(0, 1, 0)
RectCollisionVertical.directDown = Vector3(0, -1, 0)
RectCollisionVertical.directRight = Vector3(1, 0, 0)
RectCollisionVertical.directLeft = Vector3(-1, 0, 0)

function RectCollisionVertical:DescendSlope(arg_1_1, arg_1_2)
	local var_1_2 = Vector3(0, -1, 0)
	local var_1_3 = Mathf.Abs(self.y) + arg_1_2.skinWidth
	local var_1_4 = arg_1_1.layerMask
	local var_1_5, var_1_6 = Physics.Raycast(arg_1_2.bottomLeft, Vector3.down, nil, var_1_3, arg_1_1.layerMask)
	local var_1_7, var_1_8 = Physics.Raycast(arg_1_2.bottomRight, Vector3.down, nil, var_1_3, var_1_4)

	if var_1_5 or var_1_7 then
		local var_1_9 = false

		if var_1_5 and not var_1_7 or not var_1_5 and var_1_7 then
			var_1_9 = true
		else
			local var_1_10 = Vector3.Angle(var_1_6.normal, Vector3.up)
			local var_1_11 = Vector3.Angle(var_1_8.normal, Vector3.up)

			if var_1_10 <= arg_1_1.config.maxSlopeAngle and var_1_11 > arg_1_1.config.maxSlopeAngle then
				var_1_9 = true
			elseif var_1_10 > arg_1_1.config.maxSlopeAngle and var_1_11 <= arg_1_1.config.maxSlopeAngle then
				var_1_9 = true
			end
		end

		if var_1_9 then
			RectCollisionVertical.slideDownMaxSlope(var_1_6, self, arg_1_1)
			RectCollisionVertical.slideDownMaxSlope(var_1_8, self, arg_1_1)
		end
	end

	if not arg_1_1.slidingDownMaxSlope then
		local var_1_12 = Mathf.Sign(self.x)
		local var_1_13, var_1_14 = Physics.Raycast((var_1_12 == -1 or nil) and (arg_1_2.bottomRight or arg_1_2.bottomLeft), RectCollisionVertical.directDown, nil, Mathf.Infinity, var_1_4)

		if var_1_13 then
			local var_1_15 = Vector3.Angle(var_1_14.normal, RectCollisionVertical.directUp)

			if var_1_15 ~= 0 and var_1_15 <= arg_1_1.config.maxSlopeAngle and Mathf.Sign(var_1_14.normal.x) == var_1_12 and var_1_14.distance - arg_1_2.skinWidth <= Mathf.Tan(var_1_15 * Mathf.Deg2Rad) * Mathf.Abs(self.x) then
				local var_1_16 = Mathf.Abs(self.x)

				self.x = Mathf.Cos(var_1_15 * Mathf.Deg2Rad) * var_1_16 * Mathf.Sign(self.x)
				self.y = self.y - Mathf.Sin(var_1_15 * Mathf.Deg2Rad) * var_1_16
				arg_1_1.slopeAngle = var_1_15
				arg_1_1.descendingSlope = true
				arg_1_1.below = true
				arg_1_1.slopeNormal = var_1_14.normal
			end
		end
	end

	return
end

function RectCollisionVertical:slideDownMaxSlope(arg_2_1, arg_2_2)
	if self and arg_2_1.y ~= 0 then
		local var_2_0 = Vector3.Angle(self.normal, Vector3.up)

		if var_2_0 > arg_2_2.config.maxSlopeAngle then
			if Mathf.Abs(arg_2_1.y) > arg_2_2.config.downMaxSlopeSpeed * Time.deltaTime then
				arg_2_1.y = arg_2_2.config.downMaxSlopeSpeed * Time.deltaTime * Mathf.Sign(arg_2_1.y)
			end

			arg_2_1.x = Mathf.Sign(self.normal.x) * ((Mathf.Abs(arg_2_1.y) - self.distance) / Mathf.Tan(var_2_0 * Mathf.Deg2Rad))
			arg_2_2.slopeAngle = var_2_0
			arg_2_2.slidingDownMaxSlope = true
			arg_2_2.slopeNormal = self.normal
		end
	end

	return
end

function RectCollisionVertical:VerticalCollisions(arg_3_1, arg_3_2)
	local var_3_0 = Mathf.Sign(self.y)
	local var_3_1

	if var_3_0 == 1 then
		var_3_1 = RectCollisionVertical.directUp or RectCollisionVertical.directDown
	end

	local var_3_2 = Mathf.Abs(self.y) + arg_3_2.skinWidth * 2
	local var_3_3 = Vector3(0, 0, 0)
	local var_3_4

	if var_3_0 == -1 then
		var_3_4 = arg_3_2.bottomLeft or arg_3_2.topLeft
	end

	for iter_3_0 = 1, arg_3_2.verticalRayCount do
		var_3_3.x = var_3_4.x + (arg_3_2.verticalRaySpacing * (iter_3_0 - 1) + self.x)
		var_3_3.y = var_3_4.y
		var_3_3.z = var_3_4.z

		local var_3_5, var_3_6 = Physics.Raycast(var_3_3, var_3_1, nil, var_3_2, arg_3_1.layerMask)
		local var_3_7 = false

		if var_3_6 then
			if table.contains(arg_3_1.ignoreLayerMask, go(var_3_6.transform.parent).layer) then
				var_3_7 = true
			end

			if var_3_0 == 1 and not arg_3_1.verticalTopTfs[var_3_6.transform.parent] then
				arg_3_1.verticalTopTfs[var_3_6.transform.parent] = var_3_6.transform.parent
			elseif var_3_0 == -1 and not arg_3_1.verticalBottomTfs[var_3_6.transform.parent] then
				arg_3_1.verticalBottomTfs[var_3_6.transform.parent] = var_3_6.transform.parent
			end
		end

		if not var_3_7 and var_3_5 then
			if not false then
				self.y = (var_3_6.distance - arg_3_2.skinWidth) * var_3_0
				var_3_2 = var_3_6.distance

				if arg_3_1.climbingSlope then
					self.x = self.y / Mathf.Tan(arg_3_1.slopeAngle * Mathf.Deg2Rad) * Mathf.Sign(self.x)
				end

				arg_3_1.below = var_3_0 == -1
				arg_3_1.above = var_3_0 == 1
			end
		end
	end

	return
end

return RectCollisionVertical
