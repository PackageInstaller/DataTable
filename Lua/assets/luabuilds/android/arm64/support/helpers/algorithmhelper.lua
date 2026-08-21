AlgorithmHelper = {}

local var_0_0 = 1e+18

local function var_0_1()
	return {
		first = 1,
		last = 0,
		data = {},
		push = function(arg_2_0, arg_2_1)
			arg_2_0.last = arg_2_0.last + 1
			arg_2_0.data[arg_2_0.last] = arg_2_1

			return
		end,
		pop = function(arg_3_0)
			if arg_3_0:isEmpty() then
				return nil
			end

			local var_3_0 = arg_3_0.data[arg_3_0.first]

			arg_3_0.data[arg_3_0.first] = nil
			arg_3_0.first = arg_3_0.first + 1

			return var_3_0
		end,
		isEmpty = function(arg_4_0)
			return arg_4_0.first > arg_4_0.last
		end
	}
end

function AlgorithmHelper.KM(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = {}
	local var_5_5 = {}
	local var_5_6 = {}
	local var_5_7 = {}
	local var_5_8 = {}

	for iter_5_0 = 1, arg_5_0 do
		({})[iter_5_0] = {}
		;({})[iter_5_0] = -var_0_0
		;({})[iter_5_0] = 0
		;({})[iter_5_0] = 0
		;({})[iter_5_0] = 0

		for iter_5_1 = 1, arg_5_0 do
			({})[iter_5_0][iter_5_1] = -var_0_0
		end
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
		local var_5_9, var_5_10, var_5_11 = unpack(iter_5_3)

		if var_5_11 > ({})[var_5_9][var_5_10] then
			({})[var_5_9][var_5_10] = var_5_11
		end

		if ({})[var_5_9] < ({})[var_5_9][var_5_10] then
			({})[var_5_9] = ({})[var_5_9][var_5_10]
		end
	end

	local function var_5_12(arg_6_0)
		while arg_6_0 ~= 0 do
			var_5_3[var_5_7[arg_6_0]] = arg_6_0
			var_5_4[arg_6_0] = var_5_7[arg_6_0]
			arg_6_0 = var_5_3[var_5_7[arg_6_0]]
		end

		return
	end

	for iter_5_4 = 1, arg_5_0 do
		(function(arg_7_0)
			for iter_7_0 = 1, arg_5_0 do
				var_5_5[iter_7_0] = false
				var_5_6[iter_7_0] = false
				var_5_8[iter_7_0] = var_0_0
			end

			local var_7_0 = var_0_1()

			var_7_0:push(arg_7_0)

			while true do
				while not var_7_0:isEmpty() do
					local var_7_1 = var_7_0:pop()

					var_5_5[var_7_1] = true

					for iter_7_1 = 1, arg_5_0 do
						if not var_5_6[iter_7_1] then
							if var_5_1[var_7_1] + var_5_2[iter_7_1] - var_5_0[var_7_1][iter_7_1] < var_5_8[iter_7_1] then
								var_5_8[iter_7_1] = var_5_1[var_7_1] + var_5_2[iter_7_1] - var_5_0[var_7_1][iter_7_1]
								var_5_7[iter_7_1] = var_7_1

								if var_5_1[var_7_1] + var_5_2[iter_7_1] - var_5_0[var_7_1][iter_7_1] == 0 then
									var_5_6[iter_7_1] = true

									if var_5_4[iter_7_1] == 0 then
										var_5_12(iter_7_1)

										return
									else
										var_7_0:push(var_5_4[iter_7_1])
									end
								end
							end
						end
					end
				end

				local var_7_2 = var_0_0

				for iter_7_2 = 1, arg_5_0 do
					if not var_5_6[iter_7_2] and var_7_2 > var_5_8[iter_7_2] then
						var_7_2 = var_5_8[iter_7_2]
					end
				end

				for iter_7_3 = 1, arg_5_0 do
					if var_5_5[iter_7_3] then
						var_5_1[iter_7_3] = var_5_1[iter_7_3] - var_7_2
					end

					if var_5_6[iter_7_3] then
						var_5_2[iter_7_3] = var_5_2[iter_7_3] + var_7_2
					else
						var_5_8[iter_7_3] = var_5_8[iter_7_3] - var_7_2
					end
				end

				for iter_7_4 = 1, arg_5_0 do
					if not var_5_6[iter_7_4] and var_5_8[iter_7_4] == 0 then
						var_5_6[iter_7_4] = true

						if var_5_4[iter_7_4] == 0 then
							var_5_12(iter_7_4)

							return
						else
							var_7_0:push(var_5_4[iter_7_4])
						end
					end
				end
			end

			return
		end)(iter_5_4)
	end

	local var_5_13 = 0

	for iter_5_5 = 1, arg_5_0 do
		var_5_13 = var_5_13 + ({})[iter_5_5] + ({})[iter_5_5]
	end

	return var_5_13, {}
end

return AlgorithmHelper
