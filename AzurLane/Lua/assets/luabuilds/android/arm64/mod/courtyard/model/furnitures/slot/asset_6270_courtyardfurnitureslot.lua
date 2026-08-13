class = var_0_10000

local var_0_0 = "CourtYardFurnitureSlot"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardFurnitureBaseSlot"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.actionName = arg_1_1[1]

	if arg_1_1[2] then
		Vector3 = var_1_0

		local var_1_0

		if not var_1_0(arg_1_1[2][1], arg_1_1[2][2], 0) then
			Vector3 = var_1_0
			var_1_0 = var_1_0.zero
		end

		arg_1_0.offset = var_1_0

		if arg_1_1[3] then
			Vector3 = var_1_1

			local var_1_1

			if not var_1_1(arg_1_1[3][1], arg_1_1[3][2], 1) then
				Vector3 = var_1_1
				var_1_1 = var_1_1.one
			end

			arg_1_0.scale = var_1_1
			arg_1_0.mask = arg_1_1[4]

			if arg_1_1[6] then
				local var_1_2 = {}

				if arg_1_1[6][1] then
					Vector2 = var_1_3

					local var_1_3

					if not var_1_3(arg_1_1[6][1][1], arg_1_1[6][1][2]) then
						Vector3 = var_1_3
						var_1_3 = var_1_3.zero
					end

					var_1_2.offset = var_1_3

					if arg_1_1[6][2] then
						Vector2 = var_1_4

						local var_1_4

						if not var_1_4(arg_1_1[6][2][1], arg_1_1[6][2][2]) then
							Vector3 = var_1_4
							var_1_4 = var_1_4.zero
						end

						var_1_2.size = var_1_4
						var_1_2.img = arg_1_1[6][3]
						arg_1_0.bodyMask = var_1_2

						return
					end
				end
			end
		end
	end
end

function var_0_1.OnInitCombine(arg_2_0, arg_2_1)
	arg_2_0.combineData = arg_2_1

	return
end

function var_0_1.GetMask(arg_3_0)
	if arg_3_0.mask == "" then
		return nil
	end

	return arg_3_0.mask
end

function var_0_1.OnStart(arg_4_0)
	if arg_4_0:GetCombineFurnitureAnimator() then
		local var_4_0

		if not var_1[2] then
			var_4_0 = arg_4_0.defaultAction
		end

		return var_4_0
	end

	local var_4_1 = arg_4_0.user

	var_2.UpdateInteraction(var_4_1, {
		action = arg_4_0.actionName
	})

	return
end

return var_0_1
