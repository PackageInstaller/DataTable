local var_0_0 = {}

module = var_0_10001

if var_0_10001 then
	var_0_0 = mbox
end

function var_0_0.split_message(arg_1_0)
	local var_1_0 = {}

	string = var_1_10002
	arg_1_0 = var_1_10002.gsub(arg_1_0, "\r\n", "\n")
	string = var_2

	var_2.gsub(arg_1_0, "^(.-\n)\n", function(arg_2_0)
		var_1_0.headers = arg_2_0

		return
	end)

	string = var_2

	var_2.gsub(arg_1_0, "^.-\n\n(.*)", function(arg_3_0)
		var_1_0.body = arg_3_0

		return
	end)

	if not var_1_0.body then
		string = var_2

		var_2.gsub(arg_1_0, "^\n(.*)", function(arg_4_0)
			var_1_0.body = arg_4_0

			return
		end)
	end

	if not var_1_0.headers and not var_1_0.body then
		var_1_0.headers = arg_1_0
	end

	local var_1_1

	if not var_1_0.headers then
		var_1_1 = ""
	end

	local var_1_2

	if not var_1_0.body then
		var_1_2 = ""
	end

	return var_1_1, var_1_2
end

function var_0_0.split_headers(arg_5_0)
	local var_5_0 = {}

	string = var_1_10002
	arg_5_0 = var_1_10002.gsub(arg_5_0, "\r\n", "\n")
	string = var_2
	arg_5_0 = var_2.gsub(arg_5_0, "\n[ ]+", " ")
	string = var_2

	var_2.gsub("\n" .. arg_5_0, "\n([^\n]+)", function(arg_6_0)
		table = var_2_10001

		var_2_10001.insert(var_5_0, arg_6_0)

		return
	end)

	return var_5_0
end

function var_0_0.parse_header(arg_7_0)
	string = var_1_10001
	arg_7_0 = var_1_10001.gsub(arg_7_0, "\n[ ]+", " ")
	string = var_1
	arg_7_0 = var_1.gsub(arg_7_0, "\n+", "")
	string = var_1

	local var_7_0, var_7_1, var_7_2, var_7_3 = var_1.find(arg_7_0, "([^%s:]-):%s*(.*)")

	return var_7_2, var_7_3
end

function var_0_0.parse_headers(arg_8_0)
	local var_8_0 = var_0_0.split_headers(arg_8_0)
	local var_8_1 = {}

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2, var_8_3 = var_0_0.parse_header(var_8_0[iter_8_0])

		if var_8_2 then
			string = var_9

			if var_8_1[var_9.lower(var_8_2)] then
				var_8_1[var_7] = var_8_1[var_7] .. ", " .. var_8_3
			else
				var_8_1[var_7] = var_8_3
			end
		end
	end

	return var_8_1
end

function var_0_0.parse_from(arg_9_0)
	string = var_1_10001

	local var_9_0, var_9_1, var_9_2, var_9_3 = var_1_10001.find(arg_9_0, "^%s*(.-)%s*%<(.-)%>")

	if not var_9_3 then
		string = var_1_10005

		local var_9_4, var_9_5

		var_1_10005, var_9_4, var_9_5 = var_1_10005.find(arg_9_0, "%s*(.+)%s*")
		var_9_3 = var_9_5

		local var_9_6 = var_9_4
		local var_9_7 = var_1_10005
	end

	var_9_2 = var_9_2 or ""
	var_9_3 = var_9_3 or ""

	if var_9_2 == "" then
		var_9_2 = var_9_3
	end

	string = var_1_10005

	return var_1_10005.gsub(var_9_2, "\"", ""), var_9_3
end

function var_0_0.split_mbox(arg_10_0)
	local var_10_0 = {}

	string = var_1_10002
	arg_10_0 = var_1_10002.gsub(arg_10_0, "\r\n", "\n") .. "\n\nFrom \n"

	local var_10_1 = 1
	local var_10_2 = 1
	local var_10_3 = 1

	while true do
		string = var_10_4

		local var_10_4, var_10_5 = var_10_4.find(arg_10_0, "\n\nFrom .-\n", var_10_3)
		local var_10_6 = var_10_5

		if not var_10_4 then
			break
		end

		string = var_10_4
		var_10_4 = var_10_4.sub(arg_10_0, var_10_3, var_3 - 1)
		table = var_10_5

		var_10_5.insert(var_10_0, var_10_4)

		var_10_3 = var_10_6 + 1
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
