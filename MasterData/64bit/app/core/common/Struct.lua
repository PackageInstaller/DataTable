return {
	pack = function(self)
		local var_1_0 = {}
		local var_1_1 = {
			...
		}
		local var_1_2 = true

		for iter_1_0 = 1, self:len() do
			local var_1_3 = self:sub(iter_1_0, iter_1_0)

			if var_1_3 == "<" then
				var_1_2 = true
			elseif var_1_3 == ">" then
				var_1_2 = false
			elseif var_1_3:find("[bBhHiIlL]") then
				local var_1_4 = tonumber(table.remove(var_1_1, 1))
				local var_1_5 = {}

				for iter_1_1 = 1, var_1_3:find("[hH]") and 2 or var_1_3:find("[iI]") and 4 or var_1_3:find("[lL]") and 8 or 1 do
					table.insert(var_1_5, string.char(var_1_4 % 256))

					var_1_4 = math.floor(var_1_4 / 256)
				end

				if not var_1_2 then
					table.insert(var_1_0, string.reverse(table.concat(var_1_5)))
				else
					table.insert(var_1_0, table.concat(var_1_5))
				end
			elseif var_1_3:find("[fd]") then
				local var_1_6 = tonumber(table.remove(var_1_1, 1))
				local var_1_7 = 0

				if var_1_6 < 0 then
					var_1_7 = 1
					var_1_6 = -var_1_6
				end

				local var_1_8, var_1_9 = math.frexp(var_1_6)

				if var_1_6 == 0 then
					var_1_8 = 0
					var_1_9 = 0
				else
					var_1_8 = (var_1_8 * 2 - 1) * math.ldexp(0.5, var_1_3 == "d" and 53 or 24)
					var_1_9 = var_1_9 + (var_1_3 == "d" and 1022 or 126)
				end

				local var_1_10 = {}

				if var_1_3 == "d" then
					var_1_6 = var_1_8

					for iter_1_2 = 1, 6 do
						table.insert(var_1_10, string.char(math.floor(var_1_6) % 256))

						var_1_6 = math.floor(var_1_6 / 256)
					end
				else
					table.insert(var_1_10, string.char(math.floor(var_1_8) % 256))

					var_1_6 = math.floor(var_1_8 / 256)

					table.insert(var_1_10, string.char(math.floor(var_1_6) % 256))

					var_1_6 = math.floor(var_1_6 / 256)
				end

				table.insert(var_1_10, string.char(math.floor(var_1_9 * (var_1_3 == "d" and 16 or 128) + var_1_6) % 256))

				local var_1_11 = math.floor((var_1_9 * (var_1_3 == "d" and 16 or 128) + var_1_6) / 256)

				table.insert(var_1_10, string.char(math.floor(var_1_7 * 128 + var_1_11) % 256))

				local var_1_12 = math.floor((var_1_7 * 128 + var_1_11) / 256)

				if not var_1_2 then
					table.insert(var_1_0, string.reverse(table.concat(var_1_10)))
				else
					table.insert(var_1_0, table.concat(var_1_10))
				end
			elseif var_1_3 == "s" then
				table.insert(var_1_0, tostring(table.remove(var_1_1, 1)))
				table.insert(var_1_0, string.char(0))
			elseif var_1_3 == "c" then
				local var_1_13 = self:sub(iter_1_0 + 1):match("%d+")
				local var_1_14 = tonumber(var_1_13)

				if var_1_14 > 0 then
					local var_1_15 = tostring(table.remove(var_1_1, 1))

					if var_1_14 - var_1_15:len() > 0 then
						var_1_15 = table.concat({
							var_1_15,
							(string.rep(" ", var_1_14 - var_1_15:len()))
						})
					end

					table.insert(var_1_0, var_1_15:sub(1, var_1_14))
				end

				iter_1_0 = iter_1_0 + var_1_13:len()
			end
		end

		return table.concat(var_1_0)
	end,
	unpack = function(self, arg_2_1)
		local var_2_0 = {}
		local var_2_1 = 1
		local var_2_2 = true

		for iter_2_0 = 1, self:len() do
			local var_2_3 = self:sub(iter_2_0, iter_2_0)

			if var_2_3 == "<" then
				var_2_2 = true
			elseif var_2_3 == ">" then
				var_2_2 = false
			elseif var_2_3:find("[bBhHiIlL]") then
				local var_2_4 = var_2_3:find("[hH]") and 2 or var_2_3:find("[iI]") and 4 or var_2_3:find("[lL]") and 8 or 1
				local var_2_5 = var_2_3:lower() == var_2_3
				local var_2_6 = 0

				for iter_2_1 = 1, var_2_4 do
					local var_2_7 = string.byte(arg_2_1:sub(var_2_1, var_2_1))

					var_2_6 = var_2_2 and var_2_6 + var_2_7 * 2^((iter_2_1 - 1) * 8) or var_2_6 + var_2_7 * 2^((var_2_4 - iter_2_1) * 8)
					var_2_1 = var_2_1 + 1
				end

				if var_2_5 and var_2_6 >= 2^(var_2_4 * 8 - 1) then
					var_2_6 = var_2_6 - 2^(var_2_4 * 8)
				end

				table.insert(var_2_0, var_2_6)
			elseif var_2_3:find("[fd]") then
				local var_2_8 = var_2_3 == "d" and 8 or 4
				local var_2_9 = arg_2_1:sub(var_2_1, var_2_1 + (var_2_3 == "d" and 8 or 4) - 1)

				var_2_1 = var_2_1 + (var_2_3 == "d" and 8 or 4)

				if not var_2_2 then
					var_2_9 = string.reverse(var_2_9)
				end

				local var_2_10 = 1
				local var_2_11 = string.byte(var_2_9, var_2_3 == "d" and 7 or 3) % (var_2_3 == "d" and 16 or 128)

				for iter_2_2 = var_2_8 - 2, 1, -1 do
					var_2_11 = var_2_11 * 256 + string.byte(var_2_9, iter_2_2)
				end

				if string.byte(var_2_9, var_2_8) > 127 then
					var_2_10 = -1
				end

				local var_2_12 = string.byte(var_2_9, var_2_8) % 128 * (var_2_3 == "d" and 16 or 2) + math.floor(string.byte(var_2_9, var_2_8 - 1) / (var_2_3 == "d" and 16 or 128))

				if var_2_12 == 0 then
					table.insert(var_2_0, 0)
				else
					table.insert(var_2_0, math.ldexp((math.ldexp(var_2_11, var_2_3 == "d" and -52 or -23) + 1) * var_2_10, var_2_12 - (var_2_3 == "d" and 1023 or 127)))
				end
			elseif var_2_3 == "s" then
				local var_2_13 = {}

				for iter_2_3 = var_2_1, arg_2_1:len() do
					if arg_2_1:sub(iter_2_3, iter_2_3) == string.char(0) then
						break
					end

					table.insert(var_2_13, arg_2_1:sub(iter_2_3, iter_2_3))
				end

				local var_2_14 = table.concat(var_2_13)

				var_2_1 = var_2_1 + var_2_14:len() + 1

				table.insert(var_2_0, var_2_14)
			elseif var_2_3 == "c" then
				local var_2_15 = self:sub(iter_2_0 + 1):match("%d+")

				table.insert(var_2_0, arg_2_1:sub(var_2_1, var_2_1 + tonumber(var_2_15)))

				var_2_1 = var_2_1 + tonumber(var_2_15)
				iter_2_0 = iter_2_0 + var_2_15:len()
			end
		end

		return unpack(var_2_0)
	end
}
