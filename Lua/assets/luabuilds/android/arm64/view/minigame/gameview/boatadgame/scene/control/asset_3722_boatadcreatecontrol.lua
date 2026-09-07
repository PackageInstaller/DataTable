local BoatAdCreateControl = class("BoatAdCreateControl")
local var_0_1
local var_0_2
local var_0_3 = 1.3

function BoatAdCreateControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	var_0_2 = BoatAdGameConst
	self._bgContent = arg_1_1
	self._eventCall = arg_1_2
	self._content = findTF(self._bgContent, "scene/content")
	self._createRule = {}

	return
end

function BoatAdCreateControl:start()
	local var_2_0 = var_0_1.GetRoundData()

	if var_2_0 and var_2_0.rule then
		self._createRule = Clone(var_0_2.create_rule[var_2_0.rule])
	end

	self._createStepTime = 0
	self._createRuleIndex = #self._createRule
	self._createRound = 1
	self._createLine = 1
	self.applyCreateData = nil
	self.applyCount = 0
	self.applyTimes = 0

	return
end

function BoatAdCreateControl:step(arg_3_1)
	if self._createStepTime >= 0 and not var_0_1.char:getBattle() then
		self._createStepTime = self._createStepTime - var_0_1.deltaTime

		if self._createStepTime <= 0 then
			self:applyRule()

			self._createStepTime = var_0_3
		end
	end

	return
end

function BoatAdCreateControl:applyRule()
	if self.applyTimes <= 0 then
		self.applyCreateData = self._createRule[self._createRuleIndex]
		self.createCount = self.applyCreateData.count
		self._createRuleIndex = self._createRuleIndex - 1
		self.applyTimes = self.applyCreateData.times

		if self._createRuleIndex <= 0 then
			self._createRuleIndex = #self._createRule
			self._createRound = self._createRound + 1
		end
	end

	self.applyTimes = self.applyTimes - 1

	local var_4_0 = type(self.applyCreateData.data[1]) == "number" and self.applyCreateData.data or self.applyCreateData.data[math.random(1, #self.applyCreateData.data)]
	local var_4_1 = {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_3 = 0

		if var_4_0[iter_4_0] ~= 0 and #var_4_1 < self.createCount then
			local var_4_4 = Clone(var_0_2.rule_data[var_4_0[iter_4_0]])
			local var_4_5 = true

			if var_4_4.once then
				for iter_4_1 = #var_4_4.ids, 1, -1 do
					if table.contains(var_4_1, var_4_4.ids[iter_4_1]) then
						table.remove(var_4_4.ids, iter_4_1)
					end
				end
			end

			if var_4_4.round and var_4_4.round > 0 and self._createRound ~= var_4_4.round then
				var_4_5 = false
			end

			if (var_4_4.create_rate < math.random(1, 100) or nil) and false then
				local var_4_6 = var_4_4.ids[math.random(1, #var_4_4.ids)]

				if var_4_4.type == var_0_2.type_enemy then
					self._eventCall(BoatAdGameEvent.CREATE_ENEMY, {
						id = var_4_6,
						move_count = iter_4_0,
						round = self._createRound,
						line = self._createLine
					})

					var_4_3 = var_4_6
				elseif var_4_4.type == var_0_2.type_item or var_4_4.type == var_0_2.type_buff then
					self._eventCall(BoatAdGameEvent.CREATE_ITEM, {
						id = var_4_6,
						move_count = iter_4_0,
						round = self._createRound,
						line = self._createLine
					})

					var_4_3 = var_4_6
				end
			end
		end

		if var_4_3 > 0 then
			table.insert(var_4_1, var_4_3)
		end
	end

	local var_4_7 = "本轮 " .. self._createLine .. " 创建id = "

	for iter_4_2 = 1, #var_4_1 do
		var_4_7 = var_4_7 .. var_4_1[iter_4_2] .. ","
	end

	print(var_4_7)

	self._createLine = self._createLine + 1

	return
end

function BoatAdCreateControl:clear()
	return
end

function BoatAdCreateControl:stop()
	return
end

function BoatAdCreateControl:resume()
	return
end

function BoatAdCreateControl:dispose()
	return
end

return BoatAdCreateControl
