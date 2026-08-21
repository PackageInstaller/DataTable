local var_0_0 = class("BoatAdCreateControl")
local var_0_1
local var_0_2
local var_0_3 = 1.3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	var_0_2 = BoatAdGameConst
	arg_1_0._bgContent = arg_1_1
	arg_1_0._eventCall = arg_1_2
	arg_1_0._content = findTF(arg_1_0._bgContent, "scene/content")
	arg_1_0._createRule = {}

	return
end

function var_0_0.start(arg_2_0)
	local var_2_0 = var_0_1.GetRoundData()

	if var_2_0 and var_2_0.rule then
		arg_2_0._createRule = Clone(var_0_2.create_rule[var_2_0.rule])
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
	if arg_3_0._createStepTime >= 0 and not var_0_1.char:getBattle() then
		arg_3_0._createStepTime = arg_3_0._createStepTime - var_0_1.deltaTime

		if arg_3_0._createStepTime <= 0 then
			arg_3_0:applyRule()

			arg_3_0._createStepTime = var_0_3
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

	local var_4_0 = type(arg_4_0.applyCreateData.data[1]) == "number" and arg_4_0.applyCreateData.data or arg_4_0.applyCreateData.data[math.random(1, #arg_4_0.applyCreateData.data)]
	local var_4_1 = {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_3 = 0

		if var_4_0[iter_4_0] ~= 0 and #var_4_1 < arg_4_0.createCount then
			local var_4_4 = Clone(var_0_2.rule_data[var_4_0[iter_4_0]])
			local var_4_5 = true

			if var_4_4.once then
				for iter_4_1 = #var_4_4.ids, 1, -1 do
					if table.contains(var_4_1, var_4_4.ids[iter_4_1]) then
						table.remove(var_4_4.ids, iter_4_1)
					end
				end
			end

			if var_4_4.round and var_4_4.round > 0 and arg_4_0._createRound ~= var_4_4.round then
				var_4_5 = false
			end

			if var_4_4.create_rate < math.random(1, 100) then
				var_4_5 = false
			end

			if var_4_5 then
				local var_4_6 = var_4_4.ids[math.random(1, #var_4_4.ids)]

				if var_4_4.type == var_0_2.type_enemy then
					arg_4_0._eventCall(BoatAdGameEvent.CREATE_ENEMY, {
						id = var_4_6,
						move_count = iter_4_0,
						round = arg_4_0._createRound,
						line = arg_4_0._createLine
					})

					var_4_3 = var_4_6
				elseif var_4_4.type == var_0_2.type_item or var_4_4.type == var_0_2.type_buff then
					arg_4_0._eventCall(BoatAdGameEvent.CREATE_ITEM, {
						id = var_4_6,
						move_count = iter_4_0,
						round = arg_4_0._createRound,
						line = arg_4_0._createLine
					})

					var_4_3 = var_4_6
				end
			end
		end

		if var_4_3 > 0 then
			table.insert(var_4_1, var_4_3)
		end
	end

	local var_4_7 = "本轮 " .. arg_4_0._createLine .. " 创建id = "

	for iter_4_2 = 1, #var_4_1 do
		var_4_7 = var_4_7 .. var_4_1[iter_4_2] .. ","
	end

	print(var_4_7)

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
