local var_0_0 = {}

if module then
	mbox = var_0_0
end

function var_0_0.split_message(arg_1_0)
	local var_1_0 = {}

	arg_1_0 = string.gsub(arg_1_0, "\r\n", "\n")

	string.gsub(arg_1_0, "^(.-\n)\n", function(arg_2_0)
		var_1_0.headers = arg_2_0
	end)
	string.gsub(arg_1_0, "^.-\n\n(.*)", function(arg_3_0)
		var_1_0.body = arg_3_0
	end)

	if not var_1_0.body then
		string.gsub(arg_1_0, "^\n(.*)", function(arg_4_0)
			var_1_0.body = arg_4_0
		end)
	end

	if not var_1_0.headers and not var_1_0.body then
		var_1_0.headers = arg_1_0
	end

	return var_1_0.headers or "", var_1_0.body or ""
end

function var_0_0.split_headers(arg_5_0)
	local var_5_0 = {}

	arg_5_0 = string.gsub(arg_5_0, "\r\n", "\n")
	arg_5_0 = string.gsub(arg_5_0, "\n[ ]+", " ")

	string.gsub("\n" .. arg_5_0, "\n([^\n]+)", function(arg_6_0)
		table.insert(var_5_0, arg_6_0)
	end)

	return var_5_0
end

function var_0_0.parse_header(arg_7_0)
	arg_7_0 = string.gsub(arg_7_0, "\n[ ]+", " ")
	arg_7_0 = string.gsub(arg_7_0, "\n+", "")

	local var_7_0, var_7_1, var_7_2, var_7_3 = string.find(arg_7_0, "([^%s:]-):%s*(.*)")

	return var_7_2, var_7_3
end

function var_0_0.parse_headers(arg_8_0)
	local var_8_0 = var_0_0.split_headers(arg_8_0)
	local var_8_1 = {}

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2, var_8_3 = var_0_0.parse_header(var_8_0[iter_8_0])

		if var_8_2 then
			local var_8_4 = string.lower(var_8_2)

			if var_8_1[var_8_4] then
				var_8_1[var_8_4] = var_8_1[var_8_4] .. ", " .. var_8_3
			else
				var_8_1[var_8_4] = var_8_3
			end
		end
	end

	return var_8_1
end

function var_0_0.parse_from(arg_9_0)
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

function var_0_0.split_mbox(arg_10_0)
	local var_10_0 = {}

	arg_10_0 = string.gsub(arg_10_0, "\r\n", "\n") .. "\n\nFrom \n"

	local var_10_1 = 1
	local var_10_2 = 1
	local var_10_3 = 1

	while true do
		local var_10_4, var_10_5 = string.find(arg_10_0, "\n\nFrom .-\n", var_10_3)

		if not var_10_4 then
			break
		end

		local var_10_6 = string.sub(arg_10_0, var_10_3, var_10_4 - 1)

		table.insert(var_10_0, var_10_6)

		var_10_3 = var_10_5 + 1
	end

	return var_10_0
end

function var_0_0.parse(arg_11_0)
	local var_11_0 = var_0_0.split_mbox(arg_11_0)

	for iter_11_0 = 1, #var_11_0 do
		var_11_0[iter_11_0] = var_0_0.parse_message(var_11_0[iter_11_0])
	end

	return var_11_0
end

function var_0_0.parse_message(arg_12_0)
	local var_12_0 = {}

	var_12_0.headers, var_12_0.body = var_0_0.split_message(arg_12_0)
	var_12_0.headers = var_0_0.parse_headers(var_12_0.headers)

	return var_12_0
end

return var_0_0
