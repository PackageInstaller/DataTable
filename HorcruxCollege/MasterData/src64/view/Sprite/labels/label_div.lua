local function var_0_0(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	if not arg_1_1 or arg_1_1 == "" then
		return
	end

	local function var_1_0(arg_2_0, arg_2_1)
		if #arg_2_0 <= arg_2_1 then
			return arg_2_0
		end

		local var_2_0 = #arg_2_0
		local var_2_1 = 0
		local var_2_2 = {
			0,
			192,
			224,
			240,
			248,
			252
		}

		while var_2_0 > 0 and 0 < arg_2_1 do
			local var_2_3 = string.byte(arg_2_0, -var_2_0)
			local var_2_4 = #var_2_2

			while var_2_2[var_2_4] do
				if var_2_3 >= var_2_2[var_2_4] then
					var_2_0 = var_2_0 - var_2_4
					var_2_1 = var_2_1 + var_2_4

					break
				end

				var_2_4 = var_2_4 - 1
			end

			if var_2_4 == 0 then
				var_2_1 = var_2_1 + 1
			end
		end

		return string.sub(arg_2_0, 0, var_2_1), string.sub(arg_2_0, var_2_1 + 1)
	end

	local function var_1_1(arg_3_0, arg_3_1)
		if not arg_3_0 or arg_3_0 == "" then
			return
		end

		if not arg_3_1 or arg_3_1 == 0 then
			return
		end

		local var_3_0 = 0
		local var_3_1 = 1
		local var_3_2 = 0

		while var_3_1 <= string.len(arg_3_0) do
			local var_3_3 = string.byte(arg_3_0, var_3_1)

			if var_3_3 >= 248 then
				var_3_2 = var_3_2 + arg_1_3
				var_3_0 = var_3_0 + 1
				var_3_1 = var_3_1 + 5
			elseif var_3_3 >= 240 then
				var_3_2 = var_3_2 + arg_1_3
				var_3_0 = var_3_0 + 1
				var_3_1 = var_3_1 + 4
			elseif var_3_3 >= 224 then
				var_3_2 = var_3_2 + arg_1_3
				var_3_0 = var_3_0 + 1
				var_3_1 = var_3_1 + 3
			elseif var_3_3 >= 128 then
				var_3_2 = var_3_2 + arg_1_3
				var_3_0 = var_3_0 + 1
				var_3_1 = var_3_1 + 2
			elseif var_3_3 >= 32 then
				var_3_2 = var_3_2 + cc.Label:createWithTTF(string.char(var_3_3), arg_1_2, arg_1_3):getContentSize().width * 1.2
				var_3_0 = var_3_0 + 1
				var_3_1 = var_3_1 + 1
			else
				var_3_1 = var_3_1 + 1
			end

			local function var_3_4(arg_4_0, arg_4_1)
				local var_4_0, var_4_1 = var_1_0(arg_4_0, arg_4_1)

				return cc.Label:createWithTTF(var_4_0, arg_1_2, arg_1_3):getContentSize().width
			end

			local function var_3_5(arg_5_0, arg_5_1, arg_5_2)
				if arg_5_0 < arg_3_1 then
					arg_5_1 = arg_5_1 + 1
					arg_5_0 = var_3_4(arg_5_2, arg_5_1)

					if arg_5_0 > arg_3_1 then
						return arg_5_1 - 1
					else
						arg_5_1 = var_3_5(arg_5_0, arg_5_1, arg_5_2)
					end
				elseif arg_5_0 > arg_3_1 then
					arg_5_1 = arg_5_1 - 1
					arg_5_0 = var_3_4(arg_5_2, arg_5_1)

					if arg_5_0 < arg_3_1 then
						return arg_5_1
					else
						arg_5_1 = var_3_5(arg_5_0, arg_5_1, arg_5_2) or arg_5_1
					end
				end

				return arg_5_1
			end

			if arg_3_1 < var_3_2 then
				local var_3_6, var_3_7 = var_1_0(arg_3_0, var_3_0)

				return (var_3_5(cc.Label:createWithTTF(var_3_6, arg_1_2, arg_1_3):getContentSize().width, var_3_0, arg_3_0))
			end
		end

		return var_3_0
	end

	local function var_1_2(arg_6_0, arg_6_1)
		local var_6_0 = var_1_1(arg_6_0, arg_6_1) or 0
		local var_6_1, var_6_2 = var_1_0(arg_6_0, var_6_0)
		local var_6_3 = cc.Label:createWithTTF(var_6_1, arg_1_2, arg_1_3):getContentSize().width

		if var_6_3 < arg_6_1 then
			while var_6_3 <= arg_6_1 do
				if var_6_0 > subStringGetTotalIndex(var_6_1) then
					var_6_0 = var_6_0 + 1

					break
				end

				var_6_0 = var_6_0 + 1
				var_6_1, var_6_2 = var_1_0(arg_6_0, var_6_0)
				var_6_3 = cc.Label:createWithTTF(var_6_1, arg_1_2, arg_1_3):getContentSize().width
			end

			var_6_0 = var_6_0 - 1
			var_6_1, var_6_2 = var_1_0(arg_6_0, var_6_0)
		elseif arg_6_1 < var_6_3 then
			while arg_6_1 < var_6_3 do
				var_6_0 = var_6_0 - 1
				var_6_1, var_6_2 = var_1_0(arg_6_0, var_6_0)
				var_6_3 = cc.Label:createWithTTF(var_6_1, arg_1_2, arg_1_3):getContentSize().width
			end
		end

		return var_6_1, var_6_2, var_6_0
	end

	local function var_1_3(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = 0
		local var_7_3 = arg_7_0

		for iter_7_0 = 1, math.floor(arg_7_2 / arg_1_5) do
			local var_7_4, var_7_5

			var_7_4, var_7_3, var_7_5 = var_1_2(arg_7_0, arg_1_5)

			if not var_7_3 then
				var_7_3 = ""
			end

			var_7_0 = var_7_0 + var_7_5
		end

		local var_7_6, var_7_7 = var_1_0(arg_7_0, var_7_0)

		return arg_7_1 .. var_7_6, var_7_7
	end

	local function var_1_4(arg_8_0, arg_8_1, arg_8_2)
		arg_8_2 = arg_8_2 or arg_1_5

		local var_8_0, var_8_1 = var_1_3(arg_8_0, arg_8_1, arg_8_2)

		if cc.Label:createWithTTF(var_8_1, arg_1_2, arg_1_3):getContentSize().width > arg_1_5 then
			local var_8_2, var_8_3 = var_1_4(var_8_1, var_8_0, arg_8_2)
		else
			return var_8_0, var_8_1
		end

		return var_8_0, var_8_1
	end

	if arg_1_6 == arg_1_5 then
		arg_1_6 = 0
	end

	if arg_1_6 and arg_1_6 ~= 0 then
		local var_1_5 = cc.Label:createWithTTF(arg_1_1, arg_1_2, arg_1_3)
		local var_1_6 = var_1_5:getContentSize().width
		local var_1_7

		if arg_1_5 < arg_1_6 + var_1_6 then
			var_1_7 = (arg_1_6 + var_1_6) % arg_1_5 or -1

			if var_1_7 == -1 then
				var_1_5:setMaxLineWidth(arg_1_5)
				var_1_5:setColor(arg_1_4)

				do return var_1_5, var_1_6 + arg_1_6 end

				goto label_1_0
			end
		end

		local var_1_8, var_1_9 = var_1_2(arg_1_1, (var_1_6 - var_1_7) % arg_1_5)
		local var_1_10 = cc.Label:createWithTTF(var_1_8, arg_1_2, arg_1_3)

		var_1_10:setMaxLineWidth(arg_1_5)
		var_1_10:setColor(arg_1_4)

		local var_1_11 = cc.Label:createWithTTF(var_1_9, arg_1_2, arg_1_3):getContentSize().width

		if var_1_11 - var_1_11 % arg_1_5 == 0 then
			local var_1_12 = cc.Label:createWithTTF(var_1_9, arg_1_2, arg_1_3)

			var_1_12:setMaxLineWidth(arg_1_5)
			var_1_12:setColor(arg_1_4)

			return var_1_10, var_1_12:getContentSize().width, var_1_12
		else
			local var_1_13, var_1_14 = var_1_4(var_1_9, "", var_1_11 - var_1_11 % arg_1_5)
			local var_1_15 = cc.Label:createWithTTF(var_1_13, arg_1_2, arg_1_3)

			var_1_15:setMaxLineWidth(arg_1_5)
			var_1_15:setColor(arg_1_4)

			local var_1_16 = cc.Label:createWithTTF(var_1_14, arg_1_2, arg_1_3)

			var_1_16:setMaxLineWidth(arg_1_5)
			var_1_16:setColor(arg_1_4)

			return var_1_10, var_1_16:getContentSize().width, var_1_15, var_1_16
		end
	else
		local var_1_17 = cc.Label:createWithTTF(arg_1_1, arg_1_2, arg_1_3)
		local var_1_18 = var_1_17:getContentSize().width

		if var_1_18 - var_1_18 % arg_1_5 ~= 0 then
			local var_1_19, var_1_20 = var_1_4(arg_1_1, "", var_1_18 - var_1_18 % arg_1_5)
			local var_1_21 = cc.Label:createWithTTF(var_1_19, arg_1_2, arg_1_3)

			var_1_21:setMaxLineWidth(arg_1_5)
			var_1_21:setColor(arg_1_4)

			local var_1_22 = cc.Label:createWithTTF(var_1_20, arg_1_2, arg_1_3)

			var_1_22:setMaxLineWidth(arg_1_5)
			var_1_22:setColor(arg_1_4)

			return var_1_21, var_1_22:getContentSize().width, var_1_22
		else
			var_1_17:setMaxLineWidth(arg_1_5)
			var_1_17:setColor(arg_1_4)

			return var_1_17, var_1_18 % arg_1_5
		end
	end

	::label_1_0::
end

return function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = {}

	if not arg_12_1.content then
		return var_12_0
	end

	local var_12_3, var_12_4, var_12_5, var_12_6 = var_0_0(arg_12_0, arg_12_1.content, arg_12_1.fontname or arg_12_3.fontName, arg_12_1.fontsize or arg_12_3.fontSize, arg_12_0:convertColor(arg_12_1.fontcolor) or arg_12_3.fontColor, arg_12_1.maxlinewidth, arg_12_2)

	if var_12_3 then
		table.insert(var_12_0, var_12_3)
	end

	if var_12_5 then
		table.insert(var_12_0, var_12_5)
	end

	if var_12_6 then
		table.insert(var_12_0, var_12_6)
	end

	return var_12_0, var_12_4
end
