function trace(arg_1_0, ...)
	printCustom(arg_1_0, ...)
end

function printCustom(arg_2_0, ...)
	local var_2_0 = {
		...
	}
	local var_2_1 = 0

	if type(arg_2_0) == "string" then
		arg_2_0 = string.gsub(arg_2_0, "%%([o,s,d])", function(arg_3_0)
			var_2_1 = var_2_1 + 1

			if arg_3_0 == "s" then
				return var_2_0[var_2_1]
			else
				return (watch(var_2_0[var_2_1]))
			end
		end)
	end

	print(arg_2_0)
end

function watch(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ""
	local var_4_1 = true

	arg_4_1 = arg_4_1 or ""
	arg_4_2 = arg_4_2 or 0
	arg_4_1 = arg_4_1 or ""

	if arg_4_2 > 20 then
		return "... ...(duplicate reference)"
	end

	if arg_4_0 == nil then
		var_4_0 = "<nil>"
	elseif type(arg_4_0) == "table" and type(arg_4_0.is_clone) == "boolean" then
		local var_4_2 = arg_4_0:get_ob_id()

		if is_string(var_4_2) then
			if arg_4_0.destructed == true then
				var_4_0 = string.format("object(%s<destructed>)", var_4_2)
			else
				var_4_0 = string.format("object(%s)", var_4_2)
			end
		else
			var_4_0 = string.format("object(%s)", save_string(arg_4_0.class_type))
		end
	elseif type(arg_4_0) == "table" then
		local var_4_3 = sizeof(arg_4_0)

		if string.len(arg_4_1) > 20 then
			var_4_0 = "<table overflow>"
		else
			local var_4_4 = {
				string.format("<table>   size : %d\r\n%s{\r\n", var_4_3, arg_4_1)
			}
			local var_4_5 = 1

			for iter_4_0, iter_4_1 in pairs(arg_4_0) do
				local var_4_6 = true

				if type(iter_4_0) == "string" and type(iter_4_1) == "table" then
					local var_4_7 = iter_4_0

					if string.len(var_4_7) > 0 and string.sub(var_4_7, 1, 1) == "_" then
						table.insert(var_4_4, string.format("%s\t%s: <table hide>,\r\n", arg_4_1, watch(iter_4_0, arg_4_1 .. "\t", arg_4_2 + 1)))

						var_4_6 = false
					end
				end

				if var_4_6 then
					table.insert(var_4_4, string.format("%s\t%s:%s,\r\n", arg_4_1, watch(iter_4_0, arg_4_1 .. "\t", arg_4_2 + 1), watch(iter_4_1, arg_4_1 .. "\t", arg_4_2 + 1)))
				end

				var_4_5 = var_4_5 + 1

				if var_4_5 > 100 then
					table.insert(var_4_4, "... ...(table too long)")

					break
				end
			end

			table.insert(var_4_4, string.format("%s}", arg_4_1))

			var_4_0 = table.concat(var_4_4, "")
		end
	elseif type(arg_4_0) == "function" then
		var_4_0 = "<function>"
	elseif type(arg_4_0) == "string" then
		var_4_0 = string.format("\"%s\"", string.gsub(arg_4_0, "\"", "\\\""))
	elseif type(arg_4_0) == "number" then
		var_4_0 = tostring(arg_4_0)
	elseif type(arg_4_0) == "boolean" then
		var_4_0 = tostring(arg_4_0)
	else
		var_4_0 = string.format("<%s type>", "unknow")
	end

	return var_4_0
end

function sizeof(arg_5_0)
	local var_5_0 = 0

	if type(arg_5_0) == "table" then
		for iter_5_0, iter_5_1 in pairs(arg_5_0) do
			var_5_0 = var_5_0 + 1
		end
	elseif type(arg_5_0) == "string" then
		var_5_0 = string.len(arg_5_0)
	end

	return var_5_0
end
