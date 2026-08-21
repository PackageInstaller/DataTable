local var_0_0 = {}

if module then
	mbox = {}
end

;({}).split_message = function(arg_1_0)
	local var_1_0 = {}

	arg_1_0 = string.gsub(arg_1_0, "\r\n", "\n")

	string.gsub(arg_1_0, "^(.-\n)\n", function(arg_2_0)
		var_1_0.headers = arg_2_0

		return
	end)
	string.gsub(arg_1_0, "^.-\n\n(.*)", function(arg_3_0)
		var_1_0.body = arg_3_0

		return
	end)

	if not ({}).body then
		string.gsub(arg_1_0, "^\n(.*)", function(arg_4_0)
			var_1_0.body = arg_4_0

			return
		end)
	end

	if not ({}).headers and not ({}).body then
		({}).headers = arg_1_0
	end

	local var_1_1 = ({}).headers

	if not ({}).headers then
		var_1_1 = ""
	end

	local var_1_2 = ({}).body

	if not ({}).body then
		var_1_2 = ""
	end

	return var_1_1, var_1_2
end
;({}).split_headers = function(arg_5_0)
	local var_5_0 = {}

	arg_5_0 = string.gsub(arg_5_0, "\r\n", "\n")
	arg_5_0 = string.gsub(arg_5_0, "\n[ ]+", " ")

	string.gsub("\n" .. arg_5_0, "\n([^\n]+)", function(arg_6_0)
		table.insert(var_5_0, arg_6_0)

		return
	end)

	return {}
end
;({}).parse_header = function(arg_7_0)
	arg_7_0 = string.gsub(arg_7_0, "\n[ ]+", " ")
	arg_7_0 = string.gsub(arg_7_0, "\n+", "")

	local var_7_0, var_7_1, var_7_2, var_7_3 = string.find(arg_7_0, "([^%s:]-):%s*(.*)")

	return var_7_2, var_7_3
end
;({}).parse_headers = function(arg_8_0)
	local var_8_0 = var_0_0.split_headers(arg_8_0)

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1, var_8_2 = var_0_0.parse_header(var_8_0[iter_8_0])

		if var_8_1 then
			local var_8_3 = string.lower(var_8_1)

			if ({})[var_8_3] then
				({})[var_8_3] = ({})[var_8_3] .. ", " .. var_8_2
			else
				({})[var_8_3] = var_8_2
			end
		end
	end

	return {}
end
;({}).parse_from = function(arg_9_0)
	local var_9_0, var_9_1, var_9_2, var_9_3 = string.find(arg_9_0, "^%s*(.-)%s*%<(.-)%>")

	if not var_9_3 then
		local var_9_4, var_9_5

		var_9_4, var_9_5, var_9_3 = string.find(arg_9_0, "%s*(.+)%s*")
	end

	var_9_2 = var_9_2 or ""
	var_9_3 = var_9_3 or ""

	if var_9_2 == "" then
		var_9_2 = var_9_3
	end

	return string.gsub(var_9_2, "\"", ""), var_9_3
end
;({}).split_mbox = function(arg_10_0)
	arg_10_0 = string.gsub(arg_10_0, "\r\n", "\n") .. "\n\nFrom \n"

	while true do
		local var_10_2, var_10_3 = string.find(arg_10_0, "\n\nFrom .-\n", 1)
		local var_10_4

		if not var_10_2 then
			do break end

			var_10_4 = {}
		end

		table.insert({}, (string.sub(arg_10_0, 1, var_10_2 - 1)))
	end

	return {}
end
;({}).parse = function(arg_11_0)
	local var_11_0 = var_0_0.split_mbox(arg_11_0)

	for iter_11_0 = 1, #var_11_0 do
		var_11_0[iter_11_0] = var_0_0.parse_message(var_11_0[iter_11_0])
	end

	return var_11_0
end
;({}).parse_message = function(arg_12_0)
	local var_12_0 = {}

	var_12_0.headers, var_12_0.body = var_0_0.split_message(arg_12_0)
	;({}).headers = var_0_0.parse_headers(({}).headers)

	return {}
end

return {}
