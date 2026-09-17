local var_0_0 = table
local var_0_1 = string
local var_0_2 = 0
local var_0_3 = {}
local var_0_4 = "<div>"
local var_0_5 = "</div>"
local var_0_6 = "true"
local var_0_7 = "false"

function var_0_3.parse(arg_1_0, arg_1_1)
	var_0_2 = arg_1_1

	local var_1_0 = {}

	if not var_0_1.find(arg_1_0, "^%b<>.+%b<>$") then
		arg_1_0 = var_0_0.concat({
			var_0_4,
			arg_1_0,
			var_0_5
		})
	end

	local var_1_1 = {}
	local var_1_2 = 0

	for iter_1_0, iter_1_1 in function()
		return var_0_1.find(arg_1_0, "%b<>", var_1_2)
	end do
		local var_1_3 = var_0_1.sub(arg_1_0, iter_1_0, iter_1_1)

		if var_0_1.find(var_1_3, "^</") then
			var_0_3.disposeLabelTail(var_1_1, var_1_0, arg_1_0, var_1_3, iter_1_0, iter_1_1)
		elseif var_0_1.find(var_1_3, "/>$") then
			var_0_3.disposeLabelSelfClosing(var_1_1, var_1_0, arg_1_0, var_1_3, iter_1_0, iter_1_1)
		else
			var_0_3.disposeLabelHead(var_1_1, var_1_0, arg_1_0, var_1_3, iter_1_0, iter_1_1)
		end

		var_1_2 = iter_1_1 + 1
	end

	return var_1_0
end

function var_0_3.disposeLabelHead(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = var_0_3.peekstack(arg_3_0)

	if var_3_0 then
		local var_3_1 = var_0_3.htmlDecode((var_0_1.sub(arg_3_2, var_3_0.endindex + 1, arg_3_4 - 1)))

		if var_0_2 and var_0_2 ~= 0 then
			for iter_3_0 = 1, var_0_2 do
				var_3_1 = "  " .. var_3_1
			end

			var_0_2 = 0
		end

		var_0_0:insert((var_0_3.parseLabelWithContent(var_3_0.labelhead, var_3_1)))
	end

	var_0_3.pushstack(arg_3_0, {
		labelhead = arg_3_3,
		beginindex = arg_3_4,
		endindex = arg_3_5
	})
end

function var_0_3.disposeLabelTail(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = var_0_3.popstack(arg_4_0)

	if var_4_0 then
		if not var_0_3.checkLabelMatch(var_4_0.labelhead, arg_4_3) then
			return print(var_0_1.format("labelparser # error: label can not match(%s, %s)", var_4_0.labelhead, arg_4_3))
		end

		var_0_0:insert((var_0_3.parseLabelWithContent(var_4_0.labelhead, var_0_3.htmlDecode((var_0_1.sub(arg_4_2, var_4_0.endindex + 1, arg_4_4 - 1))), arg_4_6)))

		local var_4_1 = var_0_3.peekstack(arg_4_0)

		if var_4_1 then
			var_4_1.beginindex = arg_4_4
			var_4_1.endindex = arg_4_5
		end
	end
end

function var_0_3.disposeLabelSelfClosing(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	var_0_3.disposeLabelHead(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	var_0_3.disposeLabelTail(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, true)
end

function var_0_3.checkLabelMatch(arg_6_0, arg_6_1)
	return var_0_3.parseLabelname(arg_6_1) == var_0_3.parseLabelname(arg_6_0)
end

function var_0_3.parseLabelWithContent(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 or arg_7_2 == nil then
		if arg_7_1 == nil or arg_7_1 == "" then
			return
		end
	end

	local var_7_0

	do
		arg_7_1 = nil
		var_7_0 = var_0_3.parseLabelHead(arg_7_0)
	end

	var_7_0.labelname = var_0_3.parseLabelname(arg_7_0)
	var_7_0.content = arg_7_1

	return var_7_0
end

function var_0_3.parseLabelname(arg_8_0)
	local var_8_0, var_8_1 = var_0_1.find(arg_8_0, "%w+")

	if not var_8_0 then
		return print("labelparser # error: label name not found") and nil
	end

	return (var_0_1.lower((var_0_1.sub(arg_8_0, var_8_0, var_8_1))))
end

function var_0_3.parseLabelHead(arg_9_0)
	local var_9_0 = {}

	for iter_9_0 in var_0_1.gmatch(arg_9_0, "[%w%_]+%=[^%s%>]+") do
		local var_9_1 = var_0_1.find(iter_9_0, "=")
		local var_9_2 = var_0_1.sub(iter_9_0, var_9_1 + 1, var_0_1.len(iter_9_0))
		local var_9_3 = var_0_1.lower((var_0_1.sub(iter_9_0, 1, var_9_1 - 1)))
		local var_9_4 = false
		local var_9_5, var_9_6 = var_0_1.find(var_9_2, "['\"].+['\"]")

		if var_9_5 then
			var_9_2 = var_0_1.sub(var_9_2, var_9_5 + 1, var_9_6 - 1)
			var_9_4 = true
		end

		if not var_9_4 then
			local var_9_7 = var_0_1.lower(var_9_2)

			if var_9_7 == var_0_6 then
				var_9_2 = true
				var_9_4 = true
			elseif var_9_7 == var_0_7 then
				var_9_2 = false
				var_9_4 = true
			end
		end

		if not var_9_4 then
			local var_9_8 = tonumber(var_9_2)

			if var_9_8 then
				var_9_2 = var_9_8
			end
		end

		var_9_0[var_9_3] = var_9_2
	end

	return var_9_0
end

function var_0_3.htmlDecode(arg_10_0)
	arg_10_0 = var_0_1.gsub(arg_10_0, "&gt;", ">")
	arg_10_0 = var_0_1.gsub(arg_10_0, "&lt;", "<")
	arg_10_0 = var_0_1.gsub(arg_10_0, "&#039;", "'")
	arg_10_0 = var_0_1.gsub(arg_10_0, "\\", "\\")
	arg_10_0 = var_0_1.gsub(arg_10_0, "&quot;", "\"")
	arg_10_0 = var_0_1.gsub(arg_10_0, "&amp;", "&")
	arg_10_0 = var_0_1.gsub(arg_10_0, "&nbsp;", " ")

	return arg_10_0
end

function var_0_3:peekstack()
	return self[#self]
end

function var_0_3.pushstack(arg_12_0, arg_12_1)
	var_0_0.insert(arg_12_0, arg_12_1)
end

function var_0_3:popstack()
	self[#self] = nil

	return self[#self]
end

return var_0_3
