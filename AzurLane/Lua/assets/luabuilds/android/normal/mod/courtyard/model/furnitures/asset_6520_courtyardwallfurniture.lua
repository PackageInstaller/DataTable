class = var_0_10000

local var_0_0 = "CourtYardWallFurniture"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardFurniture"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	local var_1_0 = var_1_10003.furniture_data_template
	local var_1_1

	if not arg_1_2.configId then
		var_1_1 = arg_1_2.id
	end

	var_1_0[var_1_1].size[2] = 1

	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	arg_2_0:UpdatePosition(arg_2_1)

	return
end

function var_0_1.UpdatePosition(arg_3_0, arg_3_1)
	arg_3_0:SetPosition(arg_3_1)
	arg_3_0:SetDir(arg_3_0:GetDirection())

	return
end

function var_0_1.GetInitSize(arg_4_0)
	if arg_4_0:RightDirectionLimited() then
		return {
			{
				arg_4_0.sizeY,
				arg_4_0.sizeX
			}
		}
	elseif arg_4_0:LeftDirectionLimited() then
		return {
			{
				arg_4_0.sizeX,
				arg_4_0.sizeY
			}
		}
	else
		return {
			{
				arg_4_0.sizeX,
				arg_4_0.sizeY
			},
			{
				arg_4_0.sizeY,
				arg_4_0.sizeX
			}
		}
	end

	return
end

function var_0_1._GetDirection(arg_5_0, arg_5_1)
	if arg_5_0:RightDirectionLimited() then
		return 2
	elseif arg_5_0:LeftDirectionLimited() then
		return 1
	elseif arg_5_1.y - arg_5_1.x >= 1 then
		return 1
	else
		return 2
	end

	return
end

function var_0_1.GetWidth(arg_6_0)
	return arg_6_0.config.size[1]
end

function var_0_1.GetDirection(arg_7_0)
	local var_7_0 = arg_7_0:GetPosition()

	return arg_7_0:_GetDirection(var_7_0)
end

function var_0_1.Rotate(arg_8_0)
	return
end

function var_0_1.InActivityRange(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetHost()
	local var_9_1 = var_2.GetStorey(var_9_0)
	local var_9_2 = var_2.GetRange(var_9_1)

	return (arg_9_1.x == var_9_2.x or arg_9_1.y == var_9_2.y) and arg_9_1.x ~= arg_9_1.y
end

function var_0_1.LeftDirectionLimited(arg_10_0)
	return arg_10_0.config.belong == 3
end

function var_0_1.RightDirectionLimited(arg_11_0)
	return arg_11_0.config.belong == 4
end

function var_0_1.NormalizePosition(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:GetHost()
	local var_12_1 = var_3.GetStorey(var_12_0)
	local var_12_2 = var_3.GetRange(var_12_1).x
	local var_12_3 = arg_12_0

	if arg_12_0._GetDirection(var_12_3, arg_12_1) == 1 then
		Vector2 = var_12_3

		if not var_12_3(arg_12_1.x, arg_12_1.y) then
			Vector2 = var_12_3
			var_12_3 = var_12_3(arg_12_1.y, arg_12_1.x)
		end

		local var_12_4 = var_12_3.x
		local var_12_5 = arg_12_0
		local var_12_6 = arg_12_0.GetWidth(var_12_5)

		math = var_12_5

		local var_12_7 = var_12_5.min(var_12_4, var_12_2 - var_12_6)

		math = var_8

		local var_12_8 = var_8.max(arg_12_2, var_12_7)

		if var_4 then
			Vector2 = var_12_9

			local var_12_9

			if not var_12_9(var_12_8, var_12_2) then
				Vector2 = var_12_9
				var_12_9 = var_12_9(var_12_2, var_12_8)
			end

			arg_12_0:SetDir(arg_12_0:_GetDirection(var_12_9))

			return var_12_9
		end
	end
end

function var_0_1.SetDir(arg_13_0, arg_13_1)
	var_0_1.super.SetDir(arg_13_0, arg_13_1)

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.DispatchEvent

	CourtYardEvent = var_4

	var_13_1(var_13_0, var_4.ROTATE_FURNITURE, arg_13_0.dir)

	return
end

function var_0_1.CanPutChild(arg_14_0)
	return false
end

return var_0_1
