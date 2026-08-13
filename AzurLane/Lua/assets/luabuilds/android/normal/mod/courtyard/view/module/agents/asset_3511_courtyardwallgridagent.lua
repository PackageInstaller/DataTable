class = var_0_10000

local var_0_0 = "CourtYardWallGridAgent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardGridAgent"))

function var_0_1.Reset(arg_1_0, arg_1_1)
	table = var_1_10002

	var_1_10002.clear(arg_1_0.grids)

	for iter_1_0 = 1, #arg_1_1 do
		if iter_1_0 % 2 == 0 then
			local var_1_0 = arg_1_0:GetPool()
			local var_1_1 = var_6.Dequeue(var_1_0).transform

			var_7.SetParent(var_1_1, arg_1_0.gridsTF)

			local var_1_2 = var_6.transform

			Vector3 = var_1_1
			var_1_2.localScale = var_1_1.one
			table = var_1_2

			var_1_2.insert(arg_1_0.grids, var_6)
			arg_1_0:UpdatePositionAndColor(var_6, {
				arg_1_1[iter_1_0 - 1],
				arg_1_1[iter_1_0]
			})
		end
	end

	return
end

function var_0_1.Flush(arg_2_0, arg_2_1)
	for iter_2_0 = 1, #arg_2_1 do
		if iter_2_0 % 2 == 0 then
			local var_2_0 = arg_2_0.grids[iter_2_0 * 0.5]

			assert = var_7

			var_7(var_2_0)
			arg_2_0:UpdatePositionAndColor(var_2_0, {
				arg_2_1[iter_2_0 - 1],
				arg_2_1[iter_2_0]
			})
		end
	end

	return
end

function var_0_1.UpdatePositionAndColor(arg_3_0, arg_3_1, arg_3_2)
	table = var_1_10003

	var_1_10003.sort(arg_3_2, function(arg_4_0, arg_4_1)
		return arg_4_0.position.x + arg_4_0.position.y < arg_4_1.position.x + arg_4_1.position.y
	end)

	local var_3_0 = arg_3_2[1]

	CourtYardCalcUtil = var_4

	local var_3_1

	var_3_1.localPosition, var_3_1 = var_4.Map2Local(var_3_0.position), arg_3_1.transform
	_ = var_3_1

	local var_3_2 = var_3_1.all(arg_3_2, function(arg_5_0)
		return arg_5_0.flag == 1
	end)
	local var_3_3 = arg_3_0:GetColor(var_3_2 and 1 or 2)
	local var_3_4 = arg_3_1
	local var_3_5 = arg_3_1.GetComponent

	typeof = var_1_10009
	Image = var_1_10010
	var_3_5(var_3_4, var_1_10009(var_1_10010)).color = var_3_3

	local var_3_6 = var_3_0.position.y - var_3_0.position.x >= 1
	local var_3_7 = arg_3_1.transform

	if var_3_6 then
		Vector3 = var_3_8

		local var_3_8

		if not var_3_8(-1, 1, 1) then
			Vector3 = var_3_8
			var_3_8 = var_3_8(1, 1, 1)
		end

		var_3_7.localScale = var_3_8

		return
	end
end

function var_0_1.GetPool(arg_6_0)
	local var_6_0 = arg_6_0:GetView().poolMgr

	return var_1.GetWallGridPool(var_6_0)
end

return var_0_1
