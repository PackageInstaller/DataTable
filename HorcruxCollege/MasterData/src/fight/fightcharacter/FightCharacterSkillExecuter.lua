function FightCharacter:skillexecute(arg_1_1, arg_1_2, ...)
	arg_1_2 = "skill_" .. arg_1_2

	return (self[arg_1_2](self, arg_1_1, ...))
end

function FightCharacter:skill_check_target_distance(arg_2_1, arg_2_2, arg_2_3)
	if not self:getTarget() then
		return true
	end

	if type(arg_2_2) == "string" then
		arg_2_2 = self:getAttribute("range")
	end

	local var_2_0, var_2_1 = self:getTarget():getRectPosition()
	local var_2_2

	if arg_2_2 < 0 or not (arg_2_2 + var_2_1 / 2) then
		::label_2_0::

		arg_2_2 = arg_2_2 - var_2_1 / 2
		var_2_2 = self._direction
	end

	return var_2_2 * (var_2_0 - self._direction * arg_2_2 - self:getPosition()) <= 0
end

function FightCharacter:skill_rush_forward(arg_3_1, arg_3_2)
	local var_3_0 = 0.1

	if arg_3_2.frame then
		var_3_0 = arg_3_2.frame / 30
	elseif arg_3_2.time then
		var_3_0 = arg_3_2.time
	end

	local var_3_1 = arg_3_1.skillspeedscale
	local var_3_2

	if not arg_3_1.skillspeedscale then
		var_3_1 = 1
		var_3_2 = {}
	end

	var_3_2.time = var_3_0 / var_3_1
	var_3_2.distance = arg_3_2.distance * self._direction

	self:setRushForward(var_3_2)

	self._runshforwarddistance = arg_3_2.distance * self._direction

	return true
end

function FightCharacter:skill_rush_back(arg_4_1, arg_4_2)
	if not self._runshforwarddistance then
		return true
	end

	local var_4_0 = 0.1

	if arg_4_2.frame then
		var_4_0 = arg_4_2.frame / 30
	elseif arg_4_2.time then
		var_4_0 = arg_4_2.time
	end

	self:setRushForward({
		time = var_4_0,
		distance = -1 * self._runshforwarddistance
	})

	self._runshforwarddistance = nil

	return true
end

function FightCharacter:skill_blink(arg_5_1, arg_5_2)
	self:setPositionX(self:getPositionX() + arg_5_2.distance * self._direction)

	self._blinkdistance = arg_5_2.distance * self._direction

	return true
end

function FightCharacter:skill_blink_back(arg_6_1, arg_6_2)
	if not self._blinkdistance then
		return true
	end

	self:setPositionX(self:getPositionX() - self._blinkdistance)

	self._blinkdistance = nil

	return true
end

