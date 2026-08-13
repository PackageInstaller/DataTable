class = var_0_10000

local var_0_0 = var_0_10000("SyncUnitData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	Vector3 = var_2
	arg_1_0.pos = var_2(arg_1_1.pos.x, arg_1_1.pos.y, arg_1_1.pos.z)
	Quaternion = var_2
	arg_1_0.dir = var_2(arg_1_1.dir.x, arg_1_1.dir.y, arg_1_1.dir.z, arg_1_1.dir.w)
	arg_1_0.status = arg_1_1.status

	return
end

function var_0_0.Pack(arg_2_0)
	return {
		id = arg_2_0.id,
		pos = {
			x = arg_2_0.pos.x,
			y = arg_2_0.pos.y,
			z = arg_2_0.pos.z
		},
		dir = {
			x = arg_2_0.dir.x,
			y = arg_2_0.dir.y,
			z = arg_2_0.dir.z,
			w = arg_2_0.dir.w
		},
		status = arg_2_0.status
	}
end

function var_0_0.toString(arg_3_0)
	string = var_1_10001

	local var_3_0 = var_1_10001.format
	local var_3_1 = "id=%d,pos=[%s,%s,%s],dir=[%s,%s,%s,%s],status=%s"
	local var_3_2 = arg_3_0.id

	string = var_1_10004

	local var_3_3 = var_1_10004.format("%.5f", arg_3_0.pos.x)

	string = var_5

	local var_3_4 = var_5.format("%.5f", arg_3_0.pos.y)

	string = var_6

	local var_3_5 = var_6.format("%.5f", arg_3_0.pos.z)

	string = var_7

	local var_3_6 = var_7.format("%.5f", arg_3_0.dir.x)

	string = var_8

	local var_3_7 = var_8.format("%.5f", arg_3_0.dir.y)

	string = var_9

	local var_3_8 = var_9.format("%.5f", arg_3_0.dir.z)

	string = var_10

	local var_3_9 = var_10.format("%.5f", arg_3_0.dir.w)

	PrintTable = var_11

	return var_3_0(var_3_1, var_3_2, var_3_3, var_3_4, var_3_5, var_3_6, var_3_7, var_3_8, var_3_9, var_11(arg_3_0.status))
end

return var_0_0
