module("bootstrap.core.io", package.seeall)

function io.exists(arg_1_0)
	local var_1_0 = io.open(arg_1_0, "r")

	if var_1_0 then
		io.close(var_1_0)

		return true
	end

	return false
end

function io.readfile(arg_2_0)
	local var_2_0 = io.open(arg_2_0, "r")

	if var_2_0 then
		local var_2_1 = var_2_0:read("*a")

		io.close(var_2_0)

		return var_2_1
	end

	return nil
end

function io.writefile(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or "w+b"

	local var_3_0 = io.open(arg_3_0, arg_3_2)

	if var_3_0 then
		if var_3_0:write(arg_3_1) == nil then
			return false
		end

		io.close(var_3_0)

		return true
	else
		return false
	end
end

function io.pathinfo(arg_4_0)
	local var_4_0 = string.len(arg_4_0)
	local var_4_1 = var_4_0 + 1

	while var_4_0 > 0 do
		local var_4_2 = string.byte(arg_4_0, var_4_0)

		if var_4_2 == 46 then
			var_4_1 = var_4_0
		elseif var_4_2 == 47 then
			break
		end

		var_4_0 = var_4_0 - 1
	end

	local var_4_3 = string.sub(arg_4_0, 1, var_4_0)
	local var_4_4 = string.sub(arg_4_0, var_4_0 + 1)
	local var_4_5 = var_4_1 - var_4_0
	local var_4_6 = string.sub(var_4_4, 1, var_4_5 - 1)
	local var_4_7 = string.sub(var_4_4, var_4_5)

	return {
		dirname = var_4_3,
		filename = var_4_4,
		basename = var_4_6,
		extname = var_4_7
	}
end

function io.filesize(arg_5_0)
	local var_5_0 = false
	local var_5_1 = io.open(arg_5_0, "r")

	if var_5_1 then
		local var_5_2 = var_5_1:seek()

		var_5_0 = var_5_1:seek("end")

		var_5_1:seek("set", var_5_2)
		io.close(var_5_1)
	end

	return var_5_0
end
