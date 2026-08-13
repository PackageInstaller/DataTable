class = var_0_10000

local var_0_0 = "WSMapCamera"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	map = "table",
	gid = "number",
	camera = "userdata"
}

function var_0_1.Setup(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0.camera.enabled = false

	arg_2_0:Clear()

	return
end

function var_0_1.UpdateMap(arg_3_0, arg_3_1)
	if arg_3_0.map ~= arg_3_1 or arg_3_0.gid ~= arg_3_1.gid then
		arg_3_0.map = arg_3_1
		arg_3_0.gid = arg_3_1.gid
		arg_3_0.camera.fieldOfView = arg_3_1.theme.fov
	end

	return
end

function var_0_1.Init(arg_4_0)
	arg_4_0.camera.enabled = true

	return
end

return var_0_1
