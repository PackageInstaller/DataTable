local var_0_0 = class("SyncUnitData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.pos = Vector3(arg_1_1.pos.x, arg_1_1.pos.y, arg_1_1.pos.z)
	arg_1_0.dir = Quaternion(arg_1_1.dir.x, arg_1_1.dir.y, arg_1_1.dir.z, arg_1_1.dir.w)
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
	return string.format("id=%d,pos=[%s,%s,%s],dir=[%s,%s,%s,%s],status=%s", arg_3_0.id, string.format("%.5f", arg_3_0.pos.x), string.format("%.5f", arg_3_0.pos.y), string.format("%.5f", arg_3_0.pos.z), string.format("%.5f", arg_3_0.dir.x), string.format("%.5f", arg_3_0.dir.y), string.format("%.5f", arg_3_0.dir.z), string.format("%.5f", arg_3_0.dir.w), PrintTable(arg_3_0.status))
end

return var_0_0
