class = var_0_10000

local var_0_0 = var_0_10000("BoatAdCreateControl")
local var_0_1
local var_0_2
local var_0_3 = 1.3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	BoatAdGameVo = var_1_10003
	var_0_1 = var_1_10003
	BoatAdGameConst = var_1_10003
	var_0_2 = var_1_10003
	arg_1_0._bgContent = arg_1_1
	arg_1_0._eventCall = arg_1_2
	findTF = var_1_10003
	arg_1_0._content = var_1_10003(arg_1_0._bgContent, "scene/content")
	arg_1_0._createRule = {}

	return
end

function var_0_0.start(arg_2_0)
	if var_0_1.GetRoundData() and var_1.rule then
		Clone = var_2
		arg_2_0._createRule = var_2(var_0_2.create_rule[var_1.rule])
	end

	arg_2_0._createStepTime = 0
	arg_2_0._createRuleIndex = #arg_2_0._createRule
	arg_2_0._createRound = 1
	arg_2_0._createLine = 1
	arg_2_0.applyCreateData = nil
	arg_2_0.applyCount = 0
	arg_2_0.applyTimes = 0

	return
end

function var_0_0.step(arg_3_0, arg_3_1)
	if arg_3_0._createStepTime >= 0 then
		local var_3_0 = var_0_1.char

		if not var_2.getBattle(var_3_0) then
			arg_3_0._createStepTime = arg_3_0._createStepTime - var_0_1.deltaTime

			if arg_3_0._createStepTime <= 0 then
				arg_3_0:applyRule()

				arg_3_0._createStepTime = var_0_3
			end
		end
	end

	return
end

function var_0_0.applyRule(arg_4_0)
	if arg_4_0.applyTimes <= 0 then
		arg_4_0.applyCreateData = arg_4_0._createRule[arg_4_0._createRuleIndex]
		arg_4_0.createCount = arg_4_0.applyCreateData.count
		arg_4_0._createRuleIndex = arg_4_0._createRuleIndex - 1
		arg_4_0.applyTimes = arg_4_0.applyCreateData.times

		if arg_4_0._createRuleIndex <= 0 then
			arg_4_0._createRuleIndex = #arg_4_0._createRule
			arg_4_0._createRound = arg_4_0._createRound + 1
		end
	end

	arg_4_0.applyTimes = arg_4_0.applyTimes - 1

	local var_4_0

	type = var_2

	if var_2(arg_4_0.applyCreateData.data[1]) == "number" then
		var_4_0 = arg_4_0.applyCreateData.data
	else
		local var_4_1 = arg_4_0.applyCreateData.data

		math = var_3
		var_4_0 = var_4_1[var_3.random(1, #arg_4_0.applyCreateData.data)]
	end

	local var_4_2 = {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_3 = iter_4_0
		local var_4_4 = var_4_0[iter_4_0]
		local var_4_5 = 0

		if var_4_4 ~= 0 and #var_4_2 < arg_4_0.createCount then
			Clone = var_10

			local var_4_6 = var_10(var_0_2.rule_data[var_4_4]).create_rate
			local var_4_7 = var_10.round
			local var_4_8 = true
			local var_4_9 = var_10.once
			local var_4_10 = var_10.ids

			if var_4_9 then
				for iter_4_1 = #var_4_10, 1, -1 do
					table = var_1_10020

					if var_1_10020.contains(var_4_2, var_4_10[iter_4_1]) then
						table = var_1_10020

						var_1_10020.remove(var_4_10, iter_4_1)
					end
				end
			end

			if var_4_7 and 0 < var_4_7 and arg_4_0._createRound ~= var_4_7 then
				var_4_8 = false
			end

			math = var_1_10016

			if var_4_6 < var_1_10016.random(1, 100) then
				var_4_8 = false
			end

			if var_4_8 then
				math = var_1_10016
				var_1_10016 = var_4_10[var_1_10016.random(1, #var_4_10)]

				if var_10.type == var_0_2.type_enemy then
					local var_4_11 = arg_4_0._eventCall

					BoatAdGameEvent = var_18

					var_4_11(var_18.CREATE_ENEMY, {
						id = var_1_10016,
						move_count = var_4_3,
						round = arg_4_0._createRound,
						line = arg_4_0._createLine
					})

					var_4_5 = var_1_10016
				elseif var_10.type == var_0_2.type_item or var_10.type == var_0_2.type_buff then
					local var_4_12 = arg_4_0._eventCall

					BoatAdGameEvent = var_18

					var_4_12(var_18.CREATE_ITEM, {
						id = var_1_10016,
						move_count = var_4_3,
						round = arg_4_0._createRound,
						line = arg_4_0._createLine
					})

					var_4_5 = var_1_10016
				end
			end
		end

		if 0 < var_4_5 then
			table = var_10

			var_10.insert(var_4_2, var_4_5)
		end
	end

	local var_4_13 = "本轮 " .. arg_4_0._createLine .. " 创建id = "

	for iter_4_2 = 1, #var_4_2 do
		var_4_13 = var_4_13 .. var_4_2[iter_4_2] .. ","
	end

	print = var_4

	var_4(var_4_13)

	arg_4_0._createLine = arg_4_0._createLine + 1

	return
end

function var_0_0.clear(arg_5_0)
	return
end

function var_0_0.stop(arg_6_0)
	return
end

function var_0_0.resume(arg_7_0)
	return
end

function var_0_0.dispose(arg_8_0)
	return
end

return var_0_0
