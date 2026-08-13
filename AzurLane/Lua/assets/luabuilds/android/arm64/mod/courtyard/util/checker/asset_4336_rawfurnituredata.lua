class = var_0_10000

local var_0_0 = var_0_10000("RawFurnitureData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002
	arg_1_0.config = var_1_10002.furniture_data_template[arg_1_1.configId]
	arg_1_0.name = arg_1_0.config.name
	arg_1_0.id = arg_1_1.id
	arg_1_0.floor = arg_1_1.floor
	arg_1_0.parent = arg_1_1.parent
	arg_1_0.dir = arg_1_1.dir
	arg_1_0.child = arg_1_1.child
	arg_1_0.position = arg_1_1.position

	local var_1_0

	if not arg_1_0.position or not arg_1_0.position.x then
		var_1_0 = arg_1_1.x
	end

	arg_1_0.x = var_1_0

	local var_1_1

	if not arg_1_0.position or not arg_1_0.position.y then
		var_1_1 = arg_1_1.y
	end

	arg_1_0.y = var_1_1

	if arg_1_0.dir == 1 then
		arg_1_0.sizeX = arg_1_0.config.size[1]
		arg_1_0.sizeY = arg_1_0.config.size[2]
	else
		arg_1_0.sizeX = arg_1_0.config.size[2]
		arg_1_0.sizeY = arg_1_0.config.size[1]
	end

	return
end

function var_0_0.IsCompletion(arg_2_0)
	if not arg_2_0.floor then
		return false
	end

	if not arg_2_0.parent then
		return false
	end

	if not arg_2_0.dir or arg_2_0.dir < 0 or arg_2_0.dir > 2 then
		return false
	end

	if not arg_2_0.child then
		return false
	end

	if not arg_2_0.x or not arg_2_0.y then
		return false
	end

	return true
end

function var_0_0.ExistParnet(arg_3_0)
	local var_3_0

	if arg_3_0.parent then
		var_3_0 = arg_3_0.parent ~= 0
	end

	return var_3_0
end

function var_0_0.LegalParent(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return false
	end

	if not arg_4_1:LegalChild(arg_4_0) then
		return false
	end

	return true
end

function var_0_0.LegalChild(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return false
	end

	if arg_5_1.parent ~= arg_5_0.id then
		return false
	end

	local var_5_0 = {}

	pairs = var_3

	local var_5_1

	if not arg_5_0.child then
		var_5_1 = {}
	end

	for iter_5_0, iter_5_1 in var_3(var_5_1) do
		table = var_1_10008

		var_1_10008.insert(var_5_0, iter_5_0)
	end

	table = var_3

	if not var_3.contains(var_5_0, arg_5_1.id) then
		return false
	end

	return true
end

function var_0_0.InSide(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0.config.belong == 1 and arg_6_0.config.type ~= 1 and arg_6_0.config.type ~= 4 and not arg_6_0:ExistParnet() then
		local var_6_0 = arg_6_0:GetAreaByPosition()

		_ = var_1_10006

		return var_1_10006.all(var_6_0, function(arg_7_0)
			return arg_7_0.x >= arg_6_1 and arg_7_0.y >= arg_6_2 and arg_7_0.x <= arg_6_3 and arg_7_0.y <= arg_6_4
		end)
	end

	if arg_6_0.config.belong == 3 and arg_6_0.x >= arg_6_3 + 1 then
		return false
	end

	if arg_6_0.config.belong == 4 and arg_6_0.y >= arg_6_4 + 1 then
		return false
	end

	return true
end

function var_0_0.GetAreaByPosition(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = arg_8_0.x, arg_8_0.x + arg_8_0.sizeX - 1 do
		for iter_8_1 = arg_8_0.y, arg_8_0.y + arg_8_0.sizeY - 1 do
			table = var_1_10010
			var_1_10010 = var_1_10010.insert

			local var_8_1 = var_8_0

			Vector2 = var_1_10013

			var_1_10010(var_8_1, var_1_10013(iter_8_0, iter_8_1))
		end
	end

	return var_8_0
end

function var_0_0.MatOrPaper(arg_9_0)
	return arg_9_0.config.type == 5 or arg_9_0.config.type == 10 or arg_9_0.config.type == 1 or arg_9_0.config.type == 4
end

return var_0_0
