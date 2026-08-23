local var_0_0 = load("core.rule.BuffRule")
local var_0_1 = table

return {
	init = function(self, arg_1_1, arg_1_2)
		local var_1_0 = arg_1_2 or arg_1_1:getHighIdentity()

		arg_1_1:setFirstAttackId(var_1_0)

		self.order = {}

		for iter_1_0 = 1, 6 do
			self.order[iter_1_0 * 2 - 1] = {
				identity = var_1_0,
				pos = iter_1_0
			}
			self.order[iter_1_0 * 2] = {
				identity = 3 - var_1_0,
				pos = iter_1_0
			}
		end

		self.attackIndex = 0
		self.battleData = arg_1_1
		self.extraActions = {}
	end,
	next = function(self)
		local var_2_0 = self:getExtraAction()

		if var_2_0 then
			return var_2_0.knight, {
				isExtra = true,
				disableComboRecover = var_2_0.disableComboRecover == true,
				disableAngerRecover = var_2_0.disableAngerRecover == true,
				disableThreshRecover = var_2_0.disableThreshRecover == true,
				skillId = var_2_0.skillId,
				isWarBand = var_2_0.isWarBand
			}
		end

		for iter_2_0 = 1, 12 do
			if self.order[iter_2_0] then
				local var_2_1 = self.battleData:getKnightByIdAndPos(self.order[iter_2_0].identity, self.order[iter_2_0].pos)

				if var_2_1 and var_2_1:isReal() and var_2_1.assisting then
					var_2_1.assisting = false

					return var_2_1, {}
				end
			end
		end

		if self.attackIndex >= 12 then
			self.attackIndex = 0
		end

		for iter_2_1 = self.attackIndex + 1, 12 do
			if self.order[iter_2_1] then
				local var_2_2 = self.battleData:getKnightByIdAndPos(self.order[iter_2_1].identity, self.order[iter_2_1].pos)

				if var_2_2 then
					if var_2_2:isReal() then
						self.attackIndex = iter_2_1

						return var_2_2, {}
					elseif var_2_2.isDead then
						local var_2_3 = load("core.rule.BuffRule")

						var_2_2:doBuffRound(var_2_3.ROUND.BEFORE)
						var_2_2:doBuffRound(var_2_3.ROUND.AFTER)
					end
				end
			end
		end
	end,
	checkFinish = function(self)
		for iter_3_0 = self.attackIndex + 1, 12 do
			if self.order[iter_3_0] then
				local var_3_0 = self.battleData:getKnightByIdAndPos(self.order[iter_3_0].identity, self.order[iter_3_0].pos)

				if var_3_0 and var_3_0:isReal() then
					return false
				end
			end
		end

		if self:hasExtraAction() then
			return false
		end

		self.attackIndex = 0

		return true
	end,
	reset = function(arg_4_0)
		arg_4_0.attackIndex = 0
		arg_4_0.extraActions = {}
	end,
	getNextKnight = function(self)
		local var_5_0, var_5_1 = self:hasExtraAction()

		if var_5_0 then
			return var_5_1.knight
		end

		if self.attackIndex >= 12 then
			self.attackIndex = 0
		end

		for iter_5_0 = self.attackIndex + 1, 12 do
			if self.order[iter_5_0] then
				local var_5_2 = self.battleData:getKnightByIdAndPos(self.order[iter_5_0].identity, self.order[iter_5_0].pos)

				if var_5_2 and var_5_2:isReal() then
					return var_5_2
				end
			end
		end
	end,
	addExtraAction = function(self, arg_6_1)
		if arg_6_1.isWarBand then
			for iter_6_0, iter_6_1 in ipairs(self.extraActions) do
				if iter_6_1.isWarBand and arg_6_1.knight.serialId == iter_6_1.knight.serialId then
					return
				end
			end
		end

		var_0_1.insert(self.extraActions, arg_6_1)
	end,
	getExtraAction = function(self)
		repeat
			local var_7_0 = var_0_1.remove(self.extraActions, 1)

			if not var_7_0 then
				return nil
			end

			if var_7_0.knight:isReal() and not var_7_0.knight:doBuff(var_0_0.TYPE.EXTRA_ACTION_FAIL) then
				return var_7_0
			end
		until false
	end,
	hasExtraAction = function(self)
		for iter_8_0 = 1, #self.extraActions do
			if self.extraActions[iter_8_0].knight:isReal() and not self.extraActions[iter_8_0].knight:doBuff(var_0_0.TYPE.EXTRA_ACTION_FAIL) then
				return true, self.extraActions[iter_8_0]
			end
		end

		return false
	end,
	clearExtraAction = function(arg_9_0)
		arg_9_0.extraActions = {}
	end,
	changeTurns = function(self, arg_10_1, arg_10_2)
		local var_10_0 = arg_10_2 or arg_10_1:getHighIdentity()
		local var_10_1 = 3 - var_10_0

		self.order = {}

		for iter_10_0 = 1, 6 do
			local var_10_2 = self.battleData:getKnightByIdAndPos(var_10_0, iter_10_0)
			local var_10_3

			if var_10_2 and var_10_2:isReal() then
				self.order[1] = {
					identity = var_10_0,
					pos = iter_10_0
				}
				var_10_3 = 1 + 2
			end

			local var_10_4 = self.battleData:getKnightByIdAndPos(var_10_1, iter_10_0)
			local var_10_5

			if var_10_4 and var_10_4:isReal() then
				self.order[2] = {
					identity = var_10_1,
					pos = iter_10_0
				}
				var_10_5 = 2 + 2
			end
		end
	end,
	getCurAttackIndex = function(self)
		return self.attackIndex
	end
}
