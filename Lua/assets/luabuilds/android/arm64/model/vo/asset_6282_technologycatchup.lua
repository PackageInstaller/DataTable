local TechnologyCatchup = class("TechnologyCatchup", import(".BaseVO"))

TechnologyCatchup.STATE_UNSELECT = 1
TechnologyCatchup.STATE_CATCHUPING = 2
TechnologyCatchup.STATE_FINISHED_ALL = 3

function TechnologyCatchup:Ctor(arg_1_1)
	self.id = arg_1_1.version
	self.configId = self.id
	self.ssrNum = arg_1_1.number or 0
	self.urNums = arg_1_1.dr_numbers or {}

	self:bulidTargetNums()

	self.state = TechnologyCatchup.STATE_UNSELECT

	self:updateState()

	return
end

function TechnologyCatchup:bindConfigTable()
	return pg.technology_catchup_template
end

function TechnologyCatchup:isUr(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self:getConfig("ur_char")) do
		if arg_3_1 == iter_3_1 then
			return true
		end
	end

	return false
end

function TechnologyCatchup:bulidTargetNums()
	self.targetNums = {}

	for iter_4_0, iter_4_1 in ipairs(self:getConfig("char_choice")) do
		if self:isUr(iter_4_1) then
			for iter_4_2, iter_4_3 in pairs(self.urNums) do
				if iter_4_3.id == iter_4_1 then
					self.targetNums[iter_4_1] = iter_4_3.number or 0
				end
			end
		else
			self.targetNums[iter_4_1] = self.ssrNum
		end

		self.targetNums[iter_4_1] = self.targetNums[iter_4_1] or 0
	end

	return
end

function TechnologyCatchup:getTargetNum(arg_5_1)
	return self.targetNums[arg_5_1]
end

function TechnologyCatchup:addTargetNum(arg_6_1, arg_6_2)
	if self:isUr(arg_6_1) then
		self.targetNums[arg_6_1] = self.targetNums[arg_6_1] + arg_6_2
	else
		for iter_6_0, iter_6_1 in ipairs(self:getConfig("char_choice")) do
			if not self:isUr(iter_6_1) then
				self.targetNums[iter_6_1] = self.targetNums[iter_6_1] + arg_6_2
			end
		end
	end

	self:updateState()

	return
end

function TechnologyCatchup:isFinish(arg_7_1)
	if self:isUr(arg_7_1) then
		return self.targetNums[arg_7_1] >= self:getConfig("obtain_max_per_ur")
	else
		return self.targetNums[arg_7_1] >= self:getConfig("obtain_max")
	end

	return
end

function TechnologyCatchup:isFinishSSR()
	local var_8_0 = true

	for iter_8_0, iter_8_1 in ipairs(self:getConfig("char_choice")) do
		if not self:isUr(iter_8_1) and not self:isFinish(iter_8_1) then
			var_8_0 = false
		end
	end

	return var_8_0
end

function TechnologyCatchup:isFinishAll()
	local var_9_0 = true

	for iter_9_0, iter_9_1 in ipairs(self:getConfig("char_choice")) do
		if not self:isFinish(iter_9_1) then
			var_9_0 = false
		end
	end

	return var_9_0
end

function TechnologyCatchup:updateState()
	self.state = self:isFinishAll() and TechnologyCatchup.STATE_FINISHED_ALL or self.targetNums[getProxy(TechnologyProxy).curCatchupGroupID] and TechnologyCatchup.STATE_CATCHUPING or TechnologyCatchup.STATE_UNSELECT

	return
end

function TechnologyCatchup:getState()
	return self.state
end

return TechnologyCatchup