function FightCharacter:skill_rush_to_target(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2.frame / 30
	local var_7_1, var_7_2 = self:getTarget()

	if var_7_2 then
		var_7_1 = var_7_1[1]
	end

	if var_7_1 then
		local var_7_3, var_7_4 = var_7_1:getRectPosition()
		local var_7_5 = type(arg_7_2.posx) == "string" and self:getAttribute("range") or arg_7_2.posx
		local var_7_6 = self:getStandardPosition()
		local var_7_7 = var_7_6 < var_7_3 and 1 or -1

		if not self._turnbackLimit then
			self:switchDirection(var_7_7)
		end

		var_7_5 = var_7_5 >= 0 and var_7_5 + var_7_4 / 2 or var_7_5 - var_7_4 / 2

		local var_7_8 = var_7_3 - var_7_7 * var_7_5

		self:setRushForward({
			time = var_7_0,
			distance = (self._direction * (var_7_3 - var_7_7 * var_7_5 - var_7_6) <= 0 and 0 or math.abs(var_7_8 - var_7_6)) * var_7_7
		})

		return true
	else
		local var_7_11 = 200

		self:setRushForward({
			time = var_7_0,
			distance = var_7_11 * self._direction
		})

		return false
	end
end

function FightCharacter.skill_rush_to_target_cycled(arg_8_0, arg_8_1, arg_8_2)
	print("rush_to_target_cycled is deprecated...")
end

function FightCharacter:skill_catapult_next_target(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.condition
	local var_9_1 = arg_9_1

	if arg_9_2.maxcatapult <= arg_9_1.catapult then
		return false
	end

	if self.target then
		var_9_1.hitted[self.target] = true
	end

	local var_9_2 = {}

	if self.charactertype == "player" then
		if self._locktargetpool == "players" then
			var_9_2 = self.statuspool:checkStatus("addict") and self:getAreaOponent(self:getStandardPosition(), arg_9_2.area, arg_9_2.area) or self:getAreaTeammate(self:getStandardPosition(), arg_9_2.area, arg_9_2.area)
		elseif self._locktargetpool == "enemies" then
			var_9_2 = self.statuspool:checkStatus("addict") and self:getAreaTeammate(self:getStandardPosition(), arg_9_2.area, arg_9_2.area) or self:getAreaOponent(self:getStandardPosition(), arg_9_2.area, arg_9_2.area)
		end
	elseif self.charactertype == "enemy" then
		if self._locktargetpool == "players" then
			var_9_2 = self.statuspool:checkStatus("addict") and self:getAreaTeammate(self:getStandardPosition(), arg_9_2.area, arg_9_2.area) or self:getAreaOponent(self:getStandardPosition(), arg_9_2.area, arg_9_2.area)
		elseif self._locktargetpool == "enemies" then
			var_9_2 = self.statuspool:checkStatus("addict") and self:getAreaOponent(self:getStandardPosition(), arg_9_2.area, arg_9_2.area) or self:getAreaTeammate(self:getStandardPosition(), arg_9_2.area, arg_9_2.area)
		end
	end

	if #var_9_2 <= 0 then
		return false
	end

	if var_9_0 == "nearest" then
		local var_9_3 = {}
		local var_9_4 = self:getStandardPosition()

		for iter_9_0, iter_9_1 in pairs(var_9_2) do
			if iter_9_1:canBeLocked(self:getAttackUnitOrder()) then
				var_9_3[#var_9_3 + 1] = {
					id = iter_9_0,
					index = iter_9_1.index,
					distance = math.abs(iter_9_1:getPosition() - var_9_4)
				}
			end
		end

		if #var_9_3 <= 0 then
			return false
		end

		table.sort(var_9_3, function(arg_10_0, arg_10_1)
			if arg_10_0.distance == arg_10_1.distance then
				return arg_10_0.id < arg_10_1.id
			else
				return arg_10_0.distance < arg_10_1.distance
			end
		end)
		self:lockTarget(var_9_3[1].index)
	elseif var_9_0 == "next" then
		local var_9_5

		for iter_9_2, iter_9_3 in pairs(var_9_2) do
			if iter_9_3:canBeLocked(self:getAttackUnitOrder()) and not var_9_1.hitted[iter_9_3.index] then
				var_9_5 = iter_9_3.index

				break
			end
		end

		if not var_9_5 then
			return false
		end

		self:lockTarget(var_9_5)
	elseif var_9_0 == "random" then
		local var_9_7 = {}

		for iter_9_4, iter_9_5 in pairs(var_9_2) do
			if iter_9_5:canBeLocked(self:getAttackUnitOrder()) then
				table.insert(var_9_7, iter_9_5.index)
			end
		end

		if #var_9_7 <= 0 then
			return false
		end

		if #var_9_7 == 1 then
			self:lockTarget(var_9_7[1])
		else
			self:lockTarget(var_9_7[math.random(#var_9_7)])
		end
	elseif var_9_0 == "normal" then
		local var_9_9 = {}

		for iter_9_6, iter_9_7 in pairs(var_9_2) do
			if iter_9_7:canBeLocked(self:getAttackUnitOrder()) and iter_9_7.index ~= self.target then
				table.insert(var_9_9, iter_9_7.index)
			end
		end

		if #var_9_9 <= 0 then
			return false
		end

		self:lockTarget(#var_9_9 == 1 and var_9_9[1] or var_9_9[math.random(#var_9_9)])
	end

	var_9_1.catapult = var_9_1.catapult + 1

	return true
end

function FightCharacter:skill_change_to_invincible()
	return self:change_to_invincible()
end

function FightCharacter:skill_remove_invincible()
	return self:remove_invincible()
end

function FightCharacter:skill_useSkill(arg_13_1, arg_13_2)
	if arg_13_2:find("^attack") then
		if arg_13_1.isdoubleattack then
			self.skilllogic:doDoubleAttack(arg_13_2, arg_13_1)
		else
			self.skilllogic:doAttack(arg_13_2, arg_13_1)
		end
	else
		self.skilllogic:doSkill(arg_13_2, arg_13_1)
	end

	return true
end

function FightCharacter:skill_useAttack(arg_14_1, arg_14_2)
	self.skilllogic:doAttack(arg_14_2, arg_14_1)

	return true
end

function FightCharacter.skill_random(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	return compareByoperator(arg_15_3, math.random(arg_15_2.range), arg_15_2.num)
end

function FightCharacter.skill_complete(arg_16_0)
	return false
end

function FightCharacter:skill_check_target_hp_percent(arg_17_1, arg_17_2, arg_17_3)
	if not self:getTarget() then
		return false
	end

	local var_17_0, var_17_1 = self:getTarget()
	local var_17_2 = var_17_1 and var_17_0[1] or var_17_0

	return compareByoperator(arg_17_3, var_17_2:getAttribute("curhp") / var_17_2:getAttribute("singlehp"), arg_17_2)
end

function FightCharacter:skill_add_anti_hitdown()
	return self:add_anti_hitdown()
end

function FightCharacter:skill_remove_anti_hitdown()
	return self:remove_anti_hitdown()
end

function FightCharacter:skill_grab(arg_20_1, arg_20_2)
	local var_20_0, var_20_1 = self:getTarget()

	if not var_20_0 then
		return false
	end

	local var_20_2

	if var_20_1 then
		var_20_2 = var_20_0[1] or var_20_0

		if not var_20_0:canBeLocked(self:getAttackUnitOrder()) then
			return false
		end

		if var_20_0:isBKB() then
			return false
		end
	end

	self:grabTarget(var_20_2.index, arg_20_2)

	return true
end

function FightCharacter:skill_releasegrab(arg_21_1, arg_21_2)
	local var_21_0, var_21_1 = self:getTarget()

	if not var_21_0 then
		return false
	end

	self:releaseGrabTarget(((var_21_1 or nil) and (var_21_0[1] or var_21_0)).index)

	return true
end
